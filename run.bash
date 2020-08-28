# Init
startcd=$PWD
touch ~/.bashrc ~/.bash_aliases
rm ~/{.bashrc,.bash_aliases}

# Terminal/Program Configs
cp src/.config/{.bashrc,.bash_aliases} ~/
echo "$(tput setaf 1)$(tput bold)- plz add bash_aliases file $(tput sgr0)"
cd src/.config && cp -RT `ls -a --directory *` ~/.config && cd $startcd

# Code
cd ~/ && mkdir -p ~/Code/Projects ~/Code/Playground/{Bash,Ruby,Deno,C,}
cd $startcd


# Programs
echo "$(tput setaf 0)$(tput dim)" && sudo apt-get update -y && sudo apt-get full-upgrade -y && sudo apt-get install -y curl vim git flatpak unrar-free && sudo apt autoremove && echo "$(tput sgr0)"

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

if ! dpkg -s libreoffice7.0
then
	wget 'https://download.documentfoundation.org/libreoffice/stable/7.0.0/deb/x86_64/LibreOffice_7.0.0_Linux_x86-64_deb.tar.gz'
	tar -xf LibreOffice*
	rm LibreOffice*.tar.gz
	cd LibreOffice*/DEBS
	sudo dpkg -i *
	cd $startcd
	rm -rf LibreOffice* 
else
	echo -e "\n$(tput setaf 6)LibreOffice already installed$(tput sgr0)\n"
fi

# Fonts
sudo mkdir -p /usr/share/fonts/{misc,win} && sudo cp -r src/.fonts/misc/* /usr/share/fonts/misc && sudo cp -r src/.fonts/win/* /usr/share/fonts/win ; cd $startcd 

if ! dpkg -s ttf-mscorefonts-installer
then
	wget 'http://ftp.de.debian.org/debian/pool/contrib/m/msttcorefonts/ttf-mscorefonts-installer_3.6_all.deb'
	if ! sudo dpkg -i ttf-mscorefonts-installer*.deb
	then	
		sudo rm /var/lib/update-notifier/package-data-downloads/partial/*
		sudo apt-get --purge --reinstall -y install ttf-mscorefonts-installer
		sudo apt --fix-broken -y install
	fi
	rm ttf-mscorefonts-installer*.deb
else
	echo -e "\n$(tput setaf 6)'mscorefonts-installer' package already installed$(tput sgr0)\n"
fi
