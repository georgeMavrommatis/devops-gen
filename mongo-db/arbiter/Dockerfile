FROM mongo:5

ENV ARBITER_DATA_DIR="/data/arb"

RUN apt-get update && apt-get install -y locales vim apt net-tools wget curl gpg gpg-agent libaio1 xmlstarlet jq ca-certificates gettext-base procps dumb-init && apt-get install -y dos2unix\
  && \
  rm -rf /var/lib/apt/lists/*
RUN locale-gen 'el_GR.UTF-8'
RUN update-locale LANG='el_GR.UTF-8'

RUN mkdir $ARBITER_DATA_DIR