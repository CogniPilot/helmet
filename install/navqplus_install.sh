#!/bin/bash
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
'╚═══╝╚═══╝╚═══╝╚╝ ╚═╝╚══╝╚╝   ╚══╝╚═══╝╚═══╝ ╚══╝ ')

for line in "${LOGO[@]}"; do
    echo -e "$line"
done

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

PS3=$'\n\e[2;33mEnter a CogniPilot release (number) to use: \e[0m'
select opt in airy main; do
	case $opt in
	airy)
		release=airy
		echo -e "\e[2;32mUsing CogniPilot release airy alicanto.\n\e[0m"
		break;;
	main)
		release=main
		echo -e "\e[2;32mUsing CogniPilot main development branch.\n\e[0m"
		break;;
	*)
		echo -e "\e[31mInvalid option $REPLY\n\e[0m";;
	esac
done

PS3=$'\n\e[2;33mEnter a platform (number) to build: \e[0m'
select opt in b3rb elm4 rddrone; do
	case $opt in
	b3rb)
		robot=b3rb
		echo -e "\e[2;32mBuilding platform b3rb.\n\e[0m"
		break;;
	elm4)
		robot=elm4
		echo -e "\e[2;32mBuilding platform elm4.\n\e[0m"
		break;;
	rddrone)
		robot=rddrone
		echo -e "\e[2;32mBuilding platform rddrone.\n\e[0m"
		break;;
	*)
		echo -e "\e[31mInvalid option $REPLY\n\e[0m";;
	esac
done

if [ ! -f /usr/share/backgrounds/CogniPilotLogoDarkBackgrounds.png ]; then
	echo -e "\e[2;34mENVIRONMENT:\e[0m\e[2;32m Setting background and theme.\e[0m"
	sudo wget -q -P /usr/share/backgrounds/ https://raw.githubusercontent.com/CogniPilot/artwork/main/CogniPilotLogoDarkBackgrounds.png
	sudo wget -q -P /usr/share/backgrounds/ https://raw.githubusercontent.com/CogniPilot/artwork/main/CogniPilotLogoLightBackgrounds.png
	gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
	gsettings set org.gnome.desktop.background picture-uri file:////usr/share/backgrounds/CogniPilotLogoLightBackgrounds.png
	gsettings set org.gnome.desktop.background picture-uri-dark file:////usr/share/backgrounds/CogniPilotLogoDarkBackgrounds.png
	gsettings set org.gnome.desktop.background picture-options 'scaled'
fi

if [[ ${optimize} == "y" ]]; then
	echo -e "\e[2;34mOPTIMIZE:\e[0m\e[2;32m Stopping docker and containerd daemons.\e[0m"
	sudo systemctl stop docker
	sudo systemctl stop containerd
	echo -e "\e[2;34mOPTIMIZE:\e[0m\e[2;32m Disabling docker.service, docker.socket, and containerd.service.\e[0m"
	sudo systemctl disable docker.service
	sudo systemctl disable docker.socket
	sudo systemctl disable containerd.service
	echo -e "\e[2;34mOPTIMIZE:\e[0m\e[2;32m Disabling unattended upgrades.\e[0m"
	sudo dpkg-reconfigure -plow unattended-upgrades
	echo -e "\e[2;34mOPTIMIZE:\e[0m\e[2;32m Setting power profile to performance and defaulting gdm off.\e[0m"
	sudo powerprofilesctl set performance
	sudo systemctl set-default multi-user.target
fi

if ! grep -qF "COGNIPILOT_SETUP" ~/.bashrc; then
	echo -e "\e[2;34mENVIRONMENT:\e[0m\e[2;32m Setting up .bashrc with CogniPilot build.\e[0m"
	cat << EOF >> ~/.bashrc
# COGNIPILOT_SETUP
if [ -f /home/\$USER/cognipilot/cranium/install/setup.sh ]; then
  source /home/\$USER/cognipilot/cranium/install/setup.sh
fi
EOF
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
