#!/bin/bash 
# Title: DRYa (Don't Repeat Yourself app)
# Description: The central script that manages other scripts and repos. You may use this app in many ways. Specially as a toolbox
# Use: You can call an fzf main menu that, for each fx in it, there is an equivalent terminal command

# Name of current script, used on fzf menus. Helps when using 'fzf-boilerplate-1' from DRYa to create new menus already with the script name on it
   v_fzf_talk=DRYa

   __name__=drya.sh
   __repo__=${v_REPOS_CENTER}/DRYa






# uDev: Ao rever o codigo (na busca de bugs) adicionar `else` nos blocos de codigo `if` para nao dar espaco a comportamentos inesperados no codigo
# uDev: Criar um `elif` para todas as opcoes que usem a dependencia fzf (para usarem fresh install de OS). Tambem chamado 'failsafe'
# uDev: Addicionar xKill; adicionar OT: confirmar acessos aos tty

# uDev: Criar menus 'failsafe' semelhantes a este:
#
#   flunav: h: Arguments for home possibilities
#    1 | /data/data/com.termux/files/home
#    2 | /mnt/c"
#    3 | /mnt/c/Users/$(cmd.exe /C "echo %USERNAME%" | tr -d "\r")
#    4 | ~/Persistent/HOME/"
#    5 | termux-bridge-android"
#    6 | shared-HDD-home-partition"
#    7 | /data/data/com.termux/files/home/Repositories/




# Comments examples: 
   # Single comment example

   : '
     Multi comment example. Line 1
     Multi comment example. Line 2
   '






# Sourcing DRYa Lib 1: Color schemes
   v_lib1=${v_REPOS_CENTER}/DRYa/all/lib/libs/drya-lib-1-colors-greets.sh
   source $v_lib1 2>/dev/null || (read -s -n 1 -p "DRYa libs: $__name__: drya-lib-1 does not exist (error)" && echo )

   v_greet="DRYa"
   v_talk="DRYa: "

   # Examples: `db` (an fx to use during debug)
   #           f_greet, f_greet2, f_talk, f_done, f_anyK, f_Hline, f_horizlina, f_verticline, etc... [From the repo at: "https://github.com/SeivaDArve/DRYa.git"]



# Sourcing DRYa Lib 2: Creating temporary files for support on scripts
   v_lib2=${v_REPOS_CENTER}/DRYa/all/lib/libs/drya-lib-2-tmp-n-config-files.sh
   [[ -f $v_lib2 ]] && source $v_lib2 || (read -s -n 1 -p "DRYa: error: drya-lib-2 does not exist " && echo)

   # Examples: `f_create_tmp_file` (will give a $v_tmp with a new file with abs path)



# Sourcing DRYa Lib 4: Ensure package, updates, downloads, uploads
   v_lib4=${v_REPOS_CENTER}/DRYa/all/lib/libs/drya-lib-4-dependencies-packages-git.sh
   [[ -f $v_lib4 ]] && source $v_lib4 || (read -s -n 1 -p "DRYa: error: drya-lib-4 does not exist " && echo)

   # Examples: v_ensure="$v_df_repo" && f_lib4_download_compact && [edit some local file] && f_lib4_upload_compact 
   #           f_lib4_stroken




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
   # uDev: Use from drya-lib-4 instead. Make this just a copy like ezGIT

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

function f_install_drya__with_fzf {
   echo "uDev"
}

function f_install_drya__with_Select {
   # Install DRYa itself + dependencies + 1st + termux-setup-storage + termux-API

   f_greet

   f_talk; echo "uDev: Are you sure you want to install DRYa?"; 
           echo
           echo "If you want to install drya itself, 3 ways:"
           echo "  1. Download and run:  github.com/DRYa/ghost-in.sh"
           echo "  2. Git Clone and Run: github.com/DRYa; bash Drya/install.uninstall/install.sh"
           echo "  3. Git Clone and Run: github.com/DRYa; bash drya.sh install --me"
           echo 
           echo " ... uDev"
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

function f_output_drya_welcome_screen_msg_with_vimscript {
   # Repetir os comandos que criam a mensagem de apresentacao DRYa
   # (Esta sequencia de comandos ja existem em .../DRYa/all/dryaSRC

   # Ficheiro vimscript.vim (que vai servir de modelo para a proxima busca)
      v_scr=${v_REPOS_CENTER}/DRYa/all/etc/dot-files/vim/vimscript_1_*
      v_copy=~/.tmp/vimscript-1-copy.vim
   
   # Ficheiro que queremos depois pesquisar funcoes
      v_file=${v_REPOS_CENTER}/DRYa/all/dryaSRC
      v_out=~/.tmp/vimscript-1-output.txt
      rm $v_out 2>/dev/null  # Remove o ficheoiro temporario caso ja haja algum com esse nome

   # Ficheiro que tem apenas o cabecalho da drya-lib-1 para se concatenar ao ficheiro de output
      v_lib_1=${v_REPOS_CENTER}/DRYa/all/lib/libs/cat/cat-drya-lib-1-colors-greets.sh

   # Fazer uma copia desse script. Para que possamos alterar o contudo daquilo que buscamos
      mkdir -p ~/.tmp
      cp $v_scr $v_copy

   # Dentro da copia do ficheiro modelo (temporario), substituir o texto que pretendemos pesquisar
      # Nota: vai ser substituido $v_default pela var $v_busca. A variavel $v_default existe no vimscript modelo (o original)
      v_default="function f_busca_exemplo"
      v_busca="function f_drya_welcome_screen"
      v_fx=$(echo $v_busca | sed "s/function //g")  # Filtra e guarda o nome da fx sem o comando `function `

      sed -i "s/$v_default/$v_busca/g" $v_copy 

   cat $v_lib_1 >> $v_out
   
   # Agora que ja temos uma copia do vimscript personalizado, vamos usar em um ficheiro real
      #vim -Es -S $v_copy $v_file
       vim -Es -S $v_copy $v_file

   # Envia uma linha de codigo que mande executar a fx do documento (so pode serexecutado apos o vim executar)
      echo "$v_fx" >> $v_out

      bash $v_out
   
   # Para o proposito de apresentar/executar o welcome screen, no final de executado, sao apagados todos os ficheiros temporarios (Serve tambem para debug)
      #rm ~/.tmp/*
}


function f_clone_info {
   # Info given:
   # > Tell how to clone DRYa
   # > List Repositories (public and private)
   # > Automatically redirects Termux to github.com
   
   v_clone_drya='git clone https://github.com/SeivaDArve/DRYa.git ~/Repositories/DRYa'
   v_github_seiva='https://github.com/SeivaDArve?tab=repositories'

#  f_talk; echo   "Must specify a repository to clone"
#          echo
#          echo   " To list all public repositories"
#          echo   '  > `drya clone --list-public` or:'
#          echo   '    `drya clone p` or:'
#          echo   '    `D cln p`'
#          echo   
#          echo   " To list all private repositories"
#          echo   '  > `drya clone --list-private` or:'
#          echo   '    `drya clone P` or:'
#          echo   '    `D cln P`'
           echo
   f_talk; echo   "To clone DRYa:  "
           echo   "  > Command: $v_clone_drya" 
           echo   "  > QR code:"
           printf "$v_clone_drya" | curl -F-=\<- qrenco.de/
           echo
           echo
           echo
           echo
   f_talk; echo   "Visit github.com webpage (with all Seiva D'Arve Repositories):"
           echo   "  > Link: $v_github_seiva"
           echo   '  > uDev: add command: `D web github all`'
           echo   "  > QR code:"
           printf "$v_github_seiva" | curl -F-=\<- qrenco.de/
           echo

#  f_horizline
#  echo " Note: So far, drya can open this link only with Termux"
#  echo " > uDev: No other browser found"
#  echo

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
         v_git=https://github.com/SeivaDArve/scratch-paper.git
         #v_cwd="<custom-working-directory>"  # If this variable is set, then the repo will be cloned into that custom working directory
         #v_cwd=~/.tmp/scratch_paper
         #mkdir -p $v_cwd
         echo -e "cloning: scratch-paper \n > $v_git"
         git clone $v_git $v_cwd
      }

      function f_clone_patuscas {
         echo "cloning: patuscas"; git clone https://github.com/SeivaDArve/patuscas.git
      }

      function f_clone_typescript {
         echo "cloning: typescript"; git clone https://github.com/SeivaDArve/typescript-berg-house.git
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

      p | P | patuscas)
         f_clone_patuscas
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
         v_txt="Step 2: Choose a Machine name"; f_anyK
         echo

      # Path to the list of preset possible machine names
         v_list_of_machines="${v_REPOS_CENTER}/DRYa/all/etc/dot-files/git-github/list-machine-names.txt"

      # Creating fzf menu
         v_prompt="DRYa: Git: Qual é o nome que quer dar a maquina atual: "
         v_ask_for_another_name=" > Inserir outro nome manualmente..."

         v_mach=$( (echo "$v_ask_for_another_name"; cat $v_list_of_machines) | fzf --cycle --prompt "$v_prompt")
         
      # If user asked in the menu to insert a different name:
         if [[ $v_mach == "$v_ask_for_another_name" ]]; then
            f_talk; echo    "What other name do you want to add?"
                    echo    " > Exemplo: Seiva_Android_"
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
   # uDev: at least in this fx, fzf dependency should be tested

      f_greet
      fzf -h &>/dev/null 
      v_status=$?
      [[ $v_status == "1"   ]] && echo 'Aborting instalation of `git...` fzf is not installed' && exit 1 
      [[ $v_status == "127" ]] && echo 'Aborting instalation of `git...` fzf is not installed' && exit 1 

   # Atualizar historico fzf (inserir esta fx):
      echo "D ui d i git" >> $Lz4

   v_file=${v_REPOS_CENTER}/DRYa/all/etc/dot-files/git-github/.gitconfig 
   v_place=~

   f_greet

   f_talk; echo -n "Installing "
     f_c2; echo    ".gitconfig"
     f_rc; echo

   f_talk; echo    "STEP 1: "
           echo    " > Task | Copy .gitconfig"
           echo    " > From | .../DRYa/all/etc/dot-files/git-github/.gitconfig"
           echo    " > To   | ~/"
           echo
   f_talk; echo    "STEP 2: "
           echo    " > Change Machine name"
           echo    "   Insert <New name> or choose from default fzf list"
           echo

   f_hzl
   v_txt="Step 1: Install .gitconfig file" && f_anyK
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

   f_talk; echo "Installing "
     f_c3; echo " > .vimrc   (vim)"
     f_c3; echo " > init.vim (nvim)"
     f_rc; echo
   f_talk; echo "STEP 1: Copy .vimrc"
           echo " > File 1: .../DRYa/all/etc/dot-files/vim/.vimrc"
           echo " > To:     ~/"
           echo
   f_talk; echo "STEP 2: At ~/.vimrc replace global variable: dryaREPOS"
           echo " > from: \"let g:dryaREPOS = '<DRYa-variable-for-Repository-Center>' \" "
           echo " > to:   \"let g:dryaREPOS = '$v_v1' \" "
           echo
   f_talk; echo "STEP 3: Copy ~/.vimrc to ~/.config/nvim/init.vim"
           echo

   f_hzl

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
      echo


   # Start STEP 3
      # Copy ~/.vimrc to ~/.config/nvim/init.vim  (sending from `vim` to `nvim`)
      mkdir -p          ~/.config/nvim/
      cp       ~/.vimrc ~/.config/nvim/init.vim 

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

   v_satisfied="no"

   f_greet 
   f_talk; echo "Searching installed commands to provide Local IP..."
           echo


   function f_1 {
      # Tentativa 1: Obtendo o IP local usando  'ifconfig'

      f_talk; echo "Testing ifconfig"

      if $(command -v ifconfig &>/dev/null); then
         echo " > Command: is installed"
         v_ip=$(ifconfig 2>/dev/null | grep -w inet | grep -v 127.0.0.1 | awk '{print $2}')
         echo " > Ip:      $v_ip"
         echo
         v_satisfied="yes"

      else
         echo " > Command not installed (from package 'net-tools')"
         echo
      fi
   }

   function f_2 {
      # Tentativa 2: Obtendo o IP local usando hostname -I (funciona na maioria dos sistemas Linux)

      f_talk; echo "Testing hostname"

      if $(command -v hostname 1>/dev/null); then
         echo " > Command is installed"
         v_ip=$(hostname -I | awk '{print $1}')
         echo " > Ip:      $v_ip"
         echo
      else
         echo " > Command not installed"
         echo
      fi
   }

   f_1
   db
   [[ $v_satisfied == "no" ]] && echo "continue" && f_2
   db

      # Tentativa 3: 
         # Obtendo o IP local usando 'ip'
         if $(command -v ip &>/dev/null); then
            echo " > 3. Command 'ip' is installed"
            #LOCAL_IP_3=$(ip addr show | grep "inet\b" | grep -v 127.0.0.1 | awk '{print $2}' | cut -d/ -f1)
         else
            echo " > 3. Command 'ip' not installed"
         fi
         echo
        

      # Defining final variable
         ( [[ -n $LOCAL_IP_1 ]] && LOCAL_IP=$LOCAL_IP_1 )  || \
         ( [[ -n $LOCAL_IP_3 ]] && LOCAL_IP=$LOCAL_IP_2 )  || \
         ( [[ -n $LOCAL_IP_3 ]] && LOCAL_IP=$LOCAL_IP_3 )  || \
         echo "No command could find Local IP: 'ifconfig', 'hostname', 'ip'" 

   echo

   # uDev: Se todos falharem, perguntar se quer experimentar fazer download de algum pacote e tentar novamente

   # Obtendo o IP público usando curl e um serviço online
      f_talk; echo "Searching the web to provide Public IP"
              echo " 1. http://ifconfig.me"
      PUBLIC_IP=$(curl -s ifconfig.me)  # Alternativa: `curl ifconfig.co`
      echo " > $PUBLIC_IP"
      echo

   # Send last IP numbers to ssms
      echo "Sending to ssms"
      echo
   # Clear the screen
      v_secs=3
      f_talk; echo "Clearing the screen in ${v_secs} seconds..."
      read -sn1 # -t $v_secs
      f_greet


   # Imprimindo os resultados
      echo "IP Público: $PUBLIC_IP"
      echo "IP Local:   $LOCAL_IP"

   # Testar se existe algum comando `ifconfig` que se instala com o pacote 'net-tools'
}

