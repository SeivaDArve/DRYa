#!/bin/bash 
# Title: DRYa (Don't Repeat Yourself app)
# Description: The central script that manages other scripts and repos. You may use this app in many ways. Specially as a toolbox
# Use: You can call an fzf main menu that, for each fx in it, there is an equivalent terminal command

: '
  Multi comment example
'

# Sourcing DRYa Lib 1: Color schemes, f_greet, f_greet2, f_talk, f_done, f_anyK, f_Hline, f_horizlina, f_verticline, etc... [From the repo at: "https://github.com/SeivaDArve/DRYa.git"]
   source ${v_REPOS_CENTER}/DRYa/all/lib/drya-lib-1-colors-greets.sh

   v_greet="DRYa"
   v_talk="DRYa: "


# Sourcing DRYa Lib 2
   v_lib2=${v_REPOS_CENTER}/DRYa/all/lib/drya-lib-2-tmp-n-config-files.sh
   [[ -f $v_lib2 ]] && source $v_lib2 || read -s -n 1 -p "Error: drya-lib-2 does not exist"

   #f_create_tmp_file  # will give a $v_tmp with a new file with abs path


function f_instructions_of_usage {
   # Função para exibir como usar o script

   f_talk; echo "Instruções: Criar um link simbólico de <origem> para <destino>."
           echo " > Origem:  É o arquivo ou diretório existente que se deseja referenciar."
           echo " > Destino: É o caminho e nome do link simbólico que você está a criar."
           echo "            Para o destino, tem de escolher um nome novo"
           echo 
           echo ' > exemplo: `ln -s         <diretorio-existente> <novo-caminho-com-nome>`'
           echo
           echo ' > exemplo: `drya sof-link <diretorio-existente> <novo-caminho-com-nome>`'
           echo ' > exemplo: `drya sl       <diretorio-existente> <novo-caminho-com-nome>`'
           echo ' > exemplo: `D sl          <diretorio-existente> <novo-caminho-com-nome>`'
           echo 
   f_talk; echo 'Também pode guardar o <origem> em uma variavel para não ter de escrever manualmente'
           echo ' > exemplo: `origem=$(pwd)`'
           echo ' >> `D sl $origem <novo-caminho-com-nome>`'
           echo
           echo ' > Com DRYa, pode guardar um caminho na variavel $h usando 5x .'
           echo ' >> ou seja: Navegar para origem e escrever `.....` para guardar h=$(pwd)'
           echo 
           echo ' >>> Resumindo: `D sl $h <nome-ou-caminho-com-nome>` para criar com DRYa um Soft-link de $h para $v'
           echo 
   f_talk; echo "Remover um link:"
           echo ' > Se for um diretorio: `unlink <diretorio-a-remover>`'
           echo ' > Se for um ficheiro:  `rm     <ficheiro-a-remover>`'
      exit 1
}

function f_stroken {
   # When automatic github.com authentication is not set, an alternative (as text based credential, but salted) is printed on the screen. This is usefull until the app remains as Beta.

   # If ~/.netrc exists, no need to print the rest
      if [ -f ~/.netrc ]; then
         echo ".netrc exists. No github auth needed" 1>/dev/null

      else
         f_talk; echo    "stroken"
                 echo    " > Inside the ezGIT app I found this: "
         f_c4;   echo -n "seivadarve";
         f_rc;   echo    " and this:";
         f_c4;   echo    "ghp_JGIFXMcvvzfizn9OwAMdMdGMSPu9E30yVogPk"
         f_rc;   echo
      fi
}

function f_install_drya {
   # Install DRYa itself + dependencies + 1st + termux-setup-storage + termux-API

   f_greet

   f_talk; echo "uDev: Are you sure you want to install DRYa?"; 
           echo
           echo "If you want to install drya itself, 3 ways:"
           echo "  1. Download and run:  github.com/DRYa/ghost-in.sh"
           echo "  2. Git Clone and Run: github.com/DRYa; bash Drya/install.uninstall/install.sh"
           echo "  3. Git Clone and Run: github.com/DRYa; bash drya.sh install --me"
}

function f_git_status {
   f_talk; echo
     f_c4; echo -n '`git status`'
     f_rc; echo

   git status
}

function f_git_pull {
   # Copied from: ezGIT
   f_talk; echo
     f_c4; echo -n '`git pull`'
     f_rc; echo

   git pull
}

function f_trap {
	# Set a trap to restore terminal on Ctrl-c (exit).
    	# Reset character attributes, make cursor visible, and restore
    	# previous screen contents (if possible).

    	trap 'tput sgr0; tput cnorm; tput rmcup || clear; exit 0' SIGINT

	# Tutorial:
	https://www.linuxjournal.com/content/bash-trap-command
}

function f_ascii_icon {


	function f_center_to_screen_verbose {
      # Fx to verbosely study the process of creating this logo

		# To messure the screen width:
         _cols=$(tput cols)
         echo Total cols: $_cols

		# To messure hslf the width of the screen:
         _cols=$((_cols/2))
         echo Half the sreen is: $_cols

		# The ascii logo is 32 characters long (half is 16)
         echo "The ascii logo is 32 characters long (half is 16)"

		# Center to screen
         echo To center the logo horizontally to the screen we subtract half of the logo cols to half of the screen widht. And that is where we center our cursor
         _cols=$((_cols-16))
         echo -e "\nRemaining cols: $_cols"
         echo $_cols Is where we put our cursor
         echo Example of logo widht:
         echo "................................"
         echo
         echo "Example of logo centered:"
         tput cup 13 $_cols
         echo "................................"


		# Now the same for lines:
         #tput lines
		
	}
	#f_center_to_screen_verbose

	function f_spaces {
		# Manually writting spaces before and after the ascii logo

      # Assumindo que o logo tem 33 ou mais letras de cumprimento horizontal

      # Sera feito o calculo com 40 letras
         # Ler quantas colunas tem no total da janela do terminal neste momento
         # udev: criar uma fx no inicio deste ficheiro para nao ser repetitivo esta calculo

         v_cols=$(tput cols)

      # Do total de colunas do terminal, retirar o tamanho que ocupa o logo e dividir por 2
         v_cols=$(($v_cols-32))
         v_cols=$(($v_cols/2))

      # Preencher do lado Esq com espacos vazios de forma que o logo fique ao centro
         for i in $(seq 1 $v_cols)
         do
            echo -n " "
         done
	}

      f_c6;
   f_Hline; echo
             echo
             echo
	f_spaces; echo -e  "     ||\` "
	f_spaces; echo -e  "     ||	"
	f_spaces; echo -e  " .|''||  '||''| '||  ||\`  '''|.	"
	f_spaces; echo -e  " ||  ||   ||     \`|..||  .|''||	"
	f_spaces; echo -e " \`|..||. .||.        ||  \`|..||.	"
	f_spaces; echo    "                  ,  |'		      "
	f_spaces; echo    "                    ''		         "
   f_Hline
}


function f_recicle_line {
   # Example on how to write 2x or more on the same line
   # uDev: create better explanation on this tput examples
	echo "First line..."
	f_rc
	read -p "Press any key to overwrite this line... " -n1 -s
	tput rc 1
   tput el
	echo "Second line. read replaced."
}

function f_calcular_tempo_decorrido_apos_data {
   # Data de aniversário no formato YYYY-MM-DD
      #STARTINGDATE="1992-04-01"  # Variavel que é preciso alimentar a este script

   # Converter a data de aniversário para um timestamp
   # Nota: [ -d, --date=STRING ] display time described by STRING, not 'now'
   # Nota: [ %s ]                seconds since the Epoch (1970-01-01 00:00 UTC)
      BIRTH_TIMESTAMP=$(date -d "$STARTINGDATE" +%s)

   # Obter o timestamp atual
   # Nota: [ %s ] seconds since the Epoch (1970-01-01 00:00 UTC)
      CURRENT_TIMESTAMP=$(date +%s)

   # Calcular a diferença em segundos
      DIFF_SECONDS=$(( CURRENT_TIMESTAMP - BIRTH_TIMESTAMP ))

   # Converter a diferença para dias, meses e anos
      DIFF_DAYS=$(( DIFF_SECONDS / 86400 ))

   # Calcular a diferença em anos e meses
      YEARS=$(( DIFF_DAYS / 365 ))
      MONTHS=$(( (DIFF_DAYS % 365) / 30 ))
      DAYS=$(( (DIFF_DAYS % 365) % 30 ))

   # Imprimir o resultado
      echo "Tempo passado desde $STARTINGDATE:"
      echo " > $YEARS anos, $MONTHS meses e $DAYS dias."
}

function f_drya_welcome {
   # Repetir os comandos que criam a mensagem de apresentacao DRYa
   # (Esta sequencia de comandos ja existem em .../source-all-drya-files

   echo "D help welcome" >> $v_drya_fzf_menu_hist

   #v_drya_welcome_screen=~/.config/h.h/drya/drya-welcome 
   #less $v_file

   # Copiado de .../source-all-drya-files
   bash ${v_REPOS_CENTER}/DRYa/all/bin/drya-presentation.sh || echo "DRYa: Don't Repeat Yourself (app)"  # In case figlet or tput are not installed, echo only "DRYa" instead
   bash $trid_script startup-message
   f_talk; echo "Startup Help..."
           echo "      Aceder ao menu principal    : \`D .\`"
           echo "      Aceder ao menu 'Instrucoes' : \`D help\`"
           echo

   neofetch -L 2>/dev/null
}

function f_clone_info {
   # Info given:
   # > Tell how to clone DRYa
   # > List Repositories (public and private)
   # > Automatically redirects Termux to github.com
   
   v_clone_drya='git clone https://github.com/SeivaDArve/DRYa.git ~/Repositories/DRYa'
   v_github_seiva='https://github.com/SeivaDArve?tab=repositories'

   f_talk; echo   "Must specify a repository to clone"
           echo
           echo   " To list all public repositories"
           echo   '  > `drya clone --list-public` or:'
           echo   '    `drya clone p` or:'
           echo   '    `D cln p`'
           echo   
           echo   " To list all private repositories"
           echo   '  > `drya clone --list-private` or:'
           echo   '    `drya clone P` or:'
           echo   '    `D cln P`'
           echo
   f_talk; echo   "To clone DRYa:  "
           echo   "  > $v_clone_drya" 
           printf "$v_clone_drya" | curl -F-=\<- qrenco.de/
           echo
   f_talk; echo   "Visit github.com Webpage with all Seiva D'Arve Repositories:"
           echo   "  > $v_github_seiva"
           echo   '  > uDev: add command: `D web github all`'
           printf "$v_github_seiva" | curl -F-=\<- qrenco.de/
           echo

   f_horizline
   echo " Note: So far, drya can open this link only with Termux"
   echo " > uDev: No other browser found"
   echo

   # uDev: Add menu em para estas opcoes (em vez de ser obrigatorio para o utilizador)
      #echo "Opening URL with Termux (terminal)"
      #v_link="https://github.com/SeivaDArve?tab=repositories"
      #termux-open-url $v_link
}

function f_init_clone_repos {
   # Saving current location (To come back to this directory after cloning)
      v_pwd=$(pwd)  ## After cloning any repo, we will come back to this place

   # Before doing any cloning, change to the correct place for cloning
      cd $v_REPOS_CENTER

      f_stroken
}

function f_drya_mail_box__check_mail {

   # uDev: drya-mail-box
   #       Alguns scripts podem criar ficheiros offline em .../h.h/ por inexistencia de internet ou inexistencia deste repo
   #       Se esta repo omni-log existisse ao mesmo tempo que nao existisse internet, o output desses scripts (exemplo: calculadora-registadora) seriam dentro dest Repo omni-log em vez do local pre-definido dessa calculadora
   #
   #       Antes de iniciar a clonagem, verificar se existe o diretorio .../h.h/drya-mail-box/omni-log/<some-file> ao qual haja a intencao de aplicar `append`
   #       Ou seja, udev: criar um menu antes de clonar que:
   #       1. Verifica se ha correio em h.h para esta repo que vai ser clonada
   #       2. Se houver, a peguntar: 
   #
   #          Quer `append` do correio apos clonar?
   #           > sim?
   #           > nao?
   #
   #          exemplo de `sim`: (`D clc append-registo-da-registadora`)   

   echo "uDev" 1>/dev/null
}

function f_drya_mail_box__append_mail {
   echo "Para quando na fx 'f_drya_mail_box__check_mail' o user disse que quer juntar o mail com a repo"
}

function f_clone_repos {

   function f_improve_readability {
      # These next functions are to improve the reading of `case-esac` below them

      function f_refresh_terminal_after_clone {
         # Some repositories have files to be sourced (like: source-all-moedaz-files) so, after cloning, DRYa must reload everything sourcing ~/.bashrc
         echo
         v_txt="Refreshing Entire Terminal?"; f_anyK
         source ~/.bashrc
      }

      function f_clone_repos_upk {
         echo "cloning: upK"
         git clone https://github.com/SeivaDArve/upK.git
      }

      function f_clone_repos_upk-dv {
         echo "Cloning: upK-diario-Dv"; git clone https://github.com/SeivaDArve/upK-diario-Dv.git
      }

      function f_clone_repos_shiva {
         echo "cloning: 112-Shiva-Sutras"; git clone https://github.com/SeivaDArve/112-Shiva-Sutras.git
      }

      function f_clone_repos_omni {
         #f_drya_mail_box__check_mail
         echo "cloning: omni-log"; git clone https://github.com/SeivaDArve/omni-log.git
         #f_drya_mail_box__append_mail
      }

      function f_clone_repos_dWiki {
         echo "cloning: dWiki"; git clone https://github.com/SeivaDArve/dWiki.git
      }

      function f_clone_repos_wikiD {
         echo "cloning: dWiki"; git clone https://github.com/SeivaDArve/wikiD.git
      }

      function f_clone_repos_yoga {
         echo "cloning: yogaBashApp"; git clone https://github.com/SeivaDArve/yogaBashApp.git
      }

      function f_clone_repos_moedaz {
         # uDev: Criar menu fzf para questionar se tambem quer clonar
         #       dv-cv-public
         #       dv-cv-private
         #       informar que existe .../source-all-moedaz-files que contem alias. Preciasa de um restart ao terminal

         echo "cloning: moedaz"; git clone https://github.com/SeivaDArve/moedaz.git
         #f_refresh_terminal_after_clone
      }

      function f_clone_repos_Tesoro {
         echo "cloning: Tesoro"; git clone https://github.com/SeivaDArve/Tesoro.git
      }

      function f_clone_repos_ezGIT {
         echo "cloning: ezGIT"; git clone https://github.com/SeivaDArve/ezGIT.git
      }

      function f_clone_calc_extention {
         echo "cloning: calc-extention-ROM-APK"; git clone https://github.com/SeivaDArve/calc-extention-ROM-APK.git
      }

      function f_clone_3_sticks_alpha_bravo {
         echo "cloning: 3-sticks-alpha-bravo"; git clone https://github.com/SeivaDArve/3-sticks-alpha-bravo.git
      }

      function f_clone_scratch_paper {
         echo "cloning: scratch-paper"; git clone https://github.com/SeivaDArve/scratch-paper.git
      }

      function f_clone_garpho {
         echo "cloning: garpho"; git clone https://github.com/SeivaDArve/garpho.git
      }

      function f_clone_typescript {
         echo "cloning: garpho"; git clone https://github.com/SeivaDArve/typescript-berg-house.git
      }

      function f_clone_curriculum_vitae {
         echo "cloning: Curriculum-Vitae"; git clone https://github.com/SeivaDArve/Curriculum-Vitae.git
      }

      function f_clone_repos_public_repos {
         # This function scrapes the webpage of Seiva D'arve repositories on GitHub and lists all that is found

         echo "Listing public repositories" 
         echo " (from Seiva D'Arve at GitHub.com)"
            

         # Saving the list of public repos into a var called $v_list
            v_list=$(curl -s https://github.com/SeivaDArve?tab=repositories \
                     | grep "codeRepository" \
                     | sed 's,        <a href="/SeivaDArve/,,g' \
                     | sed 's," itemprop="name codeRepository" >,,g')

         # Presenting each item of $v_list with a padding
            for i in $v_list
            do
               echo " > $i"
            done
      }

      function f_clone_repos_private_repos {
         echo "uDev: listing of all repositories"
         echo " (including private ones)"

         : '
         # Example on: How to curl a list of private repositories at github if they are invisible and you need to login:
           curl \
               -u "username:password" \
               -X GET \
               https://mygithuburl.com/user/repos?visibility=private
         '
      }
   }

   f_improve_readability  # Simply runs last fx. 

   f_talk 

   case $v_arg2 in
      # uDev: Search for dependencies file if any
      # uDev: Print their webpage link
      
      ezGIT | ezgit | ez)         
         # Clones "ezGIT" to help with `git` commands
         f_clone_repos_ezGIT
      ;;

      ROM | rom | calc-extention)
         # Clones "Texas Instruments" Emulator for graphic calulators + "TI-84 Plus" ROM, to run as an Android .apk
         f_clone_calc_extention
      ;;

      Tesoro | tesoro | T)          
         f_clone_repos_Tesoro
      ;;

      moedaz | mo)                 
         f_clone_repos_moedaz
      ;;

      yoga | yg)                   
         f_clone_repos_yoga
      ;;

      dWiki | DWiki | dw) 
         f_clone_repos_dWiki
      ;;

      wikiD | wiki | wd) 
         f_clone_repos_wikiD
      ;;

      omni-log | omni | log | om)   
         f_clone_repos_omni
      ;;

      shiva-sutras | shiva | ss | SS | 112 )    
         f_clone_repos_shiva
      ;;

      upk) 
         f_clone_repos_upk
      ;;

      upk-dv | upkd)   
         f_clone_repos_upk-dv
      ;;

      3-sticks-alpha-bravo | 3sab)  
         f_clone_3_sticks_alpha_bravo
      ;;

      sc)
         f_clone_scratch_paper
      ;;

      ga | garpho)
         f_clone_garpho
      ;;

      ts | typescript | typescript-berg-house)
         f_clone_typescript
      ;;
      
      cv | curruculum | curriculum-vitae)
         f_clone_curriculum_vitae
      ;;

      setup-internal-dir)          
         f_clone_repos_setup_internal_di
      ;;

      -p | p | --list-public) 
         f_clone_repos_public_repos
      ;;

      -P | P | --list-private) 
         f_clone_repos_private_repos
      ;;

      *)
         #f_talk;  # This line is already called at the beginning of the fx
         echo "Repository \"$v_arg2\" not recognized"
      ;;
   esac

   # At the end of cloning, returning to the previous directory and discarding the variable
      cd $v_pwd  
      unset v_pwd
}

