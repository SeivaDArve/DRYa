#!/bin/bash
# Title: Test dependencies existence

# Description: 
#  - Tests the existence of DRYa dependencies like: fzf, figlet, ncurses-utils, etc
#    (See dependencies on file '1st' somewhere in DRYa repo)
#   
#  - Tests the existence of DRYa repositories
#    
#  - Tests and clone Repo dependencies too



#
#
#  INSTRUCTIONS: 
#     At the top of every script file in which this script needed, place these lines below:
#
#
#     # Using drya.sh
#        uDev: `D lib4 <file-to-open-sync-close-sync>`
# 
#     # uDev: o script main fornece Abs Path to file only, then this lib finds out with is the current repo (finding .git) and storing both variables
#



#
#
#  INSTALLING (this library on main scripts):
#
#     # Sourcing DRYa Lib 4: Ensure package, updates, downloads, uploads
#        v_lib4=${v_REPOS_CENTER}/DRYa/all/lib/drya-lib-4-dependencies-packages-git.sh
#        [[ -f $v_lib4 ]] && source $v_lib4 || (read -s -n 1 -p "DRYa: error: drya-lib-4 does not exist " && echo)
#
#        # Examples: v_ensure="$v_df_repo" && f_lib4_download_compact && [edit some local file] && f_lib4_upload_compact 
#        #           f_lib4_stroken
#
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
#     # Repo `upk` sequence of fxs: 
#                  Data de inicio
#                  Verbose: nome da repo
#                  ficheiro a ser editado
#                  git pull
#                  git status
#                  uDev: trigger, to stop multiple files to work on same file at once
#                  open file ...
#                  ... close file
#                  nome do ficheiro acabado de editar
#                  git push
#                  git status
#                  data de fim
#                  done
#       









# ------------------------------------------------------------------
# --+-- Above: Instructions on how to use on other scripts --+--
# --+-- Below: Dependencies for this library itself        --+-- 
# ------------------------------------------------------------------








# Sourcing DRYa Lib 1: Color schemes
   v_lib1=${v_REPOS_CENTER}/DRYa/all/lib/libs/drya-lib-1-colors-greets.sh
   v_lib1_copy=${v_REPOS_CENTER}/DRYa/all/lib/libs/copies-for-libs/drya-lib-1--for--drya-lib-4

   # Original Examples: f_greet, f_greet2, f_talk, f_done, f_anyK, f_Hline, f_horizlina, f_verticline, etc... [From the repo at: "https://github.com/SeivaDArve/DRYa.git"]
   #  v_greet="DRYa"
   #  v_talk="DRYa: "

   if [ -f $v_lib1 ]; then
      # Se drya-lib-1 estiver disponivel para copia, a copia é executada, alterada ao estilo de drya-lib-4 (para que as variaveis da lib 4 nao se subreponham as de lib 1, e depois `source` a essa copia

      # Making a copy of the original, before manipulating and before sourcing a manipulated version (diferent from the original)
         cp $v_lib1 $v_lib1_copy

      # Renaming ALL functions in the copied file
         sed -i "s/ f_/ F_/g" $v_lib1_copy
         sed -i "s/ v_/ V_/g" $v_lib1_copy
         sed -i 's/$v_/$V_/g' $v_lib1_copy

      # Defining variables according to manipulation
         V_greet="DRYa"
         V_talk="drya-lib-4: "

      # Sourcing a manipulated version, diferent from the original, in order not to overwrite the original
         source $v_lib1_copy

   else
      # Se a drya-lib-1 nao existir para copia, mandar mensagem de erro
         read -s -n 1 -p "DRYa: drya-lib-1 does not exist (error)"
   fi








# ---------------------------------------------------------
# --+-- Above: Dependencies for this library itself  --+-- 
# --+-- Below: functions to be internally called     --+--
# ---------------------------------------------------------
   









function f_rename_directory_with_same_name_as_original_repo {
   F_talk
   echo    "Para clonar a repo $v_ensure original, tem de renomear a pasta atual"
   echo    " > Qual o nome para a pasta existente (que nao é repo)? "
   read -p " > " v_ans
   echo    "uDev: Renomear $v_ensure para $v_ans"
}



