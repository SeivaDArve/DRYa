#!/usr/bin/env bash
# gpg-menu.sh
# Menu interativo para operações GnuPG com confirmação e explicações




# Sourcing DRYa Lib 1: Color schemes
   __name__="drya-GnuPG.sh"  # Change to the name of the script. Example: DRYa.sh, ezGIT.sh, Patuscas.sh (Set this variable at the head of the file, next to title)
   v_lib1=${v_REPOS_CENTER}/DRYa/all/lib/libs/drya-lib-1-colors-greets.sh
   source $v_lib1 2>/dev/null || (read -s -n 1 -p "DRYa libs: $__name__: drya-lib-1 does not exist (error)" && echo )

   # Examples: f_greet, f_greet2, f_talk, f_done, f_anyK, f_Hline, f_horizlina, f_verticline, etc... [From the repo at: "https://github.com/SeivaDArve/DRYa.git"]
      v_greet="DRYa"
      v_talk="DRYa-GnuPG: "



function f_allow_empty_vars {
   # Liga/Permite erros silenciosos, por exemplo a falta de iniciacao de variaveis (neste caso $1)
   set +u   
}

function f_deny_empty_vars {
   # Desliga/Rejeita erros silenciosos (a falta de inicializacao de variaveis)
   # Uma boa prática: faz com que qualquer variável não inicializada cause erro imediatamente — evita bugs silenciosos.
   set -u  
}



GPG=$(command -v gpg || true)  # Permite saber o path para o executavel OU acabar com um valor positivo. De ambas as formas o script nao acaba nem com erro nem com um valor inexistente
if [[ -z "$GPG" ]]; then
  f_talk; echo "gpg não encontrado. Por favor instala o GnuPG e tenta novamente."
          echo " > Experiementa \`D gpg i\` para instalar"
  exit 1
fi

function pause {
  echo
   v_tlk=$(f_talk)
  read -rn 1 -p "${v_tlk}Prima \"Qualquer Tecla\" para continuar..."
}

function f_header {
   f_allow_empty_vars 
   f_greet  
   f_deny_empty_vars 
}

function f_hline {
   f_allow_empty_vars 
   f_hzl
   f_deny_empty_vars 
}

function f_ls {
   # Usa simplesmente o comando `ls` para facilitar o autocomplete nos momentos em que algum menu pede um nome de um ficheiro de entrada

   f_hline
   f_talk; echo "Comando \`ls\` para facilitar:" 
   echo
   ls -pA
   f_hline
}

function confirm {
  local msg=${1:-"Confirma?"}
  read -rn1 -p "$msg (y/N): " ans
  echo
  [[ "$ans" =~ ^[Yy]$ ]]
}

function f_run_with_confirm {

   f_allow_empty_vars 
   local func="$1"
   f_deny_empty_vars 
   shift
   local message="$*"

   f_header
   f_talk; echo "Instruções \`$func\` : "
   echo " > $message"
   f_hline

   v_ask=$(f_talk)
   v_ask="$v_ask Deseja continuar com esta ação?"

   if confirm "$v_ask"; then
     #echo
     $func
   else
     echo "Ação cancelada."
   fi

   pause
}

function generate_key {
  $GPG --full-generate-key
  echo "Chave gerada:"
  $GPG --list-secret-keys --keyid-format LONG
}

function import_key {
   f_ls
   f_talk; echo "Importar Ficheiro de chave: "
           echo " > Comando \`gpg --import <file>\` (uDev: enviar para instrucoes)"
           echo

   f_talk; echo "Escolha o Ficheiro de chave a importar: "
   read -erp " < " file
   echo

   [[ ! -f "$file" ]] && echo " < " && return
   $GPG --import "$file"
}

function export_public_key {
   echo "Cada chave 'KeyID' tem um identificador legivel 'UID'"
   echo
   read -rp  "UID ou KEYID da chave pública a exportar: " key
   read -erp "Ficheiro de saída: " out
   $GPG --export --armor "$key" >"$out" && echo "Exportado para $out"
}

function export_private_key {
  read -rp "UID ou KEYID da chave privada a exportar: " key
  read -rp "Ficheiro de saída (CUIDADO): " out
  if confirm "Exportar chave privada para $out? Isto é sensível. Continuar?"; then
    $GPG --export-secret-keys --armor "$key" >"$out" && echo "Exportado para $out"
  else
    echo "Cancelado."
  fi
}

