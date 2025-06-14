function pk {
   [[ -z $1        ]] && echo 'Help: `pk --help`'
   [[    $1 == "+" ]] && [[ $trid_pkgm == "apt"    ]] && echo "sudo apt install" 
   [[    $1 == "+" ]] && [[ $trid_pkgm == "pacman" ]] && echo "sudo pacman -S" 
   [[    $1 == "+" ]] && [[ $trid_pkgm == "dnf"    ]] && echo "sudo dnf install" 
   [[    $1 == "+" ]] && [[ $trid_pkgm == "zypper" ]] && echo "uDev" 
   [[    $1 == "+" ]] && [[ $trid_pkgm == "apk"    ]] && echo "apk add" 
   [[    $1 == "+" ]] && [[ $trid_pkgm == "pkg"    ]] && echo "pkg install" 
   [[    $1 == "+" ]] && [[ $trid_pkgm == "brew"   ]] && echo "brew install" 
   [[    $1 == "+" ]] && [[ -z $trid_pkgm ]] && echo "Variable not set: \$trid_pkgm" 
}

