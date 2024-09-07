#!/bin/bash
set -e

VER=0.0.1
echo -e "\e[2;32mPerforming initial system update, please make sure you are connected to the internet.\e[0m"
sudo apt-get update
sudo apt-get dist-upgrade

LOGO=('\n\n                            \e[0m\e[38;5;252m              ▄▄▄▄▄▄▄▄'
'\e[2;34m         ▄▄▄▄▄ \e[2;33m▄▄▄▄▄\e[0m\e[38;5;252m                    ▀▀▀▀▀▀▀▀▀'
'\e[2;34m     ▄███████▀\e[2;33m▄██████▄\e[0m\e[38;5;252m   ▀█████████████████████▀'
'\e[2;34m  ▄██████████ \e[2;33m████████\e[31m ▄\e[0m\e[38;5;249m   ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄'
'\e[2;34m ███████████▀ \e[2;33m███████▀\e[31m ██\e[0m\e[38;5;249m   ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀'
'\e[2;34m█████████▀   \e[2;33m▀▀▀▀▀▀▀▀\e[31m ████\e[0m\e[38;5;246m   ▀███████████▀'
'\e[2;34m▀█████▀ \e[2;32m▄▄███████████▄\e[31m ████\e[0m\e[38;5;243m   ▄▄▄▄▄▄▄▄▄'
'\e[2;34m  ▀▀▀ \e[2;32m███████████████▀\e[31m ████\e[0m\e[38;5;243m   ▀▀▀▀▀▀▀▀'
'       \e[2;32m▀▀█████▀▀▀▀▀▀\e[31m  ▀▀▀▀\e[0m\e[38;5;240m   ▄█████▀'
'              \e[2;90m ████████▀    ▄▄▄'
'              \e[2;90m ▀███▀       ▀▀▀'
'              \e[2;90m  ▀▀      \e[0m'
'╔═══╗╔═══╗╔═══╗╔═╗ ╔╗╔══╗╔═══╗╔══╗╔╗   ╔═══╗╔════╗'
'║╔═╗║║╔═╗║║╔═╗║║║║ ║║╚╣╠╝║╔═╗║╚╣╠╝║║   ║╔═╗║║╔╗╔╗║'
'║║ ╚╝║║ ║║║║ ╚╝║║╚╗║║ ║║ ║║ ║║ ║║ ║║   ║║ ║║╚╝║║╚╝'
'║║   ║║ ║║║║╔═╗║╔╗╚╝║ ║║ ║╚═╝║ ║║ ║║   ║║ ║║  ║║  '
'║║ ╔╗║║ ║║║║╚╗║║║╚╗║║ ║║ ║╔══╝ ║║ ║║ ╔╗║║ ║║  ║║  '
'║╚═╝║║╚═╝║║╚═╝║║║ ║║║╔╣╠╗║║   ╔╣╠╗║╚═╝║║╚═╝║ ╔╝╚╗ '
'╚═══╝╚═══╝╚═══╝╚╝ ╚═╝╚══╝╚╝   ╚══╝╚═══╝╚═══╝ ╚══╝ '
'\e[5m\e[38;5;208m    _   __               ____    ____   __            '
'   / | / /____ _ _   __ / __ \  / __ \ / /__  __ _____'
'  /  |/ // __ `/| | / // / / / / /_/ // // / / // ___/'
' / /|  // /_/ / | |/ // /_/ / / ____// // /_/ /(__  ) '
'/_/ |_/ \__,_/  |___/ \___\_\/_/    /_/ \__,_//____/  '
'                                                      \e[0m'
'\e[5m\e[31m                    _____         '
'_______ ___ ______ ____(_)_______ '
'__  __ `__ \_  __ `/__  / __  __ \'
'_  / / / / // /_/ / _  /  _  / / /'
'/_/ /_/ /_/ \__,_/  /_/   /_/ /_/ \e[0m\n')

for line in "${LOGO[@]}"; do
    echo -e "$line"
done
release=main
echo -e "\n\e[2;32mWelcome to the CogniPilot NavQPlus installer ($VER) - Ctrl-c at any time to exit.\e[0m\n"

while :; do
	read -p $'\n\e[2;33mClone repositories with git using already setup github ssh keys [y/n]?\e[0m ' sshgit
	if [[ ${sshgit,,} == "y" ]]; then
		sshgit="y"
		echo -e "\e[2;32mUsing git with ssh, best for developers.\e[0m"
		break
	elif [[ ${sshgit,,} == "n" ]]; then
		sshgit="n"
		echo -e "\e[2;32mUsing git with https, read only.\e[0m"
		break
	else
		echo -e "\e[31mInvalid input please try again.\e[0m"
	fi
done

while :; do
	read -p $'\n\e[2;33mOptimize runtime performance by defaulting off unused daemons (reccomended - y) [y/n]?\e[0m ' optimize

	if [[ ${optimize,,} == "y" ]]; then
		optimize="y"
		echo -e "\e[2;32mUsing runtime optimizations.\e[0m"
		break
	elif [[ ${optimize,,} == "n" ]]; then
		optimize="n"
		echo -e "\e[2;32mNot using runtime optimizations.\e[0m"
		break
	else
		echo -e "\e[31mInvalid input please try again.\e[0m"
	fi
done

