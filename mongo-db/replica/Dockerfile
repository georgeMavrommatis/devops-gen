FROM mongo:5

ENV DATA_ADMIN_DIR="/data/admin"

RUN apt-get update && apt-get install -y locales vim apt net-tools \
    wget curl gpg gpg-agent libaio1 xmlstarlet jq ca-certificates gettext-base procps dumb-init \
    && apt-get install -y dos2unix\
    && apt-get install -y nodejs\
    && \
    rm -rf /var/lib/apt/lists/*
RUN locale-gen 'el_GR.UTF-8'
RUN update-locale LANG='el_GR.UTF-8'

RUN mkdir -p $DATA_ADMIN_DIR

ADD /admin_mongodb1.sh $DATA_ADMIN_DIR
RUN chmod 777 $DATA_ADMIN_DIR/admin_mongodb1.sh
RUN dos2unix $DATA_ADMIN_DIR/admin_mongodb1.sh
ENTRYPOINT ["/data/admin/admin_mongodb1.sh"]