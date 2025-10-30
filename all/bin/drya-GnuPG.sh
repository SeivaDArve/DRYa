#!/bin/bash
# Title: DRYa-GnuPG
# Description: Menu para operações GnuPG com explicações e confirmacao antes de executar




# Sourcing DRYa Lib 1: Color schemes
   __name__="drya-GnuPG.sh"  # Change to the name of the script. Example: DRYa.sh, ezGIT.sh, Patuscas.sh (Set this variable at the head of the file, next to title)
   v_lib1=${v_REPOS_CENTER}/DRYa/all/lib/libs/drya-lib-1-colors-greets.sh
   source $v_lib1 2>/dev/null || (read -s -n 1 -p "DRYa libs: $__name__: drya-lib-1 does not exist (error)" && echo )

   v_greet="DRYa"
   v_talk="DRYa-GnuPG: "



function f_permitir_variaveis_vazias {
   # Liga/Permite erros silenciosos, por exemplo a falta de iniciacao de variaveis (neste caso $1)
   set +u   
}

function f_deny_empty_vars {
   # Desliga/Rejeita erros silenciosos (a falta de inicializacao de variaveis)
   # Uma boa prática: faz com que qualquer variável não inicializada cause erro imediatamente — evita bugs silenciosos.
   set -u  
}



function pause {
   echo
   v_tlk=$(f_talk)
   read -rn 1 -p "${v_tlk}Prima \"Qualquer Tecla\" para continuar..."
}

function f_header {
   f_permitir_variaveis_vazias
   f_greet  
   f_deny_empty_vars 
}

function f_hline {
   f_permitir_variaveis_vazias
   f_hzl
   f_deny_empty_vars 
}

function f_ls {
   # Usa simplesmente o comando `ls` para facilitar o autocomplete nos momentos em que algum menu pede um nome de um ficheiro de entrada

   f_permitir_variaveis_vazias
   f_hline
   f_talk; echo "Comando \`ls\` para facilitar:" 
   echo
   ls -pA
   f_hline
   f_deny_empty_vars 
}

function f_gpg_path {
   # Descobrir o path para o executavel OU acabar com um valor positivo. De ambas as formas o script nao acaba nem com erro nem com um valor inexistente. 

   GPG=$(command -v gpg)  
}

function f_install_now {
   # Confirmar se quer instalar ja o `gnupg`
  
   # Usa drya-lib-1 para perguntar ao user se realmente quer Instalar
      v_txt="Install GPG" && f_anyK

   # Comando DRYa para detetar o pkg manager e adicionar o pacote
      bash pk + gnupg -y
      echo
}

function f_detetar_se_instalado {
   # Criar uma var $GPG com info do caminho do executavel

   # Descobrir o caminho do script instalado no OS
      f_gpg_path

   # Se nao existir nenhum, pergunta se quer instalar
      if [[ -z "$GPG" ]]; then

         f_header
         f_talk; echo "gpg não Instalado"
                 echo ' > Se nao quiser instalar, acede ao menu com `D gpg m`'
                 echo

         f_install_now  # uDev: Adicionar qqr outro comando para fazer bypass a esta fx e poder ser o menu a mesma
      fi

   # Descobrir o caminho do script (novamente, o user pode nao ter conseguido instalar no OS)
      f_gpg_path

   # Se continuar a nao existir nenhum, pergunta se quer realmente aceder ao menu
      if [[ -z "$GPG" ]]; then
         f_talk; echo "gpg não Instalado (confirmacao)"

         v_txt="Ver lista de comando à mesma" && f_anyK
      fi
}

