#!/bin/bash
# Important: It requires a method to acess the clipboard like the option "termux-clipboard-get" from the package Termux:API (from the F-Droid app)

clear
echo " > Tell me what do you want to store in the variable:"
echo -n " > After QR Code app is closed, press "
tput setaf 3
echo "ENTER"
tput sgr0
am start --user 0 -a andrppoid.intent.action.MAIN -n com.teacapps.barcodescanner/net.qrbot.ui.main.MainActivity &>/dev/null
read
echo " > Will be stored inside the variable: 1"
cat ~/Repositories/dWiki/TODO-apps/QR-walking-stick/ascii-art-pasting-square.txt
echo
echo -n " > "
v_ans=$(termux-clipboard-get)

echo
echo "Listing last input:"
echo -n "|1| "
echo $v_ans