function f_dotFiles_install_git_set_machine_name {
   # For .gitconfig, tell default user.name variable and ask yhe user if he wants to change

   function f_about_centralized_gitconfig {
      # About centralized .gitconfig file @ DRYa
         # Path to file
            v_gitconfig="${v_REPOS_CENTER}/DRYa/all/etc/dot-files/git-github/.gitconfig"
            #less $v_gitconfig # debug

         # Inform the user about default git name:
            v_default_name=$(grep "name =" $v_gitconfig)
            v_default_name=$(echo "$v_default_name" | cut -d " " -f 3)
            
            f_talk; echo "Default git name (@ centralized DRYa) is:" 
                    echo " > $v_default_name"
                    echo
   }

   function f_about_host_machine {
      # Inform about host machine current git name
         v_current_name=$(git config --global user.name)

         # If name is empty, tell it very clearly:
            [[ -z $v_current_name ]] && v_current_name="(empty)"

            f_talk; echo "Current git name (@host machine) is:"
                 echo " > $v_current_name"
                 echo
   }

   function f_test_if_exact_name_exists {
      # Adding new name to list if it does not exist there already
      
      # uDev: Very likely this fx has bugs (must check)

      function f_add_name {
         # Add name to list
         echo "$v_mach" >> $v_list_of_machines 
      }

      function f_test_success {
         # If this fx runns successfully, next line of code will not run
            grep -x "$v_mach" $v_list_of_machines
            [[ $? == 0 ]] && f_suc1
      }

      f_test_success

      # If last line did not run successfully, run fx to add name and try last fx again (or say "failure")
         grep -x "$v_mach" $v_list_of_machines
         [[ $? == 1 ]] && f_add_name && f_test_success || f_suc2
   }

   function f_choose_a_name_from_list {
      # Ask what name to change to (and tell dedault, if user do not choose)
         v_txt="Press ENTER to choose a name"; f_anyK
         echo

      # Path to the list of preset possible machine names
         v_list_of_machines="${v_REPOS_CENTER}/DRYa/all/etc/dot-files/git-github/list-machine-names.txt"

      # Creating fzf menu
         v_prompt="DRYa: Git: Qual é o nome que quer dar a maquina atual: "
         v_ask_for_another_name=" > Inserir outro nome..."

         v_mach=$( (echo "$v_ask_for_another_name"; cat $v_list_of_machines) | fzf --prompt "$v_prompt")
         
      # If user asked in the menu to insert a different name:
         if [[ $v_mach == "$v_ask_for_another_name" ]]; then
            f_talk; echo    "What other name do you want to add?"
                    echo -n " > "

            read v_mach
            echo

            f_talk; echo "Do you want to add that name to the list?"
                    echo " > Path: $v_list_of_machines"
                    echo
                    echo " > Press [Y]:       (Set name + add to list)"
                    echo " > Press [any key]: (Set name + do not add to list)"
                    echo -n " > "

            read -n1 v_ans

                    echo
                    echo

            v_msg="Name will be added to list of possible names"

            [[ $v_ans == "y" ]] && f_talk && echo "$v_msg" && echo " > $v_mach" && f_test_if_exact_name_exists && echo
            [[ $v_ans == "Y" ]] && f_talk && echo "$v_msg" && echo " > $v_mach" && f_test_if_exact_name_exists && echo

            [[ $v_ans != "y" ]] && [[ $v_ans != "Y" ]] && f_talk && echo "Name will not be added to list of possible names" && echo 
         fi
   }

   function f_finish_by_setting_choosen_name {

      # Inform about the result of the fzf menu
         f_talk; echo "New name to set:"
                 echo " > $v_mach"

      # Do not allow name to be empty (in case fzf menu is aborted)
         [[ -z $v_mach ]] && echo && echo "Aborting... Name is empty" && exit 1
         
      # Apply changes
         git config --global user.name "$v_mach"

      # Making sure all changes were applied (If $v_mach is equal to $v_ask_for_another_name)
         v_confirmation=$(git config --global user.name)
         [[ $v_mach == $v_confirmation ]] && f_suc1 || f_suc2
   
      echo
   }

   # Sequence
      f_about_centralized_gitconfig
      f_about_host_machine
      #f_test_if_exact_name_exists  # This fx was not made to rub by itself (other fx will call it)
      f_choose_a_name_from_list
      f_finish_by_setting_choosen_name 
}

function f_dot_files_install_git {
   # Install .gitconfig on the system
   # uDev: test if `git` itself is installed

   # Atualizar historico fzf (inserir esta fx):
      echo "D ui d i git" >> $Lz4

   v_file=${v_REPOS_CENTER}/DRYa/all/etc/dot-files/git-github/.gitconfig 
   v_place=~

   f_greet

   f_talk; echo -n "Installing "
     f_c2; echo    ".gitconfig"
     f_rc; echo

   f_talk; echo    "STEP 1: Copy .gitconfig"
           echo    " > File 1 : .../DRYa/all/etc/dot-files/git-github/.gitconfig"
           echo    " > To:      ~/"
           echo
   f_talk; echo    "STEP 2: Change Machine name"
           echo    " > Either insert New name or choose from Default name list"
           echo

   v_txt="Install .gitconfig file " && f_anyK
   echo

   f_hzl
   echo
   echo

   # Start STEP 1
      f_talk; echo "Starting STEP 1:"
      cp $v_file $v_place && f_suc1 || f_suc2
      echo

   # Start STEP 2
      f_talk; echo "Starting STEP 2:"
      echo

      # Para verificar o nome atual:
      #  > `git config --global user.name` 
      #
      # Para alterar o nome atual:
      #  > `git config --global user.name "novo-nome"` 

      f_dotFiles_install_git_set_machine_name

   f_talk; echo "Done! "
}

function f_dot_files_install_vimrc {
   # Install .vimrc on the system

   # Atualizar historico fzf (inserir esta fx):
      echo "D ui d i vimrc" >> $Lz4

   v_file=${v_REPOS_CENTER}/DRYa/all/etc/dot-files/vim/.vimrc
   v_place=~

   v_v1=$v_REPOS_CENTER
   v_v2="let g:dryaREPOS = '$v_v1' "
   #echo "Final: $v_v2"; read   # Debug

   f_greet

   f_talk; echo -n "Installing "
     f_c2; echo    ".vimrc"
     f_rc; echo
   f_talk; echo    "STEP 1: Copy .vimrc"
           echo    " > File 1: .../DRYa/all/etc/dot-files/vim/.vimrc"
           echo    " > To:     ~/"
           echo
   f_talk; echo    "STEP 2: At ~/.vimrc replace global variable: dryaREPOS"
           echo    " > from: \"let g:dryaREPOS = '<DRYa-variable-for-Repository-Center>' \" "
           echo    " > to:   \"let g:dryaREPOS = '$v_v1' \" "
           echo

   v_txt="Install .vimrc" && f_anyK
           echo
   
   # Start STEP 1
      cp $v_file $v_place && f_talk && echo "STEP 1: Done! "
           echo

   # Start STEP 2
      # At sed, we search patterns with /pattern
      # At sed, we replace entire line with c\
      # At sed, we replace entire line with variable with c\\
      # So... /pattern/c\\<variable-here>
      sed -i "/let g:dryaREPOS/c\\$v_v2" ~/.vimrc && f_talk && echo "STEP 2: Done! "

   # uDev: Ask if user want to install vim powerline (or echo out how to do)
}

function f_dotFiles_install_termux_properties {
   # Install Termux colors and properties on the system

   # uDev: Test if it is termux and still allow the user to use both ways

   v_orig1=${v_REPOS_CENTER}/DRYa/all/etc/dot-files/termux/
   v_file1=${v_REPOS_CENTER}/DRYa/all/etc/dot-files/termux/colors.properties.1
   v_file2=${v_REPOS_CENTER}/DRYa/all/etc/dot-files/termux/termux.properties
   v_place=~/.termux/

   f_greet
   f_talk; echo "Installing:"
           echo " > Termux Colors + Termux properties"
           echo
   f_talk; echo "STEP 1: Copy:"
           echo " > File 1: .../DRYa/all/etc/dot-files/termux/colors.properties\*"
           echo " > To:     ~/.termux/color.properties"
           echo
   f_talk; echo "STEP 2: Copy:"
           echo " > File 2: .../DRYa/all/etc/dot-files/termux/termux.properties"
           echo " > To:     ~/.termux/"
           echo

   v_txt="(Step 1, 2) Install termux configs" && f_anyK
   echo

   # STEP 1: 
      # Prompt de `fzf` para escolher o perfil de cores
         L0="DRYa: Qual ficheiro 'color.properties' quer usar? (CTRL-C para saltar passo)"
         
      # Ordem de Saida das opcoes durante run-time
         unset v_list
         v_list=$(cd $v_orig1 && ls colors* | fzf --pointer=">" --cycle --prompt="$L0")

      # Atuar de acordo com as instrucoes introduzidas pelo utilizador
         [[ -n $v_list ]] && cp $v_orig1/$v_list $v_place/color.properties && f_talk && echo "Step 1: Done! (Copiado: $v_list)"



   # STEP 2: 
      cp $v_file2 $v_place && f_talk && echo 'Step 2: Done! (Restart the terminal or `termux-reload-setting`)'
      echo
}

function f_dotFiles_install_tm_tmux {
   # Install .tmux.conf on the system

   v_file1=${v_REPOS_CENTER}/DRYa/all/etc/dot-files/tmux/.tmux.conf
   v_place=~

   f_greet
   f_talk; echo "Installing Termux Colors + Termux properties"
           echo " > Copy: .../DRYa/all/etc/dot-files/tmux/.tmux.conf"
           echo " > To:   ~/"

   v_txt="Install .tmux.conf" && f_anyK
   
   cp $v_file1 $v_place && f_talk && echo "Done! "
}

function f_dotFiles_install_dryarc {
   f_talk; echo "source .dryarc if any exists (uDev)"
}

function f_dot_files_install_netrc {
   # Installing .netrc at ~
   #    This file allows the user to avoid repetitive autentication (user and password) for github.com
   #    In this file, a stroken (token with a bug) is written, then corrected manually by the user, then used it is all set, no more repetition
   
   f_greet

   f_talk; echo "Installing Stroken as ~/.netrc"
           echo
   f_talk; echo "Steps of the process:"
           echo " > 1: Copy: .../DRYa/all/etc/dot-files/git-github/current-stroken"
           echo " > 2: To:   ~/.netrc"
           echo " > 3: Edit: ~/.netrc"
           echo
   f_talk; echo "Instructions:"
           echo "This script will install Current Seiva's github.com"
           echo "personal access token in this machine at the location"
           echo "of ~/.netrc but with a bug (also called stroken). "
           echo "In the end, this script will also open the file"
           echo "To be manually edited and manually removing the bug"
           echo "If the bug is fixed, github will not ask for credentials"
           echo "when uploading new commits"
           echo
           echo "Token:   Correct hashed password"
           echo "Stroken: Incorrect hashed password (allowing to be pushed to gihub)"
           echo

   v_txt="(Step 1, 2): Install .netrc"; f_anyK


   # We need that stroken message in these 2 variables, username and token: 
      v__file="${v_REPOS_CENTER}/DRYa/all/etc/dot-files/git-github/current-stroken"

      v_uName=$(cat $v__file | head -n 1)
      v_token=$(cat $v__file | tail -n 1)


   # Creating a file ~/.netrc with our new stroken info
      v_machn="Machine github.com"
      v_login="login $v_uName"
      v_stokn="password $v_token"

      v_messg="$v_machn $v_login $v_stokn"

      echo "$v_messg" > ~/.netrc && f_suc1 || f_suc2
      echo

   # Opening the file to edit
      v_txt="(Step 3): Edit file ~/.netrc to fix bugs"; f_anyK
      vim ~/.netrc && f_suc1 || f_suc2

   # Finished 
      echo; f_done
}

function f_list_ip_public_n_local {
   # Mencionar no terminsl qual é o endereço de IP publico e local

   # Obtendo o IP público usando curl e um serviço online
      PUBLIC_IP=$(curl -s ifconfig.me)

   # Obtendo o IP local usando hostname -I (funciona na maioria dos sistemas Linux)
      LOCAL_IP=$(ifconfig | grep -w inet | grep -v 127.0.0.1 | awk '{print $2}')

      # Alternativa 1: 
         #LOCAL_IP=$(hostname -I | awk '{print $1}')

      # Alternativa 2: 
         #LOCAL_IP=$(ip addr show | grep "inet\b" | grep -v 127.0.0.1 | awk '{print $2}' | cut -d/ -f1)

   # Imprimindo os resultados
      echo "IP Público: $PUBLIC_IP"
      echo "IP Local:   $LOCAL_IP"
}

