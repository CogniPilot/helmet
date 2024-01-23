#!/bin/bash
set -e

WGET_ARGS="-q --show-progress --progress=bar:force:noscroll --no-check-certificate"
ZSDK_VERSION="0.16.4"

# https://docs.zephyrproject.org/latest/develop/getting_started/index.html
# get full sdk
if ! [ -f /opt/toolchains/zephyr-sdk-${ZSDK_VERSION}/setup.sh ]; then
  sudo mkdir -p /opt/toolchains
  pushd /opt/toolchains
  sudo wget ${WGET_ARGS} https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v${ZSDK_VERSION}/zephyr-sdk-${ZSDK_VERSION}_linux-x86_64.tar.xz
  sudo tar xvf zephyr-sdk-${ZSDK_VERSION}_linux-x86_64.tar.xz
  pushd zephyr-sdk-${ZSDK_VERSION}
  sudo ./setup.sh -t all -h
  sudo rm /opt/toolchains/zephyr-sdk-${ZSDK_VERSION}_linux-x86_64.tar.xz
  popd
  popd
fi

# setup west
if ! [ -f /opt/.venv-zephyr/bin/activate ]; then
  CURRENT_USER=`whoami`
  sudo mkdir -p /opt/.venv-zephyr
  sudo chown $CURRENT_USER:$CURRENT_USER /opt/.venv-zephyr
  python3 -m venv --prompt zephyr /opt/.venv-zephyr
  source /opt/.venv-zephyr/bin/activate
  pip install wheel west catkin-tools protobuf
  pip install -r https://raw.githubusercontent.com/zephyrproject-rtos/zephyr/master/scripts/requirements.txt
  pip3 check
fi


# vi: ts=2 sw=2 et
