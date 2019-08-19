FROM starkandwayne/concourse

# https://github.com/cloudfoundry/java-buildpack does not have a manifest.yml
# so just bumping the java-buildpack version so as to trigger update of docker image
ENV JAVA_BUILDPACK 4.20

# base packages
RUN apt-get update && \
  apt-get install -yy curl file openjdk-11-jdk maven && \
  java -version

RUN /var/lib/dpkg/info/ca-certificates-java.postinst configure
