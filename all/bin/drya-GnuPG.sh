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





set -u  # Uma boa prática: faz com que qualquer variável não inicializada cause erro imediatamente — evita bugs silenciosos.

GPG=$(command -v gpg || true)  # Permite saber o path para o executavel OU acabar com um valor positivo. De ambas as formas o script nao acaba nem com erro nem com um valor inexistente
if [[ -z "$GPG" ]]; then
  echo "gpg não encontrado. Por favor instala o GnuPG e tenta novamente."
  exit 1
fi

pause() {
  echo
  read -rn 1 -p 'Prima "Qualquer Tecla" para continuar... '
}

confirm() {
  local msg=${1:-"Confirma?"}
  read -rn1 -p "$msg (y/N): " ans
  echo
  [[ "$ans" =~ ^[Yy]$ ]]
}

header() {
   #clear
   #echo "==============================================="
   #echo "        DRYa GnuPG Menu (with chatGPT)"
   #echo "==============================================="

   set +u   # Permite erros silenciosos, por exemplo a falta de iniciacao de variaveis (neste caso $1)
   f_greet  # esta fx liga    a permissao de erros silenciosos (a falta de inicializacao de variaveis, tal como $1)
   set -u   # esta fx desliga a permissao de erros silenciosos (a falta de inicializacao de variaveis)
}

f_run_with_confirm() {

   local func="$1"
   shift
   local message="$*"

   echo "--------------------------------------"
   echo "Instruções \`$func\` : "
   echo " > $message"
   echo "--------------------------------------"
   if confirm "Deseja continuar com esta ação?"; then
     echo
     $func
   else
     echo "Ação cancelada."
   fi
   pause
}

list_public_keys() {
  echo "Chaves públicas (gpg --list-keys):"
  $GPG --list-keys --keyid-format LONG
}

list_private_keys() {
  echo "Chaves privadas (gpg --list-secret-keys):"
  $GPG --list-secret-keys --keyid-format LONG
}

generate_key() {
  $GPG --full-generate-key
  echo "Chave gerada:"
  $GPG --list-secret-keys --keyid-format LONG
}

import_key() {
  read -rp "Ficheiro de chave a importar: " file
  [[ ! -f "$file" ]] && echo "Ficheiro não encontrado." && return
  $GPG --import "$file"
}

export_public_key() {
  read -rp "UID ou KEYID da chave pública a exportar: " key
  read -rp "Ficheiro de saída: " out
  $GPG --export --armor "$key" >"$out" && echo "Exportado para $out"
}

export_private_key() {
  read -rp "UID ou KEYID da chave privada a exportar: " key
  read -rp "Ficheiro de saída (CUIDADO): " out
  if confirm "Exportar chave privada para $out? Isto é sensível. Continuar?"; then
    $GPG --export-secret-keys --armor "$key" >"$out" && echo "Exportado para $out"
  else
    echo "Cancelado."
  fi
}

symmetric_store() {
  read -rp "Ficheiro a encriptar: " infile
  [[ ! -f "$infile" ]] && echo "Ficheiro não existe." && return
  read -rp "Ficheiro de saída: " outfile
  outfile=${outfile:-"${infile}.gpg"}
  $GPG --symmetric --cipher-algo AES256 --output "$outfile" "$infile" && echo "Encriptado com passphrase para $outfile"
}

encrypt_for_recipient() {
  read -rp "Ficheiro a encriptar: " infile
  [[ ! -f "$infile" ]] && echo "Ficheiro não existe." && return
  read -rp "UID/KEYID do destinatário: " recipient
  read -rp "Ficheiro de saída: " outfile
  outfile=${outfile:-"${infile}.gpg"}
  if confirm "Deseja assinar o ficheiro com a sua chave privada?"; then
    $GPG --encrypt --sign --recipient "$recipient" --output "$outfile" "$infile"
  else
    $GPG --encrypt --recipient "$recipient" --output "$outfile" "$infile"
  fi
  echo "Ficheiro encriptado para $recipient em $outfile"
}

decrypt_file() {
  read -rp "Ficheiro a desencriptar: " infile
  [[ ! -f "$infile" ]] && echo "Ficheiro não existe." && return
  read -rp "Ficheiro de saída (ou Enter para default): " outfile
  outfile=${outfile:-"${infile%.gpg}"}
  $GPG --output "$outfile" --decrypt "$infile" && echo "Desencriptado para $outfile"
}

sign_file() {
  read -rp "Ficheiro a assinar: " infile
  [[ ! -f "$infile" ]] && echo "Ficheiro não existe." && return
  read -rp "Ficheiro de assinatura (.sig): " sigout
  sigout=${sigout:-"${infile}.sig"}
  $GPG --armor --detach-sign --output "$sigout" "$infile" && echo "Assinatura criada em $sigout"
}

verify_signature() {

  # Note `read -e` permite usar 'readline' do bash interativo, ou seja, permite "autocomplete" com a tecla Tab e assim, encontra ficheiros ou diretorios que existam na pasta atual
  read -e -rp "Ficheiro original: " infile
  read -e -rp "Ficheiro .sig: " sig
  [[ ! -f "$infile" || ! -f "$sig" ]] && echo "Ficheiro(s) não encontrado(s)." && return
  $GPG --verify "$sig" "$infile"
}