function f_menu_internet_network_ip_options {
   # uDev: criar fx para verificar se existem novos bookmark no browser

   # Lista de opcoes para o menu `fzf`
      Lz1='Save '; Lz2='menu-ip-options'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      L6='6. Print  | javascript tricks (for browser console)'
      L5='5. Menu   | `web` (navegar na internet)'

      L4='4. Ver    | User info (saved @host system)'
      L3='3. Assign | New random IP'                                      
      L2='2. Ver    | IP publico e local'                                      
   
      L1='1. Cancel'

      L0="SELECIONE 1 do menu (exemplo): "
      
      v_list=$(echo -e "$L1 \n\n$L2 \n$L3 \n$L4 \n\n$L5 \n$L6 \n\n$Lz3" | fzf --cycle --prompt="$L0")

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3  ]] && echo "$Lz2" && history -s "$Lz2"
      [[ $v_list =~ "6. " ]] && echo "uDev: copiar/scrape do wikiD.org para aqui"
      [[ $v_list =~ "5. " ]] && bash ${v_REPOS_CENTER}/DRYa/all/bin/web.sh
      [[ $v_list =~ "4. " ]] && echo "uDev: Ver palavras pass guardadas no sistema"
      [[ $v_list =~ "3. " ]] && f_greet && f_list_ip_public_n_local && echo && bash ${v_REPOS_CENTER}/DRYa/all/bin/generate-new-random-ip.sh && f_list_ip_public_n_local
      [[ $v_list =~ "2. " ]] && f_greet && f_list_ip_public_n_local
      [[ $v_list =~ "1. " ]] && echo "Canceled: $Lz2" && history -s "$Lz2"
      unset v_list
}

function f_menu_audio_media_player {

   # Lista de opcoes para o menu `fzf`
      Lz1='Save '; Lz2='Audio-Media-Player'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      L8='8. Tests  | Right and Left Speakers audio'                                      
      L7='7. Tests  | Completion Bell sound'                                      

      L6='6. Mic Record | Stop'    # When Mic stops, the `history -s` is set to the opposite command (start), to enebla fast start: `history -s start`
      L5='5. Mic Record | Status'
      L4='4. Mic Record | Start'   # When Mic starts, the `history -s` is set to the opposite command (stop), to enebla fast stop: `history -s stop`
      
      L3='3. Play Music | mpv | Search file at .'                                      
      L2='2. Play Music | xdg | Search file at .'                                      
      L1='1. Cancel'

      L0="SELECT 1: DRYa: Media Player: "
      
      v_list=$(echo -e "$L1 \n$L2 \n$L3 \n\n$L4 \n$L5 \n$L6 \n\n$L7 \n$L8 \n\n$Lz3" | fzf --cycle --prompt="$L0")

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3  ]] && echo "$Lz2" && history -s "$Lz2"
      [[ $v_list =~ "8. " ]] && echo "uDev: $L8" 
      [[ $v_list =~ "7. " ]] && echo "uDev: $L7" 
      [[ $v_list =~ "6. " ]] && echo "uDev: $L6" 
      [[ $v_list =~ "5. " ]] && echo "uDev: $L5" 
      [[ $v_list =~ "4. " ]] && echo "uDev: $L4" 
      [[ $v_list =~ "3. " ]] && v_pl=$(ls | fzf --prompt='Choose media to play (with `mpv`): ')      && mpv      $v_pl
      [[ $v_list =~ "2. " ]] && v_pl=$(ls | fzf --prompt='Choose media to play (with `xdg-open`): ') && xdg-open $v_pl
      [[ $v_list =~ "1. " ]] && echo "Canceled: $Lz2" && history -s "$Lz2"
      unset v_list
}

function f_create_qr_from_text {
   f_greet
   f_talk; echo "Criar QR code: Insere o teu texto: "
           echo -n " > "
           read v_ans
           echo
           printf "$v_ans" | curl -F-=\<- qrenco.de/
}

function f_create_qr_from_file {
   f_greet
   f_talk; echo "Criar QR code: Insere o nome de um ficheiro: "
           echo -n " > "
           v_file=$(ls | fzf)
           echo $v_file
           echo
           v_ans=$(cat $v_file)
           curl qrenco.de/$v_ans
}

function f_QR_code_fzf_menu {

   # uDev: 
   #       echo '`D QR-to-clone-drya` or `QR-clone` '
   #       echo " > uDev: Will present an image to the screen, other devices can scan it to retrieve it's text and run it on the terminal"

   # Lista de opcoes para o menu `fzf`
      Lz1='Save '; Lz2='D QR'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      L6='6. Info: Website valido para criar QR codes'

      L5='5. Obter QR text | Abrir Android App, get clipboard'
         
      L4='4. Criar QR code | Apartir de 1 linha de 1 ficheiro'
      L3='3. Criar QR code | Apartir de ficheiro inteiro'
      L2='2. Criar QR code | Apartir de texto'
      L1='1. Cancel'

      L0="SELECIONE 1 Opcao: "
      
      v_list=$(echo -e "$L1 \n$L2 \n$L3 \n$L4 \n\n$L5 \n\n$L6 \n\n$Lz3" | fzf --cycle --prompt="$L0")

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3  ]] && echo "$Lz2" && history -s "$Lz2"
      [[ $v_list =~ "6. " ]] && echo uDev
      [[ $v_list =~ "5. " ]] && bash $v_REPOS_CENTER/DRYa/all/bin/launch-QRcodeApp-for-clipboard.sh
      [[ $v_list =~ "4. " ]] && echo uDev
      [[ $v_list =~ "3. " ]] && f_create_qr_from_file
      [[ $v_list =~ "2. " ]] && f_create_qr_from_text
      [[ $v_list =~ "1. " ]] && echo "Canceled: $Lz2" && history -s "$Lz2"
      unset v_list
}

function f_win_to_linux_pwd {
   # Convert text Windows Path into text Linux Path

   if [ -z $v_arg2 ]; then 

      f_greet
      f_talk; echo "Convert a Text file with a list of"
              echo "      Windows Paths into Linux Paths"
              echo "       > feed me 1 or + Windows paths to convert"

      # Make a dir and a file, to paste and convert windows text to linux text
         mkdir -p ~/.tmp 
         v_file=~/.tmp/wpwd-rel-path  # Note: Does not work: v_file="~/.tmp/wpwd-rel-path"
         touch $v_file 


      # File the file with some instructions
         echo >             $v_file
         echo >>            $v_file
         echo "# DRYa: Paste an Windows relative path into this vim file (uncommented) and exit with 'ZZ' " >> $v_file
         echo "# " >>       $v_file
         echo "# " >>       $v_file
         echo "# Help with vim commands:" >> $v_file
         echo "# > uDev" >> $v_file
         # uDev: finish vim instructions

      # Edit the file, so that the user can paste the C:\<path> and exit
         vim $v_file

      # Convert the text inside the file
         sed -i '/^#/d'             $v_file  # Delete all commented lines
         sed -i '/^$/d'             $v_file  # Delete all empty lines
         sed -i 's#C:\\#/mnt/c/#g'  $v_file  # Convert C:\ into /mnt/c
         sed -i 's#c:\\#/mnt/c/#g'  $v_file  # Convert c:\ into /mnt/c
         sed -i 's#D:\\#/mnt/d/#g'  $v_file  # Convert D:\ into /mnt/d
         sed -i 's#d:\\#/mnt/d/#g'  $v_file  # Convert d:\ into /mnt/d
         sed -i 's#E:\\#/mnt/e/#g'  $v_file  # Convert E:\ into /mnt/e
         sed -i 's#e:\\#/mnt/e/#g'  $v_file  # Convert e:\ into /mnt/e
         sed -i 's#^\\#\./#g'       $v_file  # Convert / if it exists in the begining of the line (relative path) into ./ (relative path)
         sed -i 's/\\/\//g'         $v_file  # Convert \ into /
         sed -i 's/ /\\ /g'         $v_file  # Convert with spaces " " into "\ "

      # Copy text to variable, to test if file/variable is empty
         v_text=$(cat ~/.tmp/wpwd-rel-path )
         #v_text=""  # Debug: To test if file is empty

      # Tell if it is empty or print the remaining contents (hopefully with a valid path converted)
         if [ -z "$v_text" ]; then
            f_talk; echo "The file was empty"
         else 
            echo
            w=$(cat $v_file)
            echo $w
            export w  # Nao funciona quando é lido casualmente por um script
            #echo "uDev: Perguntar com fzf qual dos links quer navegar (\`D wpwd n\`)"
         fi

      #echo "uDev: colocar todo esse texto (path) numa variavel \$w"
      #echo "uDev: Give dir basename into variable \$W so that command '$ op .' can operate"
      #echo "uDev: Mostrar o antes e o depois"

   else
      f_talk; echo 'options for w-pwd `windows-$(pwd)`on WSL2'
              echo
      f_talk; echo "feed windows 'Path' to a file, to be converted to Linux 'Path'"
              echo " > D wpwd"

   fi
}

function f_drya_help {
   # Main help function
  
   f_greet2

   f_talk; echo "Help"
           echo
           echo "What is DRYa (the name):"
           echo " > D.R.Y.a. "
           echo "   (Don't Repeat Yourself app)"
           echo "   is a CLI software intended"
           echo "   to prevent repetitive tasks"
           echo "   and work like a 2nd brain"
           echo "   written in Bash (Cross-Platform)"
           echo "   The important knowledge the Dev"
           echo "   needs to be absorbed in life"
           echo "   It is absorbed either by DRYa or by"
           echo "   Some other Repo, centralized on DRYa."
           echo
           echo "Developer Intentions (on DRYa):"
           echo " > A sub-operative system:"
           echo "   Cloud-Stored-APP, that when in sync"
           echo "   makes any host operative system"
           echo "   feel like your own. After downloading"
           echo "   and after used, upload changes and"
           echo "   delete again from the host system"
           echo
           echo " > WIP Releases:"
           echo "   New versions come in the 'work in progress' model"
           echo "   Sometimes the file changes made to a"
           echo "   file X, is finished in another device by"
           echo "   the Dev. On the current edited line it"
           echo "   says: 'uDev: This line is lacking Y"
           echo "   content'. Then, when partial releases are done "
           echo '   the Dev `git squashes` many commits to 1 version'
           echo 
           echo "   The next Dev (most likely the same Dev)" 
           echo "   will finish such line in some other occasion."
           echo "   Developing DRYa is a on-going process," 
           echo "   small steps. DRYa is made available"
           echo "   by tiny pauses in daily life, and made"
           echo "   by the CURRENT MINUTE needed script."
           echo
           echo " > Lightweight:"
           echo "   The most light weight app possible"
           echo "   that each command is performed very fast"
           echo "   a TUI app"
           echo
           echo " > Cross-platform:"
           echo "   Works on any device after proper config"
           echo "   (by feeding the depedencies)"
           echo "   Windows, Linux, Mac, Android, iPhone,"
           echo "   Raspberry Pi"
           echo
           echo " > All burocracy around the user of the app"
           echo "   is taken care of, without spy or malware"
           echo   
           echo "   possible because the code is not compiled"
           echo "   and any user non-developer is able to open"
           echo "   each script and actually read every command"
           echo "   that is going to run, and change it"
           echo
           echo " > It is a compilation of every cool feature"
           echo "   of every other cool app without their"
           echo "   bloated garbage. It either mimics features"
           echo "   or gives simplified commands to the user"
           echo "   to make use of the original app. No need"
           echo "   install any 3rd party software that"
           echo "   duplixates functionality of other apps"
           echo
           echo " > A server or cloud should be running online"
           echo "   always to allow DRYa repo to be cloned"
           echo "   (if needed)"
           echo   
           echo
           echo "Author: "
           echo " > David Rodrigues (Seiva D'Arve)"
           echo "   flowreshe.seiva.d.arve@gmail.com"
           echo
           echo "uDev: press 'H' to Help menu with \`fzf\` for each option:"
           echo " 1. DRYa man page (uDev)"
           echo " 2. DRYa (Terminal printed instructions)"
           echo " 3. DRYa README.md file "
           echo " 4. DRYa cheat sheets and alias for terminal commands"
           echo " 5. DRYa cheat sheets for 'Temporized Menu' "
           echo " 6. DRYa environment variables and .dryarc"
           echo ' 6. DRYa file where `notify` saves history'
           echo " 6. traitsID: Print specs of current device"
           echo " 7. What is D.R.Y.a. "
           echo " 8. dee-pages: filter real commands from their own script"
           echo " 9. Welcome screen DRYa's instructions"
           echo " 10. DRYa é como uma luva que acenta no PC ou Phone e sabe o que instalar e como instalar"
}

function f_dot_files_list_available {
   # List dot-files available in DRYa repo

   f_greet
   f_talk; echo '`drya dot list-ready-and-uDev`'
           echo " > Files ready to copy from DRYa repo to their Default locations"

   # List all files in one array variable
      v_all_dot_files=(                \
         ".bashrc"                     \
         ".bash_logout"                \
         ".netrc"                      \
         ".vimrc"                      \
         "emacs:init.el"               \
         "emacs:lib"                   \
         "emacs:lib:upk"               \
         "emacs:lib:omni-log"          \
         ".gitconfig"                  \
         "xrandr"                      \
         "keyboard:layout"             \
         "manpages"                    \
         "termux:storage"              \
         "termux:repos"                \
         "termux:properties"           \
         "termux:colors"               \
         '~/ln/wsl'                    \  # Soft link for WSL2 C:\
         '~/ln/Repositories'           \  # Soft link for WSL2 C:\$USER\Repositories == /mnt/c/$USER/Repositories
         ".dryarc"                     \
         ".tmux.conf"                  \
         '$PS1'                        \
         "browser:bookmarks"           )  

   # `echo` variable horizontally:
      #echo "Array is: ${v_all_dot_files[@]}"

   # `echo` variable vertically:
      echo -e "\nListing all dot files to handle:"

      for i in ${v_all_dot_files[@]}
      do 
               echo -n " > "
         f_c2; echo $i
         f_rc
      done

   # Verbose notes
      echo 
      echo "It can config:"
      echo " > emacs (init file + libraries)"
      echo " > git and github with .netrc"
      echo " > man pages"
      echo " > ezGIT automatic encryption"
      echo " > .vimrc"
      echo " > termux.properties"
      echo " > termux widgets"
      echo " uDev"
      echo
}

function f_quick_install_all_upk {
   # Makes all dependencies for upk repo available
   # This might be used most likely at in-job phone
   
   f_greet

   # Echo a list of things that are going to be installed:
      # uDev
      # uDev
      # uDev
      # uDev
      # uDev
      # uDev

   # Change dir, to avoid changing at every command
      cd ${v_REPOS_CENTER}

   # Install dependencies (and automatically answering YES to all questions)
      # uDev: Test if it is windows and install GUI version also
      f_talk; echo "install emacs figlet vim"
      yes | pkg install emacs figlet vim 

   # Repo: upk
      f_talk; echo "Cloning: upK" && git clone https://github.com/SeivaDArve/upK.git
      
   # Repo: upk-diario-dv
      f_talk; echo "cloning: upk-diario-dv" && git clone https://github.com/SeivaDArve/upK-diario-Dv.git

      read
   # Installing .netrc
      f_dot_files_install_netrc


   # Refresh the terminal
      #source ~/.bashrc

   #    install: 
   #             emacs for windows
   #             instal init.el
   f_talk; echo "udev: install all dependencies for upk repo to run"
}

function f_dot_files_install_presets {
   Lz='`D dot install presets`'

   L2="2. Quick Install | upk + upkd + dependencies "
   L1="1. Cancel "

   L0="SELECT (1 or +) dot-files to install: "

   v_list=$(echo -e "$L1 \n$L2 \n\n$Lz" | fzf --cycle -m --prompt="$L0")

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ "$Lz" ]] && echo "$Lz" 
      [[ $v_list =~ "2. " ]] && f_quick_install_all_upk
      [[ $v_list =~ "1. " ]] && echo "Canceled: $Lz"
      unset v_list

}

