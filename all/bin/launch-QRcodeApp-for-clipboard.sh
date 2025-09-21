#!/bin/bash
# Title: 
__name__="example-to-change"  # Change to the name of the script. Example: DRYa.sh, ezGIT.sh, Patuscas.sh (Set this variable at the head of the file, next to title)
# Important: It requires a method to acess the clipboard like the option "termux-clipboard-get" from the package Termux:API (from the F-Droid app)

# Sourcing file with colors 
   v_lib1=${v_REPOS_CENTER}/DRYa/all/lib/libs/drya-lib-1-colors-greets.sh
   [[ -f $v_lib1 ]] && (source $v_lib1 || read -s -n 1 -p "DRYa libs: $__name__: drya-lib-1 does not exist (error)")

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
