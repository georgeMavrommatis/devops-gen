FROM mongo:5

ENV DATA_ADMIN_DIR="/data/admin"

RUN apt-get update && apt-get install -y locales vim apt net-tools \
    wget curl gpg gpg-agent libaio1 xmlstarlet jq ca-certificates gettext-base procps dumb-init \
    && apt-get install -y dos2unix\
    && \
    rm -rf /var/lib/apt/lists/*
RUN locale-gen 'el_GR.UTF-8'
RUN update-locale LANG='el_GR.UTF-8'

RUN mkdir -p $DATA_ADMIN_DIR

# LimitFSIZE
RUN ulimit -f unlimited
# LimitCPU 
RUN ulimit -t unlimited 
# LimitAS
RUN ulimit -v unlimited 
# LimitNOFILE 
RUN ulimit -n 100000
# LimitMAXMEM
RUN ulimit -m unlimited 
# LimitMEMLOCK
RUN ulimit -l 82000
# LimitNPROC
RUN ulimit -p 100000
COPY /admin_mongodb1.sh $DATA_ADMIN_DIR
RUN chmod +x $DATA_ADMIN_DIR/admin_mongodb1.sh
RUN dos2unix $DATA_ADMIN_DIR/admin_mongodb1.sh

COPY /config.yml $DATA_ADMIN_DIR