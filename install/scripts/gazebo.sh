#!/bin/bash
set -e

GAZEBO_VERSION="harmonic"

if ! [ -f /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg ]; then
  sudo wget https://packages.osrfoundation.org/gazebo.gpg -O /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg
fi

if ! [ -f /etc/apt/sources.list.d/gazebo-stable.list ]; then
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/gazebo-stable.list > /dev/null
fi

sudo apt-get -y update
sudo DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
  gz-${GAZEBO_VERSION} \
  ros-humble-ros-gz${GAZEBO_VERSION}-bridge \
  ros-humble-ros-gz${GAZEBO_VERSION}-image \
  ros-humble-ros-gz${GAZEBO_VERSION}-sim

# vi: ts=2 sw=2 et
