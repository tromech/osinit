#!/bin/bash

set -u

HD="${HOME}"

if [ -e "${HD}/.bashrc" ]; then
  if ! grep -q .bashrc.d "${HD}/.bashrc"; then
    echo "Adding auto-load of ${HD}/.bashrc.d files to ${HD}/.bashrc..."
    mkdir -p "${HD}/.bashrc.d"
    cat >> "${HD}/.bashrc" <<EOF

# Load any supplementary scripts
if [ -d "\$HOME"/.bashrc.d ]; then
  for config in "\$HOME"/.bashrc.d/*.bash ; do
    if [ -e "\$config" ]; then
      source "\$config"
    fi
  done
  unset -v config
fi
EOF
  else
    echo "Already found .bashrc.d in ${HD}/.bashrc, aborting"
  fi
else
  echo "Couldn't find ${HD}/.bashrc, aborting"
fi
