#!/bin/bash
# Title: 1-select-installer.sh
# Description: Install DRYa witout any dependency

# uDev: at the end of the script, start installing DRYa dependencies (listed on file "1st").
# uDev: Se DRYa ainda nao existir no sistema, criar a hipotese de ghost-in ghost-out
# uDev: Redirect zsh and fish to our bashrc

# uDev: Change '# --hashtag-drya--' to  '#dee:Hashtag-DRYa'  


# Hashtags dee-pages:
   #  dee:screen_0  (refers to the history log)
   #  dee:screen_1
   #  dee:screen_2
   #  dee:screen_3
   #  dee:screen_4
   #  dee:screen_5
   #  dee:screen_6
   #  dee:screen_7
   #  dee:screen_8






# ----------------------------------------------------------------------------------------------
# -- Below: Defining default Variables 
# ----------------------------------------------------------------------------------------------



function f_internal_variables {

   v_talk="DRYa-Installer: "

   # Variables

   # After $v_5 is found (abs path), can be complemented with relative paths
      v_target=./target.sh
      v_dryaSH=../../../drya.sh
      v_readme=../../../README.org

   # Text added to the end of each line to allow `sed` or `grep` test their existence, and print then easily. Also allows faster uninstall
      v_dee="  # --hashtag-drya-- "

   # For better code reading 
      v_bash=~/.bashrc



   # Text for informational menus
      v_anyK=" [ANY KEY = Continue] or [CTRL-C = Cancel]: "


   function f_invalid_opt {
      # Text when Invalid options are given
      echo "   > Invalid option: $v_ans"
      echo "     [Any key to reload Menu]"
      read -sn1
   }

   # Set one hard coded variable to show on all menus
      v_ttl_screens=7

}

function f_delete_history {
   # Restarting history log from scratch
      unset v_hst_00
      unset v_hst_01
      unset v_hst_02
      unset v_hst_03
      unset v_hst_04
      unset v_hst_05
      unset v_hst_06
      unset v_hst_07
      unset v_hst_08
      unset v_hst_09
      unset v_hst_10
      unset v_hst_11
      unset v_hst_12
      unset v_hst_13
      unset v_hst_14
      unset v_hst_15
      unset v_hst_16
      unset v_hst_17
      unset v_hst_18
      unset v_hst_19
      unset v_hst_20
}

function f_variables_recalculated {
   # uDev: add option to simplify `/home/user/a/b/c/../../../file.org` into a simpler path
   v=uDev
   #'realpath /home/a/../b'
}

function f_define_env_vars {
   # AFTER running the function f_cut_4_fields_relative_path and finding $found_DRYa_at, only then 
	#   The remaining of this script comes. This function is based on that previous function

   # Printing Environment variables based on $found_DRYa_at
	  # List of variables to be created:
	  #  __REPOS_CENTER__="/home/user/Repositories"
	  #  __dryaSRC__
	  
   # Finding path to 'dryaSRC' (the file that contains reference for all other seiva's repositories when downloaded
	  __dryaSRC__="all/dryaSRC"
	  __dryaSRC__=$found_DRYa_at/$__dryaSRC__

     echo
	  echo "The Heart|Source of DRYa is located at:"
	  echo " > $__dryaSRC__"
     echo
     read -sn1
}







# ----------------------------------------------------------------------------------------------
# -- Below: Providing Visuals at the start 
# ----------------------------------------------------------------------------------------------




function f_greet_standard {
   # If installed, use `figlet`

   # This script could also ensure the standard.flf font is correctly installed.
	# Command to find the standard PATH for figlet fonts: `figlet -I2`
	
   figlet -f standard.flf DRYa 2>/dev/null
}