function symmetric_store {
  read -rp "Ficheiro a encriptar: " infile
  [[ ! -f "$infile" ]] && echo "Ficheiro não existe." && return
  read -rp "Ficheiro de saída: " outfile
  outfile=${outfile:-"${infile}.gpg"}
  $GPG --symmetric --cipher-algo AES256 --output "$outfile" "$infile" && echo "Encriptado com passphrase para $outfile"
}

function encrypt_for_recipient {
  read -e -rp "Ficheiro a encriptar: " infile
  [[ ! -f "$infile" ]] && echo "Ficheiro não existe." && return
  read -rp "UID/KEYID do destinatário: " recipient
  read -e   -rp "Ficheiro de saída: " outfile
  outfile=${outfile:-"${infile}.gpg"}
  if confirm "Deseja assinar o ficheiro com a sua chave privada?"; then
    $GPG --encrypt --sign --recipient "$recipient" --output "$outfile" "$infile"
  else
    $GPG --encrypt --recipient "$recipient" --output "$outfile" "$infile"
  fi
  echo "Ficheiro encriptado para $recipient em $outfile"
}

function decrypt_file {
  read -rp "Ficheiro a desencriptar: " infile
  [[ ! -f "$infile" ]] && echo "Ficheiro não existe." && return
  read -rp "Ficheiro de saída (ou Enter para default): " outfile
  outfile=${outfile:-"${infile%.gpg}"}
  $GPG --output "$outfile" --decrypt "$infile" && echo "Desencriptado para $outfile"
}

function sign_file {
  read -rp "Ficheiro a assinar: " infile
  [[ ! -f "$infile" ]] && echo "Ficheiro não existe." && return
  read -rp "Ficheiro de assinatura (.sig): " sigout
  sigout=${sigout:-"${infile}.sig"}
  $GPG --armor --detach-sign --output "$sigout" "$infile" && echo "Assinatura criada em $sigout"
}

function verify_signature {

  # Note `read -e` permite usar 'readline' do bash interativo, ou seja, permite "autocomplete" com a tecla Tab e assim, encontra ficheiros ou diretorios que existam na pasta atual
  read -erp "Ficheiro original: " infile
  read -erp "Ficheiro .sig: " sig
  [[ ! -f "$infile" || ! -f "$sig" ]] && echo "Ficheiro(s) não encontrado(s)." && return
  $GPG --verify "$sig" "$infile"
}

function change_passphrase {
  read -rp "UID/KEYID da chave: " key
  echo "No prompt GPG, escreva: passwd"
  $GPG --edit-key "$key"
}

function show_key_fingerprints {

   # Mostrar lista de Fingerprints publicas
      echo "Fingerprints públicas:"

      v_pub=$($GPG --fingerprint --keyid-format LONG)
      [[ -n $v_pub ]] && echo "$v_pub"
      [[ -z $v_pub ]] && echo " > none"
      echo

   # Mostrar lista de Fingerprints privadas
      echo "Fingerprints privadas:"
      v_priv=$($GPG --fingerprint --list-secret-keys --keyid-format LONG)
      [[ -n $v_priv ]] && echo "$v_priv"
      [[ -z $v_priv ]] && echo " > none"
      echo
}

function list_public_keys {
   f_hline
   f_talk; echo "Lista de Chaves públicas"
           echo ' > comando: `gpg --list-keys --keyid-format LONG`'

   v_list=$($GPG --list-keys --keyid-format LONG)

   if [[ -n $v_list ]]; then
      # Se existir alguma chave, apresenta no ecra
      echo "$v_list"
      v_last_search="keys-found"

   else 
      # Se nao existir alguma chave, apresenta no ecra que nao existe
      echo " > Nao existe nenhuma"
      v_last_search="keys-not-found"

   fi

   f_hline
}

function list_private_keys {
  echo "Chaves privadas (gpg --list-secret-keys):"
  $GPG --list-secret-keys --keyid-format LONG
}

function delete_key {
   list_public_keys 

   f_talk; echo "UID/KEYID da chave pública a apagar: "
   
   if [[ $v_last_search == "keys-found" ]]; then
      read -erp " < " key

      if confirm "Apagar chave pública $key?"; then
         $GPG --batch --yes --delete-key "$key"
      fi
      if confirm "Apagar também a chave privada (se existir)?"; then
         $GPG --batch --yes --delete-secret-and-public-key "$key"
      fi

   else
      echo " > Nao existe nenhuma chave para apagar"
   fi
   pause
}

