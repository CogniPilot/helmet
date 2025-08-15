#!/bin/bash
set -e

ROS_VERSION="jazzy"

if ! [ -f /etc/apt/sources.list.d/ros2.sources ]; then
  export ROS_APT_SOURCE_VERSION=$(curl -s https://api.github.com/repos/ros-infrastructure/ros-apt-source/releases/latest | grep -F "tag_name" | awk -F\" '{print $4}')
  curl -L -o /tmp/ros2-apt-source.deb "https://github.com/ros-infrastructure/ros-apt-source/releases/download/${ROS_APT_SOURCE_VERSION}/ros2-apt-source_${ROS_APT_SOURCE_VERSION}.$(. /etc/os-release && echo $VERSION_CODENAME)_all.deb" # If using Ubuntu derivates use $UBUNTU_CODENAME
  sudo dpkg -i /tmp/ros2-apt-source.deb
fi

sudo apt-get -y update
sudo DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
  ros-dev-tools \
  python3-colcon-common-extensions \
  python3-colcon-ros \
  python3-rosdep \
  python3-vcstool \
  ros-${ROS_VERSION}-ament-cmake \
  ros-${ROS_VERSION}-actuator-msgs \
  ros-${ROS_VERSION}-compressed-image-transport \
  ros-${ROS_VERSION}-cyclonedds \
  ros-${ROS_VERSION}-desktop \
  ros-${ROS_VERSION}-foxglove-bridge \
  ros-${ROS_VERSION}-gps-msgs \
  ros-${ROS_VERSION}-nav2-bringup \
  ros-${ROS_VERSION}-navigation2 \
  ros-${ROS_VERSION}-rmw-cyclonedds-cpp \
  ros-${ROS_VERSION}-rqt-tf-tree \
  ros-${ROS_VERSION}-topic-tools

# vi: ts=2 sw=2 et
