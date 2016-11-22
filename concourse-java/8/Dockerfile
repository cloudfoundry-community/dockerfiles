FROM starkandwayne/concourse

# base packages
RUN apt-get install -yy curl file openjdk-8-jdk ca-certificates-java=20140324

RUN /var/lib/dpkg/info/ca-certificates-java.postinst configure
