FROM --platform=linux/amd64 ubuntu:jammy

ENV COLUMNS=80

# 1.9.3
ENV BOSH_VERSION=${BOSH_VERSION:-7.2.3}
ENV CERTSTRAP_VERSION=${CERTSTRAP_VERSION:-1.3.0}
ENV CF_7_VERSION=${CF_7_VERSION:-7.6.0}
ENV CF_8_VERSION=${CF_8_VERSION:-8.6.1}
ENV CREDHUB_VERSION=${CREDHUB_VERSION:-2.9.15}
ENV GENESIS_VERSION=${GENESIS_VERSION:-2.8.9}
ENV GOTCHA_VERSION=${GOTCHA_VERSION:-0.2.0}
ENV GO_VERSION=${GO_VERSION:-1.20.4}
ENV HUGO_VERSION=${HUGO_VERSION:-0.36}
ENV JQ_VERSION=${JQ_VERSION:-1.6}
ENV SAFE_VERSION=${SAFE_VERSION:-1.8.0}
ENV SHIELD_VERSION=${SHIELD_VERSION:-8.8.4}
ENV SPRUCE_VERSION=${SPRUCE_VERSION:-1.30.2}
ENV VAULT_VERSION=${VAULT_VERSION:-1.13.2}
ENV HUB_VERSION=${HUB_VERSION:-2.14.2}

# COLUMNS var added to work around bosh cli needing a terminal size specified

# base packages
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
      && apt-get install -yy \
                   autoconf \
                   build-essential \
                   bzip2 \
                   curl \
                   file \
                   gcc \
                   git \
                   gnupg \
                   libc6 \
                   libreadline-dev \
                   libreadline8 \
                   libsqlite3-dev \
                   libssl-dev \
                   libtool \
                   libxml2-dev \
                   libxslt1-dev \
                   libyaml-dev \
                   lsof \
                   neovim \
                   openssl \
                   ruby \
                   ruby-dev \
                   sipcalc \
                   sqlite3 \
                   tig \
                   unzip \
                   vim-common \
                   wget \
                   zlib* \
                   zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

## Go
ENV GOPATH /go
ENV GOROOT /usr/local/go
ENV PATH="${GOROOT}/bin:${GOPATH}/bin:${PATH}"

RUN curl -sOL "https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz" \
    && tar -C /usr/local -xzf "go${GO_VERSION}.linux-amd64.tar.gz" \
    && rm "go${GO_VERSION}.linux-amd64.tar.gz" \
    && mkdir -p "${GOPATH}/src" "${GOPATH}/bin" \
    && chmod -R 777 "$GOPATH"

## Vault
RUN curl -sOL "https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip" \
    && unzip vault_${VAULT_VERSION}_linux_amd64.zip \
    && mv vault /usr/bin/vault \
    && chmod 0755 /usr/bin/vault \
    && rm vault_${VAULT_VERSION}_linux_amd64.zip

## safe
RUN curl -sOL "https://github.com/starkandwayne/safe/releases/download/v${SAFE_VERSION}/safe-linux-amd64" \
    && mv safe-linux-amd64 /usr/bin/safe \
    && chmod 0755 /usr/bin/safe

## Spruce
RUN curl -sOL "https://github.com/geofffranks/spruce/releases/download/v${SPRUCE_VERSION}/spruce-linux-amd64" \
    && mv spruce-linux-amd64 /usr/bin/spruce \
    && chmod 0755 /usr/bin/spruce

## bosh
RUN curl -sOL "https://github.com/cloudfoundry/bosh-cli/releases/download/v${BOSH_VERSION}/bosh-cli-${BOSH_VERSION}-linux-amd64" \
    && mv bosh-cli-${BOSH_VERSION}-linux-amd64 /usr/bin/bosh \
    && chmod 0755 /usr/bin/bosh

## credhub-cli
RUN curl -sOL "https://github.com/cloudfoundry/credhub-cli/releases/download/${CREDHUB_VERSION}/credhub-linux-${CREDHUB_VERSION}.tgz" \
    && tar zxvf credhub-linux-${CREDHUB_VERSION}.tgz \
    && mv credhub /usr/bin/credhub \
    && chmod 0755 /usr/bin/credhub

## genesis
RUN curl -sOL "https://github.com/genesis-community/genesis/releases/download/v${GENESIS_VERSION}/genesis" \
    && mv genesis /usr/bin/genesis \
    && chmod 0755 /usr/bin/genesis

## certstrap
RUN curl -sOL "https://github.com/square/certstrap/releases/download/v${CERTSTRAP_VERSION}/certstrap-linux-amd64" \
    && mv certstrap-linux-amd64 /usr/bin/certstrap \
    && chmod 0755 /usr/bin/certstrap

## gotcha
RUN curl -sOL "https://github.com/starkandwayne/gotcha/releases/download/v${GOTCHA_VERSION}/gotcha-linux-amd64" \
    && mv gotcha-linux-amd64 /usr/bin/gotcha \
    && chmod 0755 /usr/bin/gotcha

## shield
RUN curl -fsSLo shield "https://github.com/shieldproject/shield/releases/download/v${SHIELD_VERSION}/shield-linux-amd64" \
    && mv shield /usr/bin/shield \
    && chmod 0755 /usr/bin/shield

# git-lfs
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && \
    apt-get install -yy git-lfs && \
    git lfs install

# hugo
RUN curl -L >hugo.tar.gz "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz" \
    && tar -xzvf hugo.tar.gz -C /usr/bin \
    && rm hugo.tar.gz

# jq
RUN curl -sOL "https://github.com/stedolan/jq/releases/download/jq-${JQ_VERSION}/jq-linux64" \
    && mv jq-linux64 /usr/bin/jq \
    && chmod 0755 /usr/bin/jq

# kubectl
RUN v=$(curl -L -s https://dl.k8s.io/release/stable.txt) ; \
    curl -LO "https://dl.k8s.io/release/${v}/bin/linux/amd64/kubectl" \
    && mv kubectl /usr/bin/kubectl \
    && chmod 0755 /usr/bin/kubectl

# hub
RUN curl -sOL "https://github.com/github/hub/releases/download/v${HUB_VERSION}/hub-linux-amd64-${HUB_VERSION}.tgz" \
    && tar -xvzf hub-linux-amd64-${HUB_VERSION}.tgz \
    && mv hub-linux-amd64-2.14.2/bin/hub /usr/bin/hub \
    && chmod 0755 /usr/bin/hub

# cf v7
RUN curl -sL "https://packages.cloudfoundry.org/stable?release=linux64-binary&version=${CF_7_VERSION}&source=github-rel" -o cf-cli_${CF_7_VERSION}_linux_x86-64.tgz  \
    && tar -xvzf cf-cli_${CF_7_VERSION}_linux_x86-64.tgz \
    && mv cf7 /usr/bin/cf7 \
    && chmod 0755 /usr/bin/cf7

# cf v8
RUN curl -sL "https://packages.cloudfoundry.org/stable?release=linux64-binary&version=${CF_8_VERSION}&source=github-rel" -o cf-cli_${CF_8_VERSION}_linux_x86-64.tgz \
    && tar -xvzf cf-cli_${CF_8_VERSION}_linux_x86-64.tgz \
    && mv cf8 /usr/bin/cf8 \
    && mv cf /usr/bin/cf \
    && chmod 0755 /usr/bin/cf8

# uaac
RUN gem install cf-uaac -v 4.2.0 --no-document

# Add a user for running things as non-superuser
RUN useradd -ms /bin/bash worker