change_passphrase() {
  read -rp "UID/KEYID da chave: " key
  echo "No prompt GPG, escreva: passwd"
  $GPG --edit-key "$key"
}

delete_key() {
  read -rp "UID/KEYID da chave pública a apagar: " key
  if confirm "Apagar chave pública $key?"; then
    $GPG --batch --yes --delete-key "$key"
  fi
  if confirm "Apagar também a chave privada (se existir)?"; then
    $GPG --batch --yes --delete-secret-and-public-key "$key"
  fi
}

backup_all_keys() {
  read -rp "Prefixo para ficheiros de backup: " out
  $GPG --export-secret-keys --armor >"${out}.secret.asc"
  $GPG --export --armor >"${out}.pub.asc"
  echo "Backups criados: ${out}.secret.asc e ${out}.pub.asc"
}

restore_keys() {
  read -rp "Ficheiro de chaves a importar: " file
  [[ ! -f "$file" ]] && echo "Ficheiro não encontrado." && return
  $GPG --import "$file"
}

show_key_fingerprints() {

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

check_gpg_agent() {
  local count
  count=$($GPG --list-secret-keys --with-colons 2>/dev/null | grep -c '^sec' || true)
  if [[ "$count" -eq 0 ]]; then
    echo "Nenhuma chave privada encontrada."
  else
    echo "Encontradas $count chaves privadas:"
    $GPG --list-secret-keys --keyid-format LONG
  fi
}

# MENU PRINCIPAL
while true; do
  header

  f_talk; echo "Escolha uma opção (com instrucoes primeiro): "
  cat <<EOF
 0) Instucoes Base
 1) Listar chaves públicas
 2) Listar chaves privadas / verificar existência
 3) Gerar nova chave (interativo)
 4) Importar chave
 5) Exportar chave pública
 6) Exportar chave privada (cuidado)
 7) Encriptação simétrica (com passphrase)
 8) Encriptar para destinatário (chave pública)
 9) Desencriptar ficheiro
10) Assinar ficheiro
11) Verificar assinatura
12) Mudar passphrase de uma chave
13) Apagar chave
14) Backup de todas as chaves
15) Restaurar chaves
16) Mostrar fingerprints
 Q) Sair

EOF

  f_talk; echo -n "Escolha uma opção: "
  read -r opt
  case "${opt,,}" in
  
      0)   clear; f_talk; echo "uDev: \`gpg\` command comes from 'gnupg' package"; pause ;;
      1)   f_run_with_confirm list_public_keys "Esta opção lista todas as chaves públicas disponíveis no seu keyring GPG."; ;;
      2)   f_run_with_confirm check_gpg_agent "Esta opção verifica se existem chaves privadas (secret keys) no seu sistema e lista as mesmas."; ;;
      3)   f_run_with_confirm generate_key "Será iniciado o assistente interativo para gerar uma nova chave GPG. Poderá ser necessário inserir nome, email e definir uma passphrase. Esta chave será armazenada localmente."; ;;
      4)   f_run_with_confirm import_key "Será importada uma chave a partir de um ficheiro existente (.asc, .gpg, etc.). Certifique-se de confiar na origem do ficheiro."; ;;
      5)   f_run_with_confirm export_public_key "Irá exportar uma chave pública para um ficheiro. Pode ser partilhado com outros utilizadores para que possam encriptar mensagens para si."; ;;
      6)   f_run_with_confirm export_private_key "Exporta a sua chave privada (sensível) para um ficheiro. **Atenção:** quem tiver acesso a este ficheiro poderá agir como si. Guarde com segurança."; ;;
      7)   f_run_with_confirm symmetric_store "Encripta um ficheiro localmente utilizando apenas uma passphrase (sem chaves públicas). Apenas quem souber a senha poderá desencriptar."; ;;
      8)   f_run_with_confirm encrypt_for_recipient "Irá encriptar um ficheiro para um destinatário específico, utilizando a chave pública dele. Pode também optar por assinar o ficheiro com a sua chave privada."; ;;
      9)   f_run_with_confirm decrypt_file "Desencripta um ficheiro previamente encriptado (por si ou por outro), utilizando a chave apropriada ou passphrase."; ;;
      10)  f_run_with_confirm sign_file "Assina um ficheiro usando a sua chave privada (assinatura detached). O ficheiro original não é modificado."; ;;
      11)  f_run_with_confirm verify_signature "Verifica a autenticidade de um ficheiro usando a assinatura fornecida (.sig)."; ;;
      12)  f_run_with_confirm change_passphrase "Permite alterar a passphrase de uma chave existente. Será aberta a interface interativa do GPG."; ;;
      13)  f_run_with_confirm delete_key "Permite apagar uma chave pública e opcionalmente a chave privada associada. Esta ação é irreversível!"; ;;
      14)  f_run_with_confirm backup_all_keys "Exporta todas as suas chaves públicas e privadas para ficheiros de backup. Guarde estes ficheiros num local seguro e cifrado."; ;;
      15)  f_run_with_confirm restore_keys "Importa chaves públicas ou privadas a partir de ficheiros de backup exportados anteriormente."; ;;
      16)  f_run_with_confirm show_key_fingerprints "Mostra os fingerprints (impressões digitais) de todas as suas chaves públicas e privadas."; ;;
      q|Q) echo "Adeus!"; exit 0 ;;
      *)   echo "Opção inválida."; pause ;;
  esac
done
