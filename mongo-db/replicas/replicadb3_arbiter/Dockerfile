FROM mongo:5

ENV ARBITER_DATA_DIR="/data/arb"
ENV DATA_ADMIN_DIR="/data/admin"

RUN apt-get update && apt-get install -y locales vim apt net-tools wget curl gpg gpg-agent libaio1 xmlstarlet jq ca-certificates gettext-base procps dumb-init && apt-get install -y dos2unix\
  && \
  rm -rf /var/lib/apt/lists/*
RUN locale-gen 'el_GR.UTF-8'
RUN update-locale LANG='el_GR.UTF-8'

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
RUN mkdir -p $ARBITER_DATA_DIR
RUN mkdir -p $DATA_ADMIN_DIR

COPY /confArbiter.yml $DATA_ADMIN_DIR