#!/bin/bash
# Title: history log
# Description: to remove last 3 fields of the path of the dir where the DRYa installer is located

# v_pwd is used to store current dir
   v_pwd=$(pwd)

# v_pwd2 is used to store current dir but reversed by characters
   # REV is needed to make sure we find the last fields
      v_pwd2=$(echo $v_pwd | rev)

# Cut everything from the string except selected fields
   # Cut last field
     v_1=$(echo $v_pwd2 | cut -d / -f 1)

   # Cut second last field
     v_2=$(echo $v_pwd2 | cut -d / -f 2)

   # Cut third last field
     v_3=$(echo $v_pwd2 | cut -d / -f 3)


# Last 3 variables, when they were cut, their text was reversed by characters
   # Re-reversing (correcting) variable 1:
     v_1=$(echo $v_1 | rev)

   # Re-reversing (correcting) variable 2:
     v_2=$(echo $v_2 | rev)

   # Re-reversing (correcting) variable 3:
     v_3=$(echo $v_3 | rev)

# Using SED to find our 3 variables inside our saved v_pwd variable
   # sed needs to replace the text of our variable with 'nothing' along with a slash '/'
      # sed expression is usually: sed 's/pattern/replacement/g'
      # To replace the pattern with 'nothing' we use: sed 's/pattern//g'
      # But we need to find a '/' and that would create conflicts
      # To avoid conflicts, we will use the supported syntax: sed 's,pattern,replacement,g'
      # The pattern we need to search is a slash and a variable: '/' + $v_1
         # Therefore the pattern for the first field is:  "/$v_1"
         # Therefore the pattern for the second field is: "/$v_2"
         # Therefore the pattern for the third field is:  "/$v_3"
         # sed needs variables to be surrounded like: '"$var"' to be recognized.

   # From the original path, remove the last 3 fields and storing inside a temporary file 
      # (To avoid conflicts it is stored inside a file instead of a variable)

      # Making the hidden directory where the tmp file will be stored
         mkdir -p ~/.tmp/

      # Creating an empty file
         touch ~/.tmp/v_pwd3

      # Transporting the text found into the empty file
         echo $v_pwd | sed 's,'"/$v_1"',,g' | sed 's,'"/$v_2"',,g' | sed 's,'"/$v_3"',,g' > ~/.tmp/v_pwd3

# Retrieving the text from the file into a variable we can use
   declare found_DRYa_at=$(cat ~/.tmp/v_pwd3)

# An environment variable may be needed (in case all this process is a stand-alone file)
   export found_DRYa_at

# Deleting the unnecessray temporary file (the dir is automaticaaly deleted by DRYa at startup)
   rm ~/.tmp/v_pwd3

# Display the entire result of this script:
   echo $found_DRYa_at


