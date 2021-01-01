#!/bin/bash

setTime(){
	echo "local setting"

	echo "setting local time"
	sudo ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
	sudo hwclock --systohc
}
setCharacter(){
	echo "setting local character"
    sudo echo en_US.UTF-8 UTF-8 >> /etc/locale.gen
    sudo echo zh_CN.UTF-8 UTF-8 >> /etc/locale.gen
    sudo echo zh_TW.UTF-8 UTF-8 >> /etc/locale.gen
    sudo locale-gen
    sudo echo LANG=en_US.UTF-8 >> /etc/locale.conf
}

#-----------------git----------------#
repositories=(Vim Arch  Ubuntu Makefile Phytec)
gitDownloadOne(){
	git clone https://github.com/LargeJoker/$1
}

gitDownloadAll(){
	reNum=${#repositories[*]}
	let "reNum--"

	while(( $reNum >= 0 ))
	do
		echo "$reNum"
		rep=${repositories[$reNum]}
		echo "$rep"
		gitDownloadOne $rep
		let "reNum--"
	done
}

#-----------------download----------------#
installSystemPatch(){
	echo "starting to download the patch"
	
	sudo apt-get update
	sudo apt-get install network-manager dhcpcd5
}
downloadSoftware(){
	echo "starting to download the software"

	sudo apt-get install i3 xinit \
			cmake vim 

	sudo apt-get install  \
		vim python cmake nodejs npm ctags \
		ranger aria2 unzip unrar ntfs-3g man \
		xorg xorg-xinit \
		xf86-video-intel xf86-video-vmware virtualbox-guest-utils qtcreator qt5 \
		linux-lts linux-lts-headers \
		i3 alacritty dmenu ttf-dejavu wqy-zenhei \
		firefox firefox-i18n-zh-cn chromium \
		fcitx fcitx-configtool \
		feh mplayer libreoffice virtualbox goldendict python-pip \
		cronie rsync
}

#-----------------configuration----------------#
srcDir=~/git/Arch/Configure
srcVimDir=~/git/
configRanger(){
	ranger --copy-config=all
	cp -r ${srcDir}/ranger ~/.config/
}
configI3(){
	cp -r ${srcDir}/i3 ~/.config/
}
configVIM(){
	cp ${srcVimDir}/Vim/* ~/.vim/
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
}
configureSoftware(){
	cd ~
	mkdir .config git  .vim
	cd git
	gitDownloadAll

   	cp ${srcDir}/ArchConfig/xinitrc .xinitrc
	cp ${srcDir}/ArchConfig/inputrc .inputrc
}

setTime
setCharacter

#installSystemPatch
#downloadSoftware

#configureSoftware
configVIM
configRanger
configI3

