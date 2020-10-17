#!/bin/bash

# Config
flags=("--help" "--projects")
desc=("this message" "choose some git projects")
gits=("https://github.com/Samdvich/quickstart" "https://github.com/Samdvich/CompUI")

# Init
startdir=$PWD
rootdir=`dirname $0` # Returns the script pathname

# Flags/Optionals
case $* in
    "--help")
	echo -e "$(tput bold)sammy's quickstart bash script \U1F495"	
	for flag in ${!flags[@]}; do
	    echo "$(tput bold)$(tput setaf 5)${flags[$flag]} $(tput sgr0)${desc[$flag]}" 
	done
	exit;;
    "--projects") # duplicates later operations, a modular approach would probably help fix this
	echo "$(tput setaf 0)$(tput dim)" && sudo apt-get install -y git && echo "$(tput sgr0)"
	mkdir -p ~/Code/Projects && cd ~/Code/Projects 
	for git in ${!gits[@]}; do
	    read -p "$(tput setaf 4)${gits[$git]} $(tput sgr0)(y,n) " ans
	    if [ $ans == "y" ]; then
		gits_ans=(${gits_ans[@]} "${gits[$git]}")
	    fi
	done
	for i in ${gits_ans[@]}; do
	    git clone $i
	done
	echo -e
	cd $startdir;;
esac

# Terminal/Program Configs
touch ~/.bashrc ~/.bash_aliases ~/.vimrc  ; rm ~/{.bashrc,.bash_aliases,.vimrc}
cp $rootdir/src/.config/{.bashrc,.bash_aliases,.vimrc} ~/
cd $rootdir/src/.config && cp -RT `echo */` ~/.config && cd $startdir

# Code
cd ~/ && mkdir -p ~/Code/Projects ~/Code/Playground/{Bash,Ruby,Deno,C,}
cd $startdir

# Programs
echo "$(tput setaf 0)$(tput dim)" 
sudo apt-get update -y && sudo apt-get full-upgrade -y && sudo apt autoremove -y 
sudo apt-get install -y apt-utils neofetch curl vim git flatpak unrar-free python3-pip ffmpeg gimp

sudo pip3 install --upgrade youtube-dl && export PATH=/home/sammy/.local/bin:$PATH
echo "$(tput sgr0)"

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

if [ ! -d /usr/local/lib/node_modules ]
then
    curl -L 'https://www.npmjs.com/install.sh' | sudo sh
else
    find /usr/local/bin/npm
    echo -e "\n$(tput setaf 6)NPM is already installed$(tput sgr0)\n"
fi

if [ ! -d ~/.deno ]
then
    curl -fsSl https://deno.land/x/install/install.sh | sh
else
    find ~/.deno/bin/deno
    echo -e "\n$(tput setaf 6)Deno is already installed$(tput sgr0)\n"
fi

if [ ! -d /opt/Discord ]
then
    wget -P $rootdir 'https://dl.discordapp.net/apps/linux/0.0.12/discord-0.0.12.tar.gz'
    sudo tar -xvzf $rootdir/discord*.tar.gz -C /opt
    rm $rootdir/discord*.tar.gz
    sudo ln -sf /opt/Discord/Discord /usr/bin/Discord
    sudo cp $rootdir/src/.desktop/discord.desktop /usr/share/applications
    echo ""
else
    cat /usr/share/applications/discord.desktop
    echo -e "\n$(tput setaf 6)Discord is already installed$(tput sgr0)\n"
fi

if [ ! dpkg -s libreoffice7.0 ]
then
    wget -P $rootdir 'https://download.documentfoundation.org/libreoffice/stable/7.0.0/deb/x86_64/LibreOffice_7.0.0_Linux_x86-64_deb.tar.gz'
    tar -xf $rootdir/LibreOffice*.tar.gz -C $rootdir
    rm $rootdir/LibreOffice*.tar.gz
    sudo dpkg -i $rootdir/LibreOffice*/DEBS/*
    rm -rf $rootdir/LibreOffice*
    echo ""
else
    echo -e "\n$(tput setaf 6)LibreOffice already installed$(tput sgr0)\n"
fi

if [ ! dpkg -s code-oss ]
then
    curl -s https://packagecloud.io/install/repositories/headmelted/codebuilds/script.deb.sh | sudo bash
    echo ""
else
    echo -e "\n$(tput setaf 6)VSCode (Headmelted) already installed$(tput sgr0)\n"
fi

# Fonts
sudo mkdir -p /usr/share/fonts/{misc,win} && sudo cp -r $rootdir/src/.fonts/misc/* /usr/share/fonts/misc && sudo cp -r $rootdir/src/.fonts/win/* /usr/share/fonts/win ; cd $rootdir 

if ! dpkg -s ttf-mscorefonts-installer
then
    wget 'http://ftp.de.debian.org/debian/pool/contrib/m/msttcorefonts/ttf-mscorefonts-installer_3.6_all.deb'
    if ! sudo dpkg -i ttf-mscorefonts-installer*.deb; then # should run on its own to return the condition
	sudo rm /var/lib/update-notifier/package-data-downloads/partial/*
	sudo apt-get --purge --reinstall -y install ttf-mscorefonts-installer
	sudo apt --fix-broken -y install
    fi
    rm ttf-mscorefonts-installer*.deb
else
    echo -e "\n$(tput setaf 6)'mscorefonts-installer' package already installed$(tput sgr0)\n"
fi

cd $startcd
