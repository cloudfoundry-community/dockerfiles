FROM ubuntu

# COLUMNS var added to work around bosh cli needing a terminal size specified
ENV COLUMNS=80

# base packages and create-env deps
RUN apt-get update && \
    apt-get install -yy \
    wget \
    git \
    \
    build-essential \
    zlibc \
    zlib1g-dev \
    ruby \
    ruby-dev \
    openssl \
    libxslt-dev \
    libxml2-dev \
    libssl-dev \
    libreadline6 \
    libreadline6-dev \
    libyaml-dev \
    libsqlite3-dev \
    sqlite3 && \
    \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# packages from https://apt.starkandwayne.com/
RUN wget -q -O - https://raw.githubusercontent.com/starkandwayne/homebrew-cf/master/public.key | \
    apt-key add - && \
    echo "deb http://apt.starkandwayne.com stable main" | \
    tee /etc/apt/sources.list.d/starkandwayne.list && \
    apt-get update && apt-get install -y \
    spruce \
    safe \
    bosh-cli \
    vault && \
    \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Add a user for running things as non-superuser
RUN useradd -ms /bin/bash worker