function f_menu_install_dot_files {
   Lz='`D dot install`'

   # uDev: Redefinir browser pre-definido
   #       Endereco MAC (traitsID)
   #       Terminal best font
   #       Install: font: Monospace (best for terminal)
   
   #L10="10. .hushlogin"  # Se este ficheiro existir, o termux nao cria welcom screen
   #L10="10. stroken"     # It is part of .netrc         

    L12="12. | termux  | termux.properties + colors.termux"
    L11='11. | emacs   | .emacs.d/'  # uDev: remove from flunav `S 2`
    L10="10. | tmux    | .tmux.conf"
     L9="9.  | bash    | .bash_logout"
     L8="8.  | git     | .gitconfig "
     L7="7.  | git     | .netrc "
     L6="6.  | vim     | .vimrc "
     L5="5.  | DRYa    | .dryarc "

     L4="4.  | Install | PRESETS"
     L3="3.  | Install | ALL "

     L2='2.  -- Invert Selection --'
     L1="1.  Cancel "

   L0="DRYa: dot-files install.uninstall menu: "

   v_list=$(echo -e "$L1 \n$L2 \n\n$L3 \n$L4 \n\n$L5 \n$L6 \n$L7 \n$L8 \n$L9 \n$L10 \n$L11 \n$L12 \n\n$Lz" | fzf --cycle -m --prompt="$L0")

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ "$Lz"  ]] && history -s "$Lz"
      [[ $v_list =~ "12. " ]] && f_dotFiles_install_termux_properties
      [[ $v_list =~ "11. " ]] && echo "emacs dot-files: uDev"
      [[ $v_list =~ "10. " ]] && f_dotFiles_install_tm_tmux
      [[ $v_list =~ "9.  " ]] && cp ${v_REPOS_CENTER}/DRYa/all/etc/dot-files/bashrc/bash-logout/.bash_logout ~ && echo "DRYa: file .bash_logout copied to ~/.bash_logout"
      [[ $v_list =~ "8.  " ]] && f_dot_files_install_git 
      [[ $v_list =~ "7.  " ]] && f_dot_files_install_netrc
      [[ $v_list =~ "6.  " ]] && f_dot_files_install_vimrc
      [[ $v_list =~ "5.  " ]] && f_dotFiles_install_dryarc
      [[ $v_list =~ "4.  " ]] && f_dot_files_install_presets
      [[ $v_list =~ "3.  " ]] && f_dot_files_install_vimrc && f_dot_files_install_git && f_dotFiles_install_termux_properties && f_dotFiles_install_dryarc && f_dot_files_install_netrc
      [[ $v_list =~ "2.  " ]] && echo "uDev"
      [[ $v_list =~ "1.  " ]] && echo "Canceled: $Lz"
      unset v_list
}

function f_dot_files_menu_edit_host_files_termux_properties {
   # Mangage ./termux @Host (at the machine, not at the repo)

   # Lista de opcoes para o menu `fzf`
      Lz1='Save '; Lz2='edit only host'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      L6='6. Toggle     | .hushlogin termux verbose output at terminal startup'
      L5='5. Toggle     | (uDev) termux Extra Keys On/Off'
      L4='4. Toggle     | (uDev) termux.properties volume keys'
      L3='3. Edit       | termux.properties file'
      L2='2. Manipulate | Termux Properties as menu (uDev)'
      L1='1. Cancel'

      L0="SELECT 1: Edit @Host files: "
      
      v_list=$(echo -e "$L1 \n$L2 \n$L3 \n$L4 \n$L5 \n$L6 \n\n$Lz3" | fzf --cycle --prompt="$L0")

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3  ]] && echo "$Lz2" && history -s "$Lz2"
      [[ $v_list =~ "6. " ]] && f_toggle_termux_hushlogin
      [[ $v_list =~ "5. " ]] && echo "uDev"
      [[ $v_list =~ "4. " ]] && echo "uDev"
      [[ $v_list =~ "3. " ]] && vim ~/.termux/termux.properties
      [[ $v_list =~ "2. " ]] && echo "uDev"
      [[ $v_list =~ "1. " ]] && echo "Canceled: $Lz2" && history -s "$Lz2"
      unset v_list
}

function f_dot_files_menu_edit_host_files {
   # Edit dot files only @host system

   # Lista de opcoes para o menu `fzf`
      Lz1='Save '; Lz2='edit only host'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      L2='2. Menu | Termux'                                      
      L1='1. Cancel'

      L0="DRYa: Edit @Host files: "
      
      v_list=$(echo -e "$L1 \n$L2 \n\n$Lz3" | fzf --cycle --prompt="$L0")

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3  ]] && echo "$Lz2" && history -s "$Lz2"
      [[ $v_list =~ "2. " ]] && f_dot_files_menu_edit_host_files_termux_properties
      [[ $v_list =~ "1. " ]] && echo "Canceled: $Lz2" && history -s "$Lz2"
      unset v_list
    
}

function f_test_L3_available_updates {
   # Antes do menu dos dot-files, testar se existe diferenca entre os ficheiros centralizados e os ficheiros instalados, se houver diferenca, indica que ha atualizacoes

   # Se existe atualizacoes
      L3b="(uDev: Pending Files: yes)" # Atencao: .gitconfig vai ter user.name de acordo com traitsID, de acordo com a maquina

   # Se nao existe atualizacoes
      #L3b=""
}

function f_dot_files_menu {
   # Main Menu for dot files

   f_test_L3_available_updates

   # List of options
      Lz1='Saving '; Lz2='D dot'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      L8="8. Menu | Factory Reset "  # uDev: When setting factory reset, leave a file to clone drya ENTIRELY
      L7="7. Menu | Backups"

      L6='6. Edit | Installed   files (only @Host) |'
      L5="5. Edit | Centralized files (only @DRYa) |"
      L4='4. Edit | Centralized  > then >  Install |'

      L3="3. Menu | install.uninstall | $L3b" # Variable L3b may be set and may be empty to give more info to the user
      L2="2. List | Available         |"      # uDev: Test if centralized DRYa dot-files were modified and are available to replace old ones at the current system
      L1="1. Cancel"

      L0="DRYa: dot-files menu: "

      v_list=$(echo -e "$L1 \n$L2 \n$L3 \n\n$L4 \n$L5 \n$L6 \n\n$L7 \n$L8 \n\n$Lz3" | fzf --cycle --prompt="$L0")

   # Atualizar historico fzf automaticamente
      echo "$Lz2" >> $Lz4

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ "8. " ]] && f_ghost
      [[ $v_list =~ "7. " ]] && f_backup_helper
      [[ $v_list =~ "6. " ]] && f_dot_files_menu_edit_host_files
      [[ $v_list =~ "5. " ]] && echo uDev 
      [[ $v_list =~ "4. " ]] && echo uDev 
      [[ $v_list =~ "3. " ]] && f_menu_install_dot_files
      [[ $v_list =~ "2. " ]] && f_dot_files_list_available
      [[ $v_list =~ "1. " ]] && echo "Canceled"
      unset v_list
}

function f_drya_fzf_MM_Toolbox {
   # Funcoes inbutidas na Repo DRYa 

   function f_void {
      # Runs only once at the beginning
       Lv="V. [ ] Verbose help"
      Lvx="V. [ ] Verbose help"
      LvX="V. [X] Verbose help"
   }
 
   function f_loop {
      # Esta fx pode voltar a ser chamada varias vezes 

      # Lista de opcoes para o menu `fzf`

         # Void: Lv, ...
         # L12='12. Supporte basico de Vida: Melhorar o formulario: .../var/suporte-basico-de-vida.txt
         # L12='12. Host website on Android, using Abdroid as web server (exemplo: https://youtu.be/V-B-HGWAJac?feature=shared)
         # L12='12. Agendar envio SMS && WHATSAPP'
         # L12='12. Comboios CP web-scraping
         # L12='12. Ementas Yummy
         # L12='12. fzf keyboard (para smartphones partidos)'
         # L12='12. dir to .jpg
         # L12='12. Agendar SMS
         # L12='12. sound record
         # L12='12. Conversor de texto formal para informal
         # L12='12. Temporizador: Proximo Maha Kumbh Mela
         # L12='12. Localizacao de telemovel via info de wi-fi disponiveis e via sonora com beeps
         # L12='12. Termux > Jarve > Django
         # L12='12. Random number generator
         # L12='12. nanD
         # L12='12. Change IP and acess banned website
         # L12='12. See list of saved passwords and correspondant hotspor names
         # L12='12. Fork Bomb (overload current RAM until system failure): Will need a pin
         # L12='12. Script | youtube-dl-wrapper.sh
         # L12='12. Mount drivers com `lsblk`
         # L12='12. `curl` ticks: get current date/time
         # L12='12. See the total size (bit, Kb, Mb, Gb) of a directory
         # L12='12. `D ping` test continuously if there is internet
         # L12='12. From Pc to Pc, connect/transfer files via bluetooth / UTP 
         # L12='12. From Pc to Pc, connect/transfer files via bluetooth / UTP 
         # L12='12. info: set phonecalls recorder automatically
         # L12='12. Raspberry: GPIO
         # L12='12. Record mouse and keyboard activity
         # L12='12. criar links de imagens com suport github (partilhar fotos ou videos)
         # L13= ANSI converter: https://dom111.github.io/image-to-ansi/
         # L13= Adicionar software como JSplit que parte ficheiros grandes em ficheiros mais pequenos
         
         L20='20. Menu   | zip unzip'
         L19='19. Script | Datas (menu)'
         L18='18. Script | Youtube download (with `yt-dlp`)'
         L17='17. Menu   | Clone Repositories (github)'
         L16='16. Menu   | Metadata'
         L15='15. Menu   | Internet / Network / IP'
         L14='14. Script | sshfs-wrapper'
         L13='13. Menu   | Audio (Media Player + Voice Recorder)'  
         L12='12. Print  | `curl` tricks: Previsao do Tempo'  # uDev: Adicionar fase da lua 
         L11='11. Print  | `curl` tricks: Online man pages'  
         L10='10. Print  | morse'    # Link: https://www.instagram.com/reel/DEmApyMtMn7/?igsh=MTJqbjl6dWMxd2F1dg==
          L9='9.  Menu   | no-tes '
          L8='8.  Script | Convert `pwd` from Win to Linux'
          L7="7.  Script | xKill"
          L6="6.  Script | notify"
          L5="5.  Menu   | QR code"
          L4="4.  Menu   | calculos/calculadoras"
          L3="3.  Menu   | dot-files"
          L2='2.  Script | fluNav'

          L1="1.  Cancel" 

         L0="DRYA: toolbox fx List: " 

         v_list=$(echo -e "$L1 \n\n$L2 \n$L3 \n$L4 \n$L5 \n$L6 \n$L7 \n$L8 \n$L9 \n$L10 \n$L11 \n$L12 \n$L13 \n$L14 \n$L15 \n$L16 \n$L17 \n$L18 \n$L19 \n\n$Lv" | fzf --cycle --prompt="$L0")

      # Perceber qual foi a escolha da lista
         [[ $v_list =~ "V. " ]] && [[ $v_list =~ "[X]" ]] && Lv="$Lvx" && f_loop
         [[ $v_list =~ "V. " ]] && [[ $v_list =~ "[ ]" ]] && Lv="$LvX" && f_loop

         [[ $v_list =~ "19. " ]] && f_zip_unzip
         [[ $v_list =~ "19. " ]] && bash ${v_REPOS_CENTER}/DRYa/all/bin/data.sh .
         [[ $v_list =~ "18. " ]] && read -p 'Enter youtube link to download: ' v_ans && yt-dlp $v_ans
         [[ $v_list =~ "17. " ]] && echo "uDev"
         [[ $v_list =~ "16. " ]] && echo "uDev"
         [[ $v_list =~ "15. " ]] && f_menu_internet_network_ip_options
         [[ $v_list =~ "14. " ]] && bash ${v_REPOS_CENTER}/DRYa/all/bin/sshfs-wrapper.sh 
         [[ $v_list =~ "13. " ]] && f_menu_audio_media_player
         [[ $v_list =~ "12. " ]] && f_greet && f_talk && echo "Previsao do Tempo" && curl wttr.in 
         [[ $v_list =~ "11. " ]] && f_greet && f_talk && read -p "Ask for a man page (curl will get it): " v_ans && curl cheat.sh/$v_ans
         [[ $v_list =~ "10. " ]] && less ${v_REPOS_CENTER}/wikiD/all/morse-diagrams/morse-letters-diagram.txt
         [[ $v_list =~ "9.  " ]] && bash ${v_REPOS_CENTER}/DRYa/all/bin/no-tes.sh 
         [[ $v_list =~ "8.  " ]] && f_win_to_linux_pwd
         [[ $v_list =~ "7.  " ]] && echo "uDev"
         [[ $v_list =~ "6.  " ]] && bash ${v_REPOS_CENTER}/DRYa/all/bin/notify.sh
         [[ $v_list =~ "5.  " ]] && f_QR_code_fzf_menu

         [[ $v_list =~ "4.  " ]] && [[ $Lv =~ "[ ]" ]] && bash ${v_REPOS_CENTER}/DRYa/all/bin/ca-lculadoras.sh 
         [[ $v_list =~ "4.  " ]] && [[ $Lv =~ "[X]" ]] && bash ${v_REPOS_CENTER}/DRYa/all/bin/ca-lculadoras.sh h

         [[ $v_list =~ "3. "  ]] && f_dot_files_menu
         [[ $v_list =~ "2. "  ]] && echo "uDev"
         [[ $v_list =~ "1. "  ]] && echo "Canceled"

      # Evitar loops a mais
         # A fx "...loop" pode ser chamada varias vezes para a alteracao da checkbox
         # Mas precisa que esse loop seja quebrado no final
         exit 0
   }

   # Correr 1x "void" e possivelmente correr varias vezes "loop"
      f_void
      f_loop

   unset v_list

}

function f_drya_fzf_MM {
   # FZF Main Menu (for DRYa)

   # Lista de opcoes para o menu `fzf`
      Lz1='Saving '; Lz2='D .'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      L4="4. | Help Menu";                    L4c="drya help"
      L3="3. | DRYa: Greet & Present itself"; L3c="D p"
      L2="2. | Toolbox"

      L1="1. Cancel" 

      L0='DRYa: `fzf` Main Menu: '

      v_list=$(echo -e "$L1 \n\n$L2 \n$L3 \n$L4 \n\n$Lz3" | fzf --cycle --prompt="$L0")

   # Atualizar historico fzf automaticamente
      echo "$Lz2" >> $Lz4

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3  ]] && echo "Acede ao historico com \`D ...\`"
      [[ $v_list =~ "4. " ]] && echo "$L4c" >> $Lz4 && f_drya_help_menu 
      [[ $v_list =~ "3. " ]] && echo "$Lc3" >> $Lz4 && f_greet2 && f_talk && echo "Sub-Operative system: Installed and ready!" 
      [[ $v_list =~ "2. " ]] && f_drya_fzf_MM_Toolbox
      [[ $v_list =~ "1. " ]] && echo "Canceled" 
      #unset v_list
}

function f_exec {
   # When invalid args are given at the teminal: 
      #f_greet

   # It can be used for other function debugs also:
      # Comment/Uncomment to turn Off/On each to debug accordingly:

      #f_ascii_icon
      f_greet2
      #f_get_script_current_abs_path
      f_talk; echo "Invalid argument(s)"
              echo ' > for help: `drya -h`'
              echo

   # If no arg was given, also navigate do DRYa's repo directory
      # udev: in a script it is going there, but after the script finishes, the prompt comes back. (so, not working, it will not navigate in the end, needs to be fixed)
      cd ${v_REPOS_CENTER}/DRYa
}


function f_seiva_up_time {
   f_greet

   echo "DRYa: seiva-up-time"
   echo
   echo "Seiva D'Arve iniciou estudos em Linux:"
   echo " > 2021-03-25"
   echo

   # Variavel com a data
      STARTINGDATE="2021-03-25"  

   # Data de aniversário no formato YYYY-MM-DD
      f_calcular_tempo_decorrido_apos_data

   # uDev: Add: seiva-trade-up-time para indicar esta data importante, ou entao incluir no moedaz como data de aniversario
}

