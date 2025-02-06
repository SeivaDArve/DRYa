#!/bin/bash
# Important: It requires a method to acess the clipboard like the option "termux-clipboard-get" from the package Termux:API (from the F-Droid app)

# Sourcing file with colors 
   source ${v_REPOS_CENTER}/DRYa/all/lib/drya-lib-1-colors-greets.sh

   v_greet="DRYa"
   v_talk="QR data: "

# An ascii text box
   v_ascii_box=~/Repositories/dWiki/TODO-apps/QR-walking-stick/ascii-art-pasting-square.txt

function f_square {
   echo "
 + + + + + + + + + + + + + + + + + + + +
 +                                     +
 +                                     +
 +                                     +
 +                                     +
 +           Use your finger           +
 +        to past content here         +
 +      (anywhere on the square)       +
 +                                     +
 +                                     +
 +        if you are using an          +
 +           android that              +
 +          allows xclip or            +
 +       termux-clipboard-get          +
 +         just press ENTER            +
 +                                     +
 +                                     +
 +                                     +
 + + + + + + + + + + + + + + + + + + + +
   "
}

f_greet 
f_square
echo " > Tell me what do you want to store in the variable:"
echo -n " > After QR Code app is closed, press "
tput setaf 3
echo "ENTER"
tput sgr0
am start --user 0 -a andrppoid.intent.action.MAIN -n com.teacapps.barcodescanner/net.qrbot.ui.main.MainActivity &>/dev/null
echo " > Will be stored inside a variable"
echo
read -p " > " v_ans
[[ -z $v_ans ]] && v_ans=$(termux-clipboard-get)

echo
echo "Listing last input:"
echo $v_ans
