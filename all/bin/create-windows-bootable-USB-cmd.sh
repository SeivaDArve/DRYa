#!/bin/bash
# Title: Create Windows bootable USB intallation with Windows terminal
__name__="create-windows-bootable-USB-cmd.sh"  # Change to the name of the script. Example: DRYa.sh, ezGIT.sh, Patuscas.sh (Set this variable at the head of the file, next to title)

# Sourcing file with colors 
   v_lib1=${v_REPOS_CENTER}/DRYa/all/lib/libs/drya-lib-1-colors-greets.sh
   [[ -f $v_lib1 ]] && (source $v_lib1 || read -s -n 1 -p "DRYa libs: $__name__: drya-lib-1 does not exist (error)")

   function f_usb_tut_2 {  # uDev: rename to: _part_00
      clear
      figlet Windows USB
   }

   function f_example_0 {  # uDev: rename to: _part_0
      echo "Procedimento para o PC reconhecer o HD"
      echo " > Também resolve HD retirado de XBOX ONE, DVR, etc..."
      echo 
      echo "Para navegar no tutorial:"
      echo " > Tecla 'S' para o passo Seguinte"
      echo " > Tecla 'A' para o passo Anterior"
      echo 
   }

   function f_example_1 {  # uDev: rename to: _part_1
            echo
      f_c1; echo    '(exemplo)'
            echo    '|--------------------------------------------------------------|'
            echo    '| Microsoft Windows [Version 10.0.22631.44.60                  |'
            echo    '| (c) Microsoft Corporation. Todos os direitos Reservados.     |'    
            echo    '|                                                              |'
            echo -n '| C:\>'
      f_c2; echo -n       'diskpart'
      f_c1; echo                  '                                                 |'
      f_c1; echo    '|                                                              |'
            echo    '| Microsoft Windows [Version 10.0.22631.44.60]                 |'
            echo    '| (c) Microsoft Corporation. Todos os direitos Reservados.     |'    
            echo    '|                                                              |'
            echo    '| DISKPART>'
      f_c1; echo    '|--------------------------------------------------------------|'
      f_rc; echo
   }

   function f_example_ask {
      read -n 1 -p "Press [ENTER]"
   }


   # Greet the user
      f_usb_tut_2
      f_example_0 
      f_example_ask

   # Passo 1
      # 1- No Prompt digite DISKPART, quando ele abrir aparecera escrito DISKPART a esquerda

      f_usb_tut_2
   
      echo "Passo 1: "
      echo "  No prompt digite DISKPART, quando ele abrir aparecerá escrito DISKPART a esquerda"

      f_example_1
      f_example_ask

   # Passo 2:
      # Passo 2: Digite LIST DISK, esse comando ira listar is HD's instalados na maquina, preste muita atencao para nao escolher o HD errado
      f_usb_tut_2

               echo    "Passo 2:"
               echo    "  Digite LIST DISK, esse comando ira listar os HD's instalados na maquina"
               echo
         f_c1; echo    '(exemplo)'
               echo    '|--------------------------------------------------------------|'
               echo    '| Microsoft Windows [Version 10.0.22631.44.60]                 |'
               echo    '| (c) Microsoft Corporation. Todos os direitos Reservados.     |'    
               echo    '|                                                              |'
               echo -n '| C:\>'
         f_c2; echo -n       'diskpart'
         f_c1; echo                  '                                                 |'
         f_c1; echo    '|                                                              |'
               echo    '| Microsoft DiskPart version 10.0.22621.1                      |'
               echo    '|                                                              |'
               echo    '| Copyright (C) Microsoft Corporation.                         |'
               echo    '| On computer: YourName                                        |'
               echo    '|                                                              |'
               echo -n '| DISKPART>'
         f_c2; echo -n            'list disk'
         f_c1; echo    '                                           |'
               echo    '|                                                              |'
               echo    '| Disk ###  Status         Size     Free     Dyn  Gpt          |'
               echo    '| --------  -------------  -------  -------  ---  ---          |'
               echo    '| Disk 0    Online          476 GB      0 B        *           |'
               echo    '| Disk 1    Online           59 GB    29 MB                    |'
               echo    '|                                                              |'
               echo    '| DISKPART>                                                    |'
               echo    '|--------------------------------------------------------------|'
         f_rc; echo

      f_example_ask

   # Passo 3:
      # 3-  Digite SELECT DISK "X", no lugar do X colocar o numero referente ao HD que deseja formatar, colocar sem aspas.
      f_usb_tut_2


      function f_cwusb_passo_3 {
              echo    "Passo 3:"
              echo -n '  Digite "SELECT DISK '
        f_c2; echo -n                       'X'
        f_rc; echo                           '", mas no lugar do X colocar o numero'
              echo    '  referente ao HD que deseja formatar, colocar sem aspas.'
              echo    "  Preste muita atençao para nao escolher o HD errado"
              echo
        f_c1; echo    '(exemplo)'
              echo    '|--------------------------------------------------------------|'
              echo    '| Microsoft Windows [Version 10.0.22631.44.60]                 |'
              echo    '| (c) Microsoft Corporation. Todos os direitos Reservados.     |'    
              echo    '|                                                              |'
              echo -n '| C:\>'
        f_c2; echo -n       'diskpart'
        f_c1; echo                  '                                                 |'
              echo    '|                                                              |'
              echo    '| Microsoft DiskPart version 10.0.22621.1                      |'
              echo    '|                                                              |'
              echo    '| Copyright (C) Microsoft Corporation.                         |'
              echo    '| On computer: YourName                                        |'
              echo    '|                                                              |'
              echo -n '| DISKPART>'
        f_c2; echo -n            'list disk'
        f_c1; echo                        '                                           |'
              echo    '|                                                              |'
              echo    '| Disk ###  Status         Size     Free     Dyn  Gpt          |'
              echo    '| --------  -------------  -------  -------  ---  ---          |'
              echo    '| Disk 0    Online          476 GB      0 B        *           |'
              echo    '| Disk 1    Online           59 GB    29 MB                    |'
              echo    '|                                                              |'
      }

      f_cwusb_passo_3

              echo    '| DISKPART>                                                    |'
              echo    '|--------------------------------------------------------------|'
        f_rc; echo
        f_c4; echo    ' No seu PC, qual é o numero do disco do HD que vai selecionar?  '
        f_c1; echo -n '  DISKPART>'
        f_c2; echo -n            'select disk '


      function f_cwusb_passo_3_final {
              echo -n '| DISKPART>'
        f_c2; echo               "$v_disk"
        f_c1; echo    '|--------------------------------------------------------------|'
      }

            

            read v_disk
      f_rc; echo
      f_c4; echo -n " Confirme se vai selecionar o disco "
      f_c2; echo    "$v_disk"
      f_rc; echo    '  > "S" sim; "N" nao'
            echo -n '  > '
            read v_ans

         v_disk="select disk $v_disk"

         [[ $v_ans == "s" ]] || [[ $v_ans == "S" ]] && clear && f_usb_tut_2 && f_cwusb_passo_3 && f_cwusb_passo_3_final
         [[ $v_ans == "n" ]] || [[ $v_ans == "N" ]] && echo -e "\nOperacao cancelada: a Sair"; exit 
         echo

      f_rc
      f_example_ask

   #  4-  CLEAN
   #  5-  CREATE PARTITION PRIMARY
   #  6-  SELECT PARTITION 1
   #  7-  ACTIVE
   #  8-  FORMAT FS=NTFS QUICK ou FORMAT FS=FAT QUICK
   #      (FAT para cartoes de memoria, pendrives, HDs externos e outros dispositivos).
   #  9-  ASSIGN
   #  10- EXIT