function f_confirm {
   # Confirma cada acao a ser tomada. A ultima linha de codigo vai acabar TRUE ou FALSE propositada. Aproveitando uma das palavras "reservadas" do bash 'true'
   
   #
   # Exemplo de utilizacao (fx que vai executar sempre)
   #
   #     if true; then
   #        echo "foo"
   #     fi
   #
   #
   #     > 'true' pode ser substituido por expressoes: $(...) ou [[ ... == ... ]]
   #
   #     > No Bash, o if não avalia valores diretamente, mas o status de saída do comando. Vai desde 'if' até ';'
   #
   #     > 'if' assim suporta argumentos $1, $var, etc...
   #     
   #     > Possibilidade: `if f_confirm $1`
   #
   #     > Possibilidade: `if f_confirm "Texto como argumento 1"`
   #

   # Definir uma var $v_msg e garantir que nao subscreve nenhuma var #v_msg que existisse antes desta fx
      # Nota: O valor das variaveis que sao iniciadas com `local` sao valores temporarios, aplicam-se só dentro dessa fx. Quando a fx acaba, a variavel volta ao valor anterior
      # Nota: Em bash, é possivel dar um valor standard a uma variavel caso o utilizador nao de nenhuma no promprt ou noutra fx do codigo

      local v_msg=${1:-"Confirma?"}

   # Perguntar Sim ou Nao (so vai preencer uma variavel)
      read -rn1 -p "$v_msg (y|N): " ans
      echo

   # Caso as letras y ou Y sejam encontradas, sao literalmente encontradas. Isso significa que no final dessa linha, o "exit status" acaba em "0" o que significa 'true'
      [[ "$ans" =~ ^[Yy]$ ]]
}

function f_run_with_confirm {
   f_permitir_variaveis_vazias
   local func="$1"
   f_deny_empty_vars 
   shift
   local message="$*"

   f_header
   f_talk; echo "Instruções \`$func\` : "
   echo " > $message"
   f_hline

   v_ask=$(f_talk)
   v_ask="${v_ask}Deseja continuar com esta ação?"

   if f_confirm "$v_ask"; then
     #echo
     $func
   else
     echo "Ação cancelada."
   fi

   pause
}

function f_generate_key {
   v_fx="f_generate_key"
   f_header;
   f_talk; echo "Opcao: $v_ans: $v_fx"
           echo 
   f_talk; echo "Mini Instrucoes:"
           echo

   f_vb_generate_key; f_hline


   # Gerar chaves com o prompt interativo do `gpg`
      f_talk; echo "Chaves > Gerar (interativo)"
              echo

      $GPG --full-generate-key

              echo

   # Print das chaves geradas
      v_generated=$($GPG --list-secret-keys --keyid-format LONG)

      f_talk; echo "Chave gerada:"
      [[ -n $v_generated ]] && echo " > $v_generated" || echo " > (nenhuma)"
      echo

   # Concluir com uma divisao
      f_hline
}

function f_import_key {
   f_vb_import_key 

   f_ls
   f_talk; echo "Importar Ficheiro de chave: "
           echo " > Comando \`gpg --import <file>\` (uDev: enviar para instrucoes)"
           echo

   f_talk; echo "Escolha o Ficheiro de chave a importar: "
   read    -erp " < " file
           echo

   [[ ! -f "$file" ]] && echo " < " && return
   $GPG --import "$file"
}

function f_export_public_key {
   f_vb_export_public_key 

   echo "Cada chave 'KeyID' tem um identificador legivel 'UID'"
   echo
   read -rp  "UID ou KEYID da chave pública a exportar: " key
   read -erp "Ficheiro de saída: " out
   $GPG --export --armor "$key" >"$out" && echo "Exportado para $out"
}

function f_export_private_key {
   f_vb_export_private_key 

   read -rp "UID ou KEYID da chave privada a exportar: " key
   read -rp "Ficheiro de saída (CUIDADO): " out
   if f_confirm "Exportar chave privada para $out? Isto é sensível. Continuar?"; then
      $GPG --export-secret-keys --armor "$key" >"$out" && echo "Exportado para $out"
   else
      echo "Cancelado."
   fi
}

function f_symmetric_store {
   f_header; f_vb_symmetric_store;  f_ls
   f_talk; echo "Ficheiro a encriptar: "
   read -erp " > " infile
   [[ ! -f "$infile" ]] && echo " > Ficheiro não existe." && return
                           echo

   f_talk; echo "Novo nome do ficheiro de saída: "
           echo " > Default: $infile.gpg" 
   read -erp    " > " outfile
   outfile=${outfile:-"${infile}.gpg"}
   $GPG --symmetric --cipher-algo AES256 --output "$outfile" "$infile" && echo "Encriptado com passphrase para $outfile"
}

