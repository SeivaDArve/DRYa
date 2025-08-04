# Title: README.txt
# Description: Content of this library directory (with explanation)

# uDev: Change name of lib 1 to: drya-lib-1-colors-greets.sh to drya-lib-1-text-manip-colors-greets.sh

# Directory contents (detected with `ls`)
   drya-lib-0-template-for-missing-libs      # uDev: If main scripts detect missing libs, they should know how to download the lib file from github.com/DRYa/... (or entire DRYa repo)
   drya-lib-1-colors-greets.sh               # Text manipulation for better verbose output for scripts
   drya-lib-2-tmp-n-config-files.sh          # Supports current script with extra files like temporary files
   drya-lib-3-nanD.sh                        # Searches files across the system after a scan. Detects changes and brings those changed files
   drya-lib-4-dependencies-packages-git.sh   # For each script, Tests if all dependencies are met
   drya-lib-5-all-info-arg-0.sh              # Usado para saber em que pasta estao o script a executar, e evitar navegar ate a pasta dele para fazer alteracoes
   drya-lib-6-call-python-elisp-etc
   README.txt

# Directory ./cat contents:
   This direcotry contains a copy of each lib, but just the header, just the way it may be called by a sub-process

   Example on how to use: 
      1. A vimscript creates an output file after searching bash text, or bash functions
      2. If that files need any drya-lib, then before bash runs the output file from vimscript, we have to concat `source drya-lib--` into the output file
      3. So, we concat drya-lib-- into the first lines of the output file, then we run a bash command to execute 
