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
      libtool \
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
# Install Hugo
RUN curl -L >hugo.tar.gz https://github.com/gohugoio/hugo/releases/download/v0.36/hugo_0.36_Linux-64bit.tar.gz \
 && tar -xzvf hugo.tar.gz -C /usr/bin \
 && rm hugo.tar.gz

# Python + AWS CLI
RUN /opt/scripts/install_aws_cli.sh

# Rubygems
RUN gem install cf-uaac fpm deb-s3 --no-ri --no-rdoc

# Add a user for running things as non-superuser
RUN useradd -ms /bin/bash worker
