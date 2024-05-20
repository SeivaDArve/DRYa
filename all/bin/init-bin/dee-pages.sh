#!/bin/bash
# Title: bully (or bully-pages (man pages, but stronger))
# Description: An app made for the software developer, that filters the developer's script text and retrieves all arguments from within the text with explanation (the explanation must be a commented line next to the --flag found). (This requires the script to be written in a certain style to facilitate things)
# Use: Whenever you develop a script with flags like: --flag-example, White at the line right below it, what that flag means. This way, this script allows you to avoid unecessary time writting and installing a specific man page for each script
#
#        
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
   # uDev: No interior dos scripts, cada fx pode ter um titulo 'dee: ' e tambem pode ter um Hashtag 'dee: fx-de-opcoes #46632'
   #
   #

# Verbose file (variables and outputs)
   v_title="dee-pages"  # Name of this file
   echo "DRYa: File started loading: DRYa's $v_title" >> $v_MSGS
   echo "      > dee-pages: man pages you find by reading the source files" >> $v_MSGS

# Setup at terminal startup:
   alias dee="dee-pages: Choose a source file to extract instructiona (uDev)"

# Ask for a script to be filtered:
   # ... read v_file


# Filter the script and 1 more line after the pattern found
   # cat $v_file |  grep -A 1 "--flags..." ## uDev: Add one more line to this search

# Verbose file (variables and outputs)
   echo "DRYa: File ended loading: DRYa's $v_title" >> $v_MSGS

