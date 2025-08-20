#/bin/bash
# Title: Bash Support for Sqlite3

#
#
#  INSTRUCTIONS: 
#     At the top of every script file in which this script needed, place these lines below:
#
#
#     # Sourcing DRYa Lib 7: Bash support to implement sqlite3
#        v_lib7=${v_REPOS_CENTER}/DRYa/all/lib/drya-lib-7-bash-calling-for-sqlite3.sh
#        [[ -f $v_lib7 ]] && source $v_lib7 || read -s -n 1 -p "DRYa: drya-lib-7 does not exist (error)"
#
#        # Examples: uDev
#           
#  
#

function f_lib7_check_sqlite3_package_is_installed {
   echo "uDev: se nao estiver instalado, intala automaticamente. So da mensagem de erro quando nao consegue"
}

function f_lib7_create_database_file {
   echo "uDev"
}