function f_symmetric_decrypt {
   f_vb_symmetric_decrypt 

   f_ls
   read -erp "Ficheiro de entrada (a desencriptar): " infile
   [[ ! -f "$infile" ]] && echo "Ficheiro não existe." && return

   read -erp "Ficheiro de saída, novo nome. (default: Terminal Output): " outfile
   
   if [ -z "$outfile" ]; then
      echo "Nenhum nome introduzido. Vai ser so imprimido no terminal" 
      $GPG -d $infile

   else
      $GPG -o $outfile -d $infile
   fi

   pause
}

function f_encrypt_for_recipient {
   f_vb_encrypt_for_recipient 

   read -e -rp "Ficheiro a encriptar: " infile
   [[ ! -f "$infile" ]] && echo "Ficheiro não existe." && return
   read -rp "UID/KEYID do destinatário: " recipient
   read -e   -rp "Ficheiro de saída: " outfile
   outfile=${outfile:-"${infile}.gpg"}
   if f_confirm "Deseja assinar o ficheiro com a sua chave privada?"; then
      $GPG --encrypt --sign --recipient "$recipient" --output "$outfile" "$infile"
   else
      $GPG --encrypt --recipient "$recipient" --output "$outfile" "$infile"
   fi
   echo "Ficheiro encriptado para $recipient em $outfile"
}

function f_decrypt_file {
   f_vb_decrypt_file 

   read -rp "Ficheiro a desencriptar: " infile
   [[ ! -f "$infile" ]] && echo "Ficheiro não existe." && return
   read -rp "Ficheiro de saída (ou Enter para default): " outfile
   outfile=${outfile:-"${infile%.gpg}"}
   $GPG --output "$outfile" --decrypt "$infile" && echo "Desencriptado para $outfile"
}

function f_sign_file {
   f_vb_sign_file 

   read -rp "Ficheiro a assinar: " infile
   [[ ! -f "$infile" ]] && echo "Ficheiro não existe." && return
   read -rp "Ficheiro de assinatura (.sig): " sigout
   sigout=${sigout:-"${infile}.sig"}
   $GPG --armor --detach-sign --output "$sigout" "$infile" && echo "Assinatura criada em $sigout"
}

function f_verify_signature {
   f_vb_verify_signature 

   # Note `read -e` permite usar 'readline' do bash interativo, ou seja, permite "autocomplete" com a tecla Tab e assim, encontra ficheiros ou diretorios que existam na pasta atual
   read -erp "Ficheiro original: " infile
   read -erp "Ficheiro .sig: " sig
   [[ ! -f "$infile" || ! -f "$sig" ]] && echo "Ficheiro(s) não encontrado(s)." && return
   $GPG --verify "$sig" "$infile"
}

function f_change_passphrase {
   f_vb_change_passphrase 

   read -rp "UID/KEYID da chave: " key
   echo "No prompt GPG, escreva: passwd"
   $GPG --edit-key "$key"
}

