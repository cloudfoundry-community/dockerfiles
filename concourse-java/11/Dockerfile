FROM starkandwayne/concourse

# base packages
RUN apt-get update && \
  apt-get install -yy curl file openjdk-11-jdk maven && \
  java -version

RUN /var/lib/dpkg/info/ca-certificates-java.postinst configure
