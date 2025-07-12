#!/bin/bash
# Title: DRYa installer script (with dependency `fzf`)

# uDev: at the end of the script, start installing DRYa dependencies (listed on file "1st").
# uDev: Se DRYa ainda nao existir no systema, criar a hipotese de ghost-in ghost-out

function f_greet {
   # Example: #echo -e "plain \e[0;31mRED MESSAGE \e[0m reset"
   # echo -e "plain \e[0;32m

   function f_ascii_v1 {
      echo
      echo -e " \e[0;32m    ||\`		                   		"
      echo -e " \e[0;32m    ||				                  "
      echo -e " \e[0;32m.|''||  '||''| '||  ||\`  '''|.	   "
      echo -e " \e[0;32m||  ||   ||     \`|..||  .|''||	   "
      echo -e " \e[0;32m\`|..||. .||.        ||  \`|..||.	"
      echo -e " \e[0;32m                 ,  |'		         "
      echo -e " \e[0;32m                   ''		         "
      echo -e " \e[0m" 
   }

   function f_ascii_v2 {

      echo ' ____  ___ __   __    '
      echo '|  _ \|  _ \ \ / /_ _ '
      echo '| | | | |_) \ V / _` |'
      echo '| |_| |  _ < | | (_| |'
      echo '|____/|_| \_\|_|\__,_|'
      echo '					   '
   }

    figlet DRYa 2>/dev/null || f_ascii_v1
   #figlet DRYa 2>/dev/null || f_ascii_v2
}

function f_greet_alternative {

   # This script could also ensure the standard.flf font is correctly installed.
	  # To find the standard PATH for figlet fonts you could iddue the command '$ figlet -I2'
   figlet -f standard.flf DRYa 2>/dev/null
}

function f_touch_bashrc {
   # Making sure ~/.bashrc exists (Instalation is canceled otherwise)
      f_greet
      touch ~/.bashrc && echo "Existence of ~/.bashrc confirmed"  ## uDev: This line must be put on it's right place, not at the beggining of the script. The bug that was found was the inability to install DRYa for the simple reason that the file ~/.bashrc did not exist
      echo " " >> ~/.bashrc                             ## because there is a bug at: f_delete_empty_lines where if there is nithing at the file, this function will not proceed
      read -s -n 1 -p " > [Any key to continue]"
}

function f_test_fzf_existence {
   echo "uDev: test fzf existence"
}

function f_title {
   echo -e " ( Initial Menu )\n"
} 

function f_1st {
   # This function belongs to the First Question
   echo -e "                 (Step 1 of 4)                 \n"
   echo -e "       --- Checklist for instalation --- "
   echo -e " [ ] Do you have any dedicated dir for  repositories?\n"
   echo
   echo    "  Note: On WSL2 it is recomended at: '/mnt/c/\$USER'"
   echo    "  which is the C:\ drive, but with a directory created by hand with"
   echo    "  the user's account name (or similar) in order to better open files"
   echo    "  with windows's native software. This way, navigation through"
   echo    "  explorer.exe is easier"
} 

function f_2nd {
   # This function belongs to the Second Question
   echo -e "                 (Step 2 of 4)                 \n"
   echo -e "       --- Checklist for instalation --- "
   echo -e " [X] Do you have any dedicated dir for  repositories?"
   echo -e " [ ] Move DRYa repository into that place (or git clone it)\n"
} 

function f_3rd {
   # This function belongs to the Third Question
   echo -e "                 (Step 3 of 4)                 \n"
   echo -e "       --- Checklist for instalation --- "
   echo -e " [X] Do you have any dedicated dir for  repositories?"
   echo -e " [X] Move DRYa repository into that place (or git clone it)"
   echo -e " [ ] Running this script only side-by-side?\n"
} 

function f_4th {
   # This function belongs to the Forth Question
   echo -e "                 (Step 4 of 4)                 \n"
   echo -e "       --- Checklist for instalation --- "
   echo -e " [X] Do you have any dedicated dir for  repositories?"
   echo -e " [X] Move DRYa repository into that place (or git clone it)"
   echo -e " [X] Running this script only side-by-side?"
   echo -e "  -  Everything seems ok tostart modifications"
   echo -e " [ ] Shall we stat the magic?\n"
} 

