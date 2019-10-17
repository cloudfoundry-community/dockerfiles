FROM ubuntu

ENV COLUMNS=80

# COLUMNS var added to work around bosh cli needing a terminal size specified

# base packages
RUN apt-get update \
    && export CLOUD_SDK_REPO=cloud-sdk-$(cat /etc/lsb-release | grep DISTRIB_CODENAME | awk -F "=" '{print $2}') \
    && apt-get install -yy wget gnupg \
    && wget -q -O - https://raw.githubusercontent.com/starkandwayne/homebrew-cf/master/public.key | apt-key add - \
    && echo "deb http://apt.starkandwayne.com stable main" | tee /etc/apt/sources.list.d/starkandwayne.list \
    && wget -q -O - https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
    && echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list \
    && echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
    && apt-get update && apt-get install -yy \
      bosh-cli \
      curl \
      git \
      google-cloud-sdk \
      file \
      jq \
      kubectl \
      unzip \
    && rm -rf /var/lib/apt/lists/* \
    && HELM_VERSION=$(curl -s https://api.github.com/repos/helm/helm/releases/latest | jq -r ".tag_name") \
    && curl -LO https://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz \
    && tar xfz helm-*.tar.gz \
    && mv linux-amd64/helm  /usr/local/bin \
    && rm -f tar xfz helm-*.tar.gz \
    && helm version --client \
    && helm init --client-only

# Add a user for running things as non-superuser
RUN useradd -ms /bin/bash worker
