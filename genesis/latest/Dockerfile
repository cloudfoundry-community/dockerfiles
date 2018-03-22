FROM ubuntu

# COLUMNS var added to work around bosh cli needing a terminal size specified
ENV COLUMNS=80

# base packages
RUN apt-get update && \
    apt-get install -yy wget git

# packages from https://apt.starkandwayne.com/
RUN wget -q -O - https://raw.githubusercontent.com/starkandwayne/homebrew-cf/master/public.key | apt-key add -
RUN echo "deb http://apt.starkandwayne.com stable main" | tee /etc/apt/sources.list.d/starkandwayne.list
RUN apt-get update && apt-get install -y \
    spruce \
    safe \
    bosh-cli \
    vault

# bosh-init/create-env deps
RUN apt-get update && \
    apt-get install -yy build-essential zlibc zlib1g-dev ruby-dev openssl libxslt-dev libxml2-dev libssl-dev libreadline6 libreadline6-dev libyaml-dev libsqlite3-dev sqlite3

# Add a user for running things as non-superuser
RUN useradd -ms /bin/bash worker
