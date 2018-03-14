starkandwayne/concourse-oldbosh
=======================

Task Image for running Concourse Pipelines with original bosh CLI

This Docker image contains a set of utilities commonly used in
Concourse pipelines, pre-installed.

- [spruce][spruce] - A YAML template merging utility, useful for
  generating BOSH deployment manifests as part of an automated
  deployment pipeline (or standing up infrastructure to run
  integration tests)
- [jq][jq] - A handy tool for extracting data from JSON blobs
- curl - The command-line URL utility we just can't live without
- [cf][cf] - The Cloud Foundry command-line client, for
  interfacing with CF deployments from inside of pipelines (to
  push apps, for example)




[spruce]: https://github.com/geofffranks/spruce
[jq]: https://stedolan.github.io/jq/
[cf]: https://cloudfoundry.org
