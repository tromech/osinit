#!/bin/bash

set -u

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

"${BASEDIR}"/prepare-bashrc-for-custom-scripts.sh
"${BASEDIR}"/add-binfolder-to-path.sh
