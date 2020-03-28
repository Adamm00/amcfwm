#!/bin/sh
##############################################################################################################
#                                                                                                            #
#         ██████╗███████╗██╗    ██╗    ███╗   ███╗ █████╗ ███╗   ██╗ █████╗  ██████╗ ███████╗██████╗         #
#        ██╔════╝██╔════╝██║    ██║    ████╗ ████║██╔══██╗████╗  ██║██╔══██╗██╔════╝ ██╔════╝██╔══██╗        #
#        ██║     █████╗  ██║ █╗ ██║    ██╔████╔██║███████║██╔██╗ ██║███████║██║  ███╗█████╗  ██████╔╝        #
#        ██║     ██╔══╝  ██║███╗██║    ██║╚██╔╝██║██╔══██║██║╚██╗██║██╔══██║██║   ██║██╔══╝  ██╔══██╗        #
#        ╚██████╗██║     ╚███╔███╔╝    ██║ ╚═╝ ██║██║  ██║██║ ╚████║██║  ██║╚██████╔╝███████╗██║  ██║        #
#         ╚═════╝╚═╝      ╚══╝╚══╝     ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝        #
#                                                                                                            #
#                           AsusWRT-Merlin CFW Manager For Ubuntu 18.04 LTS                                  #
#                            By Adamm - https://github.com/Adamm00/am_cfwm                                   #
#                                         29/03/2020 - v1.0.0                                                #
##############################################################################################################


clear
sed -n '2,16p' "$0"

if [ -f "/tmp/build.lock" ] && [ -d "/proc/$(cat /tmp/build.lock)" ]; then
	logger -st Skynet "[*] Lock File Detected (pid=$(cat /tmp/build.lock)) - Exiting"
	exit 1
else
	echo "$$" > /tmp/build.lock
fi

Load_Menu() {
	while true; do
		echo "Select Menu Option:"
		echo "[1]  --> Setup VM"
		echo "[2]  --> Setup Repo / Toolchain"
		echo "[3]  --> Uninstall"
		echo
		echo "[e]  --> Exit Menu"
		echo
		printf "[1-2]: "
		read -r "menu"
		echo
		case "$menu" in
			1)
				option1="install"
				break
			;;
			2)
				option1="repo"
				break
			;;
			3)
				option1="uninstall"
				break
			;;
			e|exit)
				echo "[*] Exiting!"
				echo; exit 0
			;;
			*)
				echo "[*] $menu Isn't An Option!"
				echo
			;;
		esac
	done
}

if [ -z "$1" ] || [ "$1" != "install" ] && [ "$1" != "repo" ]; then
	Load_Menu
fi

if [ -n "$option1" ]; then
	set "$option1"
fi