function f_drya_help_menu {
   # Lista de opcoes para o menu `fzf`
      Lz1='Save '; Lz2='drya help'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      L6='6. About the Developer: seiva-up-time'
      L5='5. About DRYa extentions (ezGIT, trid, jarve, ...)'  
      L4='4. Read drya-msgs'  
      L3='3. Welcome Screen'
      L2='2. Print All' 
      L1='1. Cancel'

      L0="SELECT 1: Menu X: "
      
      v_list=$(echo -e "$L1 \n$L2 \n$L3 \n$L4 \n$L5 \n$L6\n\n$Lz3" | fzf --cycle --prompt="$L0")

   # Atualizar historico fzf automaticamente
      echo "$Lz2" >> $Lz4

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3  ]] && echo "$Lz2"
      [[ $v_list =~ "6. " ]] && f_seiva_up_time
      [[ $v_list =~ "5. " ]] && echo "uDev"
      [[ $v_list =~ "4. " ]] && less $v_MSGS
      [[ $v_list =~ "3. " ]] && f_drya_welcome
      [[ $v_list =~ "2. " ]] && f_drya_help
      [[ $v_list =~ "1. " ]] && echo "Canceled: $Lz2" 
      unset v_list
}

function f_partial_file_reader {
   # Para ler partes de documentos

   # uDev: O primeiro argumento convem ser logo o nome do ficheiro, so depois adicionar argumentos com opcoes

   # uDev:
   #      [ -z $2     ]  # Print todas estas opcoes/help
   #
   #      [ $2 == g   ]  # Usa `grep` e as pesquisas apresentam o nunero da linha
   #                       grep -n <pesquisa> <ficheiro>
   #
   #      [ $2 == n   ]  # Imprime so a linha numero X correspondente
   #                       exemplo: linha 1:
   #                       sed -n '1p' <nome-do-ficheiro>
   #
   #      [ $2 == ^   ]  # Imprime so a linha numero X para cima
   #                       sed -n '1,76p' <nome-do-ficheiro>
   #
   #      [ $2 == v   ]  # Imprime so a linha numero X para baixo
   #                       exemplo: linha 5 ate 11:
   #                       sed -n '5,$p' <nome-do-ficheiro>
   #
   #      [ $2 == "nn 5 11" ]  # Imprime desde a linha X a Y
   #                             exemplo: linha 5 ate 11:
   #                             sed -n '5,11p' <nome-do-ficheiro>
   #
   #      [ $2 == "gg <pesquisa> <pesquisa> " ]  # Imprime da linha X a Y, mas em vez de alimentar o numero da linha, alimenta 2 pesquisas de texto
   #
   #      [ $2 == "org <grep-ogr-header>" ]      # Para Emacs, imprime apenas o Header correspondente a pesquisa `grep` dada no arg seguinte 
   #
   #      [ $2 == "org" "-z $3" ]                # Para Emacs, imprime apenas o Header correspondente a pesquisa `grep` dada no arg seguinte 
   #                                               exemplo, pesquisar TODOS os headers:
   #                                               grep -n "^\*" <nome-do-ficheiro>
   #
   #      [ $2 == "r" ]  # Read a random line from a file



   #
   #   # Set Variables
   #      v_opti=$2
   #      v_line=$3
   #      v_file=$4
   #
   #      v_msg_miss_opti="DRYa: You need to provide an option"
   #      v_msg_miss_line="DRYa: You need to provide a line number"
   #      v_msg_miss_file="DRYa: You need to provide a file name"
   #
   #   # Exit on error:
   #      [[ -z $2 ]] && echo $v_msg_miss_opti && exit 1
   #      [[ -z $3 ]] && echo $v_msg_miss_line && exit 1
   #      [[ -z $4 ]] && echo $v_msg_miss_file && exit 1
   #
   #   # Run the command only if all args were given
   #      [[ -n $3 ]] && sed -n "${v_line}p" $v_file  
   #
   #

   echo
}

function f_toggle_termux_hushlogin {
   # O ficheiro .hushlogin que Liga/Desliga o ouptup:
   #     Vai ser removido se existir.
   #     Vai ser adicionado se nao existir

   v_hush=.hushlogin
   v_msgA="Ficheiro $v_hush removido"
   v_msgB="Ficheiro $v_hush adicionado"

   [[   -f ~/$v_hush ]] && rm    ~/$v_hush && f_talk && echo "$v_msgA" && exit
   [[ ! -f ~/$v_hush ]] && touch ~/$v_hush && f_talk && echo "$v_msgB" && exit
}



function f_remove_duplicated_lines_drya_fzf_history_file {
   # Removes duplicated lines from the history files using a temporary file

   # Note: This fx is meant to run only if some History file exists
   #       But such fx was already set before
   
   # variable for the file names
      # Original file name (this var was created at source-all-drya-files)
      v_original=$v_drya_fzf_menu_hist

      # Temporary file name
      v_temporary=${v_original}.tmp

   # Apagar as linhas em branco do ficheiro original
      sed -i '/^$/d' $v_original

   # Contar numero de linhas existentes no documento. Sera criado um `for` loop que vai repetir esse mesmo numero de vezes
      v_nr_lines=$(wc -l $v_original | cut -f 1 -d " ")  # O comando `wc -l` tem dois Outputs na mesma linha: o numero correspondente a contagem de linhas e tambem o nome do ficheiro, por isso, usamos o `cut` para filtrar apenas a parte do numero

   # Se o ficheiro tiver zero linhas: exit
      [[ $v_nr_lines == "0" ]] && echo "DRYa: fzf history file: file has no written lines to recall" && exit 1

   # Variable $v_max_lines was already set before (to cut excessive lines, avoiding creating huge files)

   # Creates a temporary file
      rm    $v_temporary 2>/dev/null   # Removes file if it exists. If it does not exist, then do not mention the error
      touch $v_temporary               # Create a temporary enpty file to work

   # Read original file line by line, but starting from the bottom with `tac` (instead of `cat`)
      for i in $(seq 1 $v_nr_lines)
      do 
         # Ler apenas a primeira linha do documento a flag `-r` do comando `read` faz ignorar barras de escape `\`
            #read -r v_linha < $v_original  # Nao chegou a ser preciso ou utilizado. Fica aqui como nota/comentario para estudo

         # Para cada volta do loop `for` vai buscar a proxima linha e colocar numa variavel
            v_line=$(tail -n $i $v_original | head -n 1)

         # Testar se essa linha da variavel ja existe no ficheiro temporario
            grep --fixed-strings "$v_line" $v_temporary &>/dev/null

         # Se o ultimo comando falhar, vai dar o codigo de erro de "1" que o bash guarda na variavel `$?` e se der erro, ainda nao existe essa linha la no ficheiro temporario e sera para la enviada essa linha
            [[ $? == 1 ]] && echo $v_line >> $v_temporary
      done

   # Overwrite original file with the content of temporary file
      cat $v_temporary > $v_original                    # Mater TODAS as linhas
      #tail -n $v_max_lines $v_temporary > $v_original  # Manter apenas as ultimas $v_max_lines do documento, eliminando todas as outras a mais
   
   # Removing the tmp file in the end to clean dir
      rm $v_temporary
}

function f__D_hist__recall_one_command {
   # Aceder ao historico drya-fzf-menu e repetir esse comando

   # 1. Verificar existencia desse ficheiro
   # 3. Apagar linhas em branco
   # 2. Verificar exiatencia de linhas escritas nesse ficheiro. Abortar se nao existirem linhas
   # 3. Remover linhas duplicadas
   # 3. Eliminar linhas a mais (para impedir ficheiros gisgantes). Variavel $v_max_lines
   # 4. Permitir ao utilizador escolher um comando para repetir
   # 5. No texto, Substituir 'alias' de comandos por 'abs path' desses comandos (evitar erros de falta de reconhecimento da sub-shell) 
   # 6. Executar esse comando

   # Definir max de linhas no ficheiro de historico
      v_max_lines=10

   # Remover linhas duplicadas
      f_remove_duplicated_lines_drya_fzf_history_file

   # Do ficheiro de historico, buscar apenas 1 linha
      v_line=$(cat $v_drya_fzf_menu_hist | fzf --prompt "DRYa: Choose a command to repeat (from fzf history): ")

   # Dessa linha que foi buscada, antes de tentar executar `eval` vamos substituir todos os "comandos" pelos "caminhos absolutos" (para nao dar erro)
      v_line=$(sed    "s#^D #${v_REPOS_CENTER}/DRYa/drya.sh #g" <(echo $v_line))
      v_line=$(sed "s#^drya #${v_REPOS_CENTER}/DRYa/drya.sh #g" <(echo $v_line))

      v_line=$(sed "s#^3sab #${v_REPOS_CENTER}/3-sticks-alpha-bravo/3-sticks-AB.sh #g" <(echo $v_line))

   # Se tiverem sido filtrados os comandos todos e substituidos pelos seus caminhos absolutos, entao podemos executar diretamente
      [[ -n $v_line ]] && bash $v_line 
}


function f_drya_get_all_repo_names_private_public {
   # Juntar a lista de repos publicas + privadas
      v_list_public=$(curl -s "https://api.github.com/users/SeivadArve/repos?per_page=100" | grep '"html_url"' | cut -d '"' -f 4 | grep -v "https://github.com/SeivaDArve$" | sed 's#https://github.com/SeivaDArve/##g')
      v_list_options="---Invert-Selection---"
      v_list_private="dv-cv-private moedaz omni-log luxam scratch-paper upK-diario-Dv wikiD 3-sticks-alpha-bravo verbose-lines oneFile-bau dandarez dWiki Tesoro dial-mono yogaBashApp-private autoPay Dv-Indratena"
      v_combine="$v_list_options $v_list_private $v_list_public"

      # will give a $v_tmp with a new file with abs path
         f_create_tmp_file  

      # Get the new file created
         echo "$v_combine" > $v_tmp

      # Novo resultado em nova var
         v_combine=$v_tmp
}

function f_zip_unzip {
   echo "uDev: Menu com opcoes"
}


function f_backup_helper {

      # uDev: at DRYa/all/bin/.../3-steps-formater a script will be available to make such backups and prepare format
      # Pode ser usado o SyncThing
      echo "drya: uDev: in the future you may call this function to send files from one device to another device using the web"
      echo 
      echo "DRYa backup options:"
      echo " - Smartphone >> Raspberry Pi (cloud) >> External HDD"
      echo
      echo "DRYa: type 'drya backup list' to be listed a sugestion of files to backup"

      echo "Backup on Smartphone (sugestions):"
      echo " > Contacts"
      echo " > Gmail accounts and passwords"
      echo " > Social media login credentials"
      echo " > Snapshot all installed apps"
      echo " > Browser bookmarks"
      echo " > Update all Repositories on termux"
      echo " > All SD CARD and Internal Storage content"
      echo " > ..."
      echo
      echo "Backup on Computer (suhestions):"
      echo " > ..."
      echo
      echo "uDev: criar opcoes que criam um dir, nesse dir, guarda certos dot-files atualmente na maquina"
      echo " > Depois, apartir desse exemplo, o user pode usar para outros fins"

}




function f_ghost {
   # Creating/Deleting a place-holder for DRYa
   echo "Instructions: ghost in.out:"
   echo " > When DRYa installs ANY package, it is registered"
   echo " > So, if drya wants to recover previous status (factory reset) it is possible"
   
   #uDev: Activate ghost.walk: Start recording all modifications done to the system to replace it later


   # (- ghost-out.sh): At any installation, the original default file should be stored in dryarc. So now this fx is possible. remove DRYa files and give back the dot-file that the system was fresh formated with.
   # (+ ghost-out.sh): When setting factory reset, leave a file to clone drya ENTIRELY
}






# -------------------------------------------
# -- Functions above --+-- Arguments Below --
# -------------------------------------------








# ARGUMENTS: for the Function DRYa
   # Use the programming structure provided below (if elif else fi) along 
   # with the Alias "drya" or "D" (defined in the file "source-all-drya-files")
      # Examples at the teminal: 
      #
      #  drya (with-no-arguments)
      #  drya -h
      #  drya --help
      #  drya +
      #
      #  D (with-no-arguments)
      #  D -h
      #  D --help
      #  D +
      # 

if [ -z "$*" ]; then
   # Do something if there are no arguments

   f_greet

   # Set Available time (in seconds) for Temporized quick menu
      v_secs=2

   # Info: nome do dispositivo atual
      v_user=$(git config --get user.name)

      f_talk; echo -n "Device Name: "
        f_c3; echo $v_user
        f_rc; echo 

   # Info when no args are given
      f_talk; echo "is installed!"
              echo ' > Use: Terminal: `D --help` (for help)'
              echo ' > Use: fzf Menu: `D .`      (for main menu)'
              echo

   # Temporized Quick menu
      f_talk; echo -n "Temporized Menu"; f_c3; echo -n " (available for "; f_c5; echo -n "$v_secs"; f_c3; echo    " secs):"; f_rc
              echo    "       |"
              echo -n "       |_ To open MAIN fzf menu, press NOW: '";     f_c5; echo -n "d";       f_rc; echo -n "' or '";  f_c5; echo -n "."; f_rc; echo "'"
              echo -n '          Equivalent Terminal commands: `';         f_c5; echo -n 'D .';     f_rc; echo '`' 

   
   # Options available during only few seconds
                    echo
      f_talk; f_c5; echo -en "listening... "; f_rc

      read -sn1 -t $v_secs v_ans
      
      if [ -z $v_ans ]; then
         sleep 0.1
   
         # ANSII to go to beggining of line and clear endire line after cursor
            echo -ne "\r\033[K"

      elif [ $v_ans == "d" ] || [ $v_ans == "D" ] || [ $v_ans == "." ] || [ $v_ans == "+" ]; then
         # When 'd' is pressed to open DRYa fzf main menu

         # ANSII to go to beggining of line and clear endire line after cursor
            echo -ne "\r\033[K"

         # Calling the actual menu
            f_drya_fzf_MM

      else

         # If there is a variable, delete and tell which was
         
         # ANSII to go to beggining of line and clear endire line after cursor
            echo -ne "\r\033[K"

         echo "Argument $v_ans not recognized at the temporized menu"
         unset v_ans

      fi

elif [ $1 == "help" ] || [ $1 == "h" ] || [ $1 == "?" ] || [ $1 == "--help" ] || [ $1 == "-h" ] || [ $1 == "-?" ] || [ $1 == "rtfm" ]; then
   # Help menu. [rtfm: "Read the Fucking Manual"]

   # uDev: `drya h  `  # 1st Level of help
   # uDev: `drya h 2`  # 2nd level of help
   # uDev: `drya h 3`  # 3rd level of help
   # uDev: `drya h 4`  # 4th level of help ... instead of "msgs"
   
   if [ -z "$2" ]; then
      # Menu Simples: Help

      f_drya_help_menu  

   elif [ $2 == "all" ]; then 
      f_drya_help

   elif [ $2 == "welcome" ]; then 
      # This function is used to uncluter the welcome screen of a terminal when DRYa is installed (because DRYa outputs a lot of text)
      echo "D help welcome" >> $v_drya_fzf_menu_hist
      f_drya_welcome

   elif [ $2 == "status-messages" ] || [ $2 == "msgs" ] || [ $2 == "ssms" ]; then 
      # Option to read the $DRYa_MESSAGES file
         # They are stored at: ~/.config/h.h/drya/.dryaMessages
         less $v_MSGS
   fi

elif [ $1 == "0" ] || [ $1 == "edit-bashrc" ]; then 
   # Edit the file that starts DRYa's loading sequence
   vim ~/.bashrc

elif [ $1 == "1" ] || [ $1 == "edit-source-all-drya-files" ]; then 
   # Edit first file in DRYa's loading sequence
   vim ${v_REPOS_CENTER}/DRYa/all/source-all-drya-files

elif [ $1 == "2" ] || [ $1 == "config-bash-alias" ]; then 
   # Edit second file in DRYa's loading sequence
   vim ${v_REPOS_CENTER}/DRYa/all/etc/config-bash-alias

elif [ $1 == "3" ] || [ $1 == "dryarc" ]; then 
   # Edit third file in DRYa's loading sequence
   echo uDev

elif [ $1 == "4" ] || [ $1 == "fluNav" ]; then 
   # Edit forth file in DRYa's loading sequence
   echo uDev

