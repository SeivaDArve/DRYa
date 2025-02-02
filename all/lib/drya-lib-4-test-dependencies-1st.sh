#!/bin/bash
# Title: Test dependencies existence

# Test the existence of DRYa dependencies like: fzf, figlet, ncurses-utils, etc
#
# See dependencies on file '1st' somewhere in DRYa repo




function f_testing_either_repo_or_directory {
   cd $v_repo 

   if [ -d ".git" ]; then
      echo "It is a repo"

   else
      echo "it is not a repo"
   fi
}

function f_ensure_repo_existence {
   # Tests if a repository exists. If it does not, it clones it
   # Needs var: v_ensure

   # uDev: ensure `git` is also installed to clone repo if needed

   v_repo=${v_REPOS_CENTER}/$v_ensure

   [[ -z $v_ensure ]] && echo "Could not test repo existence without specofying its name at $v_ensure" 

   if [ -d $v_ensure ]; then
      echo "it does exist, now we test if it is a repo"
      f_testing_either_repo_or_directory

   else
      echo "it does not exist"
   fi
}
f_ensure_repo_existence
