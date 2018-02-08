FROM ubuntu

ENV COLUMNS=80

# COLUMNS var added to work around bosh cli needing a terminal size specified

ADD scripts/install_aws_cli.sh /opt/scripts/

# base packages
RUN apt-get update && \
    apt-get install -yy wget curl file unzip git ruby make bzip2 python3-pip && \
    pip3 install --upgrade pip

# packages from https://apt.starkandwayne.com/
RUN wget -q -O - https://raw.githubusercontent.com/starkandwayne/homebrew-cf/master/public.key | apt-key add - \
 && echo "deb http://apt.starkandwayne.com stable main" | tee /etc/apt/sources.list.d/starkandwayne.list \
 && apt-get update && apt-get install -y \
      autoconf \
      bosh-cli \
      build-essential \
      certstrap \
      cf-cli \
      concourse \
      concourse-fly \
      credhub-cli \
      genesis \
      gotcha \
      hub \
      jq \
      libreadline6 \
      libreadline6-dev \
      libsqlite3-dev \
      libssl-dev \
      libxml2-dev \
      libxslt-dev \
      libyaml-dev \
      lsof \
      om \
      openssl \
      pivnet-cli \
      ruby-dev \
      safe \
      shield \
      sipcalc \
      spruce \
      sqlite3 \
      vault \
      vim-common \
      zlib1g-dev \
      zlibc \
  && rm -rf /var/lib/apt/lists/*

# spiff
RUN curl -L >spiff.zip https://github.com/cloudfoundry-incubator/spiff/releases/download/v1.0.5/spiff_linux_amd64.zip \
 && unzip spiff.zip -d /usr/bin \
 && rm spiff.zip

# Python + AWS CLI
RUN /opt/scripts/install_aws_cli.sh

# Rubygems
RUN gem install bosh_cli cf-uaac fpm deb-s3 --no-ri --no-rdoc

# Add a user for running things as non-superuser
RUN useradd -ms /bin/bash worker
