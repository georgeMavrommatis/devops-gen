FROM mongo:5

ENV DEPLOYMENT_SCRIPT_DIR="/deployment_scripts"
ENV DEPLOYMENT_SCRIPT_FILE="initiate_replica.sh"

RUN apt-get update && apt-get install -y locales vim apt net-tools wget curl gpg gpg-agent libaio1 xmlstarlet jq ca-certificates gettext-base procps dumb-init && apt-get install -y --reinstall rsyslog && apt-get install -y dos2unix\
  && \
  rm -rf /var/lib/apt/lists/*
RUN service rsyslog start
RUN locale-gen 'el_GR.UTF-8'
RUN update-locale LANG='el_GR.UTF-8'

RUN mkdir $DEPLOYMENT_SCRIPT_DIR 

# ADD initiate_replica.sh $DEPLOYMENT_SCRIPT_DIR/$DEPLOYMENT_SCRIPT_FILE

# WORKDIR $DEPLOYMENT_SCRIPT_DIR

# ENTRYPOINT ["/deployment_scripts/initiate_replica.sh"]

COPY /initiate_replica.sh /
RUN dos2unix /initiate_replica.sh
#ENTRYPOINT ["/initiate_replica.sh"]