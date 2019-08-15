FROM ubuntu

ENV COLUMNS=80
ENV VAULT_VERSION=1.2.2

# COLUMNS var added to work around bosh cli needing a terminal size specified

# base packages
RUN apt-get update \
    && apt-get install -yy wget gnupg \
    && wget -q -O - https://raw.githubusercontent.com/starkandwayne/homebrew-cf/master/public.key | apt-key add - \
    && echo "deb http://apt.starkandwayne.com stable main" | tee /etc/apt/sources.list.d/starkandwayne.list \
    && wget -q -O - https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
    && echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list \
    && apt-get update && apt-get install -yy \
      autoconf \
      bosh-cli \
      build-essential \
      bzip2 \
      certstrap \
      cf-cli \
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
      libreadline7 \
      libreadline-dev \
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
      ruby \
      ruby-dev \
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

# Install git-lfs
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && \
    apt-get install git-lfs && \
    git lfs install

# Install Hugo
RUN curl -L >hugo.tar.gz https://github.com/gohugoio/hugo/releases/download/v0.36/hugo_0.36_Linux-64bit.tar.gz \
 && tar -xzvf hugo.tar.gz -C /usr/bin \
 && rm hugo.tar.gz

# Rubygems
RUN gem install cf-uaac fpm deb-s3 --no-ri --no-rdoc

# Add a user for running things as non-superuser
RUN useradd -ms /bin/bash worker
