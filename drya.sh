#!/bin/bash

# Max Cols: 56; Max lines: 28 (to aprox match smartphone screen)

# Decide 2 sliders, one Horizontal and one Vertical
_V=0
_H=0
	
function f_slideVup {
	((_V=_V+1))
	#echo $_V
}
		
function f_slideHup {
	((_H=_H+1))
	#echo $_H
}

function f_slideVdw {
	((_V=_V-1))
	#echo $_V
}
		
function f_slideHdw {
	((_H=_H-1))
	#echo $_H
}

function f_horizline {
	_count=$(tput cols)
	for i in $(seq $_count); do
   	echo -ne "-" 
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
info:
To undo "tput rev" use "tput sgr0"

info:
"read -rsn1 input": Expect only one letter (and don't wait for submitting) and be silent (don't write that letter back).
heredoc
}

function f_detectOS {
	echo "whoami: 	$(whoami)"
	echo "OS type: 	${OSTYPE}"
	echo "uname:		$(uname)"
	echo "uname -a: 	$(uname -a)"
}

function f_readKeystroke {
	while true
		do

		# If you run f_exec for the first time, this if statment will break the while loop allowing f_mainmenu to run for the first time without asking for any keystroke or changes
		if [ ${_H} = 0 ] && [ ${_V} = 0 ]; then
			#echo "no keystroke is asked"
			_H=1
			_V=1
			break
		fi
			
		read -rsn1 input
		if [ "$input" = "s" ]; then
    			#echo "key pressed: s"
			#echo $_V
			f_slideV
			
		fi

		if [ "$input" = "b" ]; then
    			echo "key pressed: b"
		fi

		if [ "$input" = "S" ]; then
			# Exit the while loop
			break
		fi

		# Next it needs to recognize:
		# -Arrow Keys
		# -Enter

		f_mainmenu
	done
}

function f_entryA1 {
	# Reverse colors for this entry if it matches cursor
	if [ ${_V} = 1 ]; then tput rev; fi

	tput cup 2 4
	echo "Entry 1"

	# Reset text format (if any)
	tput sgr0
}

function f_entryA2 {
	# Reverse colors for this entry if it matches cursor
	if [ ${_V} = 2 ]; then tput rev; fi

	tput cup 3 4
	echo "Entry 2"

	# Reset text format (if any)
	tput sgr0
}

function f_footer {

	tput rev

	tput cup 23 2
	echo Stop: S

	tput cup 23 11
	echo Detect OS: D

	tput cup 23 25
	echo Detect OS: D

	read

	tput cup 22 11
	echo Detect OS: D


	tput sgr0
}

function f_menu1 {
	f_entryA1
	f_entryA2
	#f_entryA3
}

#function f_menu2 {
#	#f_entryB1
#	#f_entryB2
#	#f_entryB3
#}

function f_mainmenu {
	tput clear
	tput home; f_horizline; 
	
	tput cup 0 3
	echo " Menu DRYa "

	f_menu1
	#f_menu2
	f_footer

	tput cup 25 0; f_horizline
	f_readKeystroke
}


function f_exec {
	#f_detectOS
	#f_readKeystroke
	#f_mainmenu
	#f_wiki
	f_menu1
}
f_exec
