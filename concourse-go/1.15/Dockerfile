FROM starkandwayne/concourse
# https://github.com/starkandwayne/dockerfiles/blob/master/concourse/Dockerfile

USER root
RUN apt-get update && apt-get install bzr gcc -y

# Install Go
# mkdir -p /goroot will create goroot dir under the root in the docker
# curl url will output to stand out, with | to direct it to tar, which will extract the precompliled
# go lang to /goroot

# https://golang.org/dl/
ENV GOLANG_VERSION 1.15.14
ENV GOLANG_URL https://buildpacks.cloudfoundry.org/dependencies/go/go_1.15.14_linux_x64_cflinuxfs3_8b9b139d.tgz
ENV GOLANG_SHA256 8b9b139d3bb1b79e574c1f1d971eb86bdbfedf1beac86ee82487734cf306c0fe
RUN \
  mkdir -p /goroot /gopath  && \
  curl $GOLANG_URL | \
  tar xvzf - -C /goroot --strip-components=1 && \
  chown -R worker /goroot /gopath


# Set environment variables.
ENV \
  GOROOT=/goroot \
  GOPATH=/gopath \
  PATH=/goroot/bin:/gopath/bin:$PATH

# Useful go packages.
RUN go get golang.org/x/tools/cmd/cover \
 && go get golang.org/x/lint/golint \
 && go get github.com/tools/godep \
 && go get github.com/laher/goxc \
 && go get github.com/onsi/ginkgo/ginkgo \
 && go get github.com/onsi/gomega/... 