function f_break_select_loops {
   # This function f_break_select_loops evals if v_break_select_loops variable
      # Is defined as either yes or no
      # And returns a value to the user
   
   # If the variable is empty, do nothing, if "no", do nothing, if "yes" then break
   if [[ -z $v_break_select_loops ]]; then echo -n ""
      elif [[ $v_break_select_loops == "no" ]]; then echo -n ""
      elif [[ $v_break_select_loops == "yes" ]]; 
         then 
            _break="break"
            clear
   fi
}

function f_1st_select {
   # Initial Statements (prompting the questions):
	   # First Question:
         clear; f_greet; f_1st

         select i in "$v_line" "(yes) to continue" "(no) to abort" "" "(help) to explain" "(back to Menu)" "exit" "$v_line"
         do
            case $i in
               "(yes) to continue")
                  f_2nd_select;
                  # Last, allow to script to flow by breaking all 'select loops'
                     f_break_select_loops; eval $_break

               ;;
               "(no) to abort")
                  echo " For a correct instalation, you should create a directory where all other"
                  echo " Repositories go... (aborting)"

                  # The exit command cannot be used while sourcing, otherwise the entire terminal shuts down

                    load_remaining_functions="no"
                    #export v_unload ## Aparently scripts cannot export variables while being sorced
                    exit 1
               ;;
               "(help) to explain") 
                  clear; f_greet
                  echo " Explanation of the First question"
                    # Explain what a centralized directory is
                  echo " First Create a dedicated directory for all your repositories like ~/Repositories"
                  echo "   > Does it exist?"
                    echo "Welcome to DRYa (Don't Repeat Yoursel (app))"
                    echo 
                    echo "This script running is meant to install DRYa"
                    echo " > Please choose one centralized directory"
                    echo "   where DRYa and all other Seiva's Software"
                    echo "   can be installed (e.g. /home/Repositories)"
                    echo
                    read -s -n 1
                    clear; f_greet ; f_1st
               ;;
               "(back to Menu)")
                  clear; f_greet; f_title; break
               ;;
               "exit") echo "Bye"; exit 0 ;;
               *) echo " That option is invalid. Press ENTER to clear screen"; read; clear; f_greet; f_1st ;;
              esac
         done
}

function f_2nd_select {
   # Second question:
      clear; f_greet; f_2nd

      select i in "$v_line" "(yes) to continue" "(no) to abort" "" "(help) to explain" "(back to Q1)" "$v_line"  
      do
         case $i in 
            "(yes) to continue")

               f_3rd_select;

               # Last, allow to script to flow by breaking all 'select loops'
                  f_break_select_loops; eval $_break


          ;;
          "(no) to abort")
            echo " Second question answered NO"
                    exit 1
          ;;
          "(help) to explain") 
               clear; f_greet
               echo "Explanation for the Second Question"
               echo -e " (Step 2 of 4) - Move DRYa repository into that place (or git clone it)"

            # Explain what a centralized directory is
               echo "Move the DRYa repo into the dir you choose"
               echo " > If you were run this file, you must have a copy of DRYa"
               echo "   and that copy (this copy) should be moved into the directory you choose to be the holder of all repos"
               echo
         ;;
         "(back to Q1)")
            clear; f_greet; f_1st; break
         ;;
         *) echo " That option is invalid. Press ENTER to clear screen"; read; clear; f_greet; f_2nd ;;
        esac
      done

}

