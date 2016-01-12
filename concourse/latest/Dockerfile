FROM concourse/concourse-ci

ENV SPRUCE_VERSION=0.13.0 \
    CF_CLI_VERSION=6.13.0

# base packages
RUN apt-get install -yy curl

# spruce
RUN curl -L >spruce.tar.gz https://github.com/geofffranks/spruce/releases/download/v${SPRUCE_VERSION}/spruce_${SPRUCE_VERSION}_linux_amd64.tar.gz \
  && tar -xvzf spruce.tar.gz \
  && mv spruce_${SPRUCE_VERSION}_linux_amd64/spruce /usr/bin/spruce \
  && rm -rf spruce.tar.gz spruce_${SPRUCE_VERSION}_linux_amd64

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