elif [ $1 == "5" ] || [ $1 == "drya.sh" ]; then 
   # Edit fifth file in DRYa's loading sequence
   echo uDev

elif [ $1 == "6" ] || [ $1 == "config-drya-hh" ] || [ $1 == "hh" ]; then 
   # Instructions on how to navigate to the directory where all D'Arve repos save configs
   echo 'Navigate to ~/.config/h.h/ with the alias `hh`'


elif [ $1 == "activate" ] || [ $1 == "placeholder-off" ] || [ $1 == "ghost.in" ]; then  # Usado em aparelhos/dispositivos publicos
   # Ao instalar DRYa, fica autimaticamente ativo
   # Ao desativar DRYa com 'deactivate' fica possivel ativar novamente com 'activate'
   # Ativar serve para repor DRYa com todas as funcoes que tinha ao ser instalada

   f_greet

   echo "DRYa: activate"
   echo
   echo "uDev: Se nao existe nenhuma repo no dispositivo:"
   echo " > clonar DRYa do GitHub"

   #echo
   #f_ghost

elif [ $1 == "deactivate" ] || [ $1 == "placeholder-on" ] || [ $1 == "ghost.out" ]; then
   # Apos insdalar DRYa, fica possivel desarivar com 'deactivate'
   # Serve para apagar tudo o que existe na pasta ~/Repositories incluindo DRYa, apagando tambem as configs na pasta ~ relativamente a DRYa e deixar no seu lugar um script que volta a clonar do Github 
   # Serve para usar em telemoveis ou dispositivos dos quais SeivaDArve na é o dono, tal como nos dispositivos do trabalho

   f_greet

   echo "DRYa: deactivate"
   echo
   echo "uDev: Apagar TUDO em:"
   echo " > ~/Repositories"
   echo " > ~/.config"
   echo " > ~/.netrc"
   echo "e deixar so um script para voltar a clonar DRYa do GitHub"
   echo

   # Criar o fucheiro que Re-Ativa DRYa, clonando do Github
      echo '#!/bin/bash' > ~/.DRYa-activate.sh
      echo '# Title: Activate DRYa again' >> ~/.DRYa-activate.sh
      echo '# Description: Run this script to clone DRYa to ~/Repositories automatically' >> ~/.DRYa-activate.sh
      echo "git clone https://github.com/SeivaDArve/DRYa.git ~/Repositories/DRYa" >> ~/.DRYa-activate.sh && echo "DRYa: Criado ~/.DRYa-activate.sh"
      # uDev: usar ~/.config/h.h/DRYa-activate.sh rm vez de ~/.DRYa-activate.sh
      # uDev: Mencionar o Stroken

   #echo
   #f_ghost

elif [ $1 == "location" ]; then 
   # Save GPS locations
   # uDev: this function needs to go to the repo: master-GPS

   if [ $2 == "network" ]; then 
      # Displays current GPS location using network as provider
      termux-location -p network

   elif [ $2 == "gps" ]; then 
      # Displays current GPS location using GPS as provider
      termux-location -p GPS

   elif [ $2 == "network-save" ]; then 
      # Displays current GPS location using network and saves in a file
      # ${REPOS_CENTER}/DRYa/all/var/report-termux-locations.txt
      termux-location -p network

   elif [ $2 == "gps-save" ]; then 
      # Displays current GPS location using GPS and saves in a file
      # ${REPOS_CENTER}/DRYa/all/var/report-termux-locations.txt
      termux-location -p GPS

   fi

elif [ $1 == "update" ]; then 
   echo "uDev: Similar to: G v; source ~/.bashrc; apply all dot-files across the system"
   # uDev: Same as: `S Reload: DRYa + dot-files + Terminal`

   f_greet
   f_c4; echo -n "DRYa: "
   f_rc; echo "Downloading updates and applying them"
         cd ${v_REPOS_CENTER}/DRYa
   
   f_git_status
   f_git_pull

   echo

   # Aplly each dot-file in their correct places across the system
      f_talk; echo "applying dot-files:"
              echo " > .vimrc" && cp ${v_REPOS_CENTER}/DRYa/all/etc/dot-files/vim/.vimrc ~
              echo " > termux: colors + properties (uDev)"
              echo " > .gitconfig" && cp ${v_REPOS_CENTER}/DRYa/all/etc/dot-files/git-github/.gitconfig ~
              echo " > init.el (uDev)"
              echo " > drya: .bash_logout file"
              echo

   # Reload .bashrc
      f_talk; echo "reloading functions, variables, alias at:"
              echo " > ~/.bashrc"

      source ~/.bashrc 1>/dev/null && echo " > Done!" && echo

elif [ $1 == "logout" ]; then 
   # If you made modifications at ...DRYa/all/etc/logout-all-drya-files 
   # and you want to conveniently apply it's changes at ~/.bash_logout
   # just run this command
   #
   # The file ~/.bash_logout has an fx that calls logout-all-drya-files

   if [ -z "$2" ]; then
      # If nothing was specified to clone
         echo "What option do you want to perform around the logout file?"

   elif [ $2 == "edit" ]; then
      vim ${v_REPOS_CENTER}/DRYa/all/etc/logout-all-drya-files

   #elif [ $2 == "install" ]; then
      # It is ready and was sent to DRYa fzf main menu

   else
      echo "Option not recognized"
   fi

elif [ $1 == "cl" ]; then 
   # `cl` passou a ser `cln` para que `clip` passe a ser `clp` (ambos sao parecidos)
   echo '`cl` = help'
   echo '`cln` = clonar'
   echo '`clp` = clip'
   echo '`clr` = colar'

elif [ $1 == "clone" ] || [ $1 == "cln" ]; then 
   # Gets repositories from Github.com and tells how to clone DRYa itself
   # Any repo from Seiva's github.com is cloned to the default directory ~/Repositories

   f_greet

   if [ -z "$2" ]; then
      # If nothing was specified to clone, give some instructions
      f_clone_info

   elif [ $2 == "." ]; then
      # Open fzf to help clone by the correct name

      f_talk; echo "uDev: List all public repos to clone (with \`fzf\`)"

      v_list=$(curl -s "https://api.github.com/users/SeivadArve/repos?per_page=100" | grep '"html_url"' | cut -d '"' -f 4 | grep -v "https://github.com/SeivaDArve$" | sed 's#https://github.com/SeivaDArve/##g')
      v_multiple=$(echo $v_list | sed 's/ /\n/g' | fzf -m --prompt="DRYa: SELECT multiple: Public Repositories to clone")
      for i in $v_multiple
      do
         echo $i
      done

      f_talk; echo "uDev: List all public repos to clone (with \`fzf\`)"

      v_list=$(curl -s "https://api.github.com/users/SeivadArve/repos?per_page=100" | grep '"html_url"' | cut -d '"' -f 4 | grep -v "https://github.com/SeivaDArve$" | sed 's#https://github.com/SeivaDArve/##g')
      v_multiple=$(echo $v_list | sed 's/ /\n/g' | fzf -m --prompt="DRYa: SELECT multiple: Public Repositories to clone")
      for i in $v_multiple
      do
         echo $i
      done

      # uDev: `D cln . inv` para inverter a selecao (Clonar todas as repos excepto as que forem selecioadas)
      # uDev: `D cln . p`
      # uDev: `D cln . P`

      f_talk; echo "uDev: List all public repos to clone (with \`fzf\`)"

      v_list=$(curl -s "https://api.github.com/users/SeivadArve/repos?per_page=100" | grep '"html_url"' | cut -d '"' -f 4 | grep -v "https://github.com/SeivaDArve$" | sed 's#https://github.com/SeivaDArve/##g')
      v_multiple=$(echo $v_list | sed 's/ /\n/g' | fzf -m --prompt="DRYa: SELECT multiple: Public Repositories to clone")
      for i in $v_multiple
      do
         echo $i
      done

      # uDev: Quando aparece a lista de repos para clonar, podemos logo testar se existem ou nao:
      #       Exemplo:
      #        > [X] dv-cv-private
      #        > [ ] dv-cv-private


      f_talk; echo "Cloning Multiple Repositories"
              echo " > Listing all public repos (by web search)"
              echo " > Listing private repos    (from offline file)"

              #echo pin $v_pin; read

      f_drya_get_all_repo_names_private_public

      # Pedir ao user para selecionar repos
         v_multiple=$(cat $v_combine | sed 's/ /\n/g' | fzf -m --cycle --pointer=">" --prompt="DRYa: SELECT multiple: Repositories to clone/install: ")


      if [[ -n $v_multiple ]]; then

         #[[ $v_multiple =~ "dv-cv-public" ]] && grep "dv-cv-public" <(echo $v_multiple) && [[ $? == "1" ]] && echo "Nao Quer clonar tambem 'dv-cv-private' que se comunica com 'dv-cv-public'?"

                 echo
         f_talk; echo "Repos selecionados:"

         for i in $v_multiple
         do
            echo " > $i"
            #echo " > $i" >> $drya-status-messages
         done

      else
                 echo
         f_talk; echo "Nenhum repo selecionado"
      fi

   elif [ $2 == "try" ] || [ $2 == "t" ]; then
      # To clone repos when we are not exactly sure how it's name is written 
      #                when shortcuts were not already set or predictrd

      if [ -z $3 ]; then
         # Using menu fzf
         f_talk; echo "\`D cln try <name>\`"
                 echo " > Repo name not specified"
                 echo "   You must try at least one repo 'name'"

      else
         # Avoiding menu fzf and trying to type manually

         # uDev: It is less easy to clone repos with case insensitivity, so fzf could filter github public repo names"
         #   f_drya_get_all_repo_names_private_public
         #   to `grep` and `fzf`



         # Verbose:
            f_talk; echo -e "DRYa: Trying to clone: $3 \n"; 

         # Save current PWD + Navigate to Repos Center + Call f_stroken
            f_init_clone_repos 

         # Actually try to clone
            git clone https://github.com/SeivaDArve/$3.git
      fi

   else  
      # Clone pre-defined repositories, without menu fzf

      # Saving Terminal argument into internal variable
         v_arg2=$2

      # Save current PWD + Navigate to Repos Center + Call f_stroken
         f_init_clone_repos 

      # Actually clone known repos. (In case repo is not recognized, it is also mentioned)
         f_clone_repos 
   fi


elif [[ $1 == "wpwd" ]] || [[ $1 == "wPWD" ]]; then 
   # Convert text Windows Path into text Linux Path
   
   # Getting variables from the arguments, from the input
      v_arg2=$2

   f_win_to_linux_pwd


elif [ $1 == "eysek" ]; then 

   f_greet 

   # Frase bonita
      echo "Desde o filme..." 
      echo

   # Variavel com a data
      STARTINGDATE="2021-02-05"  

   # Data de aniversário no formato YYYY-MM-DD
      f_calcular_tempo_decorrido_apos_data


elif [ $1 == "seiva-up-time" ]; then 
   # uDev: Tells how long the Linux experience started for Seiva
   
   f_seiva_up_time

elif [ $1 == "ip" ]; then 
   f_menu_internet_network_ip_options

elif [ $1 == "mac" ]; then 

   f_greet

   # Get MAC address using ifconfig
      mac_address=$(ifconfig | grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}')

   # Print MAC address
      echo "MAC Address: $mac_address"
      echo

   # Print Android ID
      ANDROID_ID=$(termux-telephony-deviceinfo | grep 'device_id' | awk -F': ' '{print $2}' | tr -d '",')
      echo "Android ID: $ANDROID_ID"
      echo

   # Print Numero de serie do Android
      SERIAL=$(getprop ro.serialno)
      echo "Número de série do dispositivo: $SERIAL"
      echo

   # Mais info
      getprop | grep "product" | grep brand
      echo
      getprop | grep "product" | grep model
      echo
      getprop | grep "product" | grep name
      echo


elif [ $1 == "install.uninstall" ] || [ $1 == "install" ] || [ $1 == "uninstall" ] || [ $1 == "iu" ] || [[ $1 == "ui" ]];  then 
   # Install DRYa and more stuff
   # Note: even when DRYa is not yet installed into ~/.bashrc but it is cloned to the machine, autocompletion already works for this command only `bash drya.sh install.uninstall` because the command name for the `fzf` menu is the same as the existent directory. But remember that `fzf` is a dependency and should be installed first

   if [[ -z $2 ]]; then 
      # If there are no args:

      # Lista de opcoes para o menu `fzf`
         Lz1='Save '; Lz2='D install.uninstall'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

         L10='10. Menu | helper  | factory reset + ghost (in.out)'
          L9='9.  Menu | helper  | backups'
          L8='8.  Menu | clone   | repos'
          L7='7.  Menu | install | specific packages | `D iu p` | `D iu <package>`'
          L6='6.  Menu | install | dot-files         | `D iu d`'
   
          L5='5.  Install DRYa | Dependencies only (1st packages)'
          L4='4.  Install DRYa | `fzf`    installer'
          L3='3.  Install DRYa | `select` installer'

          L2='2.  List Status  | `ls`'
          L1='1.  Cancel'

         L0="DRYa: Installers Menu: "
         
         v_list=$(echo -e "$L1 \n$L2 \n\n$L3 \n$L4 \n$L5 \n\n$L6 \n$L7 \n$L8 \n$L9 \n$L10 \n\n$Lz3" | fzf --cycle --prompt="$L0")

      # Atualizar historico fzf automaticamente
         echo "$Lz2" >> $Lz4

      # Perceber qual foi a escolha da lista
         [[ $v_list =~ $Lz3   ]] && echo "$Lz2" && history -s "$Lz2"
         [[ $v_list =~ "10. " ]] && f_ghost
         [[ $v_list =~ "9.  " ]] && f_backup_helper
         [[ $v_list =~ "8.  " ]] && echo uDev
         [[ $v_list =~ "7.  " ]] && echo uDev
         [[ $v_list =~ "6.  " ]] && f_dot_files_menu  
         [[ $v_list =~ "5.  " ]] && vim ${v_REPOS_CENTER}/DRYa/all/bin/populate-machines/level+1/1st
         [[ $v_list =~ "4.  " ]] && echo uDev
         [[ $v_list =~ "3.  " ]] && f_install_drya
         [[ $v_list =~ "2.  " ]] && f_dot_files_list_available
         [[ $v_list =~ "1.  " ]] && echo "Canceled: $Lz2" && history -s "$Lz2"
         unset v_list

   elif [[ $2 == "me" ]] || [ $2 == "DRYa" ] || [ $2 == "drya" ]; then 
      f_install_drya

   elif [[ $2 == "fig" ]]; then 
      echo "testing existence of figlet (as an example)"

   #elif [[ $2 == "dependencies" ]] || [ $2 == "dep" ]; then 
   #   # uDev: Read file '1st' and exec instalation of selected group of dependencies

   elif [[ $2 == "." ]]; then 
      # Edit script "DRYa fzf installer"
      vim ./install.uninstall/linux-or-WSL/master-bashrc/1-installer-fzf-alternative.sh

   elif [[ $2 == "ls" ]] || [ $2 == "list-ready-and-udev" ]; then 
      f_dot_files_list_available

   elif [[ $2 == "dot-file" ]] || [ $2 == "dot" ] || [ $2 == "d" ]; then 

      if [ -z $3 ]; then
         # Menu principal: dot-files
         f_dot_files_menu  

      elif [ $3 == "install" ] || [ $3 == "i" ]; then
         # Menu: dot-files install
         
         [[ -z $4            ]] && f_menu_install_dot_files
         [[    $4 == "git"   ]] && f_dot_files_install_git
         [[    $4 == "vimrc" ]] && f_dot_files_install_vimrc
      fi

   elif [[ $2 == "ps1" ]] || [ $2 == "PS1" ]; then 
      # uDev: This is a config to set, not an instalation
      cd ${v_REPOS_CENTER}/DRYa/all/etc/dot-files/termux/ && source ./termux-PS1

   elif [[ $2 == "bitcoin-core" ]]; then 
      # Install a full Bitcoin node to validade blocks and allow mining
      sudo snap install bitcoin-core

   elif [[ $2 == "pycharm" ]]; then 
      # Install a dedicated GUI text editor for python

      f_greet

      echo "Installing PyCharm on Fedora"
      echo " > Press ENTER to continue; Press Ctrl-C to Abort"
      echo 
      read -sn 1
      echo "Tutorial source: https://snapcraft.io/install/pycharm-community/fedora#install"
      echo 
      # Installing Snap Store and from there, installing pycharm-community
         sudo dnf install snapd
         sudo ln -s /var/lib/snapd/snap /snap
         sudo snap install pycharm-community --classic
      echo
      echo "PyCharm installed"
      echo " > Logout the session or restart to update and use pyCharm"
  
   elif [[ $2 == "doom-emacs-windows" ]]; then 
      # installing Doom Emacs on Windows
      echo "uDev: Tutorial here:"
      echo " > https://dev.to/scarktt/installing-doom-emacs-on-windows-23ja"

   elif [[ $2 == "doom-emacs" ]]; then 
      # installing Doom Emacs on Linux
      echo "Installing Doom Emacs on Linux "
      read -p " > Do you want to continue?"

      # Dependencies
         sudo apt install git emacs ripgrep fd find
      
      # Now, doom itself
         git clone --depth 1 http://github.com/hlissner/doom-emacs ~/.emacs.d
      
      # Installing doom
         cd ~
         bash .emacs.d/bin/doom install
      
      # Utilities found in bin/doom
         #bash .emacs.d/bin/doom sync
         #bash .emacs.d/bin/doom upgrade
         #bash .emacs.d/bin/doom doctor
         #bash .emacs.d/bin/doom purge
         #bash .emacs.d/bin/doom help
         
      # Instead of giving the full path to the command, we can add the dir to ou PATH variable
         export PATH="$HOME/.emacs.d/bin:$PATH"

      # The standard emacs dir is ~/.emacs.d
         # DistroTube (DT) says to never play in this directory
         # Play in the directory ~/.doom.d instead
         # An alternative, instead of using ~/.doom.d you can use ~/.config/.doom.d (you move the dir, you do not duplicate it)
         
         # Let's move our dir
            mv ~/.doom.d ~/.config/.doom.d

      # Now just launch
         echo "Now run emacs like you normally would"
         echo "Done!"

   elif [[ $2 == "xrandr" ]] || [ $2 == "" ]; then 
      # Config the correct screen resolution with `xrandr`
      # uDev: This is a config to set, not an instalation

      echo "DRYa: By detecting the traitsID and detecting a raspberry pi, then we know we are using a Tv. And, if no args are given, such tV is brand "silver" therefore, this script applies the screen resolution of:"
      echo " > 1360x768 "

   elif [[ $2 == "upk-at-work" ]] || [[ $2 == "upk-tmp-phone" ]]; then 
      # Makes all dependencies for upk repo available
      # This might be used most likely at in-job phone

      f_quick_install_all_upk

   else
      echo "drya: What do you want to install? invalid arg"
   fi