function backup_all_keys {
  read -rp "Prefixo para ficheiros de backup: " out
  $GPG --export-secret-keys --armor >"${out}.secret.asc"
  $GPG --export --armor >"${out}.pub.asc"
  echo "Backups criados: ${out}.secret.asc e ${out}.pub.asc"
}

function restore_keys {
  read -rp "Ficheiro de chaves a importar: " file
  [[ ! -f "$file" ]] && echo "Ficheiro não encontrado." && return
  $GPG --import "$file"
}


function check_gpg_agent {
  local count
  count=$($GPG --list-secret-keys --with-colons 2>/dev/null | grep -c '^sec' || true)
  if [[ "$count" -eq 0 ]]; then
    echo "Nenhuma chave privada encontrada."
  else
    echo "Encontradas $count chaves privadas:"
    $GPG --list-secret-keys --keyid-format LONG
  fi
}

function f_reset_GnuPG_like_fresh_install {
   v_dir=~/.gnupg

   f_header
   f_talk; echo "Reset ao pacote 'gnupg' (CUIDADO!)"
           echo " > Apagando $v_dir simula um reset TOTAL do ambiente GPG"
           echo " > Apaga todas as chaves publicas + privadas"
           echo " > Aconselha-se fazer um backup primeiro"
           echo " > É possivel mudar o diretorio do GPG pre-definido"
   f_hline

   if [[ -d $v_dir ]]; then
      f_talk; echo "Pasta existe:"
              echo " > $v_dir"
              echo


      v_ask=$(f_talk)
      v_ask="${v_ask}Quer apagar a pasta?"

      if confirm "$v_ask"; then
        #echo
        rm -rf $v_dir
      else
        echo "Ação cancelada."
      fi



   else
      f_talk; echo "Pasta nao existe:"
              echo " > $v_dir"
   fi

   f_hline 
   pause
}

