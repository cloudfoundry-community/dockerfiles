FROM starkandwayne/concourse

# base packages
RUN apt-get install -yy curl file openjdk-8-jdk ca-certificates-java

RUN /var/lib/dpkg/info/ca-certificates-java.postinst configure
