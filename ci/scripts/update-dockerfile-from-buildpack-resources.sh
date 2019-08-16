#!/bin/bash

set -eu

root="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../.." && pwd )"

: ${buildpack:?required: path/to/buildpack.zip or "path/to/buildpack-*.zip"}
: ${dependency:?required: e.g. go, ruby, java}
: ${dockerfile_dep_prefix:?required: e.g. GOLANG, RUBY}

[[ -f $(eval ls $buildpack) ]] || { echo "pass path to buildpack.zip; bad parameter: '$buildpack'"; exit 1; }

manifest=$(unzip -p $(eval ls $buildpack) manifest.yml)
dependencies=$(spruce json <(echo "$manifest") | jq -r --arg dep $dependency '.dependencies | map(select(.name == $dep))')

git clone $root pushme
cd pushme

for dockerfile in $(ls -d concourse-$dependency/*/Dockerfile); do
  for version_prefix in $(basename $(dirname $dockerfile)); do
    latest_version=$version_prefix$(echo "$dependencies" | jq -r ".[].version | scan(\"^$version_prefix(.*)\")[0]" | sort -r | head -n 1)
    latest_dep=$(echo "$dependencies" | jq -r --arg dep $dependency --arg version $latest_version '.[] | select(.name == $dep and .version == $version)')

    sed -i "s%^ENV ${dockerfile_dep_prefix}_VERSION.*$%ENV ${dockerfile_dep_prefix}_VERSION $latest_version%" $dockerfile
    sed -i "s%^ENV ${dockerfile_dep_prefix}_URL.*$%ENV ${dockerfile_dep_prefix}_URL $(echo "$latest_dep" | jq -r ".uri")%" $dockerfile
    sed -i "s%^ENV ${dockerfile_dep_prefix}_SHA256.*$%ENV ${dockerfile_dep_prefix}_SHA256 $(echo "$latest_dep" | jq -r ".sha256")%" $dockerfile
  done
done