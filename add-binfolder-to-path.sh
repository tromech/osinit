#!/bin/bash

set -u

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

. ${BASEDIR}/bin/inc/_common.sh

REPO_BASEDIR="${BASEDIR}"
ADD_BIN_DIR="${REPO_BASEDIR}/bin"

[ -d "${ADD_BIN_DIR}" ] || die "Can't find folder ${ADD_BIN_DIR} to be added to PATH"

TARGET_DIR="${HOME}/.bashrc.d"
TARGET_FILE="${TARGET_DIR}/99-add-osinit-bin-to-path.bash"

[ -d "$TARGET_DIR" ] || die "Can't find folder ${TARGET_DIR} to write script to"
[ -f "$TARGET_FILE" ] && echo "Warn: overwriting existing file ${TARGET_FILE}"

cat > "${TARGET_FILE}" <<EOF
if ! echo "\${PATH}" | grep -q "${ADD_BIN_DIR}" ; then
  PATH=\$PATH:$ADD_BIN_DIR
fi
EOF
