#!/bin/bash

# Title: Install Doom Emacs from 0
# Script version: v1.3

clear

echo -e "» Doom Emacs installer - (Vim keybindings + Emacs = Doom Emacs)\n"
echo -e "» Hi, this script is intended to install Emacs for a person who never tried Emacs before"
echo -e "» This script also includes a framwork on top of Emacs called Doom\n"
echo -e "» Doom is a framework to allow Emacs to work with all the keybinding that Vim as"
echo -e "» Vim is one of the best and most powerfull text editors out there\n"
echo -e "» This script boils down a video from \"Distro Tube\" posted on Youtube\n"
echo -e "	Title: Doom Emacs On Day One (Learn These Things FIRST!)"
echo -e "	Author: Distro Tube (DT)"
echo -e "	Link: https://www.youtube.com/watch?v=37H7bD-G7nE\n"
echo -n "» Shall we beggin?"

read
clear


function f_solveIssue1 {
	# Solve issue if following error is found:
	# "Sub-process /usr/bin/dpkg returned an error code (1)"
	# Tutorial from: https://sqlserverguides.com/sub-process-usr-bin-dpkg-returned-an-error-code-1/

	function f_try1 {
		echo "Trying to solve 1 issue"
		sudo mv /var/lib/dpkg/info /var/lib/dpkg/info_silent
		sudo mkdir /var/lib/dpkg/info
		sudo apt -f install
		sudo mv /var/lib/dpkg/info/* /var/lib/dpkg/info_silent
		sudo rm -rf /var/lib/dpkg/info
		sudo mv /var/lib/dpkg/info_silent /var/lib/dpkg/info
	}
	
	function f_try2 {
		# Tutorial: https://phoenixnap.com/kb/fix-sub-process-usr-bin-dpkg-returned-error-code-1
		sudo dpkg --configure -a
	}

	#f_try1
	f_try2
}
#f_solveIssue1

echo "Updating your system"
echo ""

sudo apt update


echo "Upgrading your system"
echo ""
sudo apt upgrade

# installing dependencies for this installation:
sudo apt install git 

echo "Installing vanilla emacs:"
sudo apt install emacs

# Google Search: "doom emacs" to find "https://github.com/doomemacs/doomemacs#install"
echo "Installing doom emacs according to it's github page:"
	# execute Line 1
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d

	# execute line 2
~/.emacs.d/bin/doom install

function f_addToShell {
	# Add a path to our shell script
	echo "" >> ~/.bashrc
	
	sed -i '/# Export path to please Doom Emacs/d' ~/.bashrc
	sed -i '/export PATH="$HOME\/.emacs.d\/bin:$PATH"/d' ~/.bashrc
		echo '# Export path to please Doom Emacs' >> ~/.bashrc
		echo 'export PATH="$HOME/.emacs.d/bin:$PATH"' >> ~/.bashrc
	
	source ~/.bashrc
}
f_addToShell


doom sync

echo -e "\nNow you can simply run Doom emacs\n"
echo -e "Lets try to type \"emacs\""
emacs