elif [[ $1 == "dot" ]] || [[ $1 == "dotfiles" ]] || [[ $1 == "dot-files" ]] || [[ $1 == ".dot" ]] || [[ $1 == "dt" ]]; then 
   # Installing all configuration files

   if [[ -z $2 ]]; then 
      # Main Menu for dot-files
      f_dot_files_menu  

   else
      echo "uDev: merged with install.uninstall"
      echo 'Use:  `D ui dot ...`' 
   fi


elif [ $1 == "edit" ]; then 
   case $2 in
      stroken)
         # Editing stroken globally
         vim ${v_REPOS_CENTER}/DRYa/all/etc/dot-files/git-github/current-stroken
            echo "File edited at: ...DRYa/all/etc/dot-files/git-github/current-stroken"
            echo

         cp ${v_REPOS_CENTER}/DRYa/all/etc/dot-files/git-github/current-stroken ${v_REPOS_CENTER}/DRYa/install.uninstall/stroken
            echo "Copied also too: ...DRYa/install.uninstall/stroken"
            echo
         
            # Adding info for the new user:
               echo -e "\n(note \"info exists also at: .../DRYa/all/etc/dot-files/git-git-hub/current-stroken\")" >> ${v_REPOS_CENTER}/DRYa/install.uninstall/stroken

         # Verbose output
            echo "You may install stroken as ~/.netrc file with the command:"
            echo " > drya install stroken"
            # uDev: to be sent to: drya.sh edit stroken
      ;;
      news)
         vim ${v_REPOS_CENTER}/DRYa/all/bin/news-displayer/news-displayer.sh
      ;;
      dryarc)
         echo "edit the file to program this machine without saving inside original DRYa (uDev)"
      ;;
      alias | config-bash-alias)
         ## PERMANENT CHANGES if "git push" is used
         vim ${v_REPOS_CENTER}/DRYa/all/etc/config-bash-alias
         
         # Other ways to open the same file: 
            # Using menu F (from D.F) defined/programed at config-bash-alias (the same file we are opening)
               # '$ F'

            # Using the alias set on 'source-all-drya-files'
               # '$ ,.' 
      ;;
      src | source | source-drya | source-all-drya-files) 
         vim ${v_REPOS_CENTER}/DRYa/all/source-all-drya-files

         # Other ways to open the same file: 
            # Using menu F (from D.F) defined/programed at config-bash-alias (the same file we are opening)
               # '$ F'

            # Using the alias set on 'source-all-drya-files'
               # '$ ,..' 
      ;;
      termux)
         # Will edit termux.properties file at ~/.termux/termux.properties
         echo "Please reverse the args:"
         echo " > drya dot edit termux"
      ;;
      dot)
         echo "Please reverse the args:"
         echo " > drya dot edit"
      ;;
      *)
         echo "drya: What do you want to edit?"
         echo 
         echo "Notes:"
         echo " > you can call '$ M' for the Menu with favourite files for edition"
         echo " > Press [M] to open 'M Menu' with favourite files (uDev)"

      ;;

   esac



elif [ $1 == "remove" ]; then 
   case $2 in
      dot-files)
         echo "drya: drya dot-files remove"
         echo " > remove files from default locations and do not touch files inside drya repo"
         # Remove ~/.config/h.h
      ;;
      upk)
         # Makes all dependencies for upk repo disapear
         # This might be used most likely at in-job phone
         #    remove:  upk repo
         #             upk-dv
         #             !emacs
         #             !emacs for windows
         #             !install init.el
         #             source bashrc file
         #             !figlet
         #             netrc
         echo "drya: udev: remove all dependencies for upk repo to run"
      ;;
      netrc)
         f_greet
         echo "drya: removing the dot file ~/.netrc"
         echo -e "\nAre you sure you want to remove ~/.netrc? \n > [ Ctrl-C ] to Cancel\n > [ Any key ] to accept"
         read -s -n 1
         echo
         rm ~/.netrc && echo "Done!"

      ;;
      *)
         echo "drya: What do you want to remove? (uDev)"
      ;;
   esac

elif [ $1 == "save-backup" ]; then 

   if [ $2 == "dot-files" ]; then 
         echo "drya: drya dot-files save"
         echo " > copy from default locations to omni-log repo"
   else
         echo "drya: What do you want to save? (uDev)"
   fi

elif [ $1 == "ssh" ]; then 
   # Options for SSH File System

   # Para transportar os argumento de script para script, exportamos para o env
      # uDev: fazer destes EXPORT o standard deste script drya.sh no inicio do ficheiro, para que qualquer sub-script possa beneficiar destes argumentos
      ARG1=$1
      ARG2=$2
      ARG3=$3
      export ARG1 ARG2 ARG3
   
   # Executamos o wrapper do SSHFS
      bash ${v_REPOS_CENTER}/DRYa/all/bin/sshfs-wrapper.sh

elif [ $1 == "news" ]; then 
   # Runs a script inside DRYa directories that continuously rolls information
   bash ${v_REPOS_CENTER}/DRYa/all/bin/news-displayer/news-displayer.sh

elif [ $1 == "todo" ] || [ $1 == "t" ]; then  
   # Lista de tarefas
   f_talk; echo 'ToDo list belongs to omni-log repo'
           echo ' > Try: `td`'

elif [ $1 == "list-all-file-metadata" ] || [ $1 == "meta-ls" ]; then  # mostra os seu metadados da imagem fornecida
   
   if [ -z $2 ]; then
      # Caminho para a imagem

      # Lista de opcoes para o menu `fzf`

         L0="DRYa: Para visualizar metadata, selecione o ficheiro: "
         
         unset v_list
         v_list=$(ls | fzf --cycle --prompt="$L0")

         [[ -n $v_list ]] && exiftool "$v_list"

   else
         exiftool $2
   fi