function f_show_key_fingerprints {
   f_vb_show_key_fingerprints 

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

function f_list_public_keys {
   f_header
   f_hline
   f_vb_list_public_keys
   pause


   f_hline
   f_talk; echo "Lista de Chaves públicas"
           echo ' > comando: `gpg --list-keys --keyid-format LONG`'
           echo

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
   echo
}

function f_delete_key {
   f_vb_delete_key 

   f_list_public_keys 

   f_talk; echo "UID ou KEYID da chave pública a apagar: "
   
   if [[ $v_last_search == "keys-found" ]]; then
      read -erp " < " key

      if f_confirm "Apagar chave pública $key?"; then
         $GPG --batch --yes --delete-key "$key"
      fi
      if f_confirm "Apagar também a chave privada (se existir)?"; then
         $GPG --batch --yes --delete-secret-and-public-key "$key"
      fi

   else
      echo " > Nao existe nenhuma chave para apagar"
   fi
   pause
}

function f_backup_all_keys {
   f_vb_backup_all_keys 

   read -rp "Prefixo para ficheiros de backup: " out
   $GPG --export-secret-keys --armor >"${out}.secret.asc"
   $GPG --export --armor >"${out}.pub.asc"
   echo "Backups criados: ${out}.secret.asc e ${out}.pub.asc"
}

function f_restore_keys {
   f_vb_restore_keys 

   read -rp "Ficheiro de chaves a importar: " file
   [[ ! -f "$file" ]] && echo "Ficheiro não encontrado." && return
   $GPG --import "$file"
}


function f_check_gpg_agent {
   f_vb_check_gpg_agent 

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

      if f_confirm "$v_ask"; then
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

function f_only_convert_content_from_OpenPGP_no_encription {
   echo "uDev"
}

function f_main_menu_text {
   L00=" | opc | fx"

    L0=" |  0  | Info > Status > DRYa default settings"
    L1=" |  1  | Info > Chaves > Listar as públicas / verificar existência"
    L2=" |  2  | Info > Chaves > Listar as privadas / verificar existência"
    L3=" |  3  | Info > Chaves > Gerar nova (interativo)"
    L4=" |  4  | Info > Chaves > Importar"
    L5=" |  5  | Info > Chaves > Exportar pública"
    L6=" |  6  | Info > Chaves > Exportar privada (cuidado)"
   L12=" | 12  | Info > Chaves > Mudar passphrase"
   L13=" | 13  | Info > Chaves > Apagar"
   L14=" | 14  | Info > Chaves > Backup de todas"
   L15=" | 15  | Info > Chaves > Restaurar"

   L20=" | 20  | Info > Convert > text/file to OpenPGP   (no encription)"
   L21=" | 21  | Info > Convert > OpenPGP   to text/file (no encription)"

    L7=" |  7  | Info > Encrypt > simétrica (com passphrase)"
   L17=" | 17  | Info > Decrypt > simétrica (com passphrase)"

    L8=" |  8  | Info > Encrypt > assimetrica para destinatário (chave pública)"
    L9=" |  9  | Info > Decrypt > ficheiro"

   L10=" | 10  | Info > Assinaturas > Assinar ficheiro"
   L11=" | 11  | Info > Assinaturas > Verificar assinatura"
   L16=" | 16  | Info > Mostrar fingerprints"
   L18=" | 18  | Info > Status > Reset package 'gnupg' (MUITO CUIDADO)"
   L19=" | 19  | Info > Status > Describing all contents at ~/.gnupg"

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
   echo "$L12"
   echo "$L13"
   echo "$L14"
   echo "$L15"
   f_hline
   echo "$L20"
   echo "$L21"
   echo "$L7"
   echo "$L17"
   echo "$L8"
   echo "$L9"
   f_hline
   echo "$L10"
   echo "$L11"
   echo "$L16"
   echo "$L18"
   echo "$L19"
   f_hline
   echo "$Lh"
   echo "$LQ"
   echo
}

function f_testing_drya_defaults {

   f_gpg_path

   v_secs=1

   f_talk; echo "Testing DRYa defaults (${v_secs}s)"
           echo " > software 'gnupg' installed?"
           echo " > software \"zip\" \"unzip\" installed?"
           echo " > Private key exists?"
           echo " > Apagar duplicados automaticamente?"
           echo "   (Sim)(Nao)(Copiar; Usar copia)"
           echo " > Pasta ~/.dryaGPG existe?"  # variavel exportada para o env: $v_drya_gpg
           echo " > Number of lines the terminal output STDOUT keeps"  #Numbers to small, allow less lines from the main menu. Or else, scroll will be needed when not using fzf
           echo 
           read -sn 1 -t $v_secs

   # uDev: Se houver erros: `read -sn1` com pedido ao user para resolver
}

function f_vb_testing_drya_defaults {
   # Apos a fx f_testing_drya_defaults acumular variaveis de status, apenas as relevantes serao mesncionadas aqui, para deixar o user informado do estado atual, permanentemente

   f_talk; echo "Main Menu for \`gpg\`:"
   f_hline
   f_talk; echo "Status:"
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
           echo
           echo " > fluNav: V"
           echo "   Existe \`V x\` para navegar para \$v_drya_gpg"
           echo "   (variavel exportada para o env) que normalmente aponta"
           echo "   para ~/.dryaGPG"



           # Flags para reduzir verbose do `gpg`
           #   --quiet → reduz a verbosidade (silencia mensagens de status).

           #   --batch → impede prompts interativos.
           #   
           #   --yes → assume “sim” nas confirmações.
           #   
           #   --no-tty → evita que o GPG use o terminal para entrada/saída (evita mensagens no TTY).
}















function f_vb_list_public_keys {
   # Instrucoes/Verbose curtas, sobre f_list_public_keys
   echo "Esta opção lista todas as chaves públicas disponíveis no seu keyring GPG."
}

function f_vb_check_gpg_agent {
   # Instrucoes/Verbose curtas, sobre f_check_gpg_agent 
   echo "Esta opção verifica se existem chaves privadas (secret keys) no seu sistema e lista as mesmas."
}

function f_vb_generate_key {
   # Instrucoes/Verbose curtas, sobre f_generate_key 
   echo "Será iniciado o assistente interativo para gerar uma nova chave GPG. Poderá ser necessário inserir nome, email e definir uma passphrase. Esta chave será armazenada localmente.";
}

function f_vb_import_key {
   # Instrucoes/Verbose curtas, sobre f_import_key 
   echo "Será importada uma chave a partir de um ficheiro existente (.asc, .gpg, etc.). Certifique-se de confiar na origem do ficheiro."
}

function f_vb_export_public_key {
   # Instrucoes/Verbose curtas, sobre f_export_public_key 
   echo "Irá exportar uma chave pública para um ficheiro. Pode ser partilhado com outros utilizadores para que possam encriptar mensagens para si."
}

function f_vb_export_private_key {
   # Instrucoes/Verbose curtas, sobre f_export_private_key 
   echo  "Exporta a sua chave privada (sensível) para um ficheiro. **Atenção:** quem tiver acesso a este ficheiro poderá agir como si. Guarde com segurança."
}

function f_vb_symmetric_store {
   # Instrucoes/Verbose curtas, sobre f_symmetric_store 
   echo  "Encripta um ficheiro localmente utilizando apenas uma passphrase (sem chaves públicas). Apenas quem souber a senha vai poder desencriptar."
}

function f_vb_symmetric_decrypt {
   # Instrucoes/Verbose curtas, sobre f_symmetric_decrypt 
   echo  "Desencripta um ficheiro localmente utilizando apenas uma passphrase (sem chaves públicas). Apenas quem souber a senha poderá desencriptar."
}

function f_vb_encrypt_for_recipient {
   # Instrucoes/Verbose curtas, sobre f_encrypt_for_recipient 
   echo  "Irá encriptar um ficheiro para um destinatário específico, utilizando a chave pública dele. Pode também optar por assinar o ficheiro com a sua chave privada."
}

function f_vb_decrypt_file {
   # Instrucoes/Verbose curtas, sobre f_decrypt_file 
   echo  "Desencripta um ficheiro previamente encriptado (por si ou por outro), utilizando a chave apropriada ou passphrase."
}

function f_vb_sign_file {
   # Instrucoes/Verbose curtas, sobre f_sign_file 
   echo  "Assina um ficheiro usando a sua chave privada (assinatura detached). O ficheiro original não é modificado."
}

function f_vb_verify_signature {
   # Instrucoes/Verbose curtas, sobre f_verify_signature 
   echo  "Verifica a autenticidade de um ficheiro usando a assinatura fornecida (.sig)."
}

function f_vb_change_passphrase {
   # Instrucoes/Verbose curtas, sobre f_change_passphrase 
   echo  "Permite alterar a passphrase de uma chave existente. Será aberta a interface interativa do GPG."
}

function f_vb_delete_key {
   # Instrucoes/Verbose curtas, sobre f_delete_key 
   echo  "Permite apagar uma chave pública e opcionalmente a chave privada associada. Esta ação é irreversível!"
}

function f_vb_backup_all_keys {
   # Instrucoes/Verbose curtas, sobre f_backup_all_keys 
   echo  "Exporta todas as suas chaves públicas e privadas para ficheiros de backup. Guarde estes ficheiros num local seguro e cifrado."
}

function f_vb_restore_keys {
   # Instrucoes/Verbose curtas, sobre f_restore_keys 
   echo  "Importa chaves públicas ou privadas a partir de ficheiros de backup exportados anteriormente."
}

function f_vb_show_key_fingerprints {
   # Instrucoes/Verbose curtas, sobre f_show_key_fingerprints 
   echo  "Mostra os fingerprints (impressões digitais) de todas as suas chaves públicas e privadas.
Serve para Verificação de identidade
1. Quando você recebe a chave pública de alguém, a fingerprint garante que a chave realmente pertence àquela pessoa.
2. Em vez de confiar cegamente na chave enviada, você compara a fingerprint com a que o dono publica em um site confiável ou te informa por outro meio seguro.
"

}





function f_GnuPG_main_menu__take_action {
   case "$v_ans" in
      0)   f_testing_drya_defaults; pause;;
      1)   f_list_public_keys       ;;
      2)   f_check_gpg_agent        ;;
      3)   f_generate_key           ;;
      4)   f_import_key             ;;
      5)   f_export_public_key      ;;
      6)   f_export_private_key     ;;
      7)   f_symmetric_store        ;;
      17)  f_symmetric_decrypt      ;;
      8)   f_encrypt_for_recipient  ;;
      9)   f_decrypt_file           ;;
      10)  f_sign_file              ;;
      11)  f_verify_signature       ;;
      12)  f_change_passphrase      ;;
      13)  f_delete_key             ;;
      14)  f_backup_all_keys        ;;
      15)  f_restore_keys           ;;
      16)  f_show_key_fingerprints  ;;
      18)  f_reset_GnuPG_like_fresh_install ;;
      19)  f_explaining_content_of_default_gnupg_directory; pause ;;
      20)  f_only_convert_content_to_OpenPGP_no_encription ;;
      21)  f_only_convert_content_from_OpenPGP_no_encription ;;
      h)   f_header; f_talk; f_some_help; pause ;;
      q|Q) echo "Adeus!"; exit 0 ;;
      *)   echo "Opção inválida."; pause ;;
  esac
}