PS3=$'\n\e[2;33mEnter a platform (number) to build: \e[0m'
select opt in b3rb melm rdd2; do
	case $opt in
	b3rb)
		robot=b3rb
		echo -e "\e[2;32mBuilding platform b3rb.\n\e[0m"
		break;;
	melm)
		robot=melm
		echo -e "\e[2;32mBuilding platform melm.\n\e[0m"
		break;;
	rdd2)
		robot=rdd2
		echo -e "\e[2;32mBuilding platform rdd2.\n\e[0m"
		break;;
	*)
		echo -e "\e[31mInvalid option $REPLY\n\e[0m";;
	esac
done

if [[ ${optimize} == "y" ]]; then
	echo -e "\e[2;34mOPTIMIZE:\e[0m\e[2;32m Disabling unattended upgrades.\e[0m"
	sudo dpkg-reconfigure -plow unattended-upgrades
fi

if ! grep -qF "COGNIPILOT_SETUP" ~/.bashrc; then
	echo -e "\e[2;34mENVIRONMENT:\e[0m\e[2;32m Setting up .bashrc with CogniPilot build.\e[0m"
cat << EOF >> ~/.bashrc
# COGNIPILOT_SETUP
source /opt/ros/jazzy/setup.bash
if [ -f \$HOME/cognipilot/cranium/install/setup.sh ]; then
  source \$HOME/cognipilot/cranium/install/setup.sh
fi
GZ_VERSION=harmonic
ROS_DISTRO=jazzy
source /usr/share/colcon_cd/function/colcon_cd.sh
source /usr/share/colcon_cd/function/colcon_cd-argcomplete.bash
source /usr/share/vcstool-completion/vcs.bash
export ROS_DOMAIN_ID=7
export CMAKE_EXPORT_COMPILE_COMMANDS=ON
export CCACHE_TEMPDIR=/tmp/ccache
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
export PYTHONWARNINGS="ignore"
EOF
#Enable for current session
source /opt/ros/jazzy/setup.bash
GZ_VERSION=harmonic
ROS_DISTRO=jazzy
source /usr/share/colcon_cd/function/colcon_cd.sh
source /usr/share/colcon_cd/function/colcon_cd-argcomplete.bash
source /usr/share/vcstool-completion/vcs.bash
export ROS_DOMAIN_ID=7
export CMAKE_EXPORT_COMPILE_COMMANDS=ON
export CCACHE_TEMPDIR=/tmp/ccache
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
export PYTHONWARNINGS="ignore"
fi

mkdir -p /home/$USER/cognipilot
cd /home/$USER/cognipilot

if [[ ${sshgit} == "y" ]]; then
	echo -e "\e[2;34mBUILD:\e[0m\e[2;32m Checking helmet version, updating if needed.\e[0m"
	if [ ! -f /home/$USER/cognipilot/helmet/.git/HEAD ]; then
		git clone -b $release git@github.com:CogniPilot/helmet.git
	elif ! grep -qF "$release" /home/$USER/cognipilot/helmet/.git/HEAD; then
		cd /home/$USER/cognipilot/helmet
		git checkout $release
		git pull
		cd /home/$USER/cognipilot
	else
		cd /home/$USER/cognipilot/helmet
		git pull
		cd /home/$USER/cognipilot
	fi
	echo -e "\e[2;34mBUILD:\e[0m\e[2;32m Importing helmet/navqplus/base.yaml\e[0m"
	vcs import < helmet/navqplus/base.yaml
	echo -e "\e[2;34mBUILD:\e[0m\e[2;32m Importing helmet/navqplus/$robot.yaml\e[0m"
	vcs import < helmet/navqplus/$robot.yaml
elif [[ ${sshgit} == "n" ]]; then
	echo -e "\e[2;34mBUILD:\e[0m\e[2;32m Checking read only helmet version, updating if needed.\e[0m"
	if [ ! -f /home/$USER/cognipilot/helmet/.git/HEAD ]; then
		git clone -b $release https://github.com/CogniPilot/helmet.git
	elif ! grep -qF "$release" /home/$USER/cognipilot/helmet/.git/HEAD; then
		cd /home/$USER/cognipilot/helmet
		git checkout $release
		git pull
		cd /home/$USER/cognipilot
	else
		cd /home/$USER/cognipilot/helmet
		git pull
		cd /home/$USER/cognipilot
	fi
	echo -e "\e[2;34mBUILD:\e[0m\e[2;32m Importing helmet/read_only/navqplus/base.yaml\e[0m"
	vcs import < helmet/read_only/navqplus/base.yaml
	echo -e "\e[2;34mBUILD:\e[0m\e[2;32m Importing helmet/read_only/navqplus/$robot.yaml\e[0m"
	vcs import < helmet/read_only/navqplus/$robot.yaml
fi

cd /home/$USER/cognipilot/cranium
echo -e "\e[2;34mBUILD:\e[0m\e[2;32m Updating all existing packages in cranium\e[0m"
vcs pull
echo -e "\e[2;34mBUILD:\e[0m\e[2;32m Running colcon to build cranium ROS packages\e[0m"
colcon build --symlink-install

echo -e "\e[2;32mCogniPilot NavQPlus installer has finished!\nPlease source your .bashrc by running:\n\e[0m\e[31m    source ~/.bashrc\n\e[0m\e[2;32mOr restart the NavQPlus by running:\n\e[0m\e[31m    sudo shutdown -r now\e[0m"
