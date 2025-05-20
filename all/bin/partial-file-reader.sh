#!/bin/bash
# Title: Partial file Reader
# Description: feed this script with a file name, and A grep search, it will tell the line number
#              or, feed a .org file name and a header name, this script will print the entire header

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
    echo "Executado diretamente"
else
    echo "Chamado de dentro de outro script"
fi


echo "script: ${BASH_SOURCE[0]}"
echo $0
