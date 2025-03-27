#!/bin/bash
# Title: Test dependencies existence

# Test the existence of DRYa dependencies like: fzf, figlet, ncurses-utils, etc
#   (See dependencies on file '1st' somewhere in DRYa repo)
#
# Test the existence of DRYa repositories
# 
# Test and clone Repo dependencies too



#
#
#  INSTRUCTIONS: 
#     At the top of every script file in which this script needed, place these lines below:
#
#
#     # Sourcing DRYa Lib 4
#        source ${v_REPOS_CENTER}/DRYa/all/lib/drya-lib-4-dependencies-packages-git.sh
#
#        v_ensure="<example-name-of-repo-to-ensure-existence>" && f_lib4_ensure_repo_existence
#
#


# List of relatable functions between 'main script' + 'library script':
#
#     # f_lib4_ensure_repo_existence
#     #     main calls:  $v_ensure; f_lib4_ensure_repo_existence
#     #     lib returns: $v_green_light
#
#     # uDev: f_git_stash
#
#     # f_lib4_git_pull
#
#     # uDev: unstash
#     # uDev: f_git_push
#     # uDev: allow different commit messages
#     # uDev: delete repo in the end
#     # uDev: encrypt before push, decrypt after pull (using 3sab)
#
#
#     # `upk` fxs: 
#             Data de inicio
#             Verbose: nome da repo
#             ficheiro a ser editado
#             git pull
#             git status
#             uDev: trigger, to stop multiple files to work on same file at once
#             open file ...
#             ... close file
#             nome do ficheiro acabado de editar
#             git push
#             git status
#             data de fim
#             done
#       



# Sourcing DRYa Lib 1: Color schemes, f_greet, f_greet2, f_talk, f_done, f_prsK, f_Hline, f_horizlina, f_verticline, etc... [From the repo at: "https://github.com/SeivaDArve/DRYa.git"]
   source ${v_REPOS_CENTER}/DRYa/all/lib/drya-lib-1-colors-greets.sh

   v_greet="DRYa"
   v_talk="DRYa-lib-4: "

function f_rename_directory_with_same_name_as_original_repo {
   f_talk
   echo    "Para clonar a repo $v_ensure original, tem de renomear a pasta atual"
   echo    " > Qual o nome para a pasta existente (que nao é repo)? "
   read -p " > " v_ans
   echo    "uDev: Renomear $v_ensure para $v_ans"
}



function f_testing_either_repo_or_directory {
   f_talk; echo "Testing if it is a repo:"

   cd $v_repo 

   if [ -d ".git" ]; then
      echo " > This directory is a repo"
      echo 

      # Variable that tells main script (instead of this lib script) either to proceed or not
         v_green_light=0

   else
      echo " > This directory is not a repo"
      echo 
      

      # Lista de opcoes para o menu `fzf`
         Lz1=''; Lz2="Repo nao existe: $v_ensure"; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

         L2='2. Renomear pasta existente e Clonar Original'                                      
         L1='1. Cancelar alteracoes (com erro 1)'

         L0="drya-lib-4: f_lib4_ensure_repo_existence: $v_ensure: "
         LH="Pasta ja existe e nao é repo, o que pretende fazer?"
         
         v_list=$(echo -e "$L1 \n$L2 \n\n$Lz3" | fzf --cycle --prompt="$L0" --header="$LH")

      # Perceber qual foi a escolha da lista
         [[ $v_list =~ $Lz3  ]] && echo "$Lz2" && history -s "$Lz2"
         [[ $v_list =~ "2. " ]] && f_rename_directory_with_same_name_as_original_repo
         [[ $v_list =~ "1. " ]] && echo "Canceled" && v_green_light=1 #&& exit 1
         unset v_list
   fi
}

function f_test_pkg_git_installed {
   # See if git is installed on the machine. If not installed, proceed to instalation

   # uDev: traitsID must test package manager
   
   git --version  &>/dev/null

   v_status=$?

    [[ $v_status == 1 ]] && pkg install git
   #[[ $v_status == 0 ]] && echo 'Package `git` is installed'  # Debug

}

function f_lib4_ensure_repo_existence {
   # Tests if a repository exists. If it does not, it clones it
   # Needs var: v_ensure

   # Example: 
   #     unset v_green_light       # var given after drya-lib-4 that tells this main script either to proceed or not
   #     v_ensure="repoX"          # Repo name we want to ensure its existence
   #     f_lib4_ensure_repo_existence   # fx that searches for $v_ensure existance and presents a menu in each kind of error 


   # Path + Name of the repo
      v_repo=${v_REPOS_CENTER}/$v_ensure
   
   # When using this script as a Lib, the variable $v_ensure must exist, an error will be mentioned if not set
      if [ -z $v_ensure ]; then
         f_talk; echo 'Could not test repo existence, variable not set'
                 echo ' > Specifying variable $v_ensure'
         exit 1
      fi

   # Test if package `git` exists
      f_test_pkg_git_installed

   # Testing if directory corresponding to the repo exists
      if [ -d $v_repo ]; then

         f_talk; echo "Directory already exists:"
                 echo " > $v_ensure"
                 echo

         f_testing_either_repo_or_directory

      else
         f_talk; echo "Directory does not exist"

         cd ${v_REPOS_CENTER}/ 
         v_cloned="https://github.com/SeivaDArve/$v_ensure.git"
         git clone $v_cloned
      fi

      # uDev: Git Pull, otherwise, files can be edited in outdated versions
}

function f_lib4_git_pull {
   # Git Pull sem abrir o editor e editar a commit message quando faz Merge

   f_talk; echo 'A fazer download `git pull --no-edit`'
   git pull --no-edit
   echo
}

# uDev: git push