function f_menu_internet_network_ip_options {
   # uDev: criar fx para verificar se existem novos bookmark no browser

   # Lista de opcoes para o menu `fzf`
      Lz1='Save '; Lz2='D ip'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      L6='6. Print  | javascript tricks (for browser console)'
      L5='5. Menu   | `web` (navegar na internet)'

      L4='4. Ver    | User info (saved @host system)'
      L3='3. Assign | New random IP'                                      
      L2='2. Ver    | IP publico e local'                                      
   
      L1='1. Cancel'

      L0="SELECIONE 1 do menu (exemplo): "
      
      v_list=$(echo -e "$L1 \n\n$L2 \n$L3 \n$L4 \n\n$L5 \n$L6 \n\n$Lz3" | fzf --cycle --prompt="$L0")

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3  ]] && echo -e "Acede ao historico com \`D ..\` e encontra: \n > $Lz2"
      [[ $v_list =~ "6. " ]] && echo "uDev: copiar/scrape do wikiD.org para aqui"
      [[ $v_list =~ "5. " ]] && bash ${v_REPOS_CENTER}/DRYa/all/bin/web.sh
      [[ $v_list =~ "4. " ]] && echo "uDev: Ver palavras pass guardadas no sistema"
      [[ $v_list =~ "3. " ]] && f_greet && f_list_ip_public_n_local && echo && bash ${v_REPOS_CENTER}/DRYa/all/bin/generate-new-random-ip.sh && f_list_ip_public_n_local
      [[ $v_list =~ "2. " ]] && f_list_ip_public_n_local
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
      [[ $v_list =~ $Lz3  ]] && echo -e "Acede ao historico com \`D ..\` e encontra: \n > $Lz2"
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

      L6='6. |   | Print Info (uDev): Website valido para criar QR codes'

      L5='5. |   | 1: "Abrir Android Camera"  2: "Ler QR"  3: "Save on clipboard"'
         
      L4='4. |   | Criar QR code | Apartir de 1 linha de 1 ficheiro'
      L3='3. |   | Criar QR code | Apartir de ficheiro inteiro'
      L2='2. |   | Criar QR code | Apartir de texto `curl`'

      L1='1. Cancel'

      L0="DRYa: QR code Menu: "
      
      v_list=$(echo -e "$L1 \n\n$L2 \n$L3 \n$L4 \n\n$L5 \n\n$L6 \n\n$Lz3" | fzf --cycle --prompt="$L0")

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3  ]] && echo -e "Acede ao historico com \`D ..\` e encontra: \n > $Lz2"
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
           echo " > A failback system:"
           echo "   It has dependencies, but if they do not exist,"
           echo "   it can still run."
           echo "   Can be used fully featured, but if the system"
           echo "   does not have the features, then there are"
           echo "   functions to recall and re-install all features"
           echo "   again."
           echo 
           echo "   If enough commits are done, in one command"
           echo "   It can put Arch linux (as an example)"
           echo "   fully running, fully featured, fully configured"
           echo "   after a fresh Installation of the OS on de HDD"
           echo "   (at the taste of the user, for example D'Arve,"
           echo "   the first developer)"
           echo
           echo " > It is not installed on /bin"
           echo "   the user can run DRYa on any computer without"
           echo "   asking for admin priviledges"
           echo "   (It is s software for the current user)"
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
           echo " > Example on repetitive task:"
           echo '   1. `om` is an alias on ~/.bashrc that runs'
           echo '      `alias om="bash ~/scripts/omni-script.sh`'
           echo '      It has to be installed there for bash and'
           echo '      the script has to be downloaded'
           echo '   2. If both do not exist, then we can use'
           echo '      `drya.sh` (alias `D`) to store `om` function'
           echo '      now we can run `D om` and DRYa will'
           echo '      FIRST verify the existence of "om" repository'
           echo '      and if it does not exist, it is downloaded,'
           echo '      installed and configured, so that, next time'
           echo '      `om` alone as arguent $0 can be used'
           echo '   3. DRYa ensured the existence and configuration'
           echo '      of `om` software'
           echo '   4. Supose now that we installed a new fresh OS'
           echo '      on the HDD, DRYa will detect the current OS'
           echo '      and download and configure properly'
           echo
           echo ' '
           echo ' > Problems solved by DRYa:'
           echo '   Avoids unwanted/forced updates'
           echo '   Re-creates and connects most needed Play Store apps'
           echo '   Entirely open source'
           echo '   It will be totally encripted in the future (for the sake of the user)'
           echo '   "One script to rule them all" (any device, any network, anywhere)'
           echo '   '
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


            #            mo *
            #            |  -m *
            #            |  |  A
            #            |  |  U
            #            |  +  <ID>
            #            |  |  qr
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

function f_install_presets {
   Lz='`D ui pr`'

   L2="2. Quick Install | upk + upkd + dependencies "
   L1="1. Cancel "

   L0="DRYa: presets menu: "

   v_list=$(echo -e "$L1 \n$L2 \n\n$Lz" | fzf --cycle --pointer=">" -m --prompt="$L0")

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ "$Lz" ]] && echo "$Lz" 
      [[ $v_list =~ "2. " ]] && f_quick_install_all_upk
      [[ $v_list =~ "1. " ]] && echo "Canceled: $Lz"
      unset v_list

}

function f_menu_edit_centralized_then_install {
   # Menu to edit centralized files and then, ask the user if he wants to install

   # Lista de opcoes para o menu `fzf`
      Lz1='Saved '; Lz2='edit-centralized-then-install'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      L2='2. Edit/Install .init.el (emacs) | `S 2`'                                      
      L1='1. Cancel'

      L0="SELECT 1: Menu X: "
      
   # Ordem de Saida das opcoes durante run-time
      v_list=$(echo -e "$L1 \n$L2 \n\n$Lz3" | fzf --no-info --pointer=">" --cycle --header="$Lh" --prompt="$L0")

   # Atualizar historico fzf automaticamente (deste menu)
      echo "$Lz2" >> $Lz4
   
   # Atuar de acordo com as instrucoes introduzidas pelo utilizador
      [[    $v_list =~ $Lz3  ]] && echo -e "Acede ao historico com \`D ..\` e encontra: \n > $Lz2"
      [[    $v_list =~ "2. " ]] && bash ${v_REPOS_CENTER}/DRYa/all/boot/fluNav.sh 2
      [[    $v_list =~ "1. " ]] && echo "Canceled" 
      unset  v_list

}

