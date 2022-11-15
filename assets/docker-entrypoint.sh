#!/bin/bash
set -e
 
BROKER_HOME=/opt/messaging/artemis
OVERRIDE_PATH=$BROKER_HOME/etc
CONFIG_PATH=$BROKER_HOME/etc
export BROKER_HOME OVERRIDE_PATH CONFIG_PATH
 
 
 
# Prepends a value in the JAVA_ARGS of artemis.profile
# $1 New string to be prepended to JAVA_ARGS
# $2 Deduplication string
prepend_java_arg() {
  sed -i "\#$1#!s#^\([[:space:]]\)*JAVA_ARGS=\"#\\1JAVA_ARGS=\"$2 #g" $CONFIG_PATH/artemis.profile
}
 
 
 
# Update users and roles with if username and password is passed as argument
if [ "$ARTEMIS_USERNAME" ] && [ "$ARTEMIS_PASSWORD" ]; then
 
    HASHED_PASSWORD=$(${BROKER_HOME}/bin/artemis mask --hash ${ARTEMIS_PASSWORD} | cut -d " " -f 2)
    sed -i "s/$ARTEMIS_USERNAME[ ]*=.*/$ARTEMIS_USERNAME=ENC($HASHED_PASSWORD)\\n/g" ${CONFIG_PATH}/artemis-users.properties
 
fi
 
## Update min memory if the argument is passed
if [ "$ARTEMIS_MIN_MEMORY" ]; then
 prepend_java_arg "-Xms" "-Xms$ARTEMIS_MIN_MEMORY"
fi
 
## Update max memory if the argument is passed
if [ "$ARTEMIS_MAX_MEMORY" ]; then
  prepend_java_arg "-Xmx" "-Xmx$ARTEMIS_MAX_MEMORY"
fi
 
## Support extra java opts from JAVA_OPTS env
if [ "$JAVA_OPTS" ]; then
  prepend_java_arg "$JAVA_OPTS" "$JAVA_OPTS"
fi

 
 
 
if [ -e "${CONFIG_PATH}"/jolokia-access.xml ]; then
  xmlstarlet ed --inplace -u '/restrict/cors/allow-origin' -v "${JOLOKIA_ALLOW_ORIGIN:-*}" ${CONFIG_PATH}/jolokia-access.xml
fi
 
 
# Add BROKER_CONFIGS env variable to startup options
prepend_java_arg "BROKER_CONFIGS" "\$BROKER_CONFIGS"
 
# Loop through all BROKER_CONFIG_... and convert to java system properties
env|grep -E "^BROKER_CONFIG_"|sed -e 's/BROKER_CONFIG_//g' >/tmp/brokerconfigs.txt
while read -r config
do
  PARAM=${config%%=*}
  PARAM_CAMEL_CASE=$(echo "$PARAM"|sed -r 's/./\L&/g; s/(^|-|_)(\w)/\U\2/g; s/./\L&/')
  VALUE=${config#*=}
  BROKER_CONFIGS="${BROKER_CONFIGS} -Dbrokerconfig.${PARAM_CAMEL_CASE}=${VALUE}"
done < /tmp/brokerconfigs.txt
rm -f /tmp/brokerconfigs.txt
export BROKER_CONFIGS
 
files=$(find $OVERRIDE_PATH -name "entrypoint*.sh" -type f | sort -u );
if [ "${#files[@]}" ]; then
  for f in $files; do
    echo "Processing entrypoint override: $f"
    /bin/bash "$f"
  done
fi
 

if [ "$1" = 'artemis-server' ]; then
  exec dumb-init -- sh ./artemis run
fi
 
exec "$@"