function f_GnuPG_main_menu {
   # Menu Principal GnuPG

   f_deny_empty_vars 

   # Apresentacao do menu: ASCII, mencionar vars relevantes, corpo/texto do menu
      f_header
      #f_vb_testing_drya_defaults
      f_main_menu_text

   # Perguntar ao user: qual o numero da opcao que quer? (depois essa opcao, se tiver maiusculas, é convertido para minusculas)
      #f_talk; echo -n "Escolha uma opção: "
      #read -r v_ans
      
      #v_ans=${v_ans,,}   # Nota: Em bash, as virgulas dentro de ${var,,} servem para converter o texto em minusculas
                         #       Exemplo:  `case "${v_ans,,}" in ... esac`

   # Take action on the option choosen and given as answer
      #f_GnuPG_main_menu__take_action 

}








# -------------------------------------------
# -- Functions above --+-- Arguments Below --
# -------------------------------------------









# Standard inicial fx
   f_detetar_se_instalado 
   f_permitir_variaveis_vazias

if [ -z $1 ]; then
   f_testing_drya_defaults 
   f_GnuPG_main_menu 

elif [ $1 == "." ] || [ $1 == "edit-self" ]; then
   bash e ${v_REPOS_CENTER}/DRYa/all/bin/drya-GnuPG.sh 