function f_3rd_select {
   # Third question:
      clear; f_greet; f_3rd

      select i in "$v_line" "(yes) to continue" "(no) to abort" "" "(help) to explain" "(back to Q2)" "$v_line"  
      do 
        case $i in 
          "(yes) to continue")
            echo " Third question answered YES"

            f_4rd_select

            # Last, allow to script to flow by breaking all 'select loops'
               f_break_select_loops; eval $_break

          ;;
          "(no) to abort")
            echo " Third question answered NO"
                    exit 1
          ;;
          "(help) to explain") 
            clear; f_greet
            echo "Explanation for the Third Question"
               echo -e " (Step 3 of 4) - Navigate to this scripts dir and only then, run tjis script?\n"
               echo " Asked for help at Third question"
               echo -ne " > Are you side by side with the script? (y/n) - Help (h) > "

            # Explanation
               echo "if you are running this script some some other directory, cancel it with Ctrl + C)"
               echo "In order to properly source this file,"
               echo "you must navigate to the directory in which"
               echo "this file is located."
               echo 
               echo "Are you there? (At the terminal you could "
               echo "be sourcing or running this script from anywhere"
               echo "and that would not work)"
          ;;
          "(back to Q2)") clear; f_greet; f_2nd; break
          ;;
          *) echo " That option is invalid. Press ENTER to clear screen"; read; clear; f_greet; f_3rd ;;
         esac
      done
}

function f_4rd_select {
   # Fourth question:
      clear; f_greet; f_4th

      select i in "$v_line" "(yes) to continue" "(no) to abort" "" "(help) to explain" "(back to Q3)" "$v_line"  
      do
         case $i in 
            "(yes) to continue")
               echo " All questions answered... Continuing the script"
               read

               # After the 'select' loop breaks, it should carry this variable to indicate the next function
                  # That the process of reaching this line of code was sucessfull or not
                  # If the user used the script until this line, it means that the user wants to continue the installation
                  # This variable enables the remaining of the instalation 
                     load_remaining_functions="yes"

                     #export v_unload ## Aparently scripts cannot export variables while being sourced

               # Last, allow to script to flow by breaking all 'select loops'
                  v_break_select_loops="yes"; f_break_select_loops; eval $_break
            ;;
           "(no) to abort")
             echo " Not ready to see magic... I see..."
             exit 1
           ;;
           "(help) to explain") 
             clear; f_greet
               echo "Explanation for the Forth Question"

             # Explanation
               echo " Magic is the instalation of such usefull software"
           ;;
          "(back to Q3)") clear; f_greet; f_3rd; break ;;
          *) echo " That option is invalid. Press ENTER to clear screen"; read; clear; f_greet; f_4th ;;
         esac
      done
}

function f_options_menu {
   clear; f_greet; echo "Options not ready yet"
}

function f_uninstall_1st {
   # First question when uninstalling DRYa
   echo "Uninstalling Done!"
}

function f_underscore_creator {
   # At every 'select' menu, I want the first 
      # and last option of the menu to be an
      # horizontal split.
      # If there was no nested loops, there was no need
      # for these. Another reasob to create these horizontal
      # split lines, is force the menu to be vertical 
   # I want the last line of the menu to be all dashes
      # That forces the menu to be vertical always
      # For that, I will count hoe many lines does the
      # terminal has, store that into a variable v_cols
      # and insert it into the menu

         v_cols="$COLUMNS"
         let "v_count = $v_cols - 5"
            #echo -e "There are currently $v_cols columns in the screen \n and from that number, $v_count is the\n number of dashes '-' that the menu will have "
            #read

         # You may choose the apropriate symbol here
            v_underscore="+"

         # Store in a var, how many dashes can be replaced by empty spaces (according to the specific amount of available columns)
            v_underscoreCount=""

            for i in $(seq $v_count); do 
               v_underscoreCount="$v_underscoreCount$v_underscore"
            done

         # The result is an horizontal line
            #echo "var is $v_underscoreCount"
            #read
            v_line=$v_underscoreCount
}

