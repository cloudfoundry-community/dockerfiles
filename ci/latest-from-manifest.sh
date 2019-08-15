#!/bin/bash

set -eu

manifest=$1   # path/to/buildpack/manifest.yml
dependency=$2 # e.g. go, ruby, java
version_prefix=$3 # e.g. 1.12.
[[ -f $manifest ]] || { echo "pass path to manifest.yml"; exit 1; }

dependencies=$(spruce json $manifest | jq -r --arg dep $dependency '.dependencies | map(select(.name == $dep))')
latest_version=$version_prefix$(echo "$dependencies" | jq -r ".[].version | scan(\"^$version_prefix(.*)\")[0]" | sort -r | head -n 1)
latest_dep=$(echo "$dependencies" | jq -r --arg dep $dependency --arg version $latest_version '.[] | select(.name == $dep and .version == $version)')
echo "$latest_dep" | jq -r ".uri"
echo "$latest_dep" | jq -r ".sha256"