elif [ $1 == "h" ]; then
   f_header; f_talk; f_some_help; pause 

elif [ $1 == "m" ] || [ $1 == "menu" ]; then
   # Permite ver o menu à mesma, caso gpg nao esteja instalado
   f_talk; echo "Menu Principal"
   f_main_menu_text

elif [ $1 == "0" ]; then
   f_testing_drya_defaults; pause

elif [ $1 == "1" ]; then
   f_list_public_keys       

elif [ $1 == "2" ]; then
   f_check_gpg_agent        

elif [ $1 == "3" ]; then
   f_generate_key           

elif [ $1 == "4" ]; then
   f_import_key             

elif [ $1 == "5" ]; then
   f_export_public_key      

elif [ $1 == "6" ]; then
   f_export_private_key     

elif [ $1 == "7" ]; then
   f_symmetric_store        

elif [ $1 == "17" ]; then
   f_symmetric_decrypt      

elif [ $1 == "8" ]; then
   f_encrypt_for_recipient  

elif [ $1 == "9" ]; then
   f_decrypt_file           

elif [ $1 == "10" ]; then
   f_sign_file              

elif [ $1 == "11" ]; then
   f_verify_signature       

elif [ $1 == "12" ]; then
   f_change_passphrase      

elif [ $1 == "13" ]; then
   f_delete_key             