function f_menu {
   # The first menu of the Installer/Uninstaller

   # The following function gives the variable v_line (vertical line to use as an option inside 'select' menu)
      f_underscore_creator

   # Display a menu, using the 'select' in-built bash loop function
      clear; f_greet; f_title
      PS3=" ----- Menu ---- > "
      select i in "$v_line" "DRYa install" "DRYa uninstall" "" "CLEAR SCREEN" options "Instructions" "exit" "$v_line"
         do
            case $i in
               "DRYa install") 

                  # Start the first of a few questions in a row
                     f_1st_select 

                  # If the answers were all answered, allow to script to flow by breaking all 'select loops'
                     f_break_select_loops; eval $_break
               ;;
               "DRYa uninstall") echo "uninstalling"; f_uninstall_1st; break;;
               options) 
                  f_options_menu
               ;;
               exit) echo "Bye"; break ;;
               "CLEAR SCREEN") 
                  clear; f_greet; 
                  echo "In this bash menu, you can clear the screen if unwanted output in displayed"
                  echo "By entering any unexpected input and pressing enter 2x"
                  read -s -n 1
                  clear; f_greet; 
               ;;
               Instructions) 
                  echo "For instalation instructions, please open th README.md file"
                  read -s -n 1
                  clear; f_greet; 
               ;;
               *) clear; f_greet; f_title ;;
            esac
         done

   echo "Last line of menu"
}

function f_discard_every_unused_function {

#	# Evaluate the answer given by the user
#	   if [[ $v_unload == "1" ]]; then
#
#			 echo 
#			 echo " WILL NOT RUN"
#			 read
#			 read

		 # Discard every function if the instalation is to be aborted
			unset f_cut_4_fields_relative_path
			unset f_DRYa_instalation_state
			unset f_explain
			unset f_create_backup
			unset f_delete_empty_lines
			unset f_delete-previous-DRYa-installation
			unset f_DRYa-install-me-at-bashrc
			unset f_unset-DRYa-installer
			unset f_source_bashrc
#	   fi
   

   # Uninstalling: 
      f_remove_DRYA_desktop_icon
}

function f_cut_4_fields_relative_path {

   # Description: to remove last 4 fields of the path of the dir where the DRYa installer is located

   # v_pwd is used to store current dir
	  v_pwd=$(pwd)

   # v_pwd2 is used to store current dir but reversed by characters
	  # REV is needed to make sure we find the last fields
		 v_pwd2=$(echo $v_pwd | rev)

   # Cut everything from the string except selected fields
	  # Cut last field
		v_1=$(echo $v_pwd2 | cut -d / -f 1)

	  # Cut second last field
		v_2=$(echo $v_pwd2 | cut -d / -f 2)

	  # Cut third last field
		v_3=$(echo $v_pwd2 | cut -d / -f 3)

	  # Cut forth last field
		v_4=$(echo $v_pwd2 | cut -d / -f 4)


   # Last 3 variables, when they were cut, their text was reversed by characters
	  # Re-reversing (correcting) variable 1:
		v_1=$(echo $v_1 | rev)

	  # Re-reversing (correcting) variable 2:
		v_2=$(echo $v_2 | rev)

	  # Re-reversing (correcting) variable 3:
		v_3=$(echo $v_3 | rev)

	  # Re-reversing (correcting) variable 4:
		v_4=$(echo $v_4 | rev)

   # Using SED to find our 3 variables inside our saved v_pwd variable
	  # sed needs to replace the text of our variable with 'nothing' along with a slash '/'
		 # sed expression is usually: sed 's/pattern/replacement/g'
		 # To replace the pattern with 'nothing' we use: sed 's/pattern//g'
		 # But we need to find a '/' and that would create conflicts
		 # To avoid conflicts, we will use the supported syntax: sed 's,pattern,replacement,g'
		 # The pattern we need to search is a slash and a variable: '/' + $v_1
	   # Therefore the pattern for the first field is:	"/$v_1"
	   # Therefore the pattern for the second field is: "/$v_2"
	   # Therefore the pattern for the third field is:	"/$v_3"
	   # sed needs variables to be surrounded like: '"$var"' to be recognized.

	# From the original path, remove the last 3 fields and storing inside a temporary file 
		# (To avoid conflicts it is stored inside a file instead of a variable)

	# Making the hidden directory where the tmp file will be stored
	   mkdir -p ~/.tmp/

	# Creating an empty file
	   touch ~/.tmp/v_pwd3

   # Transporting the text found into the empty file (to remove 3 fields) 
	   echo $v_pwd | sed 's,'"/$v_1"',,g' | sed 's,'"/$v_2"',,g' | sed 's,'"/$v_3"',,g' > ~/.tmp/v_pwd3

   # Retrieving the text from the file into a variable we can use
      # This variable may look like "/home/user/Repositories/DRYa" and it's purpose is to mention DRYa specificly
	   found_DRYa_at=$(cat ~/.tmp/v_pwd3)

   # Transporting the text found into the empty file (to remove 4 fields) 
	   echo $v_pwd | sed 's,'"/$v_1"',,g' | sed 's,'"/$v_2"',,g' | sed 's,'"/$v_3"',,g' | sed 's,'"/$v_4"',,g' > ~/.tmp/v_pwd3

   # Retrieving the text from the file into a variable we can use
      # This variable may look like "/home/user/Repositories" and it's purpouse is to mention where every foreign repo will be cloned into
	   v_REPOS_CENTER=$(cat ~/.tmp/v_pwd3)

   # An environment variable may be needed (in case all this process is a stand-alone file)
	  #export found_DRYa_at

   # Deleting the unnecessray temporary file (the dir is automaticaaly deleted by DRYa at startup)
	  rm ~/.tmp/v_pwd3

   # Display the entire result of this script:
	  echo "found DRYa at: $found_DRYa_at"
     read -s -n 1 -t 4
}

