#!/bin/bash
set -e

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
  libsundials-dev \
  locales \
  lsb-release \
  make \
  meld \
  menu \
  mesa-utils \
  mkdocs \
  net-tools \
  ninja-build \
  nodejs \
  openbox \
  pkg-config \
  protobuf-compiler \
  python3-beartype \
  python3-dev \
  python3-jinja2 \
  python3-numpy \
  python3-poetry \
  python3-protobuf \
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
  wget \
  xterm \
  xz-utils

# vi: ts=2 sw=2 et