function f_menu_install_dot_files {
   Lz='`D dot install`'

   # uDev: Redefinir browser pre-definido
   #       Endereco MAC (traitsID)
   #       Terminal best font
   #       Install: font: Monospace (best for terminal)
   
   #L10="10. stroken"     # It is part of .netrc         
   #L10="10. .drya.node.rc

   #L10="10. Install termux widgets (from .../bin/termux-widgets)
   #L10="10. .hushlogin"  # Se este ficheiro existir, o termux nao cria welcom screen

    L12="12. | termux  | termux.properties + colors.termux"
    L11='11. | emacs   | .emacs.d/'  # uDev: remove from flunav `S 2`
    L10="10. | tmux    | .tmux.conf"
     L9="9.  | bash    | .bash_logout"
     L8="8.  | git     | .gitconfig "
     L7="7.  | git     | .netrc "
     L6="6.  | vim     | .vimrc "
     L5="5.  | DRYa    | .dryarc "
    #L0="1.  | .bashrc (redundante, ja existe)
    #L0="1.  | .logout (logout-all-drya-file)

     L4="4.  | Install | PRESETS" # uDev: Presets tem de passar para a fx f_dot_files_menu
     L3="3.  | Install | ALL "    # uDev: esta opc tem de passar para --invert-selection--

     L2='2.  -- Invert-Selection --'
     L1="1.  Cancel "

   L0="DRYa: dot-files install menu: "

   v_list=$(echo -e "$L1 \n$L2 \n\n$L3 \n$L4 \n\n$L5 \n$L6 \n$L7 \n$L8 \n$L9 \n$L10 \n$L11 \n$L12 \n\n$Lz" | fzf --cycle --pointer=">" -m --prompt="$L0")

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
      [[ $v_list =~ "4.  " ]] && f_install_presets
      [[ $v_list =~ "3.  " ]] && f_dot_files_install_vimrc && f_dot_files_install_git && f_dotFiles_install_termux_properties && f_dotFiles_install_dryarc && f_dot_files_install_netrc
      [[ $v_list =~ "2.  " ]] && echo "uDev"
      [[ $v_list =~ "1.  " ]] && echo "Canceled: $Lz"
      unset v_list
}

function f_dot_files_menu_edit_host_files_termux_properties {
   # Mangage ./termux @Host (at the machine, not at the repo)

   # Lista de opcoes para o menu `fzf`
      Lz1='Save '; Lz2='uDev'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      L7='7. Reload     | termux-reload-settings'
      L6='6. Toggle     | .hushlogin termux verbose output at terminal startup'
      L5='5. Toggle     | (uDev) termux Extra Keys On/Off'
      L4='4. Toggle     | (uDev) termux.properties volume keys'
      L3='3. Edit       | termux.properties file'
      L2='2. Manipulate | (uDev) Termux Properties as menu'
      L1='1. Cancel'

      L0="DRYa: vlm: Edit termux files @Host: "
      
      v_list=$(echo -e "$L1 \n$L2 \n$L3 \n$L4 \n$L5 \n$L6 \n$L7 \n\n$Lz3" | fzf --cycle --prompt="$L0")

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3  ]] && echo -e "Acede ao historico com \`D ..\` e encontra: \n > $Lz2"
      [[ $v_list =~ "7. " ]] && termux-reload-settings
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

      L2='2. Menu | Termux @Host'                                      
      L1='1. Cancel'

      L0="DRYa: Edit @Host files: "
      
      v_list=$(echo -e "$L1 \n$L2 \n\n$Lz3" | fzf --cycle --prompt="$L0")

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3  ]] && echo -e "Acede ao historico com \`D ..\` e encontra: \n > $Lz2"
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

      L8='8. Menu | Factory Reset '  # uDev: When setting factory reset, leave a file to clone drya ENTIRELY
      L7='7. Menu | Backups | `D ui bk`'

      L6='6. Edit | Installed   files (only @Host) |'
      L5='5. Edit | Centralized files (only @DRYa) |'
      L4='4. Edit | Centralized  > then >  Install |'

     #L3="3. Menu | Uninstall PRESETS | 
     #L3="3. Menu | Install   PRESETS | 

     #L3="3. Menu | Uninstall         | $L3b" # Variable L3b may be set and may be empty to give more info to the user
      L3="3. Menu | Install           | $L3b" # Variable L3b may be set and may be empty to give more info to the user
      L2='2. List | Available         |'      # uDev: Test if centralized DRYa dot-files were modified and are available to replace old ones at the current system
      L1='1. Cancel'

      L0="DRYa: dot-files menu: "

      v_list=$(echo -e "$L1 \n$L2 \n$L3 \n\n$L4 \n$L5 \n$L6 \n\n$L7 \n$L8 \n\n$Lz3" | fzf --no-info --cycle --prompt="$L0")

   # Atualizar historico fzf automaticamente
      echo "$Lz2" >> $Lz4

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3  ]] && echo -e "Acede ao historico com \`D ..\` e encontra: \n > $Lz2"
      [[ $v_list =~ "8. " ]] && f_ghost
      [[ $v_list =~ "7. " ]] && f_backup_helper
      [[ $v_list =~ "6. " ]] && f_dot_files_menu_edit_host_files
      [[ $v_list =~ "5. " ]] && echo uDev 
      [[ $v_list =~ "4. " ]] && f_menu_edit_centralized_then_install
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
         # L12='12. gerir `lsblk`, `fstab`, `journalctl`, flags das particoes no GParted
         # L13= ANSI converter: https://dom111.github.io/image-to-ansi/
         # L13= Adicionar software como JSplit que parte ficheiros grandes em ficheiros mais pequenos
         
         L22='22. Menu   |  pid  | Kill process by PID (process ID)'
         L21='21. Menu   |  gpg  | gnu-privacy-guard (encrypt and decript files)'
         L20='20. Menu   |  zip  | zip unzip'
         L19='19. Script |  `d`  | Datas (menu)'
         L18='18. Script |   -   | Youtube download (with `yt-dlp`)'
         L17='17. Menu   |  cln  | Clone Repositories (github)'
         L16='16. Menu   | mt-ls | Metadata management'
         L15='15. Menu   |  ip   | Internet / Network / IP'
         L14='14. Script |  ssh  | sshfs-wrapper'
         L13='13. Menu   |  plr  | Audio (Media Player + Voice Recorder)'  
         L12='12. Print  |       | `curl` tricks: Previsao do Tempo'  # uDev: Adicionar fase da lua 
         L11='11. Print  |       | `curl` tricks: Online man pages'  
         L10='10. Print  | morse | morse code diagram'    # Link: https://www.instagram.com/reel/DEmApyMtMn7/?igsh=MTJqbjl6dWMxd2F1dg==
          L9='9.  Menu   |  no   | no-tes '
          L8='8.  Script | wpwd  | Convert `pwd` from Win to Linux'
          L7="7.  Script |   -   | xKill + tty + PID (info)" # Ensinar como abrir diferentes tty e como usar o xKill, tambem como fechar processos teimosos
          L6="6.  Script | noty  | notify"
          L5="5.  Menu   |  qr   | QR code"
          L4="4.  Menu   |  clc  | calculos/calculadoras"
          L3="3.  Menu   | ui  d | dot-files"
          L2='2.  Script | `. .` | fluNav'

          L1="1.  Cancel" 

         L0="DRYA: toolbox fx List: " 

         v_list=$(echo -e "$L1 \n\n$L2 \n$L3 \n$L4 \n$L5 \n$L6 \n$L7 \n$L8 \n$L9 \n$L10 \n$L11 \n$L12 \n$L13 \n$L14 \n$L15 \n$L16 \n$L17 \n$L18 \n$L19 \n$L20 \n$L21 \n$L22 \n\n$Lv" | fzf --no-info --cycle --prompt="$L0")

      # Perceber qual foi a escolha da lista
         [[   $v_list =~ "V. " ]] && [[ $v_list =~ "[X]" ]] && Lv="$Lvx" && f_loop
         [[   $v_list =~ "V. " ]] && [[ $v_list =~ "[ ]" ]] && Lv="$LvX" && f_loop

         [[   $v_list =~ "22. " ]] && f_kill_process_by_PID
         [[   $v_list =~ "21. " ]] && bash ${v_REPOS_CENTER}/DRYa/all/bin/drya-GnuPG.sh
         [[   $v_list =~ "20. " ]] && f_zip_unzip
         [[   $v_list =~ "19. " ]] && bash ${v_REPOS_CENTER}/DRYa/all/bin/data.sh .
         [[   $v_list =~ "18. " ]] && read -p 'Enter youtube link to download: ' v_ans && yt-dlp $v_ans
         [[   $v_list =~ "17. " ]] && echo "uDev"
         [[   $v_list =~ "16. " ]] && echo "uDev"
         [[   $v_list =~ "15. " ]] && f_menu_internet_network_ip_options
         [[   $v_list =~ "14. " ]] && bash ${v_REPOS_CENTER}/DRYa/all/bin/sshfs-wrapper.sh 
         [[   $v_list =~ "13. " ]] && f_menu_audio_media_player
         [[   $v_list =~ "12. " ]] && f_greet && f_talk && echo "Previsao do Tempo" && curl wttr.in 
         [[   $v_list =~ "11. " ]] && f_greet && f_talk && read -p "Ask for a man page (curl will get it): " v_ans && curl cheat.sh/$v_ans
         [[   $v_list =~ "10. " ]] && f_morse
         [[   $v_list =~ "9.  " ]] && bash ${v_REPOS_CENTER}/DRYa/all/bin/no-tes.sh 
         [[   $v_list =~ "8.  " ]] && f_win_to_linux_pwd
         [[   $v_list =~ "7.  " ]] && f_menu_kill_running_process 
         [[   $v_list =~ "6.  " ]] && bash ${v_REPOS_CENTER}/DRYa/all/bin/notify.sh
         [[   $v_list =~ "5.  " ]] && f_QR_code_fzf_menu

         [[   $v_list =~ "4.  " ]] && [[ $Lv =~ "[ ]" ]] && bash ${v_REPOS_CENTER}/DRYa/all/bin/ca-lculadoras.sh 
         [[   $v_list =~ "4.  " ]] && [[ $Lv =~ "[X]" ]] && bash ${v_REPOS_CENTER}/DRYa/all/bin/ca-lculadoras.sh h

         [[   $v_list =~ "3.  " ]] && f_dot_files_menu
         [[   $v_list =~ "2.  " ]] && echo "uDev"
         [[   $v_list =~ "1.  " ]] && echo "Canceled"
         unset v_list

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
      #Lz1='Saving '; Lz2='D .'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist
      Lz1='Menu Shortcut: '; Lz2='D .'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist; Lz5="Comandos alternativos ao comando \`$Lz2\`: \n > nil"

      L4="4. | Help Menu";                    L4c="drya help"
      L3="3. | DRYa: Greet & Present itself"; L3c="D p"
      L2="2. | Toolbox"

      L1="1. Cancel" 

      L0='DRYa: Main Menu: '

      Lm1=$(f_talk)
      Lm2="Info about last Menu:\n > Usa \`$Lz2\`"
      Lm3=" (ultimo 'Shortcut' para aceder ao ultimo menu visitado)"
      Lm4=" > Usa \`D ..\` para Aceder a todos os historicos"
      Lm5=" > Usa \`ssms\` para Ver atalhos alternativos a \`$Lz2\`" 
      Lm0="${Lm1}$Lm2 \n  $Lm3 \n\n$Lm4 \n$Lm5 \n$Lm1"

      #Lm1="Info about last Menu:\n > Usa \`$Lz2\` \n   (ultimo 'Shortcut' para aceder ao ultimo menu visitado) \n\n > Usa \`D ..\` para Aceder a todos os historicos\n > Usa \`ssms\` para Ver atalhos alternativos a \`$Lz2\`" && echo -e "$Lz5" >> $v_ssms

      v_list=$(echo -e "$L1 \n\n$L2 \n$L3 \n$L4 \n\n$Lz3" | fzf --no-info --cycle --prompt="$L0")

   # Atualizar historico fzf automaticamente
      echo "$Lz2" >> $Lz4

   # Perceber qual foi a escolha da lista
     #[[ $v_list =~ $Lz3  ]] && echo -e "Acede ao historico com \`D ..\` e encontra: \n > $Lz2"
     #[[ $v_list =~ $Lz3  ]] && echo -e "Acede ao historico com \`D ..\` e encontra: \n > $Lz2" && echo -e "$Lz5" >> $v_ssms
      [[ $v_list =~ $Lz3  ]] && echo -e "$Lm0" && echo -e "$Lz5" >> $v_ssms
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
      Lz1='Shortcut '; Lz2='D h'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      # uDev: Emergency tem de ser um menu a parte, para poder crescer em tamanho sem distacoes
     L10='10. Emergency help: Extintores (instrucoes de uso)'
      L9='9.  Emergency help: SBV (Suporte Basico de Vida)'
      L8='8.  Emergency help: Arco-Iris (esquema de cores)'

      L7='7.  About: drya-fast-tg-sys-vars (see README.md)'  
      L6='6.  About: Developer (seiva-up-time)'
      L5='5.  About: DRYa extentions (ezGIT, trid, jarve, ...)'  
      L4='4.  Read drya-msgs'  
      L3='3.  Welcome Screen'
      L2='2.  Print All' 
      L1='1.  Cancel'

      L0="$v_fzf_talk: Help Menu: "
      
      v_list=$(echo -e "$L1 \n$L2 \n$L3 \n$L4 \n$L5 \n$L6 \n$L7 \n\n$L8 \n$L9 \n$L10 \n\n$Lz3" | fzf --cycle --prompt="$L0")

   # Atualizar historico fzf automaticamente
      echo "$Lz2" >> $Lz4

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3   ]] && echo -e "Acede ao historico com \`D ..\` e encontra: \n > $Lz2"
      [[ $v_list =~ "10. " ]] && f_visitar_extintores
      [[ $v_list =~ "9.  " ]] && f_visitar_sbv 
      [[ $v_list =~ "8.  " ]] && echo "uDev"
      [[ $v_list =~ "7.  " ]] && echo "uDev"
      [[ $v_list =~ "6.  " ]] && f_seiva_up_time
      [[ $v_list =~ "5.  " ]] && echo "uDev"
      [[ $v_list =~ "4.  " ]] && less $v_MSGS
      [[ $v_list =~ "3.  " ]] && f_output_drya_welcome_screen_msg_with_vimscript
      [[ $v_list =~ "2.  " ]] && f_drya_help
      [[ $v_list =~ "1.  " ]] && echo "Canceled: $Lz2" 
      unset v_list
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
   
   # Variable for the file names
      # Original file name (this var was created at dryaSRC)
      v_original=$v_drya_fzf_menu_hist

      # Temporary file name
      v_temporary=${v_original}.tmp

   # Apagar as linhas em branco do ficheiro original
      sed -i '/^$/d' $v_original

   # Contar numero de linhas existentes no documento. Sera criado um `for` loop que vai repetir esse mesmo numero de vezes
      v_nr_lines=$(wc -l $v_original | cut -f 1 -d " ")  # O comando `wc -l` tem dois Outputs na mesma linha: o numero correspondente a contagem de linhas e tambem o nome do ficheiro, por isso, usamos o `cut` para filtrar apenas a parte do numero

   # Se o ficheiro tiver zero linhas: exit
      [[ $v_nr_lines == "0" ]] && echo "DRYa: fzf history file: file has no written lines to recall" && exit 1

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

         # Saving last command status 
            v_status=$?  

         # Se o ultimo comando falhar, vai dar o codigo de erro de "1" que o bash guarda na variavel `$?` e se der erro, ainda nao existe essa linha la no ficheiro temporario e sera para la enviada essa linha
            [[ $v_status == 1 ]] && echo $v_line >> $v_temporary
      done

   # Overwrite original file with the content of temporary file
      tac $v_temporary > $v_original                    # Mater TODAS as linhas
   
   # Variable $v_max_lines was already set before (to cut excessive lines, avoiding creating huge files)
      tail -n $v_max_lines $v_original  > $v_temporary  # Manter apenas as ultimas $v_max_lines do documento, eliminando todas as outras a mais
      cat                  $v_temporary > $v_original   # O ficheiro com apenas X linhas passa a ser o ficheiro original

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
      v_line=$(tac $v_drya_fzf_menu_hist | fzf --cycle --prompt "DRYa: Choose a command to repeat (menu fzf history): ")

   # Dessa linha que foi buscada, antes de tentar executar `eval` vamos substituir todos os "comandos" pelos "caminhos absolutos" (para nao dar erro)
      v_line=$(sed    "s#^D #${v_REPOS_CENTER}/DRYa/drya.sh #g" <(echo $v_line))
      v_line=$(sed "s#^drya #${v_REPOS_CENTER}/DRYa/drya.sh #g" <(echo $v_line))

      v_line=$(sed "s#^3sab #${v_REPOS_CENTER}/3-sticks-alpha-bravo/3-sticks-AB.sh #g" <(echo $v_line))

      v_line=$(sed "s#^P #${v_REPOS_CENTER}/patuscas/patuscas.sh #g" <(echo $v_line))

   # Se tiverem sido filtrados os comandos todos e substituidos pelos seus caminhos absolutos, entao podemos executar diretamente
      [[ -n $v_line ]] && bash $v_line 
}

