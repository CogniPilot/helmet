#!/bin/bash
set -e
set -x

ROS_VERSION="humble"

if ! [ -f /usr/share/keyrings/ros-archive-keyring.gpg ]; then
  sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
fi

if ! [ -f /etc/apt/sources.list.d/ros2.list ]; then
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
fi

sudo apt-get -y update
sudo DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
  ament-cmake \
  python3-colcon-common-extensions \
  python3-colcon-ros \
  python3-rosdep \
  python3-vcstool \
  ros-${ROS_VERSION}-actuator-msgs \
  ros-${ROS_VERSION}-cyclonedds \
  ros-${ROS_VERSION}-desktop \
  ros-${ROS_VERSION}-foxglove-bridge \
  ros-${ROS_VERSION}-gps-msgs \
  ros-${ROS_VERSION}-nav2-bringup \
  ros-${ROS_VERSION}-navigation2 \
  ros-${ROS_VERSION}-rmw-cyclonedds-cpp \
  ros-${ROS_VERSION}-rqt-tf-tree \
  ros-${ROS_VERSION}-topic-tools

sudo pip install cyclonedds pycdr2

# vi: ts=2 sw=2 et
