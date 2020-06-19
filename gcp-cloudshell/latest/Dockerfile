FROM gcr.io/cloudshell-images/cloudshell@sha256:5ae630bc89da5a634af63ef06faeed5199b0b3669a49092e76a6c5674576b53b

RUN apt-get update \
    && apt-get install -yy wget gnupg \
    && wget -q -O - https://raw.githubusercontent.com/starkandwayne/homebrew-cf/master/public.key | apt-key add - \
    && echo "deb http://apt.starkandwayne.com stable main" | tee /etc/apt/sources.list.d/starkandwayne.list \
    && wget -q -O - https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
    && echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list \
    && apt-get update && apt-get install -yy \
      autoconf \
      bosh-cli \
      bosh-bootloader \
      build-essential \
      bzip2 \
      certstrap \
      cf-cli \
      cf7-cli \
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
      shield \
      sipcalc \
      spruce \
      sqlite3 \
      vim-common \
      wget \
      unzip \
      zlib1g-dev \
      zlibc \
    && rm -rf /var/lib/apt/lists/*

RUN curl -Lo vault.zip https://releases.hashicorp.com/vault/1.0.2/vault_1.0.2_linux_amd64.zip \
    && unzip vault.zip \
    && mv vault /usr/bin/vault \
    && chmod 0755 /usr/bin/vault \
    && rm vault.zip \
    && curl -Lo /usr/bin/safe https://github.com/starkandwayne/safe/releases/download/v1.1.0/safe-linux-amd64 \
    && chmod 0755 /usr/bin/safe

# Install k14s tools
RUN curl -L https://k14s.io/install.sh | bash

# Install git-lfs
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && \
    apt-get install git-lfs && \
    git lfs install

# Install gluon CLI
RUN curl -Lo /usr/bin/gluon https://raw.githubusercontent.com/starkandwayne/gluon/master/bin/gluon \
 && chmod 0755 /usr/bin/gluon