function f_explaining_content_of_default_gnupg_directory {
   # Inspeciona todos os ficheiro dentro da pasta ~/.gnupg e explica o que sao

   f_header
   local dir="$HOME/.gnupg"

   if [ ! -d "$dir" ]; then
       echo "❌ A pasta ~/.gnupg não existe."
       echo
       return 1
   fi

   f_talk; echo "📂 Conteúdo da pasta ~/.gnupg:"

   f_hline
   f_talk; echo "📂 Conteúdo da pasta (com \`ls\`):"
   ls -pA ~/.gnupg
   f_hline
   

   f_talk; echo "📂 Conteúdo da pasta (info + instrucoes):"
   for item in "$dir"/*; do
       nome=$(basename "$item")
       case "$nome" in
           pubring.kbx)
               echo " > 🔐 $nome — Armazena as chaves públicas (formato moderno)."
               echo '    > .kbx é um formato de binario "keybox"'
               echo '    > Para print do conteudo: `gpg --list-keys --keyid-format LONG --fingerprint`'
               echo
           ;;
           trustdb.gpg)
               echo " > ✅ $nome — Base de dados de confiança das chaves (nível de confiança)."
               echo
           ;;
           random_seed)
               echo " > 🎲 $nome — Semente para geração de números aleatórios (segurança criptográfica)."
               echo
           ;;
           gpg.conf)
               echo " > ⚙️ $nome — Ficheiro de configuração personalizada do GnuPG (opcional)."
               echo
           ;;
           private-keys-v1.d)
               echo  " > 🔒 $nome/ — Contém as tuas chaves privadas (em ficheiros cifrados)."
               echo
           ;;
           openpgp-revocs.d)
               echo " > 🗑️ $nome/ — Certificados de revogação das tuas chaves (para desativar uma chave perdida)."
               echo
           ;;
           .#lk*)
               echo " > ⏳ $nome — Ficheiro temporário de bloqueio (*lock file*), usado para evitar acessos simultâneos. Pode ser apagado se não houver nenhum processo GPG a correr."
           ;;
           *)
               echo " > 📄 $nome — (ficheiro ou pasta desconhecido/personalizado)"
               echo
           ;;
       esac
   done

   echo " > Usa 'gpg --list-keys' e 'gpg --list-secret-keys' para listar as chaves públicas e privadas."
   f_hline

}

function f_only_convert_content_to_OpenPGP_no_encription {
   echo "uDev: gpg --store ..."
}

function f_main_menu_text {
   L00=" | opc | fx"

    L0=" |  0  | Info : Listar DRYa default settings"
    L1=" |  1  | Info + Listar chaves públicas / verificar existência"
    L2=" |  2  | Info + Listar chaves privadas / verificar existência"
    L3=" |  3  | Info + Gerar nova chave (interativo)"
    L4=" |  4  | Info + Importar chave"
    L5=" |  5  | Info + Exportar chave pública"
    L6=" |  6  | Info + Exportar chave privada (cuidado)"

    L7=" |  7  | Info + Encriptação    simétrica (com passphrase)"
   L17=" | 17  | Info + Desencriptação simétrica (com passphrase)"

    L8=" |  8  | Info + Encriptar para destinatário (chave pública)"
    L9=" |  9  | Info + Desencriptar ficheiro"
   L10=" | 10  | Info + Assinar ficheiro"
   L11=" | 11  | Info + Verificar assinatura"
   L12=" | 12  | Info + Mudar passphrase de uma chave"
   L13=" | 13  | Info + Apagar chave"
   L14=" | 14  | Info + Backup de todas as chaves"
   L15=" | 15  | Info + Restaurar chaves"
   L16=" | 16  | Info + Mostrar fingerprints"
   L18=" | 18  | Info + Reset package 'gnupg' (MUITO CUIDADO)"
   L19=" | 19  | Info : Describing all contents at ~/.gnupg"
   L20=" | 20  | Info + Convert text/file to OpenPGP (no encription)"

    Lh=" |  h  | Instucoes Base"
    LQ=" |  Q  | Sair"

   echo "$L00"
   f_hline
   echo "$L0"
   echo "$L1"
   echo "$L2"
   echo "$L3"
   echo "$L4"
   echo "$L5"
   echo "$L6"
   f_hline
   echo "$L7"
   echo "$L17"
   f_hline
   echo "$L8"
   echo "$L9"
   echo "$L10"
   echo "$L11"
   echo "$L12"
   echo "$L13"
   echo "$L14"
   echo "$L15"
   echo "$L16"
   echo "$L18"
   echo "$L19"
   echo "$L20"
   f_hline
   echo "$Lh"
   echo "$LQ"
   echo
}

function f_testing_drya_defaults {
   f_header
   f_talk; echo "Testing DRYa defaults"
           echo " > package 'gnupg' installed?"
           echo " > Private key exists?"
           echo 
   # uDev: Se houver erros: `read -sn1` com pedido ao user para resolver
}

function f_testing_drya_defaults__verbose {
   # Apos a fx f_testing_drya_defaults acumular variaveis de status, apenas as relevantes serao mesncionadas aqui, para deixar o user informado do estado atual, permanentemente

   f_talk; echo "Main Menu for \`gpg\` (with chatGPT):"
           echo " > Tudo ok                (uDev)"
           echo " > Falta X                (uDev)"
           echo " > Permissoes de ~/.gnupg (uDev)"  # Costuma ser exigente com as permissoes. Usa `chmod 700 ~/.gnupg` para corrigir
           echo 
   f_talk; echo "Escolha uma opção (com instrucoes primeiro): "
}

function f_some_help {
   f_talk; echo "Info"
           echo " > Package 'gnupg' (GnuPG) when installed, provides the command \`gpg\`"
           echo
           echo " > Cuidado com 'Spoofing' significa falsificação de identidade digital."
           echo "   Alguém finge ser outra pessoa ou sistema (as chaves privadas podem sofrer spoofing)"
           echo "   As UID 'Name (comentario) <email>' podem ter por tras outras 'sec' (par de chaves) que nao aquele que parece"
           echo "   Uma vez que UID é so uma descricao, nao é fixo"
}

function f_GnuPG_main_menu__take_action {
   case "$v_ans" in
      0)   f_testing_drya_defaults; pause;;
      1)   f_run_with_confirm list_public_keys "Esta opção lista todas as chaves públicas disponíveis no seu keyring GPG."; ;;
      2)   f_run_with_confirm check_gpg_agent "Esta opção verifica se existem chaves privadas (secret keys) no seu sistema e lista as mesmas."; ;;
      3)   f_run_with_confirm generate_key "Será iniciado o assistente interativo para gerar uma nova chave GPG. Poderá ser necessário inserir nome, email e definir uma passphrase. Esta chave será armazenada localmente."; ;;
      4)   f_run_with_confirm import_key "Será importada uma chave a partir de um ficheiro existente (.asc, .gpg, etc.). Certifique-se de confiar na origem do ficheiro."; ;;
      5)   f_run_with_confirm export_public_key "Irá exportar uma chave pública para um ficheiro. Pode ser partilhado com outros utilizadores para que possam encriptar mensagens para si."; ;;
      6)   f_run_with_confirm export_private_key "Exporta a sua chave privada (sensível) para um ficheiro. **Atenção:** quem tiver acesso a este ficheiro poderá agir como si. Guarde com segurança."; ;;
      7)   f_run_with_confirm symmetric_store "Encripta um ficheiro localmente utilizando apenas uma passphrase (sem chaves públicas). Apenas quem souber a senha poderá desencriptar."; ;;
      17)  f_run_with_confirm symmetric_decrypt "Desencripta um ficheiro localmente utilizando apenas uma passphrase (sem chaves públicas). Apenas quem souber a senha poderá desencriptar."; ;;
      8)   f_run_with_confirm encrypt_for_recipient "Irá encriptar um ficheiro para um destinatário específico, utilizando a chave pública dele. Pode também optar por assinar o ficheiro com a sua chave privada."; ;;
      9)   f_run_with_confirm decrypt_file "Desencripta um ficheiro previamente encriptado (por si ou por outro), utilizando a chave apropriada ou passphrase."; ;;
      10)  f_run_with_confirm sign_file "Assina um ficheiro usando a sua chave privada (assinatura detached). O ficheiro original não é modificado."; ;;
      11)  f_run_with_confirm verify_signature "Verifica a autenticidade de um ficheiro usando a assinatura fornecida (.sig)."; ;;
      12)  f_run_with_confirm change_passphrase "Permite alterar a passphrase de uma chave existente. Será aberta a interface interativa do GPG."; ;;
      13)  f_run_with_confirm delete_key "Permite apagar uma chave pública e opcionalmente a chave privada associada. Esta ação é irreversível!"; ;;
      14)  f_run_with_confirm backup_all_keys "Exporta todas as suas chaves públicas e privadas para ficheiros de backup. Guarde estes ficheiros num local seguro e cifrado."; ;;
      15)  f_run_with_confirm restore_keys "Importa chaves públicas ou privadas a partir de ficheiros de backup exportados anteriormente."; ;;
      16)  f_run_with_confirm show_key_fingerprints "Mostra os fingerprints (impressões digitais) de todas as suas chaves públicas e privadas."; ;;
      18)  f_reset_GnuPG_like_fresh_install ;;
      19)  f_explaining_content_of_default_gnupg_directory; pause ;;
      20)  f_only_convert_content_to_OpenPGP_no_encription ;;

      h)   f_header; f_talk; f_some_help; pause ;;
      q|Q) echo "Adeus!"; exit 0 ;;
      *)   echo "Opção inválida."; pause ;;
  esac
}

function f_GnuPG_main_menu {
   # Menu Principal GnuPG

   f_deny_empty_vars 

   while true
   do

      # Apresentacao do menu: ASCII, mencionar vars relevantes, corpo/texto do menu
         f_header
         f_testing_drya_defaults__verbose 
         f_main_menu_text

      # Perguntar ao user: qual o numero da opcao que quer? (depois essa opcao, se tiver maiusculas, é convertido para minusculas)
         f_talk; echo -n "Escolha uma opção: "

         read -r v_ans
         
         v_ans=${v_ans,,}   # Nota: Em bash, as virgulas dentro de ${var,,} servem para converter o texto em minusculas
                            #       Exemplo:  `case "${v_ans,,}" in ... esac`

      # Take action on the option choosen and given as answer
         f_GnuPG_main_menu__take_action 

   done
}








# -------------------------------------------
# -- Functions above --+-- Arguments Below --
# -------------------------------------------









f_allow_empty_vars 

if [ -z $1 ]; then
   f_testing_drya_defaults 
   f_GnuPG_main_menu 

elif [ $1 == "." ] || [ $1 == "edit-self" ]; then
   bash e ${v_REPOS_CENTER}/DRYa/all/bin/drya-GnuPG.sh 

elif [ $1 == "i" ] || [ $1 == "install" ] || [ $1 == "install-gpg" ]; then
   #bash pk ?? gnupg  # Retorna uma var $v_last_check"
   #echo "Last check: $v_last_check"
   #read -sn1

   bash pk + gnupg

fi
