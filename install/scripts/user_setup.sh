#!/bin/bash
set -e

# handle arguments for script mode
if [ $# -eq 0 ]
then
  SCRIPT_MODE="native"
elif [ $# -eq 1 ]
then
  SCRIPT_MODE=$1
  if [ $SCRIPT_MODE != "native" ] && [ $SCRIPT_MODE != "docker" ]
  then
    echo "usage: mode must be native or docker, not: ${SCRIPT_MODE}"
  fi
else
  echo "usage: user_setup.sh [mode](native, docker)"
  exit -1
fi

ZSDK_VERSION="0.16.4"
CURRENT_USER=`whoami`

# zephyr
sudo -E /opt/toolchains/zephyr-sdk-${ZSDK_VERSION}/setup.sh -c
sudo chown -R $UID:$UID /home/$CURRENT_USER/.cmake

# update rosdep
if ! [ -f /etc/ros/rosdep/sources.list.d/20-default.list ]; then
  sudo rosdep init
fi
rosdep update

# gdbinit file
cat << EOF > ~/.gdbinit
define hook-stop
  refresh
end
EOF

# create symlink to west in ~/bin
mkdir -p ~/bin
cd ~/bin
cat << EOF > ~/bin/west
#!/bin/bash
set -e
source /opt/.venv-zephyr/bin/activate
/opt/.venv-zephyr/bin/west "\$@"
EOF
chmod +x ~/bin/west

# modify bashrc
if ! grep -qF "COGNIPILOT_SETUP" ~/.bashrc; then
cat << EOF >> ~/.bashrc
# COGNIPILOT_SETUP
source /opt/ros/humble/setup.bash
if [ -f \$HOME/cognipilot/ws/zephyr/scripts/west_commands/completion/west-completion.bash ]; then
  source \$HOME/cognipilot/ws/zephyr/scripts/west_commands/completion/west-completion.bash
fi
if [ -f \$HOME/cognipilot/gazebo/install/setup.sh ]; then
  source \$HOME/cognipilot/gazebo/install/setup.sh
fi
if [ -f \$HOME/cognipilot/cranium/install/setup.sh ]; then
  source \$HOME/cognipilot/cranium/install/setup.sh
fi
if [ -f \$HOME/cognipilot/ws/cerebri/install/setup.sh ]; then
  source \$HOME/cognipilot/ws/cerebri/install/setup.sh
fi
if [ -f \$HOME/cognipilot/electrode/install/setup.sh ]; then
  source \$HOME/cognipilot/electrode/install/setup.sh
fi
source /usr/share/colcon_cd/function/colcon_cd.sh
source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash
if [ -d /opt/poetry/bin ] ; then
  PATH="/opt/poetry/bin:\$PATH"
fi
export POETRY_VIRTUALENVS_PATH=~/cognipilot/.poetry
export POETRY_VIRTUALENVS_OPTIONS_SYSTEM_SITE_PACKAGES=true
export ROS_DOMAIN_ID=7
export CMAKE_EXPORT_COMPILE_COMMANDS=ON
export CCACHE_TEMPDIR=/tmp/ccache
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
export PYTHONWARNINGS=ignore:::setuptools.installer,ignore:::setuptools.command.install,ignore:::setuptools.command.easy_install

EOF
fi

# native specific install
if [ $SCRIPT_MODE == "native" ]; then

  # setup systemd for zeth
  if ! [ -f  /etc/systemd/system/zeth-vlan.service ]
  then
    sudo cp ~/cognipilot/helmet/install/resources/zeth-vlan.service /etc/systemd/system
    sudo chmod 664 /etc/systemd/system/zeth-vlan.service
    sudo systemctl daemon-reload
    sudo systemctl enable zeth-vlan.service
    sudo systemctl start zeth-vlan.service
  fi

  # create cognipilot directory
  mkdir -p ~/cognipilot

# docker specific install
elif [ $SCRIPT_MODE == "docker" ]; then

  # remove plugins that don't work on docker for terminator
  sudo rm -rf /usr/lib/python3/dist-packages/terminatorlib/plugins/activitywatch.py
  sudo rm -rf /usr/lib/python3/dist-packages/terminatorlib/plugins/command_notify.py

  # append more config to .bashrc for docker
  if ! grep -qF "COGNIPILOT_DOCKER_SETUP" ~/.bashrc; then
  cat << EOF >> ~/.bashrc
# COGNIPILOT_DOCKER_SETUP
export GEN_CERT=yes
export SHELL=/bin/bash
export XDG_RUNTIME_DIR=/tmp/runtime-user
export NO_AT_BRIDGE=1
eval \`keychain -q --eval --agents "gpg,ssh"\`
export GPG_TTY=\$(tty)
EOF

  fi
fi

# vi: ts=2 sw=2 et
