FROM starkandwayne/concourse
# https://github.com/starkandwayne/dockerfiles/blob/master/concourse/Dockerfile

USER root
RUN apt-get update && apt-get install bzr gcc -y

# Install Go
# mkdir -p /goroot will create goroot dir under the root in the docker
# curl url will output to stand out, with | to direct it to tar, which will extract the precompliled
# go lang to /goroot

# https://golang.org/dl/
ENV GOLANG_VERSION 1.14.9
ENV GOLANG_URL https://buildpacks.cloudfoundry.org/dependencies/go/go_1.14.9_linux_x64_cflinuxfs3_0f657a41.tgz
ENV GOLANG_SHA256 0f657a419b317dab4ff8b62cfdeab69c0bcad25458bf454cb79b61da05c1ac54
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
