#!/bin/bash
set -e

sudo apt-get -y update
sudo DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y
sudo DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y vim

sudo mkdir -p /opt/vim/
echo $whoami
sudo chown -R $UID:$UID /opt/vim
if ! [ -d /opt/vim/YouCompleteMe ]; then
  git clone --recurse-submodules https://github.com/ycm-core/YouCompleteMe.git /opt/vim/YouCompleteMe
  pushd /opt/vim/YouCompleteMe
  ./install.py --clangd-completer
  popd
fi
if ! [ -d /opt/vim/NERDCommenter ]; then
  git clone https://github.com/preservim/nerdcommenter.git /opt/vim/NERDCommenter
fi
if ! [ -d /opt/vim/securemodelines ]; then
  git clone https://github.com/ciaranm/securemodelines /opt/vim/securemodelines
fi
# vi: ts=2 sw=2 et
