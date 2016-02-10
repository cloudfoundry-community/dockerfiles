FROM concourse/concourse-ci

ENV SPRUCE_VERSION=1.0.2 \
    CF_CLI_VERSION=6.13.0

ADD scripts/install_aws_cli.sh /opt/scripts/

# base packages
RUN apt-get install -yy curl

# spruce
RUN curl -L >/usr/bin/spruce https://github.com/geofffranks/spruce/releases/download/v${SPRUCE_VERSION}/spruce-linux-amd64 \
  && chmod 0755 /usr/bin/spruce

# spiff
RUN curl -L >spiff.zip https://github.com/cloudfoundry-incubator/spiff/releases/download/v1.0.5/spiff_linux_amd64.zip \
 && unzip spiff.zip -d /usr/bin \
 && rm spiff.zip

# jq
RUN curl -L >/usr/bin/jq http://stedolan.github.io/jq/download/linux64/jq \
  && chmod 755 /usr/bin/jq

# cf-cli
RUN curl -L >cf-cli.tar.gz http://go-cli.s3-website-us-east-1.amazonaws.com/releases/v${CF_CLI_VERSION}/cf-linux-amd64.tgz \
  && tar -xzvf cf-cli.tar.gz \
  && mv cf /usr/bin/cf \
  && rm -f cf-cli.tar.gz

# Python + AWS CLI
RUN /opt/scripts/install_aws_cli.sh
