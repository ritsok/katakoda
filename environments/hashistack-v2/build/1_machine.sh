#!/bin/bash

log() {
  echo "==> $(date) - ${1}"
}
log "Running ${0}"

fix_journal() {
  log "Fixing Journal"
  if [ ! -f "/etc/machine-id" ]
  then
    systemd-machine-id-setup > /dev/null 2>&1
    systemd-tmpfiles --create --prefix /var/log/journal
    systemctl start systemd-journald.service
  fi
}

install_apt_deps() {
  log "Installing OS dependencies"
  export DEBIAN_FRONTEND=noninteractive
  apt-get -y update
  apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    lsb-release \
    python3 \
    python3-pip \
    software-properties-common \
    sudo \
    unzip \
    vim \
    wget \
    zip
}

install_pyhcl() {
  log "Installing pyhcl"
  pip3 install -qqq pyhcl
}

fix_journal
install_apt_deps
install_pyhcl
