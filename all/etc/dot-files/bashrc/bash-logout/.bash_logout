# Title: .bash_logout (dot-files by Seiva D'Arve)
# Note: ~/.bash_logout is executed by bash(1) when login shell exits.

# when leaving the console, clear the screen to increase privacy
   if [ "$SHLVL" = 1 ]; then
       [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
   fi

# DRYa files
   #bash ${v_REPOS_CENTER}/ezGIT/bin/logout-updater-git-push

   echo "DRYa: A blank logout message "; sleep 2
