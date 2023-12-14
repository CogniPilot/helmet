#!/bin/bash
set -e
set -x

sudo apt-get -y update
sudo DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y
sudo DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
  adwaita-icon-theme-full \
  appmenu-gtk2-module \
  appmenu-gtk3-module \
  bash-completion \
  build-essential \
  ca-certificates \
  ccache \
  clang-format \
  clang-tidy \
  cmake \
  curl \
  ddd \
  device-tree-compiler \
  dfu-util \
  file \
  g++-multilib \
  gcc \
  gcc-multilib \
  gdb \
  git \
  gnupg \
  gnupg2 \
  gperf \
  htop \
  ipe \
  iproute2 \
  keychain \
  lcov \
  libasan6 \
  libcanberra-gtk3-module \
  libmagic1 \
  libsdl2-dev \
  locales \
  lsb-release \
  make \
  meld \
  menu \
  mesa-utils \
  net-tools \
  ninja-build \
  nodejs \
  openbox \
  pkg-config \
  python3-dev \
  python3-jinja2 \
  python3-numpy \
  python3-pip \
  python3-pyelftools \
  python3-pykwalify \
  python3-setuptools \
  python3-tk \
  python3-venv \
  python3-wheel \
  python3-xdg \
  python3-xmltodict \
  qt5dxcb-plugin \
  screen \
  terminator \
  unzip \
  valgrind \
  vim \
  wget \
  xterm \
  xz-utils

sudo pip install protobuf

curl -sSL https://install.python-poetry.org | sudo POETRY_HOME=/opt/poetry python3 -

# vim setup
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