function f_clone_selected_from_list_no_invertion {
   # Clonar exatamente as repos que o user escolheu

   cd ${v_REPOS_CENTER}/ 

   f_talk; echo "Lista de Repos que vai ser clonada:"
   for i in $v_multiple
   do
      echo " > $i"
   done

   echo
   v_txt="Iniciar os downloads"; f_anyK
   echo

   for i in $v_multiple
   do
      f_talk; echo "A clonar o Repositorio:"
      echo " > $i"
      git clone https://github.com/SeivaDArve/$i.git
      echo
   done
}

function f_clone_selected_from_list_with_invertion {
   # Clonar exatamente as repos oposta ao que o user escolheu. O user escolheu clonar todas repos excepto as que selecionou

   # Retirar o texto "---Invert-Selection---" da variavel 
      v_multiple=$(sed 's/---Invert-Selection---//g' <(echo $v_multiple))

   f_talk; echo "Clonar todas, excepto: "
   for i in $v_multiple
   do
      echo " > $i"

      # Quando o comando anterior é executado com sucesso, informa drya-messages
         #[[ $? == 0 ]] && echo -e "DRYa: repo $i clonada com sucesso" >> $drya-status-messages  
   done
}

function f_drya_get_all_repo_names_private_public {

   # Juntar a lista de repos publicas + privadas
      v_list_public=$(curl -s "https://api.github.com/users/SeivadArve/repos?per_page=100" | grep '"html_url"' | cut -d '"' -f 4 | grep -v "https://github.com/SeivaDArve$" | sed 's#https://github.com/SeivaDArve/##g')
      v_list_options="---Invert-Selection---"
      v_list_private="dv-cv-private moedaz omni-log luxam scratch-paper upK-diario-Dv wikiD 3-sticks-alpha-bravo verbose-lines one-file-bau dandarez dWiki Tesoro dial-mono yoga-bash-app-private autoPay Dv-Indratena"

      # will give a $v_tmp with a new file with abs path
         f_create_tmp_file  # Vai criar o ficheiro $v_tmp

      # Juntar todos os textos
         echo "$v_list_options" >  $v_tmp
         for i in $v_list_private
         do
            echo $i >> $v_tmp
         done

         echo "$v_list_public"  >> $v_tmp

      # Get the new file created
         #echo "$v_combine" > $v_tmp

      # Novo resultado em nova var
         #cat $v_tmp > $v_combine
         #rm  $v_tmp
}

function f_zip_unzip {
   echo "uDev: Menu com opcoes zip/unzip"

   # uDev: aprender bruteforce para unzip: https://www.instagram.com/reel/DJfFjNpuvwW/?igsh=YTA3eDVuYTc2cmFt
   #                                       https://www.instagram.com/reel/DHzW9hboyfH/?igsh=dWgyMnRnZWE4bGJo
}