elif [ $1 == "14" ]; then
   f_backup_all_keys        

elif [ $1 == "15" ]; then
   f_restore_keys           

elif [ $1 == "16" ]; then
   f_show_key_fingerprints  

elif [ $1 == "18" ]; then
   f_reset_GnuPG_like_fresh_install 

elif [ $1 == "19" ]; then
   f_explaining_content_of_default_gnupg_directory; pause 

elif [ $1 == "20" ]; then
   f_only_convert_content_to_OpenPGP_no_encription 

elif [ $1 == "21" ]; then
   f_only_convert_content_from_OpenPGP_no_encription 

elif [ $1 == "i" ] || [ $1 == "install" ] || [ $1 == "install-gpg" ]; then
   #bash pk ?? gnupg  # Retorna uma var $v_last_check"
   #echo "Last check: $v_last_check"
   #read -sn1

   f_install_now 

elif [ $1 == "ws" ]; then
   # Opcao dedicada ao DRYa Welcome screen
   # Managing and Informing about existent decrypted files in the system

   # Note: There are 3 situations:
   #       1. Dir is     found empty     > delete > dont bother (mention only to ssms)
   #       2. Dir is     found not empty > give a warning
   #       3. Dir is not found           > dont bother

   # Messages to send to ssms
      v_msg_1="DRYa-GnuPG: Removed empty dir $v_dryaGPG"
      v_msg_2="DRYa-GnuPG: No directory needs to be deleted with Decrypted files"

   function f_message_on_startup_screen {
      f_talk; echo -n       "GPG directory : "
        f_c8; echo          "existent!"
        f_rc; echo
   }

   if [[ -d $v_dryaGPG ]]; then
      # Pasta existe

      # Implementar opcao 1.
         rmdir $v_dryaGPG 2>/dev/null

      # Implementar opcao 2.
         v_status=$?
         [[ $v_status == "0" ]] && echo "$v_msg_1" >> $v_ssms
         [[ $v_status == "1" ]] && f_message_on_startup_screen 

   else
      # Implementar opcao 3.
         echo "$v_msg_2" >> $v_ssms
   fi


elif [ $1 == "op" ]; then
   # Tentar detetar que tipo de pacote é fornecido como arg $3 e tentar abrir

   #
   #  O GPG (GNU Privacy Guard) implementa o padrão OpenPGP (RFC 4880).
   #
   #  Um ficheiro .gpg é basicamente um container binário que pode conter:
   #   > dados cifrados (simétrica ou assimetricamente),
   #   > dados assinados (sem cifragem),
   #   > dados apenas “empacotados” (literal data packet),
   #   > combinações. Ex: cifrado + assinado
   #
   #  O formato interno tem “packets”  (estruturas identificadas por tipo): Public-Key Encrypted Session Key,
   #                                                                        Symmetrically Encrypted Data Packet, 
   #                                                                        Literal Data Packet, 
   #                                                                        etc.
   #

   #
   #  Listar os conteudos de um pacote/ficheiro .gpg
   #   > gpg --list-packets ficheiro.gpg
   #

   f_ls

