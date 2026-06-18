#!/usr/bin/env bash

set -e

echo "======================================"
echo "   powershell universal installer"
echo "======================================"

# detectar os
v_os_type="$(uname -s)"
echo "[info] os detectado: $v_os_type"

f_install_pwsh_debian() {
   echo "[info] sistema debian/ubuntu detectado"

   sudo apt-get update -y
   sudo apt-get install -y wget apt-transport-https software-properties-common

   wget -q https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb
   sudo dpkg -i packages-microsoft-prod.deb
   rm packages-microsoft-prod.deb

   sudo apt-get update -y
   sudo apt-get install -y powershell
}

f_install_pwsh_fedora() {
   echo "[info] sistema fedora/rhel detectado"

   sudo dnf install -y wget

   sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
   sudo curl -o /etc/yum.repos.d/microsoft.repo https://packages.microsoft.com/config/rhel/9/prod.repo

   sudo dnf install -y powershell
}

f_install_pwsh_arch() {
   echo "[info] sistema arch/manjaro detectado"

   if command -v yay >/dev/null 2>&1; then
      yay -S --noconfirm powershell-bin
   else
      sudo pacman -Sy --noconfirm powershell
   fi
}

f_install_pwsh_termux() {
   echo "[info] android termux detectado"

   set -e
   echo

   echo "[+] Atualizando pacotes..."
   pkg update -y
   pkg upgrade -y

   echo "[+] Instalando dependências..."
   pkg install -y wget tar curl

   ARCH=$(uname -m)

   case "$ARCH" in
       aarch64)
           PS_ARCH="linux-arm64"
           ;;
       x86_64)
           PS_ARCH="linux-x64"
           ;;
       *)
           echo "Arquitetura não suportada: $ARCH"
           exit 1
           ;;
   esac

   echo "[+] Obtendo versão mais recente..."
   LATEST=$(curl -s https://api.github.com/repos/PowerShell/PowerShell/releases/latest | grep '"tag_name"' | cut -d '"' -f4)

   FILE="powershell-${LATEST#v}-${PS_ARCH}.tar.gz"
   URL="https://github.com/PowerShell/PowerShell/releases/download/${LATEST}/${FILE}"

   echo "[+] Baixando $FILE..."
   mkdir -p $HOME/powershell
   cd $HOME/powershell

   wget -O powershell.tar.gz "$URL"

   echo "[+] Extraindo..."
   tar -xzf powershell.tar.gz

   chmod +x pwsh

   echo
   echo "[+] Tentando iniciar PowerShell..."
   echo

   ./pwsh

}

# detectar package manager
if command -v pkg >/dev/null 2>&1; then
   f_install_pwsh_termux

elif command -v apt >/dev/null 2>&1; then
   f_install_pwsh_debian

elif command -v dnf >/dev/null 2>&1; then
   f_install_pwsh_fedora

elif command -v pacman >/dev/null 2>&1; then
   f_install_pwsh_arch

else
   echo "[error] nenhum package manager suportado encontrado!"
   echo "suportado: pkg, apt, dnf, pacman"
   exit 1
fi

echo ""
echo "[ok] instalacao concluida!"
echo "testa com: pwsh"