function f_backup_helper {

      # uDev: at DRYa/all/bin/.../3-steps-formater a script will be available to make such backups and prepare format
      # Pode ser usado o SyncThing
      f_greet 
      f_talk; echo "Ajuda na execucao de Backups"
              echo 
      f_talk; echo "Lista uDev:"
              echo " > Send files from one device to another device using the web (FTP, ssh)"
              echo "   Smartphone > Raspberry Pi (cloud) > External HDD"
              echo " > DRYa will suggest specific files to backup"
              echo " > criar um dir, nesse dir, guarda certos dot-files atualmente na maquina"
              #echo "uDev: criar .dotfile que guarde uma lista de enderecos de pastas que um dia podem precisar serv revistos (para backup)"
              #echo "      exemplo: Pasta com printscreen de recidos de pagamentos online. Pode estar guardado na pasta X, mas DRYa relembra no .dotfile que a pasta X pode ser importante para backup"
              echo
      f_talk; echo "Backup Checklist (Smartphone):"
              echo " > Contacts"
              echo " > Gmail accounts and passwords"
              echo " > Social media login credentials"
              echo " > Snapshot all installed apps (\`cmd package list packages\` to dump list)"
              echo " > Browser bookmarks"
              echo " > Update all Repositories from termux to github"
              echo " > All SD CARD and Internal Storage content"
              echo " > Confirmar primeiro os dados de acesso ao email de recuperacao de conta (email secundario do google), so depois reset a conta principal (email principal do google)"
              echo " > Current wallpaper (principal, de bloqueio)"
              echo " > Alarm custom music"
              echo " > Dados de aplicacoes (notas, etc)"
              echo
      f_talk; echo "Backup Checklist (computer):"
              echo " > ..."
              echo
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


function f_clone_by_fzf_list {
   # Open fzf to help clone repos by the correct name

   # uDev: `D cln . inv` para inverter a selecao (Clonar todas as repos excepto as que forem selecioadas)
   # uDev: `D cln . p`
   # uDev: `D cln . P`

   # uDev: Quando aparece a lista de repos para clonar, podemos logo testar se existem ou nao:
   #       Exemplo:
   #        > [X] dv-cv-private
   #        > [ ] dv-cv-private

   f_greet

   f_talk; echo "Cloning menu (fzf to clone Repositories)"
           echo " > Listing all public repos (by web search)"
           echo " > Listing private repos    (from offline file)"
           echo
           echo " ... a buscar repos publicas (diretamente da web)"
           echo

   # Combinar em 1 ficheiro: todas as repos publicas + privadas para usar no fzf
      f_drya_get_all_repo_names_private_public

   # Perguntar ao user quais repos quer
      L0="DRYa: cln: Public + Private Repos (to clone/install): "
      Lh=$(echo -e "\nPara apagar texto introduzido da busca:\n  CTRL-U\n ")
      v_multiple=$(cat $v_tmp | fzf --cycle --header="$Lh" --pointer=">" -m --prompt="$L0")


   if [[ -n $v_multiple ]]; then
      # Se o utilizador selecionou nem se seja uma repo, executar:

      if [[ $v_multiple =~ "---Invert-Selection---" ]]; then
         #echo "inversao detetada"
         f_clone_selected_from_list_with_invertion
      else
         #echo "inversao nao detetada"
         f_clone_selected_from_list_no_invertion
      fi

   else
      # Se o utilizador nao selecionou nem sequer uma repo
      f_talk; echo "Nenhum repo selecionado"
   fi

   #[[ $v_multiple =~ "dv-cv-public" ]] && grep "dv-cv-public" <(echo $v_multiple) && [[ $? == "1" ]] && echo "Nao Quer clonar tambem 'dv-cv-private' que se comunica com 'dv-cv-public'?"
}

function f_clone_by_attempted_name {
   # To clone repos when we are not exactly sure how it's name is written 
   #                when shortcuts were not already set or predictrd

   if [ -z $v_arg3 ]; then
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
         f_talk; echo -e "DRYa: Trying to clone: $v_arg3 \n"; 

      # Save current PWD + Navigate to Repos Center + Call f_stroken
         f_init_clone_repos 

      # Actually try to clone
         git clone https://github.com/SeivaDArve/$v_arg3.git
   fi
}

function f_clone_by_inserting_correct_name {
   # Clone pre-defined repositories, without menu fzf, when the user remembers the correct name

   # Save current PWD + Navigate to Repos Center + Call f_stroken
      f_init_clone_repos 

   # Actually clone known repos. (In case repo is not recognized, it is also mentioned)
      f_clone_repos 
}


function f_morse {
   # uDev: trazer pelo menos este ficheiro para .../all/var/ por motivos de emergencia
   less ${v_REPOS_CENTER}/wikiD/all/morse-diagrams/morse-letters-diagram.txt
}



function f_clone_main_menu {
   # Main menu para clonar repositorios do github (de SeivaDArve)

   # Lista de opcoes para o menu `fzf`
      Lz1='Saving '; Lz2='D clone'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      L4='4. Visit github.com (default browser) (uDev)'
      L3='3. Clone by fzf menu        | `D cln .`'                                      
      L2='2. Help (how to clone DRYa) | `D cln h`'                                      
      L1='1. Cancel'

      L0="DRYa: Clone Menu: "
      
   # Ordem de Saida das opcoes durante run-time
      v_list=$(echo -e "$L1 \n$L2 \n$L3 \n$L4\n\n$Lz3" | fzf --no-info --pointer=">" --cycle --prompt="$L0")

   # Atualizar historico fzf automaticamente (deste menu)
      echo "$Lz2" >> $Lz4
   
   # Atuar de acordo com as instrucoes introduzidas pelo utilizador
      [[ $v_list =~ $Lz3  ]] && echo -e "Acede ao historico com \`D ..\` e encontra: \n > $Lz2"
      [[ $v_list =~ "4. " ]] && echo uDev
      [[ $v_list =~ "3. " ]] && f_clone_by_fzf_list
      [[ $v_list =~ "2. " ]] && f_clone_info
      [[ $v_list =~ "1. " ]] && echo "Canceled" 
      unset v_list
}



function f_menu_install_drya_dependencies__1st {
   # Menu para a detecao e instalacao de dependencias, com PRESETS
   # uDev: Esta fx tambem tem de ser util para utilizacao no ficheiro dryaSRC
   # uDev: This may use drya-lib-4

   # Lista de opcoes para o menu `fzf`
      Lz1='Saved '; Lz2='D iu dp'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      L4='4. Install | Soft dependencies (less important libraries + pkgs)'                                      
      L3='3. Install | Hard dependencies (most important libraries + pkgs)'                                      
      L2="2. Edit    | '1st' file"
      L1='1. Cancel'

      L0="DRYa: Dependencies menu: "
      
   # Ordem de Saida das opcoes durante run-time
      v_list=$(echo -e "$L1 \n$L2 \n$L3 \n$L4 \n\n$Lz3" | fzf --no-info --pointer=">" --cycle --prompt="$L0")

   # Atualizar historico fzf automaticamente (deste menu)
      echo "$Lz2" >> $Lz4
   
   # Atuar de acordo com as instrucoes introduzidas pelo utilizador
      [[    $v_list =~ $Lz3  ]] && echo -e "Acede ao historico com \`D ..\` e encontra: \n > $Lz2"
      [[    $v_list =~ "4. " ]] && echo "uDev: $L4" 
      [[    $v_list =~ "3. " ]] && source $v_1st && f_gr_hard_dependencies 
      [[    $v_list =~ "2. " ]] && vim $v_1st
      [[    $v_list =~ "1. " ]] && echo "Canceled: Menu: $Lz2" 
      [[ -z $v_list          ]] && echo "ESC key used, aborting..." && exit 1
      unset  v_list
}

function f_help_installing_specific_packages {
   echo
}




function f_kbd_greet {
   f_greet
   f_talk; echo "Keyboard options"
           echo
}

function f_config_kbd_kali {
   # Set keyboard when using Kali

   f_kbd_greet
   f_talk; echo "$L4"
   echo " > setxkbmap -layout pt"
   echo
   v_txt="Proceed to set keyboard" && f_anyK 

   echo "Attempting to set ..."
   setxkbmap -layout pt
}


function f_kill_process_by_PID {
   # Kill process by Process ID (PID)

   f_greet
   f_talk; echo "Escolher um PID para eliminar (PID)"

   L0="DRYa: Choose a Process to kill: "
   v_list=$(ps -aux | fzf --tac --cycle -m --pointer=">" --prompt="$L0")
   
   if [[ -n $v_list ]]; then
      v_pid=$(echo $v_list | cut -f 2 -d " ")

      v_label=$(ps -aux | head -n 1)

      echo
      f_hzl
      echo $v_label
      echo $v_list

      f_hzl
      echo
      echo
      
      unset v_ans
      f_talk; echo    "Notas:" 
              echo    " < (A coluna do PID é a segunda)"
              echo    " < (uDev: detecao automatica do PID"
              echo
              echo    " > Insira manualmente o numero do PID:"
              echo    "    > (default: $v_pid )"
              read -p "    >  " v_ans
              echo
           
      if [[ -n $v_ans ]]; then 
         echo " > Escolhido para eliminar: $v_ans"
         echo
      
         v_txt="Eliminar '$v_ans'"  && f_anyK

         kill -9 $v_ans

      else
         echo " > A terminar o PID: $v_pid"
         kill -9 $v_pid
      fi

   else
      echo "No process choosen"
   fi
}
   
function f_visitar_extintores {
   echo "uDev: Escrever formula de extintores"
   echo "      ficheiro: .../var/extintores-info.txt"
}

function f_visitar_sbv {
   # Apresentar um script de SBV

   # uDev: se o comando less nao existir, tentar instalar em background
      v_test=$(command -v less)
      [[ -z $v_test ]] && echo "Comando less nao existe. Sera instalado em background" && read -sn1 -t 3



   # Localiacao do ficheiro
      v_file=$__repo__/all/var/suporte-basico-de-vida.txt
      
   f_greet
   f_talk; echo "Suporte Basico de Vida"
           echo " > uDev: Melhorar a formula"
           echo
   f_talk; echo "Localizacao do ficheiro:"
           echo ' > $__repo__/all/var/suporte-basico-de-vida.txt'
           echo " > $v_file"
           echo

   read -sn1 -p "Enter para ler com Less... "
   echo

   less $v_file 2>/dev/null || echo 'O comando `less` nao funcionou'

}


function f_set_keyboard_tty_RetroPie {
   # Instructions to set keyboard on tty

   echo "DRYa: Configure keyboard on tty"
   echo 
   echo  
   echo "Set TTY font size (for RetroPi OS)" 
   echo ' > Problem: tty does not support `Ctrl +` to zoom {'
   echo " > Solution: set a bigger font size with:"
   echo '   `sudo vim /etc/default/console-setup`'
   echo  
   echo " > Content of the file:"
   echo '   FONTFACE="TerminusBold"'
   echo '   FONTFACE="16x32"'
   echo "}"
   echo  
   echo  
   echo "Set Keyboard layout (for RetroPi OS) {"
   echo ' > Problem: Wrong layout'
   echo " > Solution: edit the config file"
   echo '   `sudo vim /etc/default/keyboard`'
   echo  
   echo " > Content of the file:"
   echo '   XKBMODEL="pc105"'
   echo '   XKBLAYOUT="pt"'
   echo '   XKBVARIANT=""'
   echo '   XKBOPTIONS=""'
   echo "}"
   echo
   echo
   echo "Refresh all setings in the end with:"
   echo ' > `sudo setupcon` or `sudo reboot`'

}

function f_menu_kill_running_process {
   echo "DRYa: Help killing process"
   echo
   echo 'PID: '
   echo ' > Try `D pid` to kill a process by Process ID (PID)'
   echo 
   echo 'TTY: '
   echo ' > Acess it with: `Ctrl + Alt + F1`'
   echo ' > Try `D tty` to see a list of default root users' 
   echo 
   echo 'xKill: '
   echo ' > This software does not exist in most OS'

}

# -------------------------------------------
# -- Functions above --+-- Arguments Below --
# -------------------------------------------











# ARGUMENTS: for the Function DRYa
   # Use the programming structure provided below (if elif else fi) along 
   # with the Alias "drya" or "D" (defined in the file "dryaSRC")
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

      f_talk; echo -n "Custom Device Name: "
        f_c3; echo $v_user
        f_rc; echo 

   # Info when no args are given
      f_talk; echo "is installed!"
              echo ' > Command: `D --help` (for `fzf` help menu)'
              echo ' > Command: `D .`      (for `fzf` main menu)'
              echo

   # Temporized Quick menu
      f_talk; echo -n "Temporized Menu"; f_c3; echo -n " (available for "; f_c5; echo -n "$v_secs"; f_c3; echo    " secs):"; f_rc
              echo    "       |"
              echo -n "       |_ To open MAIN fzf menu, press NOW : '";     f_c5; echo -n "d";       f_rc; echo -n "' or '";  f_c5; echo -n "."; f_rc; echo "'"
              echo -n '          Equivalent Terminal commands     : `';     f_c5; echo -n 'D .';     f_rc; echo '`' 

   
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

         f_talk; echo "Argument '$v_ans' not recognized here"

      fi

      unset v_ans

elif [ $1 == "help" ] || [ $1 == "h" ] || [ $1 == "?" ] || [ $1 == "--help" ] || [ $1 == "-h" ] || [ $1 == "-?" ] || [ $1 == "rtfm" ]; then
   # Help menu. [rtfm: "Read the Fucking Manual"]

   # uDev: Tem de passar a ser TUDO texto do README.md senao esse ficheiro nunca é trabalhado.
   #       Depois o restante script corta e imprime so partes desse ficheiro

   # uDev: `drya h  `  # 1st Level of help
   # uDev: `drya h 2`  # 2nd level of help
   # uDev: `drya h 3`  # 3rd level of help
   # uDev: `drya h 4`  # 4th level of help ... instead of "msgs"

   # uDev: se fzf nao existir, print all
   
   if [ -z "$2" ]; then
      # Menu Simples: Help

      f_drya_help_menu #` || echo "fzf falhou"`  # uDev: adicionar failsafe

   elif [ $2 == "all" ]; then 
      f_drya_help

   elif [ $2 == "welcome" ] || [ $2 == "w" ] ; then 
      # This function is used to uncluter the welcome screen of a terminal when DRYa is installed (because DRYa outputs a lot of text)
      echo "D help welcome" >> $v_drya_fzf_menu_hist
      f_output_drya_welcome_screen_msg_with_vimscript

   elif [ $2 == "status-messages" ] || [ $2 == "msgs" ] || [ $2 == "ssms" ]; then 
      # Option to read the $DRYa_MESSAGES file
         # They are stored at: ~/.config/h.h/drya/.dryaMessages
         less $v_MSGS
   fi

elif [ $1 == "-4" ] || [ $1 == "edit-how-to-flash-an-OS-on-USB" ]; then 
   echo uDev

elif [ $1 == "-3" ] || [ $1 == "edit-how-to-partition-HDD-correctly" ]; then 
   echo "uDev"

elif [ $1 == "-2" ] || [ $1 == "edit-drya-installer-select-menu" ]; then 
   echo "uDev"

elif [ $1 == "-1" ] || [ $1 == "edit-drya-installer-fzf-menu" ]; then 
   echo "uDev"

elif [ $1 == "-0" ] || [ $1 == "edit-help-populate" ]; then 
   echo "Display all these numeric arguments on how to populate machines"

elif [ $1 == "0" ] || [ $1 == "edit-bashrc" ]; then 
   # Edit the file that starts DRYa's loading sequence
   vim ~/.bashrc

elif [ $1 == "1" ] || [ $1 == "edit-dryaSRC" ]; then 
   # Edit first file in DRYa's loading sequence
   vim ${v_REPOS_CENTER}/DRYa/all/dryaSRC

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

elif [ $1 == "gps" ]; then 
   # Save GPS locations
   # uDev: this function needs to go to the repo: master-GPS

   v_file=${v_REPOS_CENTER}/omni-log/all/parts/headers/GPS-notes.org

   if [ -z "$2" ]; then
      f_talk; echo "Opcoes para GPS"
              echo " | -z  | Mostrar esta info                             |"
              echo " |  v  | Buscar coordenadas GPS termux-API \"gps\"       |"
              echo " |  n  | Buscar coordenadas GPS termux-API \"network\"   |"
              echo " |  f  | editar notas GPS em omni-log                  |"
              echo " |  F  | Buscar coordenadas + Concat em GPS-notes.sh   |"

   elif [ $2 == "r" ] || [ $2 == "grep" ]; then 
      echo "uDev: filtra texto do ficheiro em omni-log sobre coordenadas de GPS"

   elif [ $2 == "v" ]; then 
      # Displays current GPS location using GPS as provider
      termux-location -p gps  # The termux gps provider is `gps` by default

   elif [ $2 == "n" ]; then 
      # Displays current GPS location using network as provider
      termux-location -p network

   elif [ $2 == "f" ]; then 
      bash e $v_file
   fi

   # uDev: now ask the user if he wants to save to omni-log

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
   echo '`cl`  = Displays this help, then exit'
   echo '`cln` = clonar'
   echo '`clp` = clip'
   echo '`clr` = colar'

elif [ $1 == "clone" ] || [ $1 == "cln" ]; then 
   # Gets repositories from Github.com and tells how to clone DRYa itself
   # Any repo from Seiva's github.com is cloned to the default directory ~/Repositories

   # uDev: Test if Repos Center is set. If is not, just mention the command to mimic on the prompt

   if [ -z "$2" ]; then
      # If nothing was specified to clone, show an fzf menu
      f_clone_main_menu

   elif [ $2 == "h" ]; then
      # Give some instructions (imcomplete)
      f_clone_info

   elif [ $2 == "." ]; then
      # Open fzf to help clone repos by the correct name
      f_clone_by_fzf_list

   elif [ $2 == "try" ] || [ $2 == "t" ]; then
      # To clone repos when we are not exactly sure how it's name is written 
      #                when shortcuts were not already set or predictrd
      v_arg3=$3
      f_clone_by_attempted_name

   else  
      # Clone pre-defined repositories, without menu fzf, when the user remembers the correct name

      # Saving Terminal argument into internal variable
         # uDev: Ver em bash como se faz para saber os nomes dos restantes arg (para guargar todos)
         v_arg2=$2

     f_clone_by_inserting_correct_name
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
   if [[ -z $2 ]]; then 
      f_menu_internet_network_ip_options
   elif [ $2 == "b" ]; then 
      f_list_ip_public_n_local 
   fi

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

   # uDev: testar aqui se existe a dependencia `fzf` para continuar a instalacao. Se o utilizador nao quiser instalar fzf, tem de instalar com a alternativa `select`

   # Var: file for DRYa dependencies
      v_1st=${v_REPOS_CENTER}/DRYa/all/bin/populate-machines/level+1/1st

   if [[ -z $2 ]]; then 
      # If there are no args:

      # Lista de opcoes para o menu `fzf`
         Lz1='Saved '; Lz2='D install.uninstall'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

         L12='12. Help | Factory-Reset (Terminal) + Ghost-Mode (in.out)'
         L11='11. Menu | Install | PRESETS              | `D ui pr`'
         L10='10. Menu | helper  | Backup Maker         | `D ui bk`'
          L9='9.  Menu | Script  | Clone Repos          | `D cln`'
          L8='8.  Menu | install | specific packages    | `D iu p` | `D iu <package>`'
          L7='7.  Menu | install | dot-files            | `D iu d`'
          L6='6.  Menu |   1st   | Dependencies         | `D ui dp`'  # uDev: adicionar a este menu "populate machines"
   
          L5='5.  How To clone DRYa (for other devices) | `D cln h`'

          L4='4.  Install DRYa | `fzf`    installer     | `D ui fzf`'
          L3='3.  Install DRYa | `select` installer     | `D ui sel`'

          L2='2.  List Status  | `D iu ls`'
          L1='1.  Cancel'

         L0="DRYa: Installers Menu: "
         
         v_list=$(echo -e "$L1 \n$L2 \n\n$L3 \n$L4 \n\n$L5 \n\n$L6 \n$L7 \n$L8 \n$L9 \n$L10 \n$L11 \n$L12 \n\n$Lz3" | fzf --no-info --cycle --prompt="$L0")

      # Atualizar historico fzf automaticamente
         echo "$Lz2" >> $Lz4

      # Perceber qual foi a escolha da lista
         [[ $v_list =~ $Lz3   ]] && echo -e "Acede ao historico com \`D ..\` e encontra: \n > $Lz2"
         [[ $v_list =~ "12. " ]] && f_ghost
         [[ $v_list =~ "11. " ]] && f_install_presets
         [[ $v_list =~ "10. " ]] && f_backup_helper
         [[ $v_list =~ "9.  " ]] && f_clone_main_menu
         [[ $v_list =~ "8.  " ]] && f_help_installing_specific_packages
         [[ $v_list =~ "7.  " ]] && f_dot_files_menu  
         [[ $v_list =~ "6.  " ]] && f_menu_install_drya_dependencies__1st
         [[ $v_list =~ "5.  " ]] && f_clone_info
         [[ $v_list =~ "4.  " ]] && f_install_drya__with_fzf
         [[ $v_list =~ "3.  " ]] && f_install_drya__with_Select
         [[ $v_list =~ "2.  " ]] && f_dot_files_list_available
         [[ $v_list =~ "1.  " ]] && echo "Canceled: $Lz2" 
         unset v_list

   elif [[ $2 == "me" ]] || [ $2 == "DRYa" ] || [ $2 == "drya" ]; then 
      f_install_drya__with_Select

   elif [[ $2 == "dependencies" ]] || [ $2 == "dp" ]; then 
      # uDev: source file '1st' and exec instalation of selected group of dependencies

      if [[ -z $3 ]]; then 
         # Menu to pick and choose which dependencies will be installed/removed
         f_menu_install_drya_dependencies__1st

      elif [[ $3 == "hard" ]] || [ $3 == "1" ]; then 
         # Most crutial DRYa dependencies. (But if DRYa bugs are fixed, DRYa can run without dependencies)
         echo "uDev: installing git, tput, fzf... "
         echo " > Any Key to proceed (uDev)"

      elif [[ $3 == "soft" ]] || [ $3 == "2" ]; then 
         echo "uDev: installing man, tree, neofetch... "
         echo " > Any Key to proceed (uDev)"
      
      fi

   elif [[ $2 == "presets" ]] || [ $2 == "pr" ]; then 
      # Instaling PRESETS. Each option may install a package os dependencies + dot-files + custum things
      f_install_presets

   elif [[ $2 == "backups" ]] || [ $2 == "bk" ]; then 
      f_backup_helper

   elif [[ $2 == "p" ]]; then 
      # Verbose that mentions what packages exist to install
      # uDev: Create a menu instead

      f_help_installing_specific_packages

   elif [[ $2 == "fig" ]]; then 
      echo "uDev: testing and installimg existence of figlet"

   elif [[ $2 == "ls" ]] || [ $2 == "list-ready-and-udev" ]; then 
      f_dot_files_list_available

   elif [[ $2 == "dot-file" ]] || [ $2 == "dot" ] || [ $2 == "d" ] || [ $2 == "." ]; then 

      if [ -z $3 ]; then
         # Menu principal: dot-files
         f_dot_files_menu  

      elif [ $3 == "install" ] || [ $3 == "i" ]; then
         # Menu: dot-files install
         
         [[ -z $4            ]] && f_menu_install_dot_files
         [[    $4 == "git"   ]] && f_dot_files_install_git
         [[    $4 == "netrc" ]] && f_dot_files_install_netrc
         [[    $4 == "vim"   ]] && f_dot_files_install_vimrc
         [[    $4 == "vimrc" ]] && f_dot_files_install_vimrc
      fi

   elif [[ $2 == "ps1" ]] || [ $2 == "PS1" ]; then 
      # uDev: This is a config to set, not an instalation
      cd ${v_REPOS_CENTER}/DRYa/all/etc/dot-files/termux/ && source ./termux-PS1

   elif [[ $2 == "fzf" ]]; then 
      # Instalar fzf como foi recomendado pelos desenvolvedores

      v_txt="Install fzf like original developers" && f_anyK
      echo
      git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
      ~/.fzf/install

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

   elif [[ $2 == "xrandr" ]] || [ $2 == "xrr" ]; then 
      # Config the correct screen resolution with `xrandr`

      # uDev: This is a config to set, not an instalation
      # uDev: Criar um ficheiro local @host para que DRYa busque e execute
      

      # Detetar ambiente grafico  (uDev: passar para o traitsID)
         v_amb=${XDG_SESSION_TYPE:-"<nenhum>"}

      # Resolucao da TV 'Silver'
         v_tv="1360x768" 

      f_greet 
      f_talk; echo "Help for scree Resolution"
              echo " > uDev: use traitsID"
              echo
      f_talk; echo "Ambiente grafico detetado: $v_amb"
              echo " > If 'wayland' or 'weston' use \`wlr-randr\`"
              echo " > If 'x11'     or 'xorg'   use \`xrandr\`"
              echo
      f_talk; echo "Conexoes HDMI detetadas:"
      
      if [[ $v_amb == "x11" ]] || [[ $v_amb == "x11" ]]; then
         # Se for detetado a necessidade de xrandr

         # Busca do HDMI connectado
            v_connected=$(xrandr | grep -i " connected" | cut -f 1,2 -d " ")
            v_connected=${v_connected:-"<nenhuma>"}
            echo " > $v_connected"

         # Busca so do numero do HDMI
            v_nr=$(echo $v_connected | cut -f 2 -d "-" | cut -f 1 -d " " ) 

         echo
      fi

      if [[ $trid_os == "R" ]]; then
         # Se o OS detetado for RaspberryPi
         

         f_talk; echo "If detected 'Pi' + 'Silver TV' + 'X11':"
                 echo " > 1360x768 "
                 echo " > exemplo: \`xrandr --output HDMI-1 --mode 1360x768\`"
                 echo
                 echo "Tente: \`xrandr --output HDMI-$v_nr --mode $v_tv\`"
      fi

   elif [[ $2 == "upk-at-work" ]] || [[ $2 == "upk-tmp-phone" ]]; then 
      # Makes all dependencies for upk repo available
      # This might be used most likely at in-job phone

      f_quick_install_all_upk

   elif [[ $2 == "1" ]]; then 
      # Edit script "DRYa fzf installer"
      vim ./install.uninstall/linux-or-WSL/master-bashrc/1-installer-fzf-alternative.sh

   else
      f_talk; echo "What do you want to install? (invalid arg)"
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

            # Using the alias set on 'dryaSRC'
               # '$ ,.' 
      ;;
      src | source | source-drya | dryaSRC) 
         vim ${v_REPOS_CENTER}/DRYa/all/dryaSRC

         # Other ways to open the same file: 
            # Using menu F (from D.F) defined/programed at config-bash-alias (the same file we are opening)
               # '$ F'

            # Using the alias set on 'dryaSRC'
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