function f_greet_failsafe {
   # Display a nice ascii Title for DRYa

   # Example: `echo -e "plain \e[0;31mRED MESSAGE \e[0m reset"`
   #          `echo -e "plain \e[0;32m`

   function f_one {
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

   function f_two {
      echo ' ____  ___ __   __    '
      echo '|  _ \|  _ \ \ / /_ _ '
      echo '| | | | |_) \ V / _` |'
      echo '| |_| |  _ < | | (_| |'
      echo '|____/|_| \_\|_|\__,_|'
      echo '					   '
   }

   f_one || f_two
}

function f_greet {
   # This fx ensures some correct ASCII greet is used
   clear
   #f_greet_standard || f_greet_failsafe
   f_greet_failsafe
}

function f_GR {
   f_greet
}

function f_talk {
   echo -n "$v_talk"
}



# ----------------------------------------------------------------------------------------------
# -- Below: Functions copied from drya-lib-1 
# ----------------------------------------------------------------------------------------------
   # Functions should remain COPIES from drya-lib-1



function f_hzl {

   # At every 'select' menu, I want the first 
      # and last option of the menu to be an
      # horizontal split.
      # If there was no nested loops, there was no need
      # for these. Another reason to create these horizontal
      # split lines, is force the menu to be vertical 
   # I want the last line of the menu to be all dashes
      # That forces the menu to be vertical always
      # For that, I will count how many lines does the
      # terminal has, store that into a variable v_cols
      # and insert it into the menu

   clear

   # Finding ANY way possible to find value $COLUMNS
      unset           v_cols    # Preventing loading wrong values from past memory
                      v_cols="$COLUMNS"
      [[ -z           $v_cols  ]] && v_cols=$(stty size | awk '{print $2}')  2>/dev/null  # Caso `printenv` nao contenha $COLUMNS
      [[ -z           $v_cols  ]] && v_cols=$(stty size | cut -f 2 -d " " )  2>/dev/null  # Caso `awk`      nao esteja instalado
      [[ -z           $v_cols  ]] && v_cols=$(tput cols                   )  2>/dev/null    # Caso `cut`      nao esteja instalado
      [[ -z           $v_cols  ]] && echo "An error does not allow counting Terminal Columns Size to create f_hzl" && read -sn 1
     #echo "Columns = $v_cols"  # Debug

   # Subtrair alguns caracteres
      let "v_count = $v_cols - 5"
      #echo "Count = $v_count"  # debug
         #echo -e "There are currently $v_cols columns in the screen \n and from that number, $v_count is the\n number of dashes '-' that the menu will have "
         #read -sn1

      # You may choose the apropriate symbol here
         v_underscore="-"

      # Store in a var, how many dashes can be replaced by empty spaces (according to the specific amount of available columns)
         v_underscoreCount=""

         for i in $(seq $v_count); do 
            v_underscoreCount="$v_underscoreCount$v_underscore"
         done

      # The result is an horizontal line
         #echo "var is $v_underscoreCount"
         #read -sn1
         v_line=$v_underscoreCount  # uDev: substituir para $v_hzl

      v____________=------------------------------------------------------------------  # Hard coded line

      echo $v_line  # If the last line is Printing the result, then __main__ scripts can call `f_hzl` instead of `f_hzl && v_hzl` and it will give the advantage to re-calvulate the columns
}







# ----------------------------------------------------------------------------------------------
# Below: Functions copied from drya-lib-2
# ----------------------------------------------------------------------------------------------
   # Functions should remain COPIES from drya-lib-2


function f_create_tmp_history_file {
   # Create a temporary file to save all steps taken as history log

   # Creating directory and file
      v_tmp_dir=~/.tmp/DRYa-instalation-wizzard
      v_tmp_file="history-log"

   # Merging both in one sinlge variable
      v_historyF=$v_tmp_dir/$v_tmp_file

   # If there is any file already, remove it. If no file is found, do not mention any error too
      rm $v_historyF 2>/dev/null 

   # Create the hosting directoru if it does not exist
      mkdir -p $v_tmp_dir

   # Creating an empty file
      touch $v_historyF
}


# ----------------------------------------------------------------------------------------------
# Below: Functions copied from drya-lib-5
# ----------------------------------------------------------------------------------------------
   # Functions should remain COPIES from drya-lib-5




function f_1 {
   # Gives the terminal's current directory name (the directory from where, the user is calling a script. This script)

   # Mostrar sem sufixo
   v_pwd=$(pwd)

   v_1=$v_pwd
}
function f_1_verbose {
   echo " -1- Rel path: Prompt location \`pwd\` (Current CLI working directory, without sufix '/' ):"
   echo "  >  $v_1"
   echo
   echo
}

function f_5 {
   # Gives working directory where the script is placed (without the name in the end)

   # Doesn't matter the prompt location from where this script will be executed, $v_script_directory will indicate the correct directory where this script is located/inserted

    v_script_directory=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
   #v_script_directory="$v_script_directory/"  # Adding sufix /

   # For beter verbose (Same line of code as f_6)
      v_basename=$(basename $0)

   # Finally
      v_5_verbose=$v_basename
      v_5=$v_script_directory
}
function f_5_verbose {
   echo " -5- Abs Path: working dir of running script \"$v_5_verbose\" (without sufix '/'):"; 
   echo "  >  $v_5";
   echo
   echo
}



# --------------------------------------------------------------------------------------------------
# Below: Creating the History Log on-the-go  --
# --------------------------------------------------------------------------------------------------




function f_history_log {
   # dee:screen_0

   f_greet

   # Example of output
   #
   # | 
   # | History: [Clean] (it will grow here)"
   # | 
   # 


   v_hst_br="|" 
   v_hst_00="| History:"
   v_hst_br="|" 


                         echo  $v_hst_br
   [[ -n $v_hst_00 ]] && echo "$v_hst_00"  # Title 
                         echo  $v_hst_br
   [[ -n $v_hst_01 ]] && echo "$v_hst_01"  # Tells about 'target' working or not
   [[ -n $v_hst_02 ]] && echo "$v_hst_02"  # Tell is .bashrc could be created
   [[ -n $v_hst_03 ]] && echo "$v_hst_03"
   [[ -n $v_hst_04 ]] && echo "$v_hst_04"
   [[ -n $v_hst_05 ]] && echo "$v_hst_05"
   [[ -n $v_hst_06 ]] && echo "$v_hst_06"
   [[ -n $v_hst_07 ]] && echo "$v_hst_07"
   [[ -n $v_hst_08 ]] && echo "$v_hst_08"
   [[ -n $v_hst_09 ]] && echo "$v_hst_09"
   [[ -n $v_hst_10 ]] && echo "$v_hst_10"
   [[ -n $v_hst_11 ]] && echo "$v_hst_11"
   [[ -n $v_hst_12 ]] && echo "$v_hst_12"
   [[ -n $v_hst_13 ]] && echo "$v_hst_13"
   [[ -n $v_hst_14 ]] && echo "$v_hst_14"
   [[ -n $v_hst_15 ]] && echo "$v_hst_15"
   [[ -n $v_hst_16 ]] && echo "$v_hst_16"
   [[ -n $v_hst_17 ]] && echo "$v_hst_17"
   [[ -n $v_hst_18 ]] && echo "$v_hst_18"
   [[ -n $v_hst_19 ]] && echo "$v_hst_19"
   [[ -n $v_hst_20 ]] && echo "$v_hst_20"
                         echo  $v_hst_br
                         echo

   read -p "Enter to return"
   echo
}





# ----------------------------------------------------------------------------------------------
# -- Below: Testing the wizzard --
# ----------------------------------------------------------------------------------------------




function f_screen_1__test_installer_habilities {
   # Check Target.sh (if Relative|Absolute paths are taken care of)
   # dee:screen_1
   clear; read -sn 1 -p "screen 1"

   function f_trg {
      # Running a test, to see if the drya-lib-5 is properly configured inside the 1-select-installer wizzard
      source $v_5/$v_target 2>/dev/null
   }

   function f_ckY {
      # Will this function work properlly if $v_target is `sourced` instead of `bashed`?
      # If this var does exist, $v_target was sourced properly
      [[ $v_double_check == "code_34y6" ]] && v_chk=" |   | - [X] Test 2: Success!" 
   }

   function f_ckN {
      # Will this function work properlly if $v_target is `sourced` instead of `bashed`?
      # If this var does not exist, $v_target was not sourced properly
      [[ $v_double_check != "code_34y6" ]] && v_chk=" |   | - [ ] Test 2: Fail!"    
   }

   f_create_tmp_history_file  # Creates a file $v_historyF

   function f_ckF {
      # Testing if file actually exists (debugging process)
      [[   -f $v_historyF ]] && v_chF=" |   | - [X] History file (was created)"
   }

   function f_ckf {
      # Testing if file actually exists (debugging process)
      [[ ! -f $v_historyF ]] && v_chf=" |   | - [ ] History file (was not created)"
   }

   # After proper update of drya-lib-5, a test will be performed to it. (This gives freedom to the user to place the terminal 'prompt' wherever when installing DRYa
      f_greet
      f_talk;  echo                "[1/$v_ttl_screens] Testing installer itself"
      
               echo $v____________  
               echo                " |   | "
               echo                " |   | Can it can detect relative and absolute paths?"
      f_trg                      # " |   | - [X]  Test 1: Success!"   # This comes from external file
      f_ckY && echo "$v_chk"     # " |   | - [X]  Test 2: Success!" 
      f_ckN && echo "$v_chk"     # " |   | - [ ]  Test 2: Fail!"    
               echo                " |   | "
               echo                " |   | Can history file be created?"
      f_ckF && echo "$v_chF"     # " |   | - [X] History file (was created)"
      f_ckf && echo "$v_chf"     # " |   | - [ ] History file (was not created)"
               echo                " |   | "
               echo $v____________
               echo                "$v_anyK"
               echo $v____________
      read -sn1 -p                 "   > "

   # Fill the history file here...
      # "$v_hst_01"  # Tells about 'target' working or not
      # "$v_hst_02"  # Tell is .bashrc could be created

      [[ $v_double_check == "code_34y6" ]] && v_hst_01="| Wizzard tested 'target' file: success!"
      [[   -f $v_historyF ]] && v_hst_02="| Wizzard tested '.bashrc' could be created: success!"

}







# ----------------------------------------------------------------------------------------------
# -- Below: Main Menu --
# ----------------------------------------------------------------------------------------------







function f_screen_2__main_menu {
   # Menu principal, baseado em `read`
   # dee:screen_2
   clear; read -sn 1 -p "screen 2"

   while true
   do

      f_GR
      f_talk
      echo "[2/$v_ttl_screens] Menu Principal"
      echo $v____________
      echo " |   |"
      echo " | 1 | >>> Install DRYa"  # Vai para screen_3
      echo " |   |"
      echo " | 2 | >>> Uninstall DRYa"  # Vai para screen_3_1
      echo " |   |"
      echo ' | m | >>> [Menu fzf] DRYa install.uninstall ' 
      echo " |   |"
      echo " | 3 | >>> Options"  # Vai para screen_3_3
      echo " |   |"
      echo " | h | >>> Help + Instructions + Checklist " 
      echo " |   |"
      echo " | q | >>> Exit"
      echo " |   |"
      echo $v____________
      read -p "   < " v_ans


      if [[ $v_ans == "1" ]] || [[ $v_ans == "install" ]]; then
         # option 1
         f_screen_3__instalation_menu 

      elif [[ $v_ans == "2" ]] || [[ $v_ans == "Uninstall" ]]; then
         # option 2
         f_uninstall_1st

      elif [[ $v_ans == "m" ]] || [[ $v_ans == "fzf" ]]; then
         #bash $v_5/$v_dryaSH ui i fzf  # uDev: Install fzf if it does not exist
         bash $v_5/$v_dryaSH ui

      elif [[ $v_ans == "3" ]]; then
         # option 3
         f_options_menu

      elif [[ $v_ans == "h" ]] || [[ $v_ans == "H" ]]; then
         # option help
         f_help

      elif [[ $v_ans == "q" ]] || [[ $v_ans == "Q" ]]; then
         # Option: exit
         echo "   > exit"
         echo
         exit 0

      else
         f_invalid_opt  # Invalid option given
      fi

   done
   
   # Fill the history file here...
}



function f_screen_3__instalation_menu {
   # Menu principal, baseado em `while` + `read` + `if` 
   # dee:screen_3
   clear; read -sn 1 -p "screen 3"

   while true
   do

      f_GR
      f_talk; echo "[3/$v_ttl_screens] Menu Principal"
      echo $v____________
      echo " |   |"
      echo " | 1 | >>> Install DRYa normally (from scratch)"  
      echo " |   |"
      echo ' | 3 | >>> Install using `cat` (For Live OS like TAILS)' 
      echo " |   |"
      echo ' | 4 | >>> Install using QR Code'
      echo " |   |"
      echo ' | 5 | >>> Install GUI features' # When DRYa is not sourced at .bashrc unless it it called
      echo " |   |"
      echo " | h | >>> Help + Instructions + Checklist " 
      echo " |   |"
      echo " | b | >>> Back"
      echo " |   |"
      echo " | q | >>> Exit"
      echo " |   |"
      echo $v____________
      read -p "   < " v_ans


      if [[ $v_ans == "1" ]] || [[ $v_ans == "install" ]]; then
         # option 1
         f_screen_4__correcting_empty_bashrc 
         break


      elif [[ $v_ans == "3" ]] || [[ $v_ans == "cat" ]]; then
         read -sn 1 -p "uDev: Print info on how to install manually"

      elif [[ $v_ans == "4" ]] || [[ $v_ans == "qr" ]]; then
         read -sn 1 -p "uDev: On smartphones or devides with camera, it is possible to give them a QR code to clone DRYa Correctly"
         
      elif [[ $v_ans == "5" ]] || [[ $v_ans == "gui" ]]; then
         f_install_DRYA_desktop_icon 

      elif [[ $v_ans == "h" ]] || [[ $v_ans == "H" ]]; then
         # option help
         f_help

      elif [[ $v_ans == "b" ]] || [[ $v_ans == "back" ]]; then
         return

      elif [[ $v_ans == "q" ]] || [[ $v_ans == "Q" ]]; then
         # Option: exit
         echo "   > exit"
         echo
         exit 0

      else
         f_invalid_opt  # Invalid option given
      fi

   done
   
   # Fill the history file here...
}




function f_screen_4__correcting_empty_bashrc {
   # Avoid bugs on ~/.bashrc by correcting filling it with something. To enable regex
   # dee:screen_4
   clear; read -sn 1 -p "screen 4"

   # uDev: depois de testado e funcionar corretamente, este screen so aparece caso haja erros. se o .bashrc estiver ok, nao vai aparecer

   # If file ~/.bashrc does not exist, DRYa cannot be installed
      touch   $v_bash
      [[   -f $v_bash ]] && v_tested="- [X] File exists"
      [[ ! -f $v_bash ]] && v_tested="- [ ] File does not exist"

   # Avoiding bugs on f_delete_empty_lines, this fx needs at least one empty line in order to avoid errors. If there are no characters inside the file, these lines of code will add at least one. "fixing" means "fill with something"
      unset v_char_count
      v_char_count=$(wc -m $v_bash | cut -f 1 -d " ")

      [[ $v_char_count -gt 1 ]] && v_char="- [X] Does not need to be fixed, all ok!"

      [[ $v_char_count -lt 1 ]] && echo " " >> $v_bash 
      [[ $v_char_count -lt 1 ]] && v_char_count=$(wc -m $v_bash | cut -f 1 -d " ")
      [[ $v_char_count -lt 1 ]] && v_char="- [ ] Needs to be fixed..." 

      [[ $v_char_count -gt 1 ]] && v_char="- [X] Fixed, all ok"

   f_greet
   f_talk; echo      "[4/$v_ttl_screens] testing file ~/.bashrc"
           echo      "-------------------------------"
           echo      " |   | "
           echo      " |   | Ensuring existence:"
           echo      " |   | $v_tested"
           echo      " |   | "
           echo      " |   | Ensuring it is not Empty:"
           echo      " |   | -     Number of chars inside: $v_char_count"  # Debug
           echo      " |   | $v_char"
           echo      " |   | "
           echo       $v____________
           echo      "$v_anyK"
           echo       $v____________
      read -sn1 -p   "   > "

   f_screen_5__choose_REPOS_CENTER 
}


function f_screen_5__choose_REPOS_CENTER {
   # Asking prefered location to place $__REPOS_CENTER__ which is a directory where DRYa will clone all repositories by default
   # dee:screen_5
   clear; read -sn 1 -p "screen 5"


   function f_verbose_results__REPOS_CENTER__ {
      echo  
      echo         " Defined as \$__REPOS_CENTER__ :"
      read -sn1 -p "  > $__REPOS_CENTER__"
      echo 
      # uDev: Aqui, testar se ja existe
   }

   while true
   do
      # Test existence of default repositories directory
         [[   -d ~/Repositories ]] && v_rep="It already exists [tested]"
         [[ ! -d ~/Repositories ]] && v_rep="It will be created"

      f_GR
      f_talk
      echo    "[5/$v_ttl_screens] Repository centralization directory"
      echo    "$v____________"
      echo    " | Choose a path to centralize all repositories into"
      echo    " |  > \$__REPOS_CENTER__/"
      echo    "$v____________"
      echo    " |   |"
      echo    " | 1 | >>> ~/Repositories/"  # Vai para screen_6
      echo    " |   |     > $v_rep"
      echo    " |   |"
      echo    " | 2 | >>> /mnt/c/\$USER/Repositories/"
      echo    " |   |     > Used at WSL2"
      echo    " |   |     > It is at the C:\\ drive, inside a new directory"
      echo    " |   |       with the same name as the USER"
      echo    " |   |       This way, navigation through explorer.exe"
      echo    " |   |       becomes easier"
      echo    " |   |       (not safe if there are multiple users)"
      echo    " |   |"
      echo    " | 3 | >>> /mnt/c/users/\$USER/Repositories/"
      echo    " |   |     > Used at WSL2"
      echo    " |   |"
      echo    " | 4 | >>> Current CLI prompt location"
      echo    " |   |     > $v_1"
      echo    " |   |"
      echo    " | 5 | >>> Insert 'other location' manually"
      echo    " |   |"
      echo    " | h | >>> Help / Explanation"
      echo    " |   |"
      echo    " | b | >>> Back to 'Main Menu'"  # Vai para screen_2
      echo    " |   |"
      echo    " | q | >>> Exit (Abort everything)"
      echo    " |   |"
      echo    "$v____________"
      echo    " [ Default = ~/Repositories ] "  # uDev: every time this loop is loaded, change this variable to the path choosen
      echo    "$v____________"
      read -p "   > " v_ans

      # Default option
         [[ -z $v_ans ]] && v_ans="1"


      if [[ $v_ans == 1 ]]; then
         # Option 1

         __REPOS_CENTER__="$HOME/Repositories"
         export __REPOS_CENTER__
         f_verbose_results__REPOS_CENTER__  # Before leaving the screen, mention the results
         f_screen_6__detect_if_DRYa_is_correctly_placed_into_REPOS_CENTER 

      elif [[ $v_ans == 2 ]]; then
         # Option 2
         export __REPOS_CENTER__="/mnt/c/$USER/Repositories"
         f_verbose_results__REPOS_CENTER__  # Before leaving the screen, mention the results
         f_screen_6__detect_if_DRYa_is_correctly_placed_into_REPOS_CENTER 


      elif [[ $v_ans == 3 ]]; then
         # Option 3
         export __REPOS_CENTER__="/mnt/c/users/$USER/Repositories"
         f_verbose_results__REPOS_CENTER__  # Before leaving the screen, mention the results
         f_screen_6__detect_if_DRYa_is_correctly_placed_into_REPOS_CENTER 


      elif [[ $v_ans == 4 ]]; then
         # Option 4
         export __REPOS_CENTER__="$PWD"
         f_verbose_results__REPOS_CENTER__  # Before leaving the screen, mention the results
         f_screen_6__detect_if_DRYa_is_correctly_placed_into_REPOS_CENTER 

      elif [[ $v_ans == 5 ]]; then
         # Option 5: Insert custom path

         # uDev: Create a while loop just for this one
        
         echo; read -p " Insert custom path: " v_variable_custom_path  # Create a loop here until a valid path is given
         [[ -n $v_variable_custom_path ]] && export __REPOS_CENTER__="$v_variable_custom_path"
         f_verbose_results__REPOS_CENTER__  # Before leaving the screen, mention the results
         f_screen_6__detect_if_DRYa_is_correctly_placed_into_REPOS_CENTER 


      elif [[ $v_ans == "h" ]] || [[ $v_ans == "H" ]]; then
         # option help

         f_greet
         echo " Explanation of this Menu"
         echo
         echo " First create a dedicated directory"
         echo " for all your repositories like:"
         echo
         echo "    ~/Repositories"
         echo
         echo " Welcome to DRYa (Don't Repeat Yourself app)"
         echo
         echo " This installer is meant to install DRYa"
         echo " and other Seiva software repositories"
         echo
         echo " Choose one centralized directory"
         echo " where all repositories can be stored"
         echo
         echo " Example:"
         echo "    /home/$USER/Repositories"
         echo
         echo
         echo
         echo " What is WSL?  ... uDev"
         read -sn1


      elif [[ $v_ans == "b" ]] || [[ $v_ans == "B" ]] ; then
         # Back to menu

         f_screen_2__main_menu

      elif [[ $v_ans == "q" ]] || [[ $v_ans == "Q" ]]; then
         # Option: exit
         v_allow="yes"
         load_remaining_functions="no"
         echo "   > exit"
         echo
         exit 0

      else 
         # Invalid option
         f_invalid_opt 
      fi

   done
}

function f_screen_6__detect_if_DRYa_is_correctly_placed_into_REPOS_CENTER {
   # If at __REPOS_CENTER__ there is DRYa already cloned, this step is unecessary
   # dee:screen_6
   clear; read -sn 1 -p "screen 6"

   function f_clone_now {
      # Git clone DRYa immediatly
      git clone https://github.com/SeivaDArve/DRYa.git ~/Repositories/DRYa
   }

   function f_ask_to_clone_DRYa_right_now {
      unset v_ans
      read -p "Clone DRYa right now? (Y/n) " v_ans
      echo
       
      [[ -z $v_ans        ]] && f_clone_now
      [[    $v_ans == "y" ]] && f_clone_now
      [[    $v_ans == "Y" ]] && f_clone_now

      [[    $v_ans == "n" ]] && ...  # estas linhas nem precisam existir porque estamos dentro de um while
      [[    $v_ans == "N" ]] && ...  # estas linhas nem precisam existir porque estamos dentro de um while
   }

   while true
   do
      
      [[   -d $__REPOS_CENTER__/DRYa ]] && v_test_clonage_existence_of_DRYa=yes
      [[ ! -d $__REPOS_CENTER__/DRYa ]] && v_test_clonage_existence_of_DRYa=no

      f_GR
      f_talk; echo "[6/$v_ttl_screens] Getting DRYa's directory correctly placed"
              echo $v____________
              echo " Testing:" 
              echo
              echo "  \$DRYa existence at \$__REPOS_CENTER__ "
              echo "   > $v_test_clonage_existence_of_DRYa."
              echo
              echo "  Checking path of \$__REPOS_CENTER__:"
              echo "   > $__REPOS_CENTER__"
              echo $v____________
              echo " |   |"
              echo " | 1 | >>> Yes, (continue using __REPOS_CENTER__ with DRYa inside)"
              echo " |   |"
              echo " | 2 | >>> Yes, (continue using __REPOS_CENTER__ but clone DRYa into it first)"
              echo " |   |"
              echo " | 3 | >>> Yes, (continue by remove existing DRYa directory and clone again)"
              echo " |   |"
              echo " | h | >>> Help|info|instructions"
              echo " |   |"
              echo " | b | >>> Back"
              echo " |   |"
              echo " | q | >>> No, abort"
              echo " |   |"
              echo $v____________
          read -rp "   >  " v_ans 

      if [[ "$v_ans" == "1" || "$v_ans" == "yes default" ]]; then

         # uDev: Neste passo, se DRYa nao existir em repos center, tem de ser MOVIDO ou CLONADO
         [[ $v_test_clonage_existence_of_DRYa == "yes" ]] && f_screen_7__resume_before_instalation 
         [[ $v_test_clonage_existence_of_DRYa == "no"  ]] && echo && read -p " > You need either to CLONE or MOVE repository DRYa into \$__REPOS_CENTER__" && echo

      elif [[ "$v_ans" == "2" || "$v_ans" == "yes clone" ]]; then

         # If it already existe, another attempt to clone Must fail
            [[ $v_test_clonage_existence_of_DRYa == "yes" ]] && read -p "Directory named DRYa already exists there" && echo && continue

         f_ask_to_clone_DRYa_right_now

         #f_screen_7__resume_before_instalation  # It will not go to another menu from here, instead, the `while` will make another loop

      elif [[ "$v_ans" == "3" || "$v_ans" == "yes remove" ]]; then
         echo "Are you sure? Remove DRYa and Clone again"
         read -s

         rm -rf $__REPOS_CENTER__/DRYa 2>/dev/null
         f_ask_to_clone_DRYa_right_now
       
      elif [[ "$v_ans" == "q" || "$v_ans" == "exit" ]]; then

         echo "Second question answered NO"
         exit 1

      elif [[ "$v_ans" == "h" || "$v_ans" == "help" ]]; then

         f_greet
         echo "Explanation for the Second Question"
         echo -e " (Step 2 of 4) - Move DRYa repository into that place (or git clone it)"

         # Explain what a centralized directory is
         echo "Move the DRYa repo into the dir you choose"
         echo " > If you run this file, you must have a copy of DRYa"
         echo "   and that copy (this copy) should be moved into the directory"
         echo "   you choose to be the holder of all repos"
         echo

         read -rp "Press ENTER to continue..."

      elif [[ "$v_ans" == "b" || "$v_ans" == "back" ]]; then
         # Move from screen 4 to screen 5 permanently
         return

      else
         # Invalid option
         f_invalid_opt 
      fi
   done
}






function f_screen_7__resume_before_instalation {
   # Resume of all the choices before, before actually running the instalation
   # dee:screen_8
   clear; read -sn 1 -p "screen 7"

   while true
   do

      f_GR
      f_talk; echo    "[7/$v_ttl_screens] Resume|History > Eecute|Install"
              echo    "$v____________"
              echo    " |   |"
              echo    " | 0 | >>> Checklist"
              echo    " |   |"
              echo    " | 1 | >>> yes (Start Instalation Sequence)"
              echo    " |   |"
              echo    " | 2 | >>> help and Instructions"
              echo    " |   |"
              echo    " | b | >>> back"
              echo    " |   |"
              echo    " | q | >>> no (abort)"
              echo    " |   |"
              echo    "$v____________"
              read -p "   < " v_ans

      if [[ $v_ans == "0" ]]; then
         f_history_log 

      elif [[ $v_ans == "1" ]]; then
         f_run_every_used_function 
         break

      elif [[ $v_ans == "2" ]]; then
         f_help

      elif [[ $v_ans == "b" ]]; then
         return

      elif [[ $v_ans == "q" ]]; then

         echo " Not ready to see magic... I see..."
         exit 1

      else

         echo " That option is invalid. Press ENTER to clear screen"
         read -sn1

      fi

   done
}


function f_congratulations_finished {
   f_GR
   f_talk; echo "Finished"
   read -sn 1
}



function f_options_menu {
   f_greet
   f_talk; echo "Options (uDev)"
      echo $v____________
      echo " |   |" 
      echo " | 1 | >>> Fix outdated installations"   
      echo ' |   |     Replace outdated variables:'
      echo ' |   |      > `sed "s/{v_REPOS_CENTER}/__REPOS_CENTER__/g" ~/.bashrc'
      echo " |   |" 
      echo $v____________
           read -sn1

}


function f_uninstall_1st {
   # First question when uninstalling DRYa
   
   f_greet
   echo "Uninstalling DRYa:"
   sed "/$v_dee/d" $v_bash 1>/dev/null
   echo "Done!"
   read -sn1 -p " ... "
   # uDev: Confirmation would be good to avoid bugs
}


function f_help {
   # Instrucoes
   
   while true
   do
      f_GR
      f_talk
      echo    "Help|Instructions"
      echo    $v____________
      echo    " |   |"
      echo    " | 0 | >>> Checklist (History log) of current instalation process"
      echo    " |   |"
      echo    " | 1 | >>> Instructions 1 - (local readme)"  
      echo    " |   |"
      echo    " | 2 | >>> Instructions 2 - (internal instructions)"  
      echo    " |   |"
      echo    " | 3 | >>> Instructions 3 - (main DRYa README.org)"
      echo    " |   |"
      echo    " | r | >>> Report Bugs"
      echo    " |   |"
      echo    " | b | >>> Back "
      echo    " |   |"
      echo    " | q | >>> Exit"
      echo    " |   |"
      echo    $v____________
      read -p "   < " v_ans


      if [[ $v_ans == "0" ]] || [[ $v_ans == "checklist" ]]; then
         f_history_log  


      elif [[ $v_ans == "1" ]] || [[ $v_ans == "install" ]]; then
         # option 1
         f_explain

      elif [[ $v_ans == "2" ]]; then
         # option 2

         f_tk "Instructions"
         echo " > Will be presented with \`less\` text editor"
         echo "   (It uses 'Q' letter to exit the instructions doc)"
         read -sn1
         less $v_5/README.txt

      elif [[ $v_ans == "3" ]]; then
         # option 3
         less "$v_5/$v_readme"

      elif [[ $v_ans == "r" ]] || [[ $v_ans == "report" ]]; then
         echo "uDev: email"
         echo "uDev: github > pull requests"
         read -sn1
   
      elif [[ $v_ans == "b" ]] || [[ $v_ans == "B" ]] ; then
         # Back to menu
         return

      elif [[ $v_ans == "q" ]] || [[ $v_ans == "Q" ]]; then
         # Option: exit
         echo "   > exit"
         echo
         exit 0

      else
         # Invalid option
         f_invalid_opt 
      fi

   done
}


function f_discard_every_unused_function {

   # Discard every function if the instalation is to be aborted
      unset f_cut_4_fields_relative_path
      unset f_explain
      unset f_create_backup
      unset f_delete_empty_lines
      unset f_delete_previous_DRYa_installation
      unset f_DRYa_install_me_at_bashrc
      unset f_unset_DRYa_installer
      unset f_source_bashrc

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
	   __REPOS_CENTER__=$(cat ~/.tmp/v_pwd3)

   # An environment variable may be needed (in case all this process is a stand-alone file)
	  #export found_DRYa_at

   # Deleting the unnecessray temporary file (the dir is automaticaaly deleted by DRYa at startup)
	  rm ~/.tmp/v_pwd3

   # Display the entire result of this script:
	  echo " > found DRYa at: $found_DRYa_at"
}

function f_explain {
   # uDev: this explanation is to delete, and the content to absorved by the menu

   f_greet

   echo "Welcome to DRYa"
   echo " > Don't Repeat Yoursel (app)"
   read -sn1 -t 0.5
   echo 
   echo "This script running is meant to install DRYa"
   echo " > Please choose one centralized directory"
   echo "   where DRYa and all other Seiva's Software"
   echo "   can be installed (e.g. /home/Repositories)"
   #echo " > You should prefer absolute paths instead of relative paths"
   #echo " > In order go cross platform"
   echo
   read -sn1 -t 0.5
   echo "Instalation - Step 1 - by sourcing this file:"
   echo " > Issue the command '$ source <name-of-this-file>' and then"
   echo "   travel to the directory you want the software to be installed in"
   echo "   and from there, invoke this script with the command '$ DRYa-install-me-at-bashrc' " 
   echo 
   read -sn1 -t 0.5
   echo "Instalation - Step 2 - Move the DRYa repo into the dir you choose"
   echo " > If you were able to source this file, you must have a copy of DRYa"
   echo "   and that copy (this copy) should be moved into the directory in which"
   echo "   you did invoke DRYa-install-me-at_bashrc"
   echo "   uDev: create a function that automatically moves the directory"
   echo 
   read -sn1 -t 0.5
   echo "After instalation:"
   echo " > You cat unload the function that was sourced for instalation"
   echo "   you loaded: f_DRYa_install_me_at_bashrc that exports the variable \$DRYa_PATH"
   echo "   Now, if the place for instalation is how you like, you can prevent it from changing"
   echo "   by invoking: unset-DRYa-installer"
   echo

   read -s -p "ENTER to Main Menu... "
   
   return  # Returns to the fx that called this one
}



















function f_create_backup {

   # Search and delete the entry for DRYa inside ~/.bashrc

   function f_backup_choice_was_no {
      echo          "   > You are choosing not to create a backup"
      echo          "   > [Any Key to Continue...] or [Ctrl + C] to CANCEL"
      read -sn 1 -p "   > "
      echo
   }

   while true
   do

      # Asking if the user want to create a backup first

      echo -n " > Do you want a backup to be created from your ~/.bashrc? (y/N) "
      read -sn 1 v_ans
      echo

      if [[ -z $v_ans ]]; then
         f_backup_choice_was_no 
         break

      elif [[ $v_ans == "y" ]] || [[ $v_ans == "Y" ]]; then

         cp ~/.bashrc ~/.bashrc.bak

         echo "   > file ~/.bashrc copied to ~/.bashrc.bak (ENTER to continue)"
         read -sn 1

         break

      elif [[ $v_ans == "n" ]] || [[ $v_ans == "N" ]]; then
         f_backup_choice_was_no 
         break

      else

         echo " > Please choose a valid Option (ENTER to continue)"
         read -sn 1
         echo

      fi

   done
}






























function f_delete_empty_lines {
   echo "Press enter to start the backup removal of empty lines sequence"
   read -sn1

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
	     read -sn1

		fi
}

function f_delete_previous_DRYa_installation {

   # Asking if the user wants the previous DRYa instalation to be removed (if any)
	  # This deletes only the 2 lines of code inside ~/.bashrc
	  # uDev: Find first if there is any entry at ~/.bashrc to avoid this speach
	  echo "DRYa: Do you want this script"
	  echo " > to remove the 4 lines of code maybe present inside"
	  echo "   ~/.bashrc from a possible previous DRYa instalation?"
	  echo "   (ignore if you never installed DRYa before)"
	  read -sn1 -p " > Remove? (y/n)" v_ans
	  
	  case $v_ans in
		 y | Y)
           read -sn 1 -p " Press ENTER to proceed to delete previous DRYa instalation"
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

function f_DRYa_install_me_at_bashrc {
   # Print into ~/.bashrc

   # uDev: Esta fx busca as variaveis e imprime texto em ~/.bashrc. Mas pode tambem ser util no inicio deste script manter uma copia literal desse TEXTO literal tal como ele fica escrito apos a instalacao. Por algum motivo que o instalador falhe iria servir para colar diretamente esse texto para ~/.bashrc

   # From the previous function, DRYa repo is located at:
	   #echo $found_DRYa_at
      #read -sn 1
	  
   # Defining the environment variable:
	  #__dryaSRC__="${found_DRYa_at}/all/dryaSRC"
	  #__dryaSRC__="$__REPOS_CENTER__/DRYa/all/dryaSRC"
	  __dryaSRC__=DRYa/all/dryaSRC
	  echo " > DRYa: Initial ramification file, redirects all others is located at: $__dryaSRC__"
   
   # This variable comes from the function that cuts the string
      echo "You have chosen $__REPOS_CENTER__ to be a dedicated directory to receive every kind of repositories"
   
   echo "If you agree with this, press [ANY KEY] to concat this info into ~/.bashrc"
   echo " > Or press Ctrl-c to abort"
   read -sn1

   # Pasting a new entry inside ~/.bashrc (these lines are responsible to load every other Seiva's Repositories
	   # Pasting 1 empty line + 4 lines of code:

      v_hashtag_top=" ##  ( #drya-top-hashtag )"   # This hashtag is placed on the 3rd line. (Not on the empty line, not on the title, but at the end of the third line of code)
      v_hashtag_bot=" ##  ( #drya-bot-hashtag )"   # This hashtag is placed, not on the last line of the instalation (which is the empty one), but it is place on the line before (which is also the last line of code)

      L_space=""
         L1_1="# Legacy DRYa"
         L1_2="   v_REPOS_CENTER="/home/dv/Repositories"; export v_REPOS_CENTER  # Dedicated and directory for repos $v_hashtag_top"
      L_space=""
           L2="# STARTING: DRYa (Don't Repeat Yourself, app) $v_hashtag_top"
           L3="   __REPOS_CENTER__=$__REPOS_CENTER__; # Directory to centralize Repositories"
           L4="   __dryaSRC__=\$__REPOS_CENTER__/$__dryaSRC__; # First DRYa file to run. It initiates all others"
           L5="   export __REPOS_CENTER__ __dryaSRC__ ; source \$__dryaSRC__ $v_hashtag_bot"
      L_space=""

      echo "$L_space"   >> ~/.bashrc
      echo "$L1_1"      >> ~/.bashrc
      echo "$L1_2"      >> ~/.bashrc
      echo "$L_space"   >> ~/.bashrc
      echo "$L1"        >> ~/.bashrc
      echo "$L2       " >> ~/.bashrc
      echo "$L3       " >> ~/.bashrc
      echo "$L4       " >> ~/.bashrc
      echo "$L5       " >> ~/.bashrc
      echo "$L_space"   >> ~/.bashrc

   # Process Finished
	  echo "DRYa: 1 Empty line + 3 Lines of code where send from DRYa to ~/.bashrc"

   # If the script was sorced instead of run, remember to unset
	  #echo "You can even unset the installer"
	  #echo " > Type: unset-DRYa-installer"
}

function f_install_DRYA_desktop_icon {
   # uDev: This will be part of GUI features
   echo " > uDev: installing drya.desktop is not ready yet"
}

function f_remove_DRYA_desktop_icon {
   echo " > uDev: removing drya.desktop is not ready yet"
}

function f_source_bashrc {

   # Execute this file simply to source (reset) ~/.bashrc
   # description: This file contains 2 ways of sourcing ~/.bashrc (one correct and one wrong)

   # Wrong way (because if the script that calles this file is listed under ~/.bashrc than that shell will enter in a loop):
   #alias src="source ~/.bashrc"

   # CORRECT WAY (you can paste these following functions inside ~/.bashrc or inside a side script called by ~/.bashrc):
   alias src="go gnome-terminal; exit" ## This command is similar to `source ~/.bashrc` but needs the function `go` and the specific Gnome terminal

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
   echo " > Note: 'figlet' will be install in the first dependencies package"
   echo " > Note: 'figlet' fonts are automatically installed by dryaSRC (when the terminal reloads)"
}


function f_run_every_used_function {
   # Installer sequence
   
   f_GR
   f_talk; echo "Last installation steps... "
   read -sn 1

         f_install_DRYA_desktop_icon
         f_install_figlet_font
			f_cut_4_fields_relative_path
			f_create_backup
			f_delete_previous_DRYa_installation
			f_delete_empty_lines
			f_DRYa_install_me_at_bashrc
			#f_unset_DRYa_installer
			#f_source_bashrc
}


function f_testar_linha_120_se_se_encontra_em_branco {

   if [ -z "$(sed -n '120p' ficheiro.txt)" ]; then
      # Isto considera também uma linha que contenha apenas espaços ou tabulações como não vazia.
      echo "Linha 120 vazia"
   fi


   if [[ $(sed -n '120p' ficheiro.txt) =~ ^[[:space:]]*$ ]]; then
      # considerar linhas com apenas espaços/tabulações como vazias:

      echo "vazia ou só espaços"

      # Faz match com: 
      #  ""
      #  " "
      #  "    "
      #  "\t"
      #  " \t  "
   fi
}

function f_initialization {
   # Testing the wizzard and setting up History log

   f_internal_variables
   f_delete_history
   f_hzl

   # Defining Libraries
      f_5; #f_5_verbose
      f_1; #f_1_verbose

   f_variables_recalculated 

}





function f_exec {
   # Sequence to run after loading all previosu fx

   f_initialization  
   f_screen_1__test_installer_habilities  # Step (1/x)
   f_screen_2__main_menu                  # Step (from 2 to x)
   f_congratulations_finished
}
f_exec
