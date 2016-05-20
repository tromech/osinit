#!/bin/bash

set -u

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

. "${BASEDIR}"/inc/_install.sh

if [ $# -ne 1 ]; then
  echo "usage: <packageset>, one of:"
  for f in "${BASEDIR}"/*.apt ; do
    PKGSET_FILE=`basename $f`
    PKGSET="${PKGSET_FILE%.apt}"
    echo "- ${PKGSET}"
  done
  exit 1
fi

if [ ! -f "${BASEDIR}/${1}.apt" ]; then
  echo "Can't find packageset file ${BASEDIR}/${1}.apt"
  exit 2
fi

for PKG in `cat "${BASEDIR}/${1}.apt"`; do
  install::install_if_missing "${PKG}"
done
