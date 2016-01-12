FROM starkandwayne/concourse
# https://github.com/starkandwayne/dockerfiles/blob/master/concourse/Dockerfile

RUN apt-get update && apt-get install bzr -y

# Install Go
# mkdir -p /goroot will create goroot dir under the root in the docker
# curl url will output to stand out, with | to direct it to tar, which will extract the precompliled 
# go lang to /goroot

RUN \
  mkdir -p /goroot /gopath && \
  curl https://storage.googleapis.com/golang/go1.4.2.linux-amd64.tar.gz | \
  tar xvzf - -C /goroot --strip-components=1

# Set environment variables.
ENV GOROOT /goroot
ENV GOPATH /gopath
ENV PATH $GOROOT/bin:$GOPATH/bin:$PATH

# Useful go packages 
RUN go get golang.org/x/tools/cmd/vet
RUN go get golang.org/x/tools/cmd/cover
RUN go get github.com/golang/lint/golint
RUN go get github.com/tools/godep
RUN go get github.com/laher/goxc
