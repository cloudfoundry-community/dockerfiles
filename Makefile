.PHONY: concourse go

concourse:
	docker build -t genesiscommunity/concourse:latest concourse/latest/

go:
	docker build -t genesiscommunity/concourse-go:1.20 concourse-go/1.20/