function f_define_env_vars {
   # AFTER running the function f_cut_4_fields_relative_path and finding $found_DRYa_at, only then 
	  # The remaining of this script comes. This function is based on that previous function

   # Printing Environment variables based on $found_DRYa_at
	  # List of variables to be created:
	  #  v_REPOS_CENTER="/home/user/Repositories"
	  #  DRYa_HEART
	  
   # Finding path to 'source-all-drya-files' (the file that contains reference for all other seiva's repositories when downloaded
	  declare DRYa_HEART="all/source-all-drya-files"
		 declare DRYa_HEART=$found_DRYa_at/$DRYa_HEART

	  echo "The Heart of DRYa is located at:"
	  echo " > $DRYa_HEART"
}

function f_explain {
   # uDev: this explanation is to delete, and the content to absorved by the menu

      # First determine where to install
        echo "Welcome to DRYa"
        echo " > Don't Repeat Yoursel (app)"
        sleep 0.5
        echo 
        echo "This script running is meant to install DRYa"
        echo " > Please choose one centralized directory"
        echo "   where DRYa and all other Seiva's Software"
        echo "   can be installed (e.g. /home/Repositories)"
        #echo " > You should prefer absolute paths instead of relative paths"
        #echo " > In order go cross platform"
        echo
        sleep 0.5
        echo "Instalation - Step 1 - by sourcing this file:"
        echo " > Issue the command '$ source <name-of-this-file>' and then"
        echo "   travel to the directory you want the software to be installed in"
        echo "   and from there, invoke this script with the command '$ DRYa-install-me-at-bashrc' " 
        echo 
        sleep 0.5
        echo "Instalation - Step 2 - Move the DRYa repo into the dir you choose"
        echo " > If you were able to source this file, you must have a copy of DRYa"
        echo "   and that copy (this copy) should be moved into the directory in which"
        echo "   you did invoke DRYa-install-me-at_bashrc"
        echo "   uDev: create a function that automatically moves the directory"
        echo 
        sleep 0.5
        echo "After instalation:"
        echo " > You cat unload the function that was sourced for instalation"
        echo "   you loaded: f_DRYa-install-me-at-bashrc that exports the variable \$DRYa_PATH"
        echo "   Now, if the place for instalation is how you like, you can prevent it from changing"
        echo "   by invoking: unset-DRYa-installer"
        echo
}

