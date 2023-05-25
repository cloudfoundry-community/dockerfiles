ARG BASE_IMAGE=genesiscommunity/concourse:latest
FROM --platform=linux/amd64 $BASE_IMAGE
# https://github.com/genesiscommunity/dockerfiles/blob/master/concourse/Dockerfile
# Dockerfile go build ref:
# https://github.com/docker-library/golang/blob/5c6fa89055275c8f182ce96af9f5cde8399bdf76/1.20/bullseye/Dockerfile

USER root

ENV GOPATH /go
ENV GOROOT /usr/local/go

# Set environment variables.
ENV PATH=${GOROOT}/bin:${GOPATH}/bin:$PATH

RUN set -eux; apt-get update; apt-get install -y --no-install-recommends \
		g++ \
		gcc \
		libc6-dev \
		make \
		pkg-config \
	; rm -rf /var/lib/apt/lists/*

ENV PATH /usr/local/go/bin:$PATH

RUN set -eux; \
	arch="$(dpkg --print-architecture)"; arch="${arch##*-}"; \
	url=; \
	case "$arch" in \
		'amd64') \
			url='https://dl.google.com/go/go1.20.4.linux-amd64.tar.gz'; \
			sha256='698ef3243972a51ddb4028e4a1ac63dc6d60821bf18e59a807e051fee0a385bd'; \
			;; \
		'armel') \
			export GOARCH='arm' GOARM='5' GOOS='linux'; \
			;; \
		'armhf') \
			url='https://dl.google.com/go/go1.20.4.linux-armv6l.tar.gz'; \
			sha256='0b75ca23061a9996840111f5f19092a1bdbc42ec1ae25237ed2eec1c838bd819'; \
			;; \
		'arm64') \
			url='https://dl.google.com/go/go1.20.4.linux-arm64.tar.gz'; \
			sha256='105889992ee4b1d40c7c108555222ca70ae43fccb42e20fbf1eebb822f5e72c6'; \
			;; \
		'i386') \
			url='https://dl.google.com/go/go1.20.4.linux-386.tar.gz'; \
			sha256='5dfa3db9433ef6a2d3803169fb4bd2f4505414881516eb9972d76ab2e22335a7'; \
			;; \
		'mips64el') \
			export GOARCH='mips64le' GOOS='linux'; \
			;; \
		'ppc64el') \
			url='https://dl.google.com/go/go1.20.4.linux-ppc64le.tar.gz'; \
			sha256='8c6f44b96c2719c90eebabe2dd866f9c39538648f7897a212cac448587e9a408'; \
			;; \
		's390x') \
			url='https://dl.google.com/go/go1.20.4.linux-s390x.tar.gz'; \
			sha256='57f999a4e605b1dfa4e7e58c7dbae47d370ea240879edba8001ab33c9a963ebf'; \
			;; \
		*) echo >&2 "error: unsupported architecture '$arch' (likely packaging update needed)"; exit 1 ;; \
	esac; \
	build=; \
	if [ -z "$url" ]; then \
# https://github.com/golang/go/issues/38536#issuecomment-616897960
		build=1; \
		url='https://dl.google.com/go/go1.20.4.src.tar.gz'; \
		sha256='9f34ace128764b7a3a4b238b805856cc1b2184304df9e5690825b0710f4202d6'; \
		echo >&2; \
		echo >&2 "warning: current architecture ($arch) does not have a compatible Go binary release; will be building from source"; \
		echo >&2; \
	fi; \
	\
	wget -O go.tgz.asc "$url.asc"; \
	wget -O go.tgz "$url" --progress=dot:giga; \
	echo "$sha256 *go.tgz" | sha256sum -c -; \
	\
# https://github.com/golang/go/issues/14739#issuecomment-324767697
	GNUPGHOME="$(mktemp -d)"; export GNUPGHOME; \
# https://www.google.com/linuxrepositories/
	wget -q -O - https://dl.google.com/linux/linux_signing_key.pub |  gpg --import - ; \
	gpg --batch --verify go.tgz.asc go.tgz; \
	gpgconf --kill all; \
	rm -rf "$GNUPGHOME" go.tgz.asc; \
	\
	tar -C /usr/local -xzf go.tgz; \
	rm go.tgz; \
	\
	if [ -n "$build" ]; then \
		savedAptMark="$(apt-mark showmanual)"; \
# add backports for newer go version for bootstrap build: https://github.com/golang/go/issues/44505
		( \
			. /etc/os-release; \
			echo "deb https://deb.debian.org/debian $VERSION_CODENAME-backports main" > /etc/apt/sources.list.d/backports.list; \
			\
			apt-get update; \
			apt-get install -y --no-install-recommends -t "$VERSION_CODENAME-backports" golang-go; \
		); \
		\
		export GOCACHE='/tmp/gocache'; \
		\
		( \
			cd /usr/local/go/src; \
# set GOROOT_BOOTSTRAP + GOHOST* such that we can build Go successfully
			export GOROOT_BOOTSTRAP="$(go env GOROOT)" GOHOSTOS="$GOOS" GOHOSTARCH="$GOARCH"; \
			./make.bash; \
		); \
		\
		apt-mark auto '.*' > /dev/null; \
		apt-mark manual $savedAptMark > /dev/null; \
		apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
		rm -rf /var/lib/apt/lists/*; \
		\
# remove a few intermediate / bootstrapping files the official binary release tarballs do not contain
		rm -rf \
			/usr/local/go/pkg/*/cmd \
			/usr/local/go/pkg/bootstrap \
			/usr/local/go/pkg/obj \
			/usr/local/go/pkg/tool/*/api \
			/usr/local/go/pkg/tool/*/go_bootstrap \
			/usr/local/go/src/cmd/dist/dist \
			"$GOCACHE" \
		; \
	fi; \
	\
	go version

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" \
    && chmod -R 1777 "$GOPATH" \
    && chown -R worker $GOROOT $GOPATH

WORKDIR $GOPATH

# Frequently used go packages.
RUN go install golang.org/x/tools/cmd/cover@latest \
 && go install golang.org/x/lint/golint@latest \
 && go install github.com/tools/godep@latest \
 && go install github.com/laher/goxc@latest \
 && go install github.com/onsi/ginkgo/ginkgo@latest \
 && go install github.com/onsi/gomega/...@latest

