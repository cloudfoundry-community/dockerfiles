FROM starkandwayne/concourse
# https://github.com/starkandwayne/dockerfiles/blob/master/concourse/Dockerfile

USER root
RUN apt-get update && apt-get install bzr gcc -y

# Install Go
# mkdir -p /goroot will create goroot dir under the root in the docker
# curl url will output to stand out, with | to direct it to tar, which will extract the precompliled
# go lang to /goroot

# https://golang.org/dl/
ENV GOLANG_VERSION 1.13.15
ENV GOLANG_URL https://buildpacks.cloudfoundry.org/dependencies/go/go_1.13.15_linux_x64_cflinuxfs3_03745468.tgz
ENV GOLANG_SHA256 0374546870b055b01e4aea14fd05cc30dd4bda45f46a48c3cb960167a95afb96
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
 && go get github.com/laher/goxc