function f_create_backup {
   echo "Press enter to start the backup sequence"
   read -s -n 1

   # Search and delete the entry for DRYa inside ~/.bashrc
	  
	  # Asking if the user want to create a backup first
		 while true
		   do
			   echo -n " > Do you want a backup to be created from your ~/.bashrc? (y/n) "
			   read -n 1 -s v_ans
		      echo

            case $v_ans in
               y | Y)
                  cp ~/.bashrc ~/.bashrc.bak
                  echo "	> file ~/.bashrc copied to ~/.bashrc.bak (ENTER to continue)"
                  read -s -n 1
                  break
               ;;
               n | N)
                  echo "	 > You are choosing not to create a backup"
                  echo "	 > Ctrl + C:  to CANCEL, or"
                  echo "	 > 3 x ENTER: to CONTINUE"
                  read -s -n 1
                  read -s -n 1
                  read -s -n 1
                  break
               ;;
               *)
                  echo " > Please choose a valid Option (ENTER to continue)"
                  read -s -n 1
                  echo
               ;;
            esac
         done
}

function f_delete_empty_lines {
   echo "Press enter to start the backup removal of empty lines sequence"
   read -s -n 1

   # Deleting empty lines found only at the bottom of the file 
      # It deletes one by one with a while loop (while the last line is found empty)
		 
	# Using TAIL to print only the last line inside a variable called: last_line
	   last_line=$(tail -n 1 ~/.bashrc )

	# Creating an empty dir and an empty file for our process to take place
	   mkdir -p ~/.tmp/
	   touch ~/.tmp/tmp_file
  
	# If the last function found an empty line, then the next while loop will run until something is found
	   # The meaning of -z is "empty". Therefore is $last_line = -z (empty), then do something

	   if [ ! -z "$last_line" ]; then 

		  echo "Last line not empty"

	   elif [ -z "$last_line" ]; then

		  echo "Last line is empty.. proceeding to remove"

		  while [ -z "$last_line" ]; do 

			 # Copying the entire file to the file 'tmp' except the last 1 line
				  head -n -1 ~/.bashrc > ~/.tmp/tmp_file

			 # Deleting ~/.bashrc with empty space before restpring it WITHOUT empty space
			 rm ~/.bashrc

			 # Renaming tmp file (with .bashrc contents) to it's real name
			 mv ~/.tmp/tmp_file ~/.bashrc

			 # Evaluate the file againg to check if there is more empty lines needed to be removed the next loop
			 last_line=$(tail -n 1 ~/.bashrc )
		  done

		  echo "Done removing empty lines. PRESS any key"
	      read -s -n 1

		fi
}

function f_delete-previous-DRYa-installation {

   # Asking if the user wants the previous DRYa instalation to be removed (if any)
	  # This deletes only the 2 lines of code inside ~/.bashrc
	  # uDev: Find first if there is any entry at ~/.bashrc to avoid this speach
	  echo "DRYa: Do you want this script"
	  echo " > to remove the 4 lines of code maybe present inside"
	  echo "   ~/.bashrc from a possible previous DRYa instalation?"
	  echo "   (ignore if you never installed DRYa before)"
	  read -s -n 1 -p " > Remove? (y/n)" v_ans
	  
	  case $v_ans in
		 y | Y)
           read -s -n 1 -p " Press ENTER to proceed to delete previous DRYa instalation"
           # Finding the line containing: "# Load Seiva's main repo (one file that wakes all others)"
             # and deleting also the next 4 lines which are the actual code
             sed -i "/# Load Seiva's main repo (one file that wakes all others)/,+3d" ~/.bashrc


			echo "DRYa: entry removed from ~/.bashrc"
		 ;;
		 n | N)
			echo
			echo "DRYa: you choose N"
			echo " > Continuing..."
		 ;; 
	  esac

   
}