elif [ $1 == "v" ] || [ $1 == "navigate-to-dryaGPG" ]; then
   # Create and Navigate to $v_dryaGPG
   # Note: It is using dryaSRC to allow `cd` in the main shell (does not `cd` in a sub-shell)

   mkdir -p $v_dryaGPG
   cd       $v_dryaGPG  # Not working in a sub-shell (it is using dryaSRC to do it)
   
elif [ $1 == "+" ] || [ $1 == "add-text-file-info-confidenntial-info" ]; then
    f_header


   #  {
   #    "name": "GitHub",
   #    "username": "joao",
   #    "password": "abc123",
   #    "url": "https://github.com",
   #    "ultima-alteracao-de-password": "2025-10-25"
   #    "notes": "2FA ativo"
   #    "permissoes-de-leitura-desta-chave": "Naghori" "Dv!" "DvR+IsM" "DArve" "Flowreshe"
   #  }



   # Desencriptar um .tar
   #  gpg -d minha_pasta.tar.gz.gpg | tar -xz



   function f_create_new_nano_name {
      # Criar novo nome de ficheiro usando data com: Ano + Mes + Dia + Nanosegundos

      v_data=$(date +'%Y-%m-%d-%N')
      v_data="$v_data.txt"
   }

   # Garantir que esse nome nao existe ja, para nao dar erro ao criar
      f_create_new_nano_name 
      [[ -f $v_dryaGPG/$v_data ]] && echo "Nome ja existe (incrivel), reenicia este comando"

   mkdir -p $v_dryaGPG

   f_talk; echo "Creating sensitive data:"

   f_hline
   f_talk; echo "Options:"
   echo " > Plain text file (empty, with JSON)"
   echo " > Directory       (empty, with JSON)"
   echo
   echo " > If prompt is not at .dryGPG dir, New creations will be moved there"

   f_hline  
   f_talk; echo "New name:"
           echo " > Default: '$v_data' (current date)"
   read -p      " > " v_sens
   echo

   v_sens=${v_sens:-"$v_data"}

   if [[ -n $v_sens ]]; then
      touch $v_dryaGPG/$v_sens
      echo " > Criado: $v_sens"

   else
      echo " > Nao Criado: $v_sens"
   fi

   f_hline  
   f_talk; echo "File content:"
   echo         " > (N)one (J)son (D)irectory (defaulti none)"
   read -p      " > " v_content
   echo

   
   f_hline
   f_talk; echo -n "Ready to edit "
     f_c5; echo -n "$v_sens"
     f_rc; echo    

   echo
   v_txt="Editar Ficheiro"; f_anyK
   echo

   bash e $v_sens

elif [ $1 == "add" ] || [ $1 == "add-dryaGPG-dir" ]; then
   mkdir -p $v_dryaGPG
   touch    $v_dryaGPG/y

elif [ $1 == "rm" ] || [ $1 == "remove-dryaGPG-dir" ]; then

   v_base=$(basename $v_dryaGPG)
   v_base="~/$v_base"

   if [[ -d $v_dryaGPG ]]; then
      # So se existir a pasta é que executa o processo todo de apagar

      f_header
      f_talk; echo "Removing $v_base"
      f_hline

      f_talk; echo 'Listing storage `ls` helping decision:'
      echo
      ls -pA $v_dryaGPG
      f_hline
      echo
      v_txt="Delete $v_base" && f_anyK
      echo
      f_talk; echo "Removing $v_base"

      #cd ~   # At dryaSRC then is an fx 'drya' that detects this argument first. It will `cd $HOME` and then run `D gpg rm` allowing always to remove $v_dryaGPG even if the prompt is located there
      rm -rf  $v_dryaGPG
      [[ ! -d $v_dryaGPG ]] && echo " > done" 
      f_hline

   else
      f_talk; echo "Directory does not even exist: $v_base"
   fi
         

elif [ $1 == "crack" ] || [ $1 == "bruteforce-crack" ]; then
   echo "uDev: Developing a tool to test cracking delays (simetric with passphrase)"

elif [ $1 == "q" ] || [ $1 == "Q" ]; then
   echo " > Exit"
   exit 0 

else
   f_talk; echo "Opcao desconhecida"

fi