case "$1" in
	install)
		sudo apt-get update
		sudo apt-get -y dist-upgrade
		sudo dpkg --add-architecture i386
		sudo apt-get update
		sudo apt-get -y install lib32ncurses5-dev dos2unix libtool-bin cmake libproxy-dev uuid-dev liblzo2-dev autoconf automake bash bison bzip2 diffutils file flex m4 g++ gawk groff-base libncurses5-dev libtool libslang2 make patch perl pkg-config shtool subversion tar texinfo zlib1g zlib1g-dev git gettext libexpat1-dev libssl-dev cvs gperf unzip python libxml-parser-perl gcc-multilib gconf-editor libxml2-dev g++-multilib gitk libncurses5 mtd-utils libncurses5-dev libvorbis-dev git autopoint autogen sed build-essential intltool libelf1 libglib2.0-dev xutils-dev lib32z1-dev lib32stdc++6 xsltproc gtk-doc-tools libelf-dev:i386 libelf1:i386 libltdl-dev openssh-server curl git build-essential nano
		if [ ! -f "$HOME/Desktop/setup.sh" ]; then curl -fsL --retry 3 "https://raw.githubusercontent.com/Adamm00/am_cfwm/master/setup.sh" -o "$HOME/Desktop/setup.sh"; fi
		if [ ! -f "$HOME/Desktop/build.sh" ]; then curl -fsL --retry 3 "https://raw.githubusercontent.com/Adamm00/am_cfwm/master/build.sh" -o "$HOME/Desktop/build.sh"; fi
		sudo ln -sf ~/Desktop/setup.sh /bin/setup
		sudo ln -sf ~/Desktop/build.sh /bin/build
		chmod 755 /bin/build /bin/setup
		mkdir -p ~/images
		echo
		if [ ! -f ~/.ssh/id_rsa ]; then
			ssh-keygen -b 4096
		fi
		echo "Your SSH Pubkey For Remote Access - [Press Enter To Continue]"
		cat ~/.ssh/id_rsa.pub
		read -r
		echo "Setting Up OpenSSH-Server - Input authorized_keys - [Press Enter To Continue]"
		read -r
		sudo nano -w ~/.ssh/authorized_keys
		echo "Hardening OpenSSH Config"
		sed -i 's~#Port 22~Port 4216~g' /etc/ssh/sshd_config
		sed -i 's~#ChallengeResponseAuthentication yes~ChallengeResponseAuthentication no~g' /etc/ssh/sshd_config
		sed -i 's~#PasswordAuthentication yes~PasswordAuthentication no~g' /etc/ssh/sshd_config
		echo "Input MOTD - [Press Enter To Continue]"
		read -r
		rm -rf /etc/update-motd.d/80-livepatch /etc/update-motd.d/50-motd-news /etc/update-motd.d/80-esm /etc/update-motd.d/91-release-upgrade /etc/update-motd.d/95-hwe-eol
		true > /etc/update-motd.d/10-help-text
		sudo nano -w /etc/update-motd.d/10-help-text
		echo "Rebooting To Apply Updates - [Press Enter To Continue]"
		read -r
		sudo rm -f /bin/sh && sudo ln -sf bash /bin/sh && sudo reboot
	;;
	repo)
		sudo rm -rf ~/am-toolchains ~/amng /opt
		sudo mkdir -p /opt
		sed -i '\~AsusWRT-Merlin CFW Manager~d' ~/.profile

		# BCM-SDK
		sudo ln -fs ~/am-toolchains/brcm-arm-sdk/hndtools-arm-linux-2.6.36-uclibc-4.5.3 /opt/brcm-arm
		sudo ln -fs ~/am-toolchains/brcm-arm-sdk  ~/amng/release/src-rt-6.x.4708/toolchains
		echo "PATH=$PATH:/opt/brcm-arm/bin # AsusWRT-Merlin CFW Manager" >> ~/.profile

		# BCM-HND
		sudo ln -fs ~/am-toolchains/brcm-arm-hnd /opt/toolchains
		{ echo "export LD_LIBRARY_PATH=$LD_LIBRARY:/opt/toolchains/crosstools-arm-gcc-5.3-linux-4.1-glibc-2.22-binutils-2.25/usr/lib # AsusWRT-Merlin CFW Manager"
		echo "export TOOLCHAIN_BASE=/opt/toolchains # AsusWRT-Merlin CFW Manager"
		echo "PATH=\$PATH:/opt/toolchains/crosstools-arm-gcc-5.3-linux-4.1-glibc-2.22-binutils-2.25/usr/bin # AsusWRT-Merlin CFW Manager"
		echo "PATH=\$PATH:/opt/toolchains/crosstools-aarch64-gcc-5.3-linux-4.1-glibc-2.22-binutils-2.25/usr/bin # AsusWRT-Merlin CFW Manager"; } >> ~/.profile

		# BCM-HND AX
		{ echo "export LD_LIBRARY_PATH=$LD_LIBRARY:/opt/toolchains/crosstools-arm-gcc-5.5-linux-4.1-glibc-2.26-binutils-2.28.1/usr/lib # AsusWRT-Merlin CFW Manager"
		echo "PATH=\$PATH:/opt/toolchains/crosstools-arm-gcc-5.5-linux-4.1-glibc-2.26-binutils-2.28.1/usr/bin # AsusWRT-Merlin CFW Manager"
		echo "PATH=\$PATH:/opt/toolchains/crosstools-aarch64-gcc-5.5-linux-4.1-glibc-2.26-binutils-2.28.1/usr/bin # AsusWRT-Merlin CFW Manager"; } >> ~/.profile

		cd ~ || exit 1
		if [ ! -d ~/am-toolchains ]; then
			echo "Preparing Toolchain Repo"
			git clone https://github.com/RMerl/am-toolchains.git
			sudo ln -s ~/am-toolchains/brcm-arm-hnd /opt/toolchains
		fi
		if [ ! -d ~/amng ]; then
			echo "Preparing Firmware Repo"
			git clone https://github.com/RMerl/asuswrt-merlin.ng amng
		fi
		echo
		echo "Repo Setup Complete!"
		echo
	;;
	uninstall)
		sudo rm -rf ~/am-toolchains ~/amng /opt
		sed -i '\~AsusWRT-Merlin CFW Manager~d' ~/.profile
		rm -rf "$HOME/Desktop/setup.sh" "/bin/setup" "$HOME/Desktop/build.sh" "/bin/build"
		rm -rf /etc/update-motd.d/10-help-text
	;;
esac

rm -rf /tmp/build.lock