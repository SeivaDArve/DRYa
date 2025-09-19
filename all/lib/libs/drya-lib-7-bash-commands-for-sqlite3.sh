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

function f_lib7_create_new_database {
   # Notas:
   #     1. No terminal da erro criar primeiro o ficheiro `touch exemplo.db` e depois abrir com sqlite `sqlite exemplo.db`, ao criar tabelas vai dar o erro "Nao é database"
   #     2. Para criar uma database, o proprio comando `sqlite` pode criar o ficheiro. Se na pasta atual nao existir nenhum ficheiro 'exemplo.db' entao sqlite tem a oportunidade de criar com `sqlite exempo.db`
   #     3. Ao criar a base de dados dessa forma `sqlite exempo.db` o sql vai abrir o seu shell por pre-definicao. Para abrir e fechar logo, adicionamos um arg extra `.exit` ou seja `sqlite3 "exemplo.db" ".exit"`
   #     4. O chatGPT sugerir o output de um argumento a mais: `sqlite3 "exemplo.db" ".databases" ".exit"`
   #
   #     Resumo: Criar database (com o nome de um ficheiro ainda enixistente): `sqlite3 exemplo.db`

   echo "drya-lib-7: Creating new database. Insert name:"
   read -p " > " v_ans

   [[ -n $v_ans ]] && sqlite3 "${v_ans}.db" ".exit"
}


