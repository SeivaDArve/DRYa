# Title: .bash_logout (dot-files by Seiva D'Arve)
# Description: default bash file that runs before terminal is closed
# Use: The name of this file (.bash_logout when used) should be copied to ~
#      To do so, you can navigate to the directory this file is located and run the command: "cp logout-all-drya-files ~/.bash_logout"

# Note: ~/.bash_logout is executed by bash(1) when login shell exits.

# when leaving the console, clear the screen to increase privacy
   if [ "$SHLVL" = 1 ]; then
       [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
   fi

# DRYa files (loads logout-all-drya-files)
    source ${v_REPOS_CENTER}/DRYa/all/etc/logout-all-drya-files
