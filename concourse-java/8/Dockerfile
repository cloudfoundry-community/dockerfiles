FROM starkandwayne/concourse

# https://github.com/cloudfoundry/java-buildpack does not have a manifest.yml
# so just bumping the java-buildpack version so as to trigger update of docker image
ENV JAVA_BUILDPACK 4.47

# base packages
RUN apt-get update && \
  apt-get install -yy curl file openjdk-8-jdk maven && \
  apt-get remove  -yy openjdk-11-jre-headless && \
  java -version

RUN /var/lib/dpkg/info/ca-certificates-java.postinst configure
