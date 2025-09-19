
   # Sourcing DRYa Lib 1: Color schemes
      v_lib1=${v_REPOS_CENTER}/DRYa/all/lib/drya-lib-1-colors-greets.sh
      [[ -f $v_lib1 ]] && source $v_lib1 || read -s -n 1 -p "DRYa: drya-lib-1 does not exist (error)"

      v_greet="DRYa"
      v_talk="DRYa: "

