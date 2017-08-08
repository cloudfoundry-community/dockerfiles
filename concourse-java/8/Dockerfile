FROM starkandwayne/concourse

# base packages
RUN apt-get update && apt-get install -yy curl file openjdk-8-jdk maven

RUN /var/lib/dpkg/info/ca-certificates-java.postinst configure
