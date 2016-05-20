# Sourcing script is expected to have defined BASEDIR correctly

. ${BASEDIR}/inc/_common.sh

INSTALL__APT_CACHE_UPDATED=false

install::update_apt_cache() {
  sudo apt-get update
}

install::update_apt_cache_once() {
  if [ ${INSTALL__APT_CACHE_UPDATED} = "false" ]; then
    INSTALL__APT_CACHE_UPDATED=true
    install::update_apt_cache
  fi
}

install::install() {
  local PKG="${1:-}"

  [ -z "${PKG}" ] && die "No package given"

  sudo apt-get install -y "${PKG}"
}

# $1 - package name
install::install_if_missing() {
  local PKG="${1:-}"

  [ -z "${PKG}" ] && die "No package given"

  if ! dpkg -s ${PKG} &>/dev/null ; then
    echo "To be installed: ${PKG}"
    install::update_apt_cache_once
    install::install "${PKG}"
  else
    echo "Already installed, skipping: ${PKG}"
  fi
}