elif [ $1 == "list-all-dir-metadata" ] || [ $1 == "meta-ps-ls-dir" ]; then  # Junta todas as fotos do dir atual e mostra os seus metadados

   # Caminho para a pasta com as imagens
      FOLDER_PATH="."

   # Loop através dos arquivos na pasta
      for i in "$FOLDER_PATH"/*; do
        # Verifica se o arquivo é uma imagem (extensões .jpg, .jpeg, .png)
        if [[ $i == *.jpg || $i == *.jpeg || $i == *.png ]]; then
          # Listar todos os metadados da imagem
          exiftool "$i"
        fi
      done

elif [ $1 == "list-photoshop-edited-imgs" ] || [ $1 == "meta-ps-ls-r-jpg" ]; then  # Na pasta atual, identifica todas as fotos editadas pelo Photoshop (com apoio do chatGPT)
   # uDev: Existem mais campos que mencionam 'Photoshop' sem ser so o campo '-Software', é necessario completar

   # Caminho para a pasta com as imagens
      FOLDER_PATH="."

   # Loop através dos arquivos na pasta
      for i in "$FOLDER_PATH"/*; do
        # Verifica se o arquivo é uma imagem (extensões .jpg, .jpeg, .png)
        if [[ $i == *.jpg || $i == *.jpeg || $i == *.png ]]; then
          # Extrai os metadados EXIF
          SOFTWARE=$(exiftool -Software "$i")
          
          # Verifica se o Software usado foi o Photoshop
          if [[ $SOFTWARE == *"Adobe Photoshop"* ]]; then
            echo "Imagem editada no Photoshop: $i"
          fi
        fi
      done

elif [ $1 == "clear-photoshop-editor-from-metadata-of-imgs" ] || [ $1 == "meta-ps-clr" ]; then  # Na pasta atual, elimina os campos onde diz que a foto foi editada por algum software 
   # Caminho para a pasta com as imagens
      FOLDER_PATH="."

   # Loop através dos arquivos na pasta
      for i in "$FOLDER_PATH"/*; do
        # Verifica se o arquivo é uma imagem (extensões .jpg, .jpeg, .png)
        if [[ $i == *.jpg || $i == *.jpeg || $i == *.png ]]; then
          # Remove o metadado do software da imagem
          #exiftool -Software= "$i"
          exiftool -all= "$i"
          echo "Metadado do software removido de: $i"
        fi
      done


elif [ $1 == "generate-photo-ID" ] || [ $1 == "gpID" ]; then  # Busca a data/hora atual de forma inconfundivel e adiciona o texto "Img-ID-xxxxxxxxxxxxxxxxx.jpg"
   echo "uDev: Idenfiticação de photos criando um nome com ID"
   # uDev: criar fx que busca em TODO o sistema de pastas no Android apartir do termux para encontrar todos esses ID espalhados e enviar para a pasta desejada (local atual do cursor)

elif [ $1 == "soft-link" ] || [ $1 == "sl" ]; then 
   # uDev: criar também hard links para ficheiros e pastas
   
   f_greet

   # Verificar se o número de argumentos é igual a 2
      if [ "$#" -ne 3 ]; then
         f_instructions_of_usage
      fi

   origem=$2
   destino=$3

   # Verificar se o arquivo/diretório de origem existe
      if [ ! -e "$origem" ]; then
          echo "Erro: O arquivo ou diretório de origem '$origem' não existe."
          f_instructions_of_usage
          exit 1
      fi

   # Criar o link simbólico
      ln -s "$origem" "$destino"

   # Verificar se o link simbólico foi criado com sucesso
      if [ "$?" -eq 0 ]; then
          echo "Link simbólico criado com sucesso: '$destino' -> '$origem'"
      else
          echo "Erro ao criar o link simbólico."
          f_instructions_of_usage
          exit 1
      fi

elif [ $1 == "calculo" ] || [ $1 == "calc" ] || [ $1 == "ca" ] || [ $1 == "calculator" ] || [ $1 == "clc" ] || [ $1 == "calculadora" ]; then
   # List of calculatores (some modified for Trading)

   if [ -z $2 ]; then 
      # Opens menu "calculadoras"
      bash ${v_REPOS_CENTER}/DRYa/all/bin/ca-lculadoras.sh

   elif [ $2 == "." ]; then 
      # Opens interactive calculadora
      bash ${v_REPOS_CENTER}/DRYa/all/bin/ca-lculadoras.sh .

   elif [ $2 == "," ]; then 
      # Opens calculadora registadora
      bash ${v_REPOS_CENTER}/DRYa/all/bin/ca-lculadoras.sh ,

   elif [ $2 == "3" ]; then
      # Entrar na Calculadora da Regra de 3 Simples
      bash ${v_REPOS_CENTER}/DRYa/all/bin/ca-lculadoras.sh 3

   elif [ $2 == "p" ]; then
      # Entrar na Calculadora de Percentagens

      # Perguntar quantas casas decimais?
         v_ask=no

      if [ -z $3 ]; then
         bash ${v_REPOS_CENTER}/DRYa/all/bin/ca-lculadoras.sh p

      elif [ $3 == "d" ]; then
         v_ask=yes
         bash ${v_REPOS_CENTER}/DRYa/all/bin/ca-lculadoras.sh p d
      fi

   elif [ $2 == "x" ]; then 
      # Calculations directly on the prompt: `D ca x "3 + 3"`
      [[ -n $3 ]] && echo "$3" | bc

   fi

elif [ $1 == "set-keyboard" ] || [ $1 == "kbd" ]; then 
   f_greet
   f_talk; echo "Keyboard options"
    
   # Menu Simples

   # Lista de opcoes para o menu `fzf`
      Lz1='Save '; Lz2='D set-keyboard'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

   #  Instrucoes: Para usar 'ç' na palacra 'caça', com a variavel $c_1 que contem o valor 'ç', usa o `eval` no terminal: `eval ca${c_1}a`
	#
	#     | a | $a_0 |
	#     | á | $a_1 |
	#     | à | $a_2 |
	#     | ã | $a_3 |
	#     | ä | $a_4 |
	#
	#     | c | $c_0 |
	#     | ç | $c_1 |
	#


	  
      L6='6. DRYa emergency keyboard'

      L5='5. Config keyboard layout: Fedora Linux (sess atual)'  # Apenas para a sessao atual
      L4='4. Config keyboard layout: Kali   Linux (sess atual)'
      L3='3. Config keyboard layout: Ubuntu Linux (sess atual)'

      L2='2. Verificar teclado atual' 
      L1='1. Cancel + Instructions'

      L0="DRYa: Keyboard: "
      
      v_list=$(echo -e "$L1 \n$L2 \n\n$L3 \n$L4 \n$L5 \n\n$L6 \n\n$Lz3" | fzf --pointer=">" --cycle --prompt="$L0")

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3  ]] && echo "$Lz2" && history -s "$Lz2"
      [[ $v_list =~ "6. " ]] && cat ${v_REPOS_CENTER}/DRYa/all/bin/fzf-keyboard-alterbative/keys-list.txt | fzf
      [[ $v_list =~ "5. " ]] && echo "uDev: $L4"
      [[ $v_list =~ "4. " ]] && echo "Configuring Keyboard to PT-PT (current session only)" && setxkbmap -layout pt
      [[ $v_list =~ "3. " ]] && echo "Configuring Keyboard to PT-PT (current session only)" && setxkbmap pt
      [[ $v_list =~ "2. " ]] && localectl status 
      [[ $v_list =~ "1. " ]] && echo "Canceled: $Lz2" && echo "DRYa: try CTRL-X to open fzf-keyboard-alternative in the middle of the prompt"
      unset v_list
    


elif [ $1 == "k" ]; then 
   echo 'uDev: fzf menu for entire keyboard'
   echo '      Used when keyboard configs are unsolved'
   read -sn1 -p " > Press enter "
   clear
   cat ${v_REPOS_CENTER}/DRYa/all/bin/fzf-keyboard-alterbative/keys-list.txt | fzf --header "Live text here: ..."

   # uDev: Set a keybing like Ctrl-... to open this fzf file while writting text to allow adding some special charter like: ? _ " + ) -

elif [ $1 == "set-timezone" ] || [ $1 == "timez" ]; then 
   f_talk; echo "uDev: Options to set timezone"
    
elif [ $1 == "vlm" ]; then 
   # Works on termux only
      # Toggles the value volume-key from =virtual to =volume (inside termux. more info at: man termux)

      echo "uDev: Send to Termux menu (that manipulates the entire termux.properties file)"
      f_dot_files_menu_edit_host_files_termux_properties

   #echo "volume keys on Termux toggled. Now they act as X instead of Y"
   # DO NOT CHANGE VOLUME ON DRYa REPO, CHANGE ONLY AT ~/.termux/ (no need to continuously git push such changes
   # volume-keys = volume
   # volume-keys = virtual
   # Default is virtual

   # As per termux instructions, we can reload the configs: 
      #termux-reload-settings

elif [ $1 == "no" ] || [ $1 == "note" ] || [ $1 == "notes" ]; then 
   bash ${v_REPOS_CENTER}/DRYa/all/bin/no-tes.sh
   
elif [ $1 == "noty" ] || [ $1 == "notify" ]; then 
   bash ${v_REPOS_CENTER}/DRYa/all/bin/notify.sh

elif [ $1 == "QR" ] || [ $1 == "qr" ]; then 
   # Options for QR codes

   f_QR_code_fzf_menu

elif [ $1 == "p" ] || [ $1 == "presentation" ] || [ $1 == "logo" ]; then 
   # Presenting DRYa with ASCII text
   ${v_REPOS_CENTER}/DRYa/all/bin/drya-presentation.sh || echo -e "DRYa: app availablei \n > (For a pretty logo, install figlet)"  # In case figlet or tput are not installed, echo only "DRYa" instead

elif [ $1 == "create-windows-bootable-USB-cmd" ] || [ $1 == "cwusb" ]; then 
   # Step-by-step guide to create a bootable USB at windows command prompt"

   bash ${v_REPOS_CENTER}/DRYa/all/bin/create-windows-bootable-USB-cmd.sh

elif [ $1 == "wiki" ] || [ $1 == "w" ]; then 
   # Menu to edit locally, visualize in the browser, etc...
   
   f_talk; echo "Opening: wikiD.org"
           echo " > uDev: Create menu for browser visualization"

   # uDev: Test fist if repo exists
   
   cd ${v_REPOS_CENTER}/wikiD/ && emacs wikiD.org

elif [ $1 == "omni" ] || [ $1 == "om" ]; then 
   f_talk; echo "Opening: omni-log.org"

   # uDev: Test fist if repo exists
   cd ${v_REPOS_CENTER}/omni-log/ && emacs omni-log.org

elif [ $1 == "quit" ] || [ $1 == "q" ]; then 
   # Several ways to exit the terminal


   # uDev: Fazer um script equivalente a `getopts` para esta fx. Ou fzf com --multiple
   #     exemplo: `D quit -Huc -r`
   #              -H (apagar historico)
   #              -u (Uninstal softwares)
   #              -c (Delete specific configs)
   #              -r (Delete specific repo by name)


   # File to run as last script before exit terminal
      v_quit=${v_REPOS_CENTER}/DRYa/all/etc/logout-all-drya-files

   # Specific repos to delete
      v_repo=${v_REPOS_CENTER}

   if [ -z $2 ]; then 
      # File to run as last script before exit terminal
      source $v_quit

   elif [ $2 == "1" ]; then 
      # When exit, delete specific repositories too
      [ -d $v_repo/scratch-paper ] && cd && rm -rf $v_repo1 && f_talk && echo "Sc removed"

   elif [ $2 == "2" ]; then 
      # Delete all personal-data repos (private + scratch-paper + .netrc)
      [ -d $v_repo/scratch-paper ] && cd && rm -rf $v_repo/scratch-paper && f_talk && echo "Sc removed"
      [ -d $v_repo/omni-log      ] && cd && rm -rf $v_repo/omni-log      && f_talk && echo "omni-log removed"
      [ -d $v_repo/moedaz        ] && cd && rm -rf $v_repo/moedaz        && f_talk && echo "moedaz removed"
      [ -f ~/.netrc              ] &&       rm ~/.netrc                  && f_talk && echo ".netrc removed"
      
      sleep 3
      clear

   elif [ $2 == "3" ]; then 
      # When exit, delete specific configs 
      # When exit, uninstall specific softwares too
      echo "uDev"

   elif [ $2 == "4" ]; then 
      # When exit, delete browser history and other trails of activity
      echo "uDev"

   elif [ $2 == "5" ]; then 
      # When exit, delete DRYa entirely
      echo "uDev"
         
   else
      echo "uDev"

   fi
   
   # Independent of the activity before closing, it still closes in the end
      exit 0

elif [ $1 == "web" ]; then 
   # All options for web
   f_menu_internet_network_ip_options

elif [ $1 == "lib" ]; then 
   # Print with `ls` all the drya-lib file names

   if [ -z $2 ]; then 
      f_greet
      f_talk; echo "Info about libraries file at:"
              echo ' > ${v_REPOS_CENTER}/DRYa/all/lib/'
              echo
      f_talk; echo "Listing names:"

      ls -1 ${v_REPOS_CENTER}/DRYa/all/lib

              echo
      f_talk; echo "Listing how each can be installed"
              echo " > uDev"

   elif [ $2 == "4" ]; then 
      # Make drya-lib-4 available on current terminal and use it for some purpouse

      # Source lib 4
         v_greet="DRYa"
         v_talk="DRYa-lib-4: "
         source ${v_REPOS_CENTER}/DRYa/all/lib/drya-lib-4-dependencies-packages-git.sh

      f_greet

      f_talk; echo "uDev: Use drya-lib-4 to sync a file given as second arg"
              echo '      Or use `G s <file>` instead'
              echo

      if [ -z $3 ]; then 
         f_talk; echo "You can sync a file with github (pull, edit file, push again) if you provide a name as arg 3"

      else
         shift
         shift
         for i in $*; do
            echo "uDev: git pull $i repo"
            echo "edit $i"
            echo "uDev: git push $i repo"
         done
      fi
   fi
   
elif [ $1 == "copy" ]; then 
   #Using fzf to copy multiple files at ./ to ~/.config/h.h/drya/drya-clipboard"

   # uDev: Options to addd to `D copy`:
   #        > `Copy + to clip`: Add more items to clipboard (do not overwrite current clipboard items)
   #        > `Steath Copy`:    Call repo 'scratch-paper' if it does not exist, then paste all the items in the clioboard, then delete the repo again

   if [ -z $2 ]; then 
      # Se o arg $2 nao invocar `.` entao, a pesquisa inclui todas as subpastas

      v_files=$(ls -1F | fzf -m --prompt="DRYa: Copy to clipboard multiple: " --preview 'cat {}' --preview-window=right:40%)
      v_pwd=$(pwd)
 
      echo > $v_clip   # Variable already set on file: 'source-all-drya-files'

      if [[ -n $v_files ]]; then
         for i in $v_files
         do
            echo "$v_pwd/$i" >> $v_clip
         done
      fi

      # Verbose info: Show what was sent to .../drya-clipboard file
         f_talk; echo "Clipboard content: "
         cat $v_clip

   elif [ $2 == "." ]; then 
      # Se o arg $2 invocar `.` entao, a pesquisa exclui todas as subpastas

      less $v_clip
      read
      
      [[ -f $v_clip ]] && rm $v_clip && touch $v_clip

      v_files=$(find . -maxdepth 1 | fzf -m --prompt="DRYa: Copy to clipboard multiple: " --preview 'cat {}' --preview-window=right:40%)

      if [[ -n $v_files ]]; then

         for i in $v_files
         do
            [[ -f $i ]] && echo "file: $i" && echo "$(pwd)/$i" >> $v_clip 2>/dev/null
            [[ -d $i ]] && echo "dir:  $i" && echo "$(pwd)/$i" >> $v_clip 2>/dev/null

         done
      fi
   fi

elif [ $1 == "paste" ]; then 
   #Using fzf to paste multiple files from ~/.config/h.h/drya/drya-clipboard to ./"

   for i in $(cat $v_clip)
   do
      cp $i .
   done

elif [ $1 == "clip" ] || [ $1 == "clp" ]; then 
   f_talk; echo "Opcoes de clipboard (@DRYa + @host)"

   less $v_clip

   # uDev: integrar: 
   #       termux-clipboard-get
   #       termux-clipboard-set


   # uDev: integrar: 
   #     Copiar uma variável do WSL2 para o Windows
   #     mensagem="Texto vindo do Linux"
   #     echo "$mensagem" | clip.exe
   #     
   #     # Ler o clipboard do Windows e salvar numa variável no WSL2
   #     conteudo=$(powershell.exe -Command "Get-Clipboard")
   #     echo "Clipboard do Windows contém: $conteudo"
   #     

   # uDev: integrar: 
   #     echo "Olá Fedora Linux!" | xclip -selection clipboard
   #

   # uDev: 
   #        `D clp`      # Help on DRYa clipboard   
   #        `D clp c`    # Copy  (Drya clipboard)
   #        `D clp p`    # Paste (Drya clipboard)
   #        `D clp .`    # edit  (Drya clipboard)
   #
   #        `D clp m`    # Help on machine clipboard
   #        `D clp m c`  # Copy using machine clipboard
   #        `D clp m p`  # Paste using machine clipboard
   #

elif [ $1 == "line" ] || [ $1 == "linha" ] || [ $1 == "l" ]; then 
   # Partial File Reader: Para imprimir apenas a linha X de um documento
   # Exemplo: `D linha <opcao> <numero-da-linha> <nome-do-ficheiro>`

   # Save Arguments as variables
      v_1=$1
      v_2=$2
      v_3=$3
      v_4=$4
      v_5=$5
      v_6=$6
      v_7=$7
      v_8=$8
      v_9=$9

   f_partial_file_reader

# Alternativa (uDev)
#   echo "script: ${BASH_SOURCE[0]}"
#   echo $0
#   bash  ${v_REPOS_CENTER}/DRYa/all/bin/partial-file-reader.sh 

elif [ $1 == "dmsg" ]; then 
   # Read the log file to events (drya-messages)
   less $v_MSGS
   
elif [ $1 == "call" ]; then 
   # Opcoes para chamadas (usa `termux-telephony-call` da Termux:API)
   echo "uDev: Criar reencaminhamento de chamadas e tambem retirar esses reencaminhamentos"

elif [ $1 == "cmp" ] || [ $1 == "compare" ] || [ $1 == "comparar" ]; then 
   # Fornecendo dois nomes de ficheiros, informa se sao iguais ou tem diferencas

   # Se os argumentos $2 e $3 nao foram fornecidos, o programa termina
      if [[ -z "$2" || -z "$3" ]]; then
          echo "Uso: $0 <qualquer_coisa> <ficheiro1> <ficheiro2>"
          exit 1
      fi

   # Compara os ficheiros silenciosa (sem o output standard)
      if cmp -s "$2" "$3"; then
          f_talk; echo "Os ficheiros são iguais."
                  echo " > $2"
                  echo " > $3"
      else
          f_talk; echo "Os ficheiros são diferentes."
                  echo " > $2"
                  echo " > $3"
      fi

elif [ $1 == "hush" ]; then 
   # Ligar/Desligar o output verboso do Termux. 

   f_toggle_termux_hushlogin 

elif [ $1 == "zip" ] ; then 
   f_zip_unzip

elif [ $1 == "morse" ]; then 
   less ${v_REPOS_CENTER}/wikiD/all/morse-diagrams/morse-letters-diagram.txt

elif [ $1 == "emergencia" ] || [ $1 == "112" ] || [ $1 == "sbv" ]; then 
   echo "uDev: Escrever formula de 1.os Socorros"
   echo "      fichiro: .../var/suporte-basico-de-vida.txt"

elif [ $1 == "cv" ] || [ $1 == "curriculum" ] || [ $1 == "curriculum-vitae" ]; then 
   
   f_greet
   f_talk; echo "Repos com Curriculum-Vitae:"
           echo " > moedaz"
           echo " > Curriculum-Vitae"
           echo 
           echo "Moedaz: "
           echo " > guarda os ficheiros e apontamentos offline"
           echo " > Navegue para a pasta ´CV´com: \`V mo cv\`"
           echo " > Edite o ficheiro de apontamentos com: \`cv\`"
           echo 
           echo "Curriculum-Vitae: "
           echo " > Mostra o mais atualizado CV em Website"
           echo " > https://seivadarve.github.io/Curriculum-Vitae/"
           echo " > Navegue para a repo com: \`V cv\`"
           echo " > Visite website com: \`web cv\`"

elif [ $1 == "..." ]; then  
   # Editar manualmente o ficheiro de historico usado por DRYa durante os menus fzf
   # uDev: Remover linhas duplicadas

   vim $v_drya_fzf_menu_hist

elif [ $1 == ".." ]; then  
   # Se existir ficheiro de historico drya-fzf-menu, o utilizador pode:
   # `D ..`   repetir comandos desse ficheiro  
   #
   # `D .. s` salvar uma copia desse ficheiro de historico
   # `D .. S` substituir o ficheiro de historico original pela copia guardada desse ficheiro
   #          Isso permite ao utilizador navegar a vontade sem se importar com o ficheiro de historico (enquanto procura os menus certos) e depois restaurar para a versao anterior
   #          Assim o user consegue escolher como e quanto vai para o ficheiro de historico

   # Se o ficheiro que queremos manipular nao existir, abortar todo o script
      if [[ -f $v_drya_fzf_menu_hist ]]; then
         # Para quando o ficheiro existe
         echo "ficheiro existe" 1>/dev/null
         
      else
         # Para quando o ficheiro nao existe
         f_talk; echo "ficheiro de historico AINDA nao existe. Abs Path:"
                 echo "      > $v_drya_fzf_menu_hist"
         exit 1
      fi


   # Buscar os argumentos do prompt e manipular o ficheiro
      if [ -z $2 ]; then
         f__D_hist__recall_one_command

      elif [ $2 == "s" ]; then
         # Guardar copia do ficheiro de historico)
         cp $v_drya_fzf_menu_hist ${v_drya_fzf_menu_hist}.copia
         echo "DRYa: criada uma copia do ficheiro de historico dos menus fzf"

      elif [ $2 == "S" ]; then
         # Substituir o original pela copia
         [[ -f ${v_drya_fzf_menu_hist}.copia ]] \
            && cp ${v_drya_fzf_menu_hist}.copia $v_drya_fzf_menu_hist

         echo "DRYa: a copia do ficheiro de historico dos menus fzf foi APLICADO como original"

      elif [ $2 == "c" ]; then
         echo "DRYa: a visualizar o ficheiro de historico dos menus fzf"
         [[ -f ${v_drya_fzf_menu_hist}.copia ]] && vim ${v_drya_fzf_menu_hist}.copia || echo " > Nao existe ficheiro nenhum"

      fi

elif [[ $1 == "." ]] || [[ $1 == "+" ]] || [[ $1 == "d" ]] || [[ $1 == "D" ]]; then  
   # Open DRYa fzf Main Menu
   # uDev: If fzf is not installed, imediatly do it, no questions!

   f_drya_fzf_MM

elif [[ $1 == "," ]]; then  
   # Open DRYa fzf toolbox directly

   f_drya_fzf_MM_Toolbox

else 
   # When invalid arguments are given. (May also be used to debug functions)
   f_exec
fi