elif [ $1 == "list-all-file-metadata" ] || [ $1 == "meta-ls" ] || [ $1 == "mt-ls" ]; then  # mostra os seu metadados da imagem fornecida
   
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

   v_calc="${v_REPOS_CENTER}/DRYa/all/bin/ca-lculadoras.sh"
   shift; bash $v_calc $*

   function f_off {
      if [ -z $2 ]; then 
         # Opens menu "calculadoras"
         bash $v_calc

      elif [ $2 == "." ]; then 
         # Opens interactive calculadora
         #bash $v_calc .
         shift; bash $v_calc $*

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
   }

elif [ $1 == "set-keyboard" ] || [ $1 == "kbd" ]; then 
   # Comandos para configurar o layout do teclado

   # uDev: - nem sempre existe fzf e ddrya-lib-1 quando é preciso configurar o teclado
   #       - Apresentar verbose sobre como configurar cada teclado

   if [ -z $2 ]; then


      # Lista de opcoes para o menu `fzf`
         Lz1='Save '; Lz2='D kbd'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

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

         L8='8. |   | DRYa emergency keyboard 2'
         L7='7. |   | DRYa emergency keyboard 2'

         L6='6. |   | Config keyboard layout: RetroPi (tty)'              
         L5='5. |   | Config keyboard layout: Fedora Linux (sess atual)'  # Apenas para a sessao atual
         L4='4. |   | Config keyboard layout: Kali   Linux (sess atual)'
         L3='3. |   | Config keyboard layout: Ubuntu Linux (sess atual)'

         L2='2. |   | Verificar teclado atual' 
         L1='1. |   | Cancel + Instructions'

         L0="DRYa: Keyboard: "
         
         v_list=$(echo -e "$L1 \n$L2 \n\n$L3 \n$L4 \n$L5 \n$L6 \n\n$L7 \n$L8 \n\n$Lz3" | fzf --cycle --prompt="$L0")

      # Perceber qual foi a escolha da lista
         [[ $v_list =~ $Lz3  ]] && echo -e "Acede ao historico com \`D ..\` e encontra: \n > $Lz2"
         [[ $v_list =~ "8. " ]] && f_kbd_greet && echo 'Use hotkeys `Ctrl-x` to open drya-emergency-keyboard'
         [[ $v_list =~ "7. " ]] && f_kbd_greet && cat ${v_REPOS_CENTER}/DRYa/all/bin/fzf-keyboard-alterbative/keys-list.txt | fzf
         [[ $v_list =~ "6. " ]] && f_kbd_greet && f_set_keyboard_tty_RetroPie
         [[ $v_list =~ "5. " ]] && f_kbd_greet && echo "uDev: $L4"
         [[ $v_list =~ "4. " ]] && f_config_kbd_kali
         [[ $v_list =~ "3. " ]] && f_kbd_greet && echo && echo "$L3" && echo " > setxkbmap pt" && echo && v_txt="Proceed to set keyboard" && f_anyK && setxkbmap pt
         [[ $v_list =~ "2. " ]] && f_kbd_greet && localectl status 
         [[ $v_list =~ "1. " ]] && f_kbd_greet && echo "Canceled: $Lz2" && echo "DRYa: try CTRL-X to open fzf-keyboard-alternative in the middle of the prompt"
         unset v_list

   elif [ $2 == "detect" ] || [ $2 == "d" ]; then 
      # An alternative for when `fzf` is not yet installed

      v_uname=$(uname -a)
      echo
      echo "DRYa: Detecting OS and Setting correct keyboard layout"
      [[ $v_uname =~ "kali" ]] && echo " > Detected: Kali Linux" && echo " > setxkbmap -layout pt" && setxkbmap -layout pt && echo " > Sucess!"

   elif [ $2 == "help" ] || [ $2 == "h" ]; then 
      echo 'Use hotkeys `Ctrl-x` to open drya-emergency-keyboard'

   fi

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

   if [ -z $2 ]; then
      f_QR_code_fzf_menu

   elif [ $2 == "curl" ] ; then 

      if [ -z $3 ]; then
         echo "Tem de fornecer arg 4 como texto"

      else 
         shift
         shift

         f_talk; echo "A criar QR codes de cada argumento"

         for i in $@ 
         do
            # curl trick, pedir a um site para criar um qr code
            echo
            echo " > $i"
            printf "$i" | curl -F-=\<- qrenco.de/
            echo
            echo
      
         done
      fi
   fi

