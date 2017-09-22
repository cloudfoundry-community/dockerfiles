FROM ubuntu

ENV COLUMNS=80

# COLUMNS var added to work around bosh cli needing a terminal size specified

ADD scripts/install_aws_cli.sh /opt/scripts/

# base packages
RUN apt-get update && \
    apt-get install -yy wget curl file unzip git ruby make bzip2

# packages from https://apt.starkandwayne.com/
RUN wget -q -O - https://raw.githubusercontent.com/starkandwayne/homebrew-cf/master/public.key | apt-key add -
RUN echo "deb http://apt.starkandwayne.com stable main" | tee /etc/apt/sources.list.d/starkandwayne.list
RUN apt-get update && apt-get install -y \
      spruce \
      safe \
      bosh-cli \
      vault \
      genesis \
      gotcha \
      shield \
      certstrap \
      credhub-cli \
      cf-cli \
      jq \
      sipcalc \
      concourse-fly \
      concourse \
      om \
      pivnet-cli \
      hub
      
# safe uses xxd in tests
RUN apt-get update && apt-get install -y vim-common

# bosh-init/create-env deps
RUN apt-get update && \
    apt-get install -yy build-essential zlibc zlib1g-dev ruby-dev openssl libxslt-dev libxml2-dev libssl-dev libreadline6 libreadline6-dev libyaml-dev libsqlite3-dev sqlite3

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
