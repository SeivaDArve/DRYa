# ~/.bash_logout: executed by bash(1) when login shell exits.

# when leaving the console clear the screen to increase privacy

if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi

# DRYa files
   #bash ${v_REPOS_CENTER}/ezGIT/bin/logout-updater-git-push

echo "drya: A message"; sleep 2
