FROM starkandwayne/concourse

# base packages
RUN apt-get update && \
  apt-get install -yy curl file openjdk-8-jdk maven && \
  apt-get remove  -yy openjdk-11-jre-headless && \
  java -version

RUN /var/lib/dpkg/info/ca-certificates-java.postinst configure
