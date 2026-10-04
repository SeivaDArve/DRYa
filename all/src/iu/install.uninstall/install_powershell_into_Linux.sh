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


function fix_pwsh {

    # Esta função corrige o comando "pwsh" criado no Termux.
    # O erro acontece porque o proot-distro não pode ser executado
    # quando já estamos dentro de outro ambiente PRoot.
    #
    # O lançador antigo fazia:
    # Termux -> proot-distro -> Debian -> pwsh
    #
    # Mas se o comando era chamado já dentro do Debian/PRoot:
    # PRoot -> proot-distro
    #
    # o proot-distro bloqueia a execução.
    #
    # A solução é criar um lançador simples que chama o PowerShell
    # diretamente dentro do Debian existente.

    echo "[+] A remover lançador antigo..."

    # Remove o ficheiro pwsh antigo criado no Termux.
    # Ele estava a chamar proot-distro de forma incorreta.
    rm -f "$PREFIX/bin/pwsh"


    echo "[+] A criar novo lançador..."


    # Cria um novo comando chamado pwsh no Termux.
    # Quando escreveres "pwsh", ele:
    # 1. entra no Debian pelo proot-distro
    # 2. abre uma shell bash dentro do Debian
    # 3. inicia o PowerShell instalado em /data/data/com.termux/files/home/powershell/pwsh
    cat > "$PREFIX/bin/pwsh" <<'EOF'
#!/data/data/com.termux/files/usr/bin/bash

# Executa o PowerShell dentro do Debian.
# O Debian fornece a glibc necessária que o Termux não possui.
proot-distro login debian -- /bin/bash -c "/data/data/com.termux/files/home/powershell/pwsh"
EOF


    echo "[+] A dar permissões..."

    # Torna o lançador executável para poder ser chamado
    # como um comando normal:
    #
    # pwsh
    chmod +x "$PREFIX/bin/pwsh"


    echo
    echo "=================================="
    echo "pwsh corrigido com sucesso!"
    echo
    echo "Executa agora:"
    echo
    echo "    pwsh"
    echo "=================================="
}



function f_entrar_no_Debian_procurar_powershell_executar_powershell {
   echo "Entrar no Debian que acabou de ser instalado:"
   echo " > proot-distro login debian"
   echo
   echo "Atualizar"
   echo " > apt update -y"
   echo
   echo "Adicionar biblioteca:"
   echo " > apt install -y libicu-dev libicu*"
   echo
   echo "Encontrar o caminho para o binario do powershell"
   echo " > find / -name pwsh 2>/dev/null"
   echo
   echo "executar powershell:"
   echo " > /data/data/com.termux/files/home/powershell/pwsh"
}

function f_install_glibc_no_termux {
   # Função: instalar PowerShell no Termux usando Debian + proot-distro
   # Motivo: o PowerShell oficial precisa de glibc, mas o Termux usa bionic.
   # O Debian dentro do proot fornece o ambiente glibc necessário.


    echo "[+] Atualizando repositórios do Termux..."
    # Mantém o Termux atualizado antes de instalar pacotes
    pkg update -y && pkg upgrade -y


    echo "[+] Instalando proot-distro..."
    # proot-distro permite executar uma distribuição Linux
    # sem root e sem alterar o Android
    pkg install proot-distro -y


    echo "[+] Instalando Debian..."
    # Debian foi escolhido porque usa glibc e é leve
    # para executar ferramentas Linux como o PowerShell
    proot-distro install debian


    echo "[+] Entrando no Debian e instalando dependências..."

    # Executa comandos dentro do Debian:
    # - atualiza listas de pacotes
    # - instala wget para downloads
    # - instala libc6 (glibc)
    # - instala certificados SSL
    proot-distro login debian -- bash -c '

        apt update

        # wget será usado para baixar o PowerShell
        # libc6 fornece a glibc que falta no Termux
        # ca-certificates evita erros HTTPS
        apt install -y wget libc6 ca-certificates


        echo "[+] A descarregar PowerShell..."

        cd /opt


        # Baixa o PowerShell oficial para ARM64
        # (a maioria dos Android modernos é ARM64)
        wget -O powershell.tar.gz \
        https://github.com/PowerShell/PowerShell/releases/latest/download/powershell-linux-arm64.tar.gz


        echo "[+] A instalar PowerShell..."


        # Cria a pasta onde o PowerShell ficará instalado
        mkdir -p /opt/microsoft/powershell


        # Extrai os ficheiros do PowerShell
        tar -xzf powershell.tar.gz \
        -C /opt/microsoft/powershell


        # Cria um comando global dentro do Debian
        # para poderes escrever apenas: pwsh
        ln -sf /opt/microsoft/powershell/pwsh /usr/bin/pwsh


        echo "[OK] PowerShell instalado no Debian"
    '


    echo
    echo "[+] Criando comando pwsh no Termux..."

    # Cria um atalho no Termux:
    # quando escreveres pwsh, ele entra no Debian e abre PowerShell
    cat > "$PREFIX/bin/pwsh" << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash

proot-distro login debian -- pwsh
EOF


    chmod +x "$PREFIX/bin/pwsh"


    echo
    echo "=================================="
    echo "Instalação concluída!"
    echo
    echo "Agora podes iniciar com:"
    echo
    echo "    pwsh"
    echo "=================================="
}

function f_download_binario_powershell {
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

   #  echo
   #  echo "[+] Tentando iniciar PowerShell..."
   #  echo
   #  ./pwsh
}

f_install_pwsh_termux() {
   echo "[info] android termux detectado"

   # Nota:
   #     Em Linux, é interessante saber a diferenca entre PRoot e chroot

   f_download_binario_powershell
   f_install_glibc_no_termux
   fix_pwsh
   f_entrar_no_Debian_procurar_powershell_executar_powershell 
   


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
