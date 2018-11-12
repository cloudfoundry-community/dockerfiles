FROM ubuntu

ENV COLUMNS=80

# COLUMNS var added to work around bosh cli needing a terminal size specified

# base packages
RUN apt-get update \
    && export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" \
    && apt-get install -yy wget gnupg \
    && wget -q -O - https://raw.githubusercontent.com/starkandwayne/homebrew-cf/master/public.key | apt-key add - \
    && echo "deb http://apt.starkandwayne.com stable main" | tee /etc/apt/sources.list.d/starkandwayne.list \
    && wget -q -O - https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
    && echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list \
    && echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
    && apt-get update && apt-get install -yy \
      curl \
      git \
      google-cloud-sdk \
      file \
      jq \
      kubectl \
      unzip \
    && rm -rf /var/lib/apt/lists/* \
    && gcloud init

# Add a user for running things as non-superuser
RUN useradd -ms /bin/bash worker
