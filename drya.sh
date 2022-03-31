#!/bin/bash

# Max Cols: 56; Max lines: 28 (to aprox match smartphone screen)

_slide=0
	
function f_slide {
	((_slide=_slide+1))
	echo $_slide
}

function f_horizline {
_count=$(tput cols)
for i in $(seq $_count); do
   echo -ne "-" 
done
}

function f_readKeystroke {
	# "read -rsn1 input": Expect only one letter (and don't wait for submitting) and be silent (don't write that letter back).
	while true; do
		read -rsn1 input
		if [ "$input" = "a" ]; then
    			echo "key pressed: a"
		fi

		if [ "$input" = "b" ]; then
    			echo "key pressed: b"
		fi
	done
}
function f_replaceRead {
echo "First line..."
tput sc
read -p "Press any key to overwrite this line... " -n1 -s
tput rc 1; tput el
echo "Second line. read replaced."
}

function f_wiki {
cat << heredoc
To undo "tput rev" use "tput sgr0"
heredoc
}

function f_mainmenu {
tput clear
tput home; horizline; 

tput cup 0 2
echo --- Menu DRYa ---

#f_entry1
#f_entry2
#f_entry3
#f_entryStop

tput cup 28 0; horizline
}


function f_exec {
#f_mainmenu
echo $_slide
f_slide
echo $_slide
f_slide
f_readKeystroke
}
f_exec
