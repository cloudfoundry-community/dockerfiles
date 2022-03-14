FROM ruby:2.7-bullseye AS ruby

FROM ubuntu:xenial

ENV COLUMNS=80
ENV VAULT_VERSION=1.9.3

# COLUMNS var added to work around bosh cli needing a terminal size specified

# base packages
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get install -y wget gnupg \
    apt-transport-https ca-certificates \
    libreadline-dev \
    && apt-get update \
    && wget -q -O - https://raw.githubusercontent.com/starkandwayne/homebrew-cf/master/public.key | apt-key add - \
    && echo "deb http://apt.starkandwayne.com stable main" | tee /etc/apt/sources.list.d/starkandwayne.list \
    && wget -q -O - https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
    && echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list \
    && apt-get update && apt-get install -y \
      autoconf \
      bosh-cli \
      build-essential \
      bzip2 \
      certstrap \
      cf-cli \
      cf6-cli \
      concourse-fly \
      credhub-cli \
      curl \
      genesis \
      git \
      gotcha \
      hub \
      file \
      jq \
      kubectl \
      libc6 \
      libsqlite3-dev \
      libssl-dev \
      libtool \
      libxml2-dev \
      libxslt-dev \
      libyaml-dev \
      lsof \
      om \
      openssl \
      pivnet-cli \
      safe \
      sipcalc \
      spruce \
      sqlite3 \
      vim-common \
      wget \
      unzip \
      zlib1g-dev \
      zlibc \
    && rm -rf /var/lib/apt/lists/*


RUN curl -Lo vault.zip https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip \
    && unzip vault.zip \
    && mv vault /usr/bin/vault \
    && chmod 0755 /usr/bin/vault \
    && rm vault.zip


RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && \
    apt-get install git-lfs && \
    git lfs install

# Install Hugo
RUN curl -L >hugo.tar.gz https://github.com/gohugoio/hugo/releases/download/v0.36/hugo_0.36_Linux-64bit.tar.gz \
 && tar -xzvf hugo.tar.gz -C /usr/bin \
 && rm hugo.tar.gz

# Rubygems
RUN gem install cf-uaac fpm deb-s3 --no-document

# Add a user for running things as non-superuser
RUN useradd -ms /bin/bash worker





USER root
RUN apt-get update && apt-get install bzr gcc -y

ENV GOLANG_VERSION 1.17.7
ENV GOLANG_URL https://buildpacks.cloudfoundry.org/dependencies/go/go_1.17.7_linux_x64_cflinuxfs3_e8cf2ae0.tgz
ENV GOLANG_SHA256 e8cf2ae04da5a64fd1e7d88e66c533802a9406303148904eb87d188314cf56fb

RUN \
  mkdir -p /goroot /gopath  && \
  curl $GOLANG_URL | \
  tar xvzf - -C /goroot --strip-components=1 && \
  chown -R worker /goroot /gopath

ENV \
  GOROOT=/goroot \
  GOPATH=/gopath \
  PATH=/goroot/bin:/gopath/bin:$PATH

RUN go get golang.org/x/tools/cmd/cover \
 && go get golang.org/x/lint/golint \
 && go get github.com/tools/godep \
 && go get github.com/laher/goxc \
 && go get github.com/onsi/ginkgo/ginkgo \
 && go get github.com/onsi/gomega/... 







