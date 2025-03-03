#!/bin/bash
# Title: Test dependencies existence

# Test the existence of DRYa dependencies like: fzf, figlet, ncurses-utils, etc
#
# See dependencies on file '1st' somewhere in DRYa repo


#
#
#  INSTRUCTIONS: 
#     At the top of every script file in which this script needed, place these lines below:
#
#
#     # Sourcing DRYa Lib 4
#        source ${v_REPOS_CENTER}/DRYa/all/lib/drya-lib-4-test-dependencies-1st.sh
#
#        v_ensure="<example-name-of-repo-to-ensure-existence>" && f_ensure_repo_existence
#
#


# Sourcing DRYa Lib 1: Color schemes, f_greet, f_greet2, f_talk, f_done, f_prsK, f_Hline, f_horizlina, f_verticline, etc... [From the repo at: "https://github.com/SeivaDArve/DRYa.git"]
   source ${v_REPOS_CENTER}/DRYa/all/lib/drya-lib-1-colors-greets.sh

   v_greet="DRYa"
   v_talk="DRYa: Lib 4: "





function f_testing_either_repo_or_directory {
   cd $v_repo 

   if [ -d ".git" ]; then
      echo " > There is a directory with that name and It is a repo"

   else
      echo "There is a directory with that name and It is not a repo"
      echo 
      

      # Lista de opcoes para o menu `fzf`
         Lz1='Save '; Lz2='<menu-terminal-command-here>'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

         L2='2. Renomear pasta existente > Clonar Original'                                      
         L1='1. Exit com erro 1'

         L0="SELECT 1: Ensure repo $v_ensure: "
         LH="Pasta ja existe e nao é repo, o que pretende fazer?"
         
         v_list=$(echo -e "$L1 \n$L2 \n$L3 \n$L4 \n\n$Lz3" | fzf --cycle --prompt="$L0" --header="$LH")

         #echo "comando" >> ~/.bash_history && history -n
         #history -s "echo 'Olá, mundo!'"

      # Perceber qual foi a escolha da lista
         [[ $v_list =~ $Lz3  ]] && echo "$Lz2" && history -s "$Lz2"
         [[ $v_list =~ "2. " ]] && echo "uDev: $L2" && sleep 0.1 
         [[ $v_list =~ "1. " ]] && echo "Canceled" && exit 1
         unset v_list
    


   fi
}

function f_test_pkg_git_installed {
   # See if git is installed on the machine

   git --version  &>/dev/null

   v_status=$?

   [[ $v_status == 1 ]] && pkg install git

}

function f_ensure_repo_existence {
   # Tests if a repository exists. If it does not, it clones it
   # Needs var: v_ensure

   # uDev: ensure `git` is also installed to clone repo if needed

   v_repo=${v_REPOS_CENTER}/$v_ensure

   [[ -z $v_ensure ]] \
      && f_talk \
      && echo "Could not test repo existence without specifying its name as \$v_ensure" \
      && exit 1

   if [ -d $v_ensure ]; then

      f_talk \
         && echo "Directory $v_ensure already exists"

      f_talk \
         && echo "Now we test if it is a repo:"

      f_testing_either_repo_or_directory

   else

      f_talk \
         && echo "Directory it does not exist"

      f_test_pkg_git_installed

      git clone https://github.com/SeivaDArve/$v_ensure.git
   fi
}
