#!/bin/bash

# Max Cols: 56; Max lines: 28 (to aprox match smartphone screen)

function horizline {
_count=$(tput cols)
for i in $(seq $_count); do
   echo -ne "-" 
done
}

function replaceRead {
echo "First line..."
tput sc
read -p "Press any key to overwrite this line... " -n1 -s
tput rc 1; tput el
echo "Second line. read replaced."
}
function mainmenu {
tput clear
tput rev
tput home; horizline

tput cup 0 2
echo --- Menu DRYa ---

tput cup 28 0; horizline
}


function exec {
mainmenu
read
replaceRead
}
exec
