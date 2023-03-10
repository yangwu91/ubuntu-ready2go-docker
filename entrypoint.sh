#!/bin/bash

set -ex
set -o pipefail

function main() {
    if (( $# != 0 )); then
        $@
    else
        /bin/bash
    fi
}

main $@