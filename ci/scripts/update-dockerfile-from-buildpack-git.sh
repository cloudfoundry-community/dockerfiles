#!/bin/bash

set -eu

root="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../.." && pwd )"

: ${buildpack:?required: path/to/buildpack}
: ${dependency:?required: e.g. go, ruby, java}
: ${dockerfile_dep_prefix:?required: e.g. GOLANG, RUBY}
dockerfile_name=${dockerfile_name:-$dependency}

manifest=${buildpack}/manifest.yml
[[ -f $manifest ]] || { echo "No $manifest found"; exit 1; }
dependencies=$(spruce json $manifest | jq -r --arg dep $dependency '.dependencies | map(select(.name == $dep))')

git clone $root pushme
cd pushme

if [[ -z $(git config --global user.email) ]]; then
  git config --global user.email "${git_email}"
fi
if [[ -z $(git config --global user.name) ]]; then
  git config --global user.name "${git_name}"
fi

for dockerfile in $(ls -d concourse-$dockerfile_name/*/Dockerfile); do
  version_prefix=$(basename $(dirname $dockerfile))
  echo "Checking $version_prefix of $dockerfile"
  patch_release=$(echo "$dependencies" | jq -r ".[].version | scan(\"^$version_prefix(.*)\")[0]" | sort -r | head -n 1)
  # do not touch Dockerfile if manifest.yml does not yet/no longer includes versions
  if [[ "${patch_release:-X}" != "X" ]]; then
    latest_version=$version_prefix$patch_release
    echo "Latest version $latest_version"
    latest_dep=$(echo "$dependencies" | jq -r --arg dep $dependency --arg version $latest_version '.[] | select(.name == $dep and .version == $version and .cf_stacks == ["cflinuxfs3"])')

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
  fi
done