function f_testing_either_repo_or_directory {
   # Testing if it is a repo

   cd $v_repo 

   if [ -d ".git" ]; then
      F_c3; echo "$v_repo__ok"; F_rc
      v_green_light=0  # Variable that tells main script (instead of this lib script) either to proceed or not

   else
      F_c3; echo "$v_repo_nok"; F_rc
      v_green_light=1  # Variable that tells main script (instead of this lib script) either to proceed or not
      

      # Lista de opcoes para o menu `fzf`
         Lz1=''; Lz2="Repo nao existe: $v_ensure"; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

         L2='2. Renomear pasta existente e Clonar Original'                                      
         L1='1. Cancelar alteracoes (com erro 1)'

         Lh="Pasta ja existe e nao é repo, o que pretende fazer?"
         L0="drya-lib-4: f_lib4_ensure_repo_existence: $v_ensure: "
         
         v_list=$(echo -e "$L1 \n$L2 \n\n$Lz3" | fzf --cycle --prompt="$L0" --header="$Lh")

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





function f_git_commit {
   # Introduzir mensagem manualmente
   # Git commit -m ""

   # uDev: Run only if there are files to commit
   # uDev: If git status says "nothing to commit, working tree clean" then we must not ask for a commit message. Unless there are N number of commits to upload, which in that case, G ++ be used anyway

   F_talk; echo -en "Adding a commit message "
     F_c1; echo -n                          "i"
     F_rc; echo                              " (to staged files):"
           echo -n ' > `git commit -m "'
     F_c1; echo -n                    "i"
     F_rc; echo                        '" `'
           echo
           echo    " > What is your commit message?"
           echo    " > (leave empty to abort)"  # uDev: save cursor position here to overwrite text "leave empty to abort" 
     F_c1; read -p " > " v_ans
     F_rc; echo
   F_talk; echo -n 'git commit -m "'
     F_c1; echo -n               "$v_ans"
     F_rc; echo                        '"'

   git commit -m "$v_ans"  # uDev: Add F_sucess

           echo

}



function f_get_stroken {
   # This fx gets the current acess token from a file. (When a new acess token is configured at github, the user has to modify only the file ...DRYa/all/etc/dot-files/git-github/current-stroken)

   v_current_stroken=${v_REPOS_CENTER}/DRYa/all/etc/dot-files/git-github/current-stroken

   v_user=$(head -n 1 $v_current_stroken)
   v_tokn=$(tail -n 1 $v_current_stroken)
}



# --------------------------------------------------------------------------------
# --+-- Above: functions to be internally called                           --+--  
# --+-- Below: functions (single) to be called externally by main scripts  --+--
# --------------------------------------------------------------------------------

# This Section if for functions that are meant to be called one by one. They are not related to each other, and each one solves thwir own issue (longer verbose output)




               function f_stroken_print {
                  F_talk; echo -n "Presenting \""
                    F_c3; echo -n "stroken"
                    F_rc; echo    "\""
                          echo    " > Automatic sync (config file) not configured"
                          echo -n "   Use: "
                    F_c2; echo    "seivadarve"
                    F_rc; echo -n           "   And: ";
                    F_c2; echo    "ghp_JGIFXMcvvzfizn9OwAMdMdGMSPu9E30yVogPk"
                    F_rc; echo
               }

               function f_stroken {
                  # (Copiando de ezGIT)
                  # When automatic github.com authentication is not set, an alternative (as taxt based credential, but salted) is printed on the screen. This is usefull until the app remains as Beta.
                  # While the app is in beta, this is usefull

                  # If ~/.netrc exists, no need to print the rest
                     if [ -f ~/.netrc ]; then
                        #echo "~/.netrc exists"
                        echo "it exists" 1>/dev/null
                     else
                        f_stroken_print 
                     fi
               }



function f_lib4_stroken {
   # (Copiando de ezGIT)
   # When automatic github.com authentication is not set, an alternative (as taxt based credential, but salted) is printed on the screen. This is usefull until the app remains as Beta.
   # While the app is in beta, this is usefull

   f_get_stroken 

   if [ -f ~/.netrc ]; then
      # If ~/.netrc exists, no need to print the rest

      (F_talk && echo "~/.netrc exists" ) 1>/dev/null

   else
      # If ~/.netrc does not exists print stroken
      F_talk; echo "~/.netrc does not exist (config file for automatic sync)" #1>/dev/null
              echo -n " > Presenting\" "
        F_c3; echo -n                 "stroken"
        F_rc; echo          "\""
              echo -n "   Use: "
        F_c2; echo            "$v_user"
        F_rc; echo -n "   And: ";
        F_c2; echo            "$v_tokn"
        F_rc; echo
   fi
}

function f_lib4_stroken_print {
   # Print EVEN if .netrc exists and is properly configured. Print just to inform
      
   f_get_stroken 

         echo -n " > Presenting\" "
   F_c3; echo -n                 "stroken"
   F_rc; echo          "\""
         echo -n "   Use: "
   F_c2; echo            "$v_user"
   F_rc; echo -n "   And: ";
   F_c2; echo            "$v_tokn"
   F_rc; echo
}


function f_lib4_welcome {
   # Use this just to know if drya-lib-4 is intalled/available/sourced/ready

   F_talk; echo "Ready!"
}

function f_lib4_just_check_repo_existence {
   echo "uDev: Just check if repo exists and do nothing. exit if it does not exist"

   # uDev: pode ser dado o nome de uma repo $v_repo:                [ -n $v_repo         ]
   # uDev: pode ser dado o nome de um ficheiro de uma repo $v_file: [ -n $v_repo/$v_file ]

   echo "args: $@"
}





function f_lib4_ensure_repo_existence_single {
   # Tests if a repository exists. If it does not, it clones it
   # Needs var: v_ensure

   # Example: 
   #     unset v_green_light       # var given after drya-lib-4 that tells this main script either to proceed or not
   #     v_ensure="repoX"          # Repo name we want to ensure its existence
   #     f_lib4_ensure_repo_existence_single   # fx that searches for $v_ensure existance and presents a menu in each kind of error 


   # Path + Name of the repo
      v_repo=${v_REPOS_CENTER}/$v_ensure
   
   # When using this script as a Lib, the variable $v_ensure must exist, an error will be mentioned if not set
      if [ -z $v_ensure ]; then
         F_talk; echo 'Could not test repo existence, variable not set'
                 echo ' > Specifying variable $v_ensure'
         # uDev: add v_green_light
         exit 1
      fi

   # Test if package `git` exists
      f_test_pkg_git_installed

   # Testing if directory corresponding to the repo exists
      # uDev: add v_green_light
      if [ -d $v_repo ]; then

         F_talk; echo "Directory already exists:"
                 echo " > $v_ensure"
                 echo

         f_testing_either_repo_or_directory

      else
         F_talk; echo "Directory does not exist"

         cd ${v_REPOS_CENTER}/ 
         v_cloned="https://github.com/SeivaDArve/$v_ensure.git"
         git clone $v_cloned
      fi

      # uDev: Git Pull, otherwise, files can be edited in outdated versions
}

function f_lib4_git_pull_single {
   # Git Pull sem abrir o editor e editar a commit message quando faz Merge

   # uDev: perguntar char GPT: testar `git pull` so por 10 secs, e editar à mesma se Offline.

   F_talk; echo 'A fazer download `git pull --no-edit`'
   git pull --no-edit
   read -sn1 -t 1  # Dar 1 segundo pada o user ler o texto  

   # uDev: Se a fx anterior der erro, questionar o utilizador se quer continuar a edtar o ficheiro em modo offline com a ultima versao do ficheiro possivelmente desatualizada

   echo
}


function f_lib4_git_pull_2_single {
   F_talk; echo -n 'Receiving from Github: '
     F_c3; echo    '`git pull`'
     F_rc; echo

   git pull
   read -sn1 -t 1  # Dar 1 segundo pada o user ler o texto  
}

function f_lib4_git_add_all_single {

   # Get current `git status` without verbose, only the intresting part.
      v_status=$(git status --short)

     #cd $v_df_repo_pwd  # Legacy
      cd $v_ensure

   # Only if there is anything to commit or to finish, only then, changes are added to Staging Are
      if [[ -n $v_status ]]; then
         # uDev: Run only if there are files to stage
         F_talk; echo -n 'Staging all files: '
           F_c3; echo    '`git add --all`'
           F_rc
                 git add --all
                 echo

         read -sn1 -t 1  # Dar 1 segundo pada o user ler o texto  

      else
         F_talk; echo 'Nothing needs to be done'
         exit 0

      fi
}


function f_lib4_git_push_single {
   # uDev: Run only if there are files to push

   F_talk; echo -n 'Sending to Github: '
     F_c3; echo    '`git push`'
     F_rc

   git push
   echo
   read -sn1 -t 1  # Dar 1 segundo pada o user ler o texto  
}





function f_lib4_git_commit_single {
   # uDev: Run only if there are files to commit
   # uDev: Nas commit messagem, incluir o nome do ficheiro modificado

   # Menu Simples

   # Variables to improve txt
      v_blind__msg="drya-lib-4: Pushed to github.com automatically"
      v_udev___msg="drya-lib-4: Improvements made only around uDev comments (added/modify/etc..)"
      v_auto___msg="drya-lib-4: automatic commit"
      v_cancel_msg="Canceled: Adding a commit message to last changes"
      v_unfini_msg=" > Unfinished uploads: repo $v_df_repo (uDev)"

   # Lista de opcoes para o menu `fzf`
      L5='5. Mensagem automatica: blind commit'
      L4='4. Mensagem automatica: uDev comments'                                      
      L3='3. Mensagem nova (Introduzir manualmente)'                                      

      L2='2. Cancel'
      L1='1. Mensagem automatica: "drya-lib-4: automatic commit"'

      L0="drya-lib-4: Que tipo de commit message pretende? "
      
      v_list=$(echo -e "$L1 \n$L2 \n\n$L3 \n$L4 \n$L5" | fzf --cycle --prompt="$L0")

   # Perceber qual foi a escolha da lista
      [[    $v_list =~ $Lz3  ]] && echo "$Lz2" && history -s "$Lz2"
      [[    $v_list =~ "5. " ]] && git commit -m "$v_blind__msg" && echo
      [[    $v_list =~ "4. " ]] && git commit -m "$v_udev___msg" && echo
      [[    $v_list =~ "3. " ]] && f_git_commit
      [[    $v_list =~ "2. " ]] && echo          "$v_cancel_msg"
      [[    $v_list =~ "1. " ]] && git commit -m "$v_auto___msg" && echo
      [[ -z $v_list          ]] && echo          "$v_cancel_msg" && F_c8 && echo "$v_unfini_msg" && F_rc && echo

      unset v_list
}


# --------------------------------------------------------------------------------
# --+-- Above: functions (single)  to be called externally by main scripts  --+--
# --+-- Below: functions (compact) to be called externally by main scripts  --+--
# --------------------------------------------------------------------------------

# This Section if for a cascade effect of functions connected with themselves (for compact verbose output). 


function f_repo_name_compact {
   F_talk; echo -n "Ensuring repository existence (compact): "
     F_c3; echo "$v_ensure"
     F_rc  
}

function f_lib4_git_status_compact {
   v_basename=$(basename $(pwd))
    F_talk; echo -n "git status on path: "
     F_c3; echo    ".../$v_basename"
     F_rc


   F_c1
   git status
   F_rc
}

function f_lib4_ensure_repo_existence_compact {
   # Tests if a repository exists. If it does not, it clones it. (Needs var: v_ensure)

   # When using this script as a Lib, the variable $v_ensure must exist, an error will be mentioned if not set
      if [ -z $v_ensure ]; then
         F_talk; echo 'Could not test repo existence, variable not set'
                 echo ' > Specify variable $v_ensure first'
         # uDev: add v_green_light
         exit 1
      fi

   # Path + Name of the repo
      v_repo=${v_REPOS_CENTER}/$v_ensure
   
   # Varible that corresponds to github repo name
      v_cloned="https://github.com/SeivaDArve/$v_ensure.git"

   # Messages
      v_dir__ok=" > Directory exists "
      v_dir_nok=" > Directory does not exist "

      v_repo__ok="(It is a repo)"
      v_repo_nok="(It is not a repo)"
      v_repo_ren=" > Do you want to rename existing directory to make space for repo?"  # Rename a directory with same name as repo

      v_clone_inf=" > Starting attempt to clone"
      v_clone__ok=" > Attempting to clone: Sucess"
      v_clone_nok=" > Attempting to clone: Not sucessfull"


   # Test if package `git` exists
      f_test_pkg_git_installed
      # uDev: Verbose se git existe


   # Testing if the name $v_ensure that was given corresponds to file/directory/repository or if it does not exist
      # uDev: add v_green_light

      f_repo_name_compact 

      if [ -d $v_repo ]; then
         # If directory exists

         echo -n "$v_dir__ok"
         f_testing_either_repo_or_directory

      else
         # If directory does not exist  (uDev: Test if there is a file)

         echo "$v_dir_nok"
         echo "$v_clone_inf"

         cd ${v_REPOS_CENTER}  &&   git clone $v_cloned

         # If last command worked, a sucess message is sent, otherwise, app closes
            [[ $? == 0 ]] && echo "$v_clone__ok" || (echo "$v_clone_nok" && exit 1)

      fi

      # uDev: Git Pull, otherwise, files can be edited in outdated versions
}


function f_lib4_stroken_compact {
   f_get_stroken 

   if [ -f ~/.netrc ]; then
      # If ~/.netrc exists, no need to print the rest
            echo -n " > Config file exists "
      F_c3; echo                          "(~/.netrc)"
      F_rc

   else
      # If ~/.netrc does not exists print stroken
            echo -n " > Config file does not exist "
      F_c3; echo                          "(~/.netrc)"
      F_rc
            echo -n "   Use: "
      F_c2; echo            "$v_user"
      F_rc; echo -n "   And: ";
      F_c2; echo            "$v_tokn"
      F_rc
   fi

}




function f_lib4_git_pull_compact {
   # Git Pull sem abrir o editor e editar a commit message quando faz Merge

   # uDev: perguntar char GPT: testar `git pull` so por 10 secs, e editar à mesma se Offline.

   # Get current hour in nanoseconds only
      v_date=$(bash ${v_REPOS_CENTER}/DRYa/all/bin/data.sh n)

         echo -n ' > Downloading: '
   F_c3; echo                    '`git pull --no-edit`'
   F_rc

   # Output com outra cor
         echo -n "   > git output here "
   F_c3; echo                    "(Hidden. Sent to ssms. ID: $v_date)"
   F_rc

      f_hzl >> $v_ssms
      echo "drya-lib-4: git pull: Date: $v_date" >> $v_ssms

      #git pull --no-edit 1>/dev/null
      git pull --no-edit 1>>$v_ssms

   # uDev: Se a fx anterior der erro, questionar o utilizador se quer continuar a edtar o ficheiro em modo offline com a ultima versao do ficheiro possivelmente desatualizada

}

function f_lib4_opening_file_compact {
   echo ' > Finished sync down ... '
}

function f_lib4_closing_file_compact {
   echo ' > Starting sync up ...'
}

function f_lib4_git_pull_2 {
   F_talk; echo -n 'Receiving from Github: '
     F_c3; echo    '`git pull`'
     F_rc; echo

   git pull
   echo
}

function f_lib4_git_add_all_compact {

   unset v_changes

   # Get current `git status` without verbose, only the intresting part.
      v_status=$(git status --short)

      #cd $v_df_repo_pwd

   # Only if there is anything to commit or to finish, only then, changes are added to Staging Are
      if [[ -n $v_status ]]; then
         # uDev: Run only if there are files to stage
               echo -n ' > Adding modified files: '
         F_c3; echo    '`git add --all`'
         F_rc
         git add --all
         v_changes="found"
      else
         echo ' > No changes found to add'
         v_changes="not-found"

      fi
}


function f_lib4_git_commit_compact {
   # uDev: Run only if there are files to commit
   # uDev: Nas commit messagem, incluir o nome do ficheiro modificado

   function f_cmt_msg {

      # Get current hour in nanoseconds only
         v_date=$(bash ${v_REPOS_CENTER}/DRYa/all/bin/data.sh n)

            echo -n ' > Commiting: '
      F_c3; echo                    "\"$v_msg\""
      F_rc

      # Output com outra cor
            echo -n "   > git output here "
      F_c3; echo                    "(Hidden. Sent to ssms. ID: $v_date)"
      F_rc

      f_hzl >> $v_ssms
      echo "drya-lib-4: git commit. Date: $v_date" >> $v_ssms

      git commit -m "$v_msg" 1>>$v_ssms

   }

   if [[ $v_changes == "found" ]]; then
      echo " > Opening 'commits' menu..."

      # Variables to improve txt
         v_blind__msg=" > commits menu: Pushed to github.com automatically"
         v_udev___msg=" > Commits menu: Improvements made only around uDev comments (added/modify/etc..)"
         v_auto___msg=" > Commits menu: automatic commit"
         v_cancel_msg=" > Commits menu: Canceled automatic commit messages"
         v_unfini_msg=" > Commits menu: Unfinished uploads"

      # Lista de opcoes para o menu `fzf`
         L5="5. Mensagem automatica |  $v_blind__msg"
         L4="4. Mensagem automatica |  $v_udev___msg"                                      
         L3="3. Mensagem nova       |  (Introduzir manualmente)"                                      

         L2='2. Cancel'
         L1="1. Mensagem automatica | $v_auto___msg"

         Lh=$(echo -e "\n- Alteracoes detetadas: 'git status -s':\n$(git status -s)\n ")
         L0="drya-lib-4: Que tipo de commit message pretende? "
         
         v_list=$(echo -e "$L1 \n$L2 \n\n$L3 \n$L4 \n$L5" | fzf --no-info --cycle --header="$Lh" --prompt="$L0")

      # Perceber qual foi a escolha da lista
         [[    $v_list =~ $Lz3  ]] && echo "$Lz2" && history -s "$Lz2"
         [[    $v_list =~ "5. " ]] && v_msg="$v_blind__msg" && f_cmt_msg
         [[    $v_list =~ "4. " ]] && v_msg="$v_udev___msg" && f_cmt_msg
         [[    $v_list =~ "3. " ]] && f_git_commit
         [[    $v_list =~ "2. " ]] && F_c8 && echo          "$v_cancel_msg" && F_rc
         [[    $v_list =~ "1. " ]] && v_msg="$v_auto___msg" && f_cmt_msg
         [[ -z $v_list          ]] && echo          "$v_cancel_msg" && F_c8 && echo "$v_unfini_msg" && F_rc

         unset v_list

      v_push=yes

   else
      v_push=no

      echo ' > No changes to commit'
   fi

}


function f_lib4_git_push_compact {
   # uDev: Run only if there are files to push

   if [[ $v_push == "yes" ]]; then

      # Get current hour in nanoseconds only
         v_date=$(bash ${v_REPOS_CENTER}/DRYa/all/bin/data.sh n)

            echo -n ' > Uploading: '
      F_c3; echo                    "\"$v_msg\""
      F_rc

      # Output com outra cor
            echo -n "   > git output here "
      F_c3; echo                    "(Hidden. Sent to ssms. ID: $v_date)"
      F_rc

      f_hzl >> $v_ssms
      echo "drya-lib-4: git push. Date: $v_date" >> $v_ssms

      git push  &>>$v_ssms

   else
      echo ' > No changes to upload'
   fi

   echo " > Done"
   echo
}


function f_lib4_download_compact {
   # uDev: All fx here have to end in _compact
   f_lib4_ensure_repo_existence_compact  # Precisa da variavel: $v_ensure com o nome do repositorio
   f_lib4_stroken_compact
   f_lib4_git_pull_compact
   f_lib4_opening_file_compact
   f_hzl
   echo
}

function f_lib4_upload_compact {
   echo
   f_hzl
   f_repo_name_compact 
   # uDev: All fx here have to end in _compact
   f_lib4_closing_file_compact
  #f_lib4_git_add_all_compact: converter em: f_lib4_git_add_one_file_compact  # uDev: As repos podem ter outro ficheiros sem commit que nao precisam ser adicionados ao editar apenas 1 ficheiro
   f_lib4_git_add_all_compact
   f_lib4_git_commit_compact
   f_lib4_git_push_compact
   f_lib4_git_status_compact
   f_hzl
}


# -------------------------------------------------------------------------------
# --+-- Above: functions (compact) to be called externally by main scripts  --+--
# -------------------------------------------------------------------------





