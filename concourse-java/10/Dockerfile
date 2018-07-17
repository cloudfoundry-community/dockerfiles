FROM starkandwayne/concourse

# base packages
RUN apt update && \
  apt remove openjdk-11-jre-headless -yy && \
  apt install -yy curl file openjdk-10-jdk maven

RUN /var/lib/dpkg/info/ca-certificates-java.postinst configure
