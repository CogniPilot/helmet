#!/bin/bash
set -e
set -x

WGET_ARGS="-q --show-progress --progress=bar:force:noscroll --no-check-certificate"
ZSDK_VERSION="0.16.1"

# https://docs.zephyrproject.org/latest/develop/getting_started/index.html
sudo mkdir -p /opt/toolchains
cd /opt/toolchains

# get full sdk
sudo wget ${WGET_ARGS} https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v${ZSDK_VERSION}/zephyr-sdk-${ZSDK_VERSION}_linux-x86_64.tar.xz
sudo tar xvf zephyr-sdk-${ZSDK_VERSION}_linux-x86_64.tar.xz
cd /opt/toolchains/zephyr-sdk-${ZSDK_VERSION}
sudo ./setup.sh -t all -h
sudo rm /opt/toolchains/zephyr-sdk-${ZSDK_VERSION}_linux-x86_64.tar.xz

# setup west
CURRENT_USER=`whoami`
sudo mkdir /opt/.venv-zephyr
sudo chown $CURRENT_USER:$CURRENT_USER /opt/.venv-zephyr
python3 -m venv --prompt zephyr /opt/.venv-zephyr
source /opt/.venv-zephyr/bin/activate
pip install wheel
pip install west
pip install catkin-tools
pip install -r https://raw.githubusercontent.com/zephyrproject-rtos/zephyr/master/scripts/requirements.txt
pip3 check
