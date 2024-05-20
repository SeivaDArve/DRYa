#!/bin/bash

echo "Jarve running (uDev)"
echo " > type 'D clone try jarve' to download my repo"
echo " >> Use DRYa for shortcuts and commands"
echo " >> Use Jarve to decide what commands to run next"

while true
do
   echo "Starting ezGIT pull all"
   bash ${v_REPOS_CENTER}/ezGIT/ezGIT.sh v all &>/dev/null
   echo "ended at <date> (waiting 5 min to restart)"
   # uDev: sound at the end

done

