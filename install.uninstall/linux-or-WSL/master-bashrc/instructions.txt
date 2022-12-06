# Explanation on how it works
	If you are trying to install this repository (DRYa) from the terminal, 
	   then we know that you can issue commands across the entire 
	   file system (not opening the file explorer at the location where actually at)

	If you are using a terminal we know that your current directory may be your home directory
	   and still listing and running files from the root of your drive (for exemple)

	But this script was made in such a way that it needs you to navigate to the directory in which this file is located
	   Because it will need to evaluate your current location

	This happens because the user MAY clone a git repository for any part of the file system
	   And the script is trying to facilitate the user at the point of instalation where the entire DRYa directoy is MOVED
	   to a new location choosen by the user
	   If the user already downloads DRYa repository to exactly where the user wants to dir to be, 
	   then, there would not be any problem

	The Repository also asks the user to be organized and decide which directory the user wants ALL repositories to be located
	  At linux usually ALL binary file go into /bin
	  At linux usually ALL variable files go into /var
	  At linux usually ALL config files go into /etc
	  Accordingly, this script will ask the user to decide a directory to centralize every Repository under development
	  like ~/Repositories

# Steps for installation
  1 - Read the explanation on how it works (because it is actually important)
  2 - Source the file "1-cutting-last-3-fields.sh" with the command 'source 1-cutting-last-3-fields.sh &>/dev/null'

