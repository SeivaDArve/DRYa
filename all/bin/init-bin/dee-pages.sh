#!/bin/bash
# Title: bully (or bully-pages (man pages, but stronger))
# Description: An app made for the software developer, that filters the developer's script text and retrieves all arguments from within the text with explanation (the explanation must be a commented line next to the --flag found). (This requires the script to be written in a certain style to facilitate things)
# Use: Whenever you develop a script with flags like: --flag-example, White at the line right below it, what that flag means. This way, this script allows you to avoid unecessary time writting and installing a specific man page for each script
#
#        





# uDev: the BEST documentation happens if you can open the source code and read it
#       Therefore: uDev: Create a grep function to grep all 'if [' and 'elif' in this document and along with that, search one more line below with the comment that tells what that function does





   #   uDev: Visualizacao grafica que um possivel output do dee-pages:
   #
   #   #+name: tree
   #   #+begin_src ditaa
   #     ROOT      
   #     |
   #     +--foo
   #     |  +----bar
   #     |  
   #     +--baz   
   #     +--bax   
   #     +--src   
   #     |  +--main
   #     |  |  +---java
   #     |  |  |   +---something
   #     |  |  |
   #     |  |  +---fine
   #     |  |
   #     |  +--yes
   #     |  +--no
   #   #+end_src

#
# uDev: if $1 == "var-converter"; then: 
#  
# We may use $(sed) to help us with variables
#  > If we want to code faster
#    Instead of writting '${v_REPOS_CENTER}' multiple times
#    We write <v_reposc> instead and close the file
#    Then we call var-converter to use sed on the file
#     > sed -i "s/<v_reposc>/\${v_REPOS_CENTER}/g" <name-of-file-here>
#
   #
   #
   # uDev: No interior dos scripts, 
   #       cada fx pode ter um titulo 'dee: ' 
   #       e tambem pode ter um Hashtag 'dee: fx-de-opcoes #46632'
   #
   #       cujo Hasgtag é "nested", ou seja:
   #
   #           #!/bin/bash
   #           # Title: X
   #           # dee: #T0
   #
   #           if $1 == Y; then  # dee: T1
   #              if $2 == Y; then  # dee: T11
   #              if $2 == C; then  # dee: T12
   #
   #           if $1 == Z; then  # dee: T2
   #              if $2 == Y; then  # dee: T21
   #
#
#
#
#
#
# ALTERNATIVA: 
# $ DD
# $ cat drya.sh | grep "\$1"
# $ 
#  
# OUTPUT:
#  
# $ elif [ $1 == "location" ]; then       # dee: ...
# $ elif [ $1 == "+" ]; then              # dee: ...
# $ elif [ $1 == "update" ]; then         # dee: ...
# $ elif [ $1 == "logout" ]; then         # dee: ...
# $ elif [ $1 == "clone" ]; then          # dee: ...
# $ elif [ $1 == "config" ]; then         # dee: ...
# $ elif [ $1 == "wsl" ]; then            # dee: ...
# $ elif [ $1 == "backup" ]; then         # dee: ...
# $ elif [ $1 == "eysek" ]; then          # dee: ...
# $ elif [ $1 == "seiva-up-time" ]; then  # dee: ...
# $ elif [ $1 == "ip" ]; then             # dee: ...
# $ elif [ $1 == "mac" ]; then            # dee: ...
# $ elif [ $1 == "install" ]; then        # dee: ...
# $ elif [ $1 == "ssh" ]; then            # dee: ...
#
#
#
#
#
#


# If drya-msgs are not ready, we may use this fx (info this file is loading)
#
#     # Verbose file (variables and outputs)
#        v_title="dee-pages"  # Name of this file
#        echo "DRYa: File started loading: DRYa's $v_title" >> $v_MSGS
#        echo "      > dee-pages: man pages you find by reading the source files" >> $v_MSGS






# Setup at terminal startup:
   alias dee="dee-pages: Choose a source file to extract instructiona (uDev)"

# Ask for a script to be filtered:
   # ... read v_file


# Filter the script and 1 more line after the pattern found
   # cat $v_file |  grep -A 1 "--flags..." ## uDev: Add one more line to this search









# If drya-msgs are not ready, we may use this fx (info this file ended loading)
#    
#    # Verbose file (variables and outputs)
#       echo "DRYa: File ended loading: DRYa's $v_title" >> $v_MSGS
#    
