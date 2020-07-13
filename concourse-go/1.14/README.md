starkandwayne/concourse-go:1.14
==============================

Task Image for running Concourse Pipelines - Now With Go 1.14!

This Docker image contains a set of utilities commonly used in
Concourse pipelines, pre-installed, along with Go 1.14.

The `$GOPATH` and `$GOROOT` environment variables will already be
set for you (to `/gopath` and `/goroot`, respectively).  Likewise,
`$PATH` is properly set up to include the binaries installed by
`go get`.

The following useful tools are installed by default:

- [go cover][gocover] - Tool for generating test coverage reports
- [go vet][govet] - Tool for vetting your source code for possible
  issues and non-idiomatic usage
- [golint][golint] - A linter for Go source code
- [godep][godep] - Dependency management utility for Go projects
- [goxc][goxc] - Go cross-compiler




[gocover]: https://godoc.org/golang.org/x/tools/cmd/cover
[govet]:   https://godoc.org/golang.org/x/tools/cmd/vet
[golint]:  https://github.com/golang/lint
[godep]:   https://github.com/tools/godep
[goxc]:    https://github.com/laher/goxc
