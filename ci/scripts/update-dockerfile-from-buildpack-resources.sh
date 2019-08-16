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

if [[ -z $(git config --global user.email) ]]; then
  git config --global user.email "${git_email}"
fi
if [[ -z $(git config --global user.name) ]]; then
  git config --global user.name "${git_name}"
fi

for dockerfile in $(ls -d concourse-$dependency/*/Dockerfile); do
  for version_prefix in $(basename $(dirname $dockerfile)); do
    echo "Checking $version_prefix of $dockerfile"
    latest_version=$version_prefix$(echo "$dependencies" | jq -r ".[].version | scan(\"^$version_prefix(.*)\")[0]" | sort -r | head -n 1)
    echo "Latest version $latest_version"
    latest_dep=$(echo "$dependencies" | jq -r --arg dep $dependency --arg version $latest_version '.[] | select(.name == $dep and .version == $version)')

    sed -i "s%^ENV ${dockerfile_dep_prefix}_VERSION.*$%ENV ${dockerfile_dep_prefix}_VERSION $latest_version%" $dockerfile
    sed -i "s%^ENV ${dockerfile_dep_prefix}_URL.*$%ENV ${dockerfile_dep_prefix}_URL $(echo "$latest_dep" | jq -r ".uri")%" $dockerfile
    sed -i "s%^ENV ${dockerfile_dep_prefix}_SHA256.*$%ENV ${dockerfile_dep_prefix}_SHA256 $(echo "$latest_dep" | jq -r ".sha256")%" $dockerfile

    if [[ "$(git status -s)X" != "X" ]]; then
      echo "Detected new $dependency $latest_version"
      git merge --no-edit master
      git status
      git --no-pager diff
      git add $dockerfile
      git commit -m "Updated $dependency $latest_version"
    fi
  done
done