function f_DRYa-install-me-at-bashrc {

   # From the previous function, DRYa repo is located at:
	   #echo $found_DRYa_at
      #read -s -n 1
	  
   # Defining the environment variable:
	  DRYa_HEART="${found_DRYa_at}/all/source-all-drya-files"
	  export DRYa_HEART
	  echo " > DRYa: My file that awakes all others is located at: $DRYa_HEART"
   
   # This variable comes from the function that cuts the string
      echo "You have chosen $v_REPOS_CENTER to be a dedicated directory to receive every kind of repositories"
	   #$v_REPOS_CENTER
   
   echo "If you agree with this, press any key to concat this info into ~/.bashrc"
   read -s -n 1

   # Pasting a new entry inside ~/.bashrc (these 2 lines are responsible to load every other Seiva's Repositories
	  # Pasting 1 empty line + 4 lines of code:
	  echo ""														                                                   >> ~/.bashrc
	  echo "# Load Seiva's main repo (one file that wakes all others)"                                    >> ~/.bashrc
     echo "   v_REPOS_CENTER=\"$v_REPOS_CENTER\"; export v_REPOS_CENTER #Dedicated dir for repos"        >> ~/.bashrc
	  echo "   DRYa_HEART=\"$DRYa_HEART\"; export DRYa_HEART"			                                    >> ~/.bashrc
	  echo "   source ${DRYa_HEART}"                              	                                       >> ~/.bashrc
     #uDev: Decide a name for a variable to point at a file called DRYa-messages. And export it too

   # Process Finished
	  echo "DRYa: 1 Empty line + 3 Lines of code where send from DRYa to ~/.bashrc"

   # If the script was sorced instead of run, remember to unset
	  #echo "You can even unset the installer"
	  #echo " > Type: unset-DRYa-installer"
}

function f_remove_DRYA_desktop_icon {
   echo "# uDev: removing drya.desktop is not ready yet"
}

function f_install_DRYA_desktop_icon {
   echo "# uDev: installing drya.desktop is not ready yet"
}


function f_source_bashrc {

   # Execute this file simply to source (reset) ~/.bashrc
   # description: This file contains 2 ways of sourcing ~/.bashrc (one correct and one wrong)

   # Wrong way (because if the script that calles this file is listed under ~/.bashrc than that shell will enter in a loop):
   #alias src="source ~/.bashrc"

   # CORRECT WAY (you can paste these following functions inside ~/.bashrc or inside a side script called by ~/.bashrc):
   alias src="go gnome-terminal; exit" ## This command is same as: "source ~/.bashrc" (but needs the function: go)

   function go {
	  # This function opens applications apart from the terminal. It means that you can close the terminal after the aplications launch and the terminal being killed does not kill the apps it created
	  for v_arg in $@
	  do
		 setsid $v_arg &>/dev/null
	  done
   }
}


function f_install_figlet_font {
   # Not every instalation of figlet comes with my favourite figlet font, lets correct that
   echo "# uDev: Not ready yet"
   
   # Command to invoke at the terminal to display where figlet stores all fonts
       #figlet -I2

   # Directoty where Seiva stored his favourit figlet font
      #cd ${REPOS_CENTER}/DRYa/all/dotFiles/figlet-fonts
}


function f_run_every_used_function {
   # Installer sequence
   
   echo "Press enter to start the installation sequence"
   read -s -n 1

         #f_install_DRYA_desktop_icon
         #f_install_figlet_font
			f_cut_4_fields_relative_path
			#f_DRYa_instalation_state
			#f_explain
			f_create_backup
			f_delete-previous-DRYa-installation
			f_delete_empty_lines
			f_DRYa-install-me-at-bashrc
			#f_unset-DRYa-installer
			#f_source_bashrc
#	fi
}

function f_decide_to_run {
   # Mention to the user what the previous varible was:
	  #echo "variable load_remaining_functions = $load_remaining_functions"

   # Making use of that variable:
	  if [ -z $load_remaining_functions ]; then
		 echo "You are not cooperating!"
		 v=0

	  elif [ $load_remaining_functions == "yes" ]; then
		 echo "permission to run installer: Yep"
		 read
		 f_run_every_used_function

	  elif [ $load_remaining_functions == "no" ]; then
		 echo "permission to run installer: nope"
		 read
		 #f_discard_every_unused_function

	  fi

}

function f_exec {
   clear

   f_greet || f_greet_alternative

   f_touch_bashrc
   f_test_fzf_existence 
   f_menu

   # The previous function f_initial_statement brings a variable that allows 
	  # the next function to decide wether to run the remaining of the code or not
	  f_decide_to_run
}
f_exec