elif [ $1 == "p" ] || [ $1 == "presentation" ] || [ $1 == "logo" ]; then 

   function f_presentation_info {
      echo ' > `D p 1`  # DRYa presentation'
      echo ' > `D p 2`  # DRYa ascii logo legacy'
      echo ' > `D p 3`  # DRYa ascii logo'
   }

   if [ -z $2 ]; then
      f_presentation_info

   elif [ $2 == "1" ] ; then 
      # Presenting DRYa with ASCII text
      ${v_REPOS_CENTER}/DRYa/all/bin/drya-presentation.sh || echo -e "DRYa: app availablei \n > (For a pretty logo, install figlet)"  # In case figlet or tput are not installed, echo only "DRYa" instead

   elif [ $2 == "2" ] ; then 

      # uDev: Centrar BEM no ecra. Nao apresentar o prompt por alguns segundos com `read -t 5`
      clear
      #${v_REPOS_CENTER}/DRYa/all/bin/drya-presentation.sh || echo -e "DRYa: app availablei \n > (For a pretty logo, install figlet)"  # In case figlet or tput are not installed, echo only "DRYa" instead
      figlet "               DRYa" 
      cat ${v_REPOS_CENTER}/DRYa/all/etc/dot-files/drya/logo.ascii
      echo

      read -t 5

   elif [ $2 == "3" ] ; then 
      clear
      figlet DRYa
      f_talk; echo "DRYa: Presentation 3"
              echo
      cat ${v_REPOS_CENTER}/DRYa/all/etc/dot-files/drya/logo.ascii.2
      echo
   else
      f_presentation_info
   fi

elif [ $1 == "P" ] || [ $1 == "default-presentation" ] || [ $1 == "default-logo" ]; then 
   # uDev: juntar `D p` com `D P`

   clear
   figlet DRYa
   f_talk; echo "DRYa: Presentation 3"
           echo
   cat ${v_REPOS_CENTER}/DRYa/all/etc/dot-files/drya/logo.ascii.2
   echo

elif [ $1 == "create-windows-bootable-USB-cmd" ] || [ $1 == "cwusb" ]; then 
   # Step-by-step guide to create a bootable USB at windows command prompt"

   bash ${v_REPOS_CENTER}/DRYa/all/bin/create-windows-bootable-USB-cmd.sh

