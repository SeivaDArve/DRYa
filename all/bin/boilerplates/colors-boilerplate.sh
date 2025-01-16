#/bin/bash
# Title: Colors Boilerplate
# Description: One file that saves all colors
# Use: `source` this file to avoid repeating the same color functions on your scripts

# Functions for text colors (used usually with `figlet`)
   function f_c1 {	
      # This function is to be used when something is SEARCHED
      tput setaf 5 
   }

   function f_c2 { 
      tput setaf 2 
   }

   function f_c3 { 
      # Mentioning user input or valiable input
      # This function is to be used when something is DECLAIRED
      tput setaf 3
   }

   function f_c4 { 
      # Similar to Bold. Used in: f_talk
      # This function is to be used when something is ASKED
      tput setaf 4
   }

   function f_c5 { 
      # Similar to Bold
      tput setaf 6
   }

   function f_c6 { 
      # Used for ASCII Drya Logo, centered to the screen
      tput setaf 28
      tput bold
   }

   function f_rc { 
      # This function is to be used when styles are to be CLEARED
      tput sgr0
   }

   function f_colors_without_tput {
      # Text Colors before discovering '$ tput setaf'
         RESTORE=$(echo -en '\001\033[0m\002')
             RED=$(echo -en '\001\033[00;31m\002')

      # Example of Text formating before discovering '$ tput'
      # > `echo ${RED}To do something, specify an argument like \"G 2\"${RESTORE}`
   }  

   function f_cursorON {
      # Show cursor normally. Use "tput civis" to hide
      tput cnorm
   }

function f_cursorOFF {
	# Hide cursor to prevent flickering of the screen. Use "tput cnorm" to show again
	tput civis
}
