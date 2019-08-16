#!/bin/bash
if [[ -z ${1} ]]; then
	echo >&2 "USAGE: $0 concourse-target"
	exit 1
fi
concourse=${1}

fly_cmd="${FLY_CMD:-fly}"

set -eu
root=$(cd $(dirname $BASH_SOURCE[0])/..; pwd)

if [[ -z $(command -v spruce 2>/dev/null) ]]; then
	echo >&2 "spruce is missing!  Please install spruce from https://github.com/geofffranks/spruce"
	exit 1
fi

ifpresent() {
	for file in "$@"; do
		[ -f ${file} ] && echo ${file}
	done
}

(cd ${root}/ci && \
 spruce merge \
        $(ifpresent ../*/pipeline.yml ../*/*/pipeline.yml)  \
    > .full.yml) || exit 2
(cd ${root}/ci && \
 spruce merge --prune meta .full.yml \
    > .live.yml) || exit 2

set -x
$fly_cmd set-pipeline -p docker-images -c ${root}/ci/.live.yml -t ${concourse}