elif [ $1 == "wiki" ] || [ $1 == "w" ]; then 
   # Menu to edit locally, visualize in the browser, etc...

   v_repo=${v_REPOS_CENTER}/wikiD/
   v_file="$v_repo/wikiD.org"
   v_editor=$(cat $trid_editor_file)
   v_editor="'$v_editor'"
   
   v_udev=' > uDev: usar `sed` para substituir ";; #+SETUPFILE" por "#+SETUPFILE"'

   f_talk; echo "Opening: wikiD.org"

   function f_wikiD_main_menu {
      # Lista de opcoes para o menu `fzf`
         Lz1='Saved '; Lz2='D wiki'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

         L3='3. | w | wikiD.org | Abrir no browser'
         L2="2. | . | wikiD.org | Abrir no $v_editor" 
         L1='1. Cancel'

         Lh=$(echo -e "\nInstrucoes sobre editor de texto:\n - Altere o editor com a fx \`ee\`\n ")
         L0="$v_fzf_talk: SELECT 1: Menu X: "
         
      # Ordem de Saida das opcoes durante run-time
         v_list=$(echo -e "$L1 \n$L2 \n$L3 \n\n$Lz3" | fzf --no-info --pointer=">" --cycle --header="$Lh" --prompt="$L0")

      # Atuar de acordo com as instrucoes introduzidas pelo utilizador
         [[    $v_list =~ $Lz3  ]] && echo -e "Acede ao historico com \`D ..\` e encontra: \n > $Lz2"
         [[    $v_list =~ "3. " ]] && echo "$v_udev"
         [[    $v_list =~ "2. " ]] && ( [[ -d $v_repo ]] && cd $v_repo && bash e $v_file ) || echo "Nao deu para abrir wikiD.org"
         [[    $v_list =~ "1. " ]] && echo "Canceled: Menu: $Lz2" 
         [[ -z $v_list          ]] && echo "ESC key used, aborting..." && exit 1
         unset  v_list

   }
   
   if [ -z $2 ]; then
      f_wikiD_main_menu 

   elif [ $2 == "web" ] || [ $2 == "w" ]; then 
      echo "$v_udev"

   elif [ $2 == "edit" ] || [ $2 == "." ]; then 
      ( [[ -d $v_repo ]] && cd $v_repo && bash e $v_file ) || echo "Nao deu para abrir wikiD.org"

   fi

elif [ $1 == "omni" ] || [ $1 == "om" ]; then 
   f_talk; echo "Opening: omni-log.org"

   # uDev: Test fist if repo exists
   cd ${v_REPOS_CENTER}/omni-log/ && emacs omni-log.org

elif [ $1 == "remove" ] || [ $1 == "rm" ]; then 
   echo "uDev: Remove repos"

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
      # uDev: perguntar por 5 segundos: quer `git push` das alteracoes?

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

elif [ $1 == "player" ] || [ $1 == "plr" ]; then 
   f_menu_audio_media_player 

elif [ $1 == "lib" ]; then 
   # Print with `ls` all the drya-lib file names

   v_libs=${v_REPOS_CENTER}/DRYa/all/lib/libs

   if [ -z $2 ]; then 
      f_greet
      f_talk; echo "Info about libraries file at:"
              echo " > $v_libs"
              echo
      f_talk; echo "Listing names:"

      ls -1 $v_libs

              echo
      f_talk; echo "Listing how each can be installed"
              echo " > uDev"

   elif [ $2 == "1" ] || [ $2 == "source-drya-lib-1" ]; then 
      # Make drya-lib-- available on current terminal session
      # Note: DRYa Lib 1: Color schemes

      v_lib1=$v_libs/drya-lib-1-colors-greets.sh
      source $v_lib1 2>/dev/null || (read -sn 1 -p "DRYa: drya-lib-1 does not exist (error)" && echo)
      # uDev: este source nao sera valido, ira abrir num sub-processo

      v_greet="DRYa"
      v_talk="DRYa: "

   elif [ $2 == "4" ] || [ $2 == "source-drya-lib-4" ]; then 
      # Make drya-lib-- available on current terminal session
      # Note: DRYa Lib 4: dependencies, packages, git...

      v_lib4=$v_libs/drya-lib-4-dependencies-packages-git.sh
      source $v_lib4 2>/dev/null || (read -sn 1 -p "DRYa: drya-lib-1 does not exist (error)" && echo)
      # uDev: este source nao sera valido, ira abrir num sub-processo

      v_greet="DRYa"
      v_talk="DRYa-lib-4: "

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

      v_files=$(ls -1F | fzf --pointer=">" -m --prompt="DRYa: Copy to clipboard multiple: " --preview 'cat {}' --preview-window=right:40%)
      v_pwd=$(pwd)
 
      echo > $v_clip   # Variable already set on file: 'dryaSRC'

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

      v_files=$(find . -maxdepth 1 | fzf --pointer=">" -m --prompt="DRYa: Copy to clipboard multiple: " --preview 'cat {}' --preview-window=right:40%)

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

elif [ $1 == "grep" ] || [ $1 == "gr" ]; then 
   # Partial File Reader: Filtrar texto de ficheiros

   v_script=${v_REPOS_CENTER}/DRYa/all/bin/drya-extended-grep.sh

   if [ -z $2 ]; then 
      bash $v_script 

   elif [ $2 == "." ]; then 
      vim $v_script

   else

      # Enviar todos os argumentos deste processo principal para o script (sub-processo). Shift elimina o arg 'grep'
      shift
      bash $v_script "$@"
         
   fi


elif [ $1 == "dmsg" ] || [ $1 == "ssms" ] || [ $1 == "msg" ]; then 
   # Read the log file to events (drya-messages)
   f_talk; echo 'Showing `ssms` entire file'
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

elif [ $1 == "gpg" ] || [ $1 == "gnu-privacy-guard" ] || [ $1 == "pgp" ] || [ $1 == "G" ] || [ $1 == "g" ]; then 
   # Encrypt and Decript personal, private abd sensitive data

   shift; bash ${v_REPOS_CENTER}/DRYa/all/bin/drya-GnuPG.sh $*

elif [ $1 == "wam" ]; then 
   # Editar ficheiro 'wam' com `D wam` (worldlly abreviated messages). Mensagens que sao manualemte escritas em qualquer parte do mundo (por exemplo "drya::wam:01" cujo significado esta apenas guardado online em omni-log
   # Ficheiro gerido e usado por repos e scripts: drya.sh; no-tes.sh; 3sab; omni-log
   
   # Ficheiro que é editado
      v_wam=${v_REPOS_CENTER}/omni-log/all/wam/wam.org
      v_example="${v_REPOS_CENTER}/omni-log/all/wam/example-wam-qrcode/run-example.sh"

   if [ -z $2 ]; then
      # Se nao for dado nenhum arg extra, da instrucoes
      f_talk; echo "DRYa WAM messages, arguments:"
              echo " > .          | To edit main DWAM file"
              echo " > ?          | To give an example of DWAM aplyied in the world"
              echo " > g <search> | To grep text directly from the main DWAM file"

   elif [ $2 == "." ] || [[ $1 == "edit-dwam-main-file" ]]; then
      [[ -d ${v_REPOS_CENTER}/omni-log ]] && emacs $v_wam  ## Usa o script `e` que vem com DRYa repo

   elif [ $2 == "g" ]; then

      if [ -z $3 ]; then
         f_talk; echo "DRYa WAM: How to use grep command:"
                 echo ' > `D wam g <search>`'
      else
         cat $v_wam | grep --color=auto $3
      fi


   elif [ $2 == "?" ]; then
      f_greet
      f_talk; echo "Example of D.W.A.M. (DRYa Worldly Abreviated Messages)"
              echo " > 1. Text    : code written according to database"
              echo " > 2. QR code : containing the text code (for automation)"
              echo " > 3. NFC tag : possibility to scan the NFC (for automation)"
      f_hzl

      echo
      echo
      [[ -f $v_example ]] && bash $v_example
      echo
      echo

      f_hzl

   else 
      # Se forem usados mais args, pesquisa-os e imprime no terminal
      for i in $*
      do
         grep "drya-wam-$i" $v_wam | sed "s/|/\n|/g" | sed "s/  / /g" | sed "s/  / /g" | sed "s/  / /g" 
         f_hzl
      done
   fi

elif [ $1 == "morse" ]; then 
   # uDev: trazer pelo menos este ficheiro para .../all/var/ por motivos de emergencia
   # uDev: Passar video/menemonica para Imagem: https://www.facebook.com/share/v/19uVyHMg1P/
   f_morse

# uDev: Fazer um menu so para SOS
#elif [ $1 == "emergencia" ] || [ $1 == "112" ] || [ $1 == "sbv" ] || [ $1 == "sos" ]; then 

elif [ $1 == "sbv" ]; then 
   f_visitar_sbv

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

elif [ $1 == "cal" ] || [ $1 == "calendar" ] ; then 
   if [[ -n $(command -v cal) ]]; then
      clear 
      f_talk; echo "Calendario"
      cal -y
   else 
      f_talk; echo "cal does not exist. Installing... "
      echo 
      pk + ncal
      clear 
      f_talk; echo "Calendario"
      cal -y
   fi

elif [ $1 == "game" ] && [ $1 == "games" ] ; then 
   # Inicia jogos
   
   emulationstation  # Inicia o emulador do RetroPie

elif [ $1 == "tty" ] ; then 
   # Info sobre tty
   echo "Default usernames and passwords for root users:"
   echo " > 'RetroPi OS' pi:raspberry"
    
elif [ $1 == "pid" ] || [ $1 == "kill-pid" ] ; then 
   f_kill_process_by_PID 

elif [ $1 == "o" ] || [ $1 == "other" ] ; then 
   # Scripts less important here, like scratch-paper

   bash $v_spr/drya-other.sh $*  # Variable set at dryaSRC

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
   #
   # `D .. c` edita copia desse ficheiro de historico (se existir)

   # Variavel com o nome/caminho do ficheiro de historico fzf
      # v_drya_fzf_menu_hist  # Ja foi definido em dryaSRC

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

         f_talk; echo "Criada uma copia do ficheiro de historico dos menus fzf"

      elif [ $2 == "S" ]; then
         # Substituir o original pela copia
         [[ -f ${v_drya_fzf_menu_hist}.copia ]] \
            && cp ${v_drya_fzf_menu_hist}.copia $v_drya_fzf_menu_hist

         f_talk; echo "A copia do ficheiro de historico dos menus fzf foi APLICADO como original"

      elif [ $2 == "c" ]; then
         f_talk; echo "A editar o ficheiro copiado de historico dos menus fzf (se existir)"

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
