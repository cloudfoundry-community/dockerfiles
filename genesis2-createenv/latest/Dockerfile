FROM starkandwayne/genesis2

# COLUMNS var added to work around bosh cli needing a terminal size specified
ENV COLUMNS=80

# base packages and create-env deps
RUN apt-get update && \
    apt-get install -yy \
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

