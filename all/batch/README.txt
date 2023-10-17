# Title: Batch files 
# Description: In thi directory we will have .bat files or other windows files

# Directory: shut-restart-hibernate-sleep
   It contains .bat files that either shutdown windows, restar, hibernate or puts it to sleep
   
   # Tutorial 1: how to create such scripts on windows alone {
      (source: https://www.computerhope.com/issues/ch000321.htm)

      Below are the steps required for creating a shutdown, restart, and hibernate shortcut for windows.
      1 - Create a new shortcut with mouse's right click button.
         For the location of the shortcut, enter one of the following commands, depending on what you want to do.

         1.1 - To shut down the computer, type the following line in the location text field.
               'shutdown.exe /s /t 00'

         1.2 - To restart the computer, type the following line in the location text field.
               'shutdown.exe /r /t 00'
   
         1.3 - To hibernate the computer, type the following line in the location text field.
               'shutdown.exe /h'

      2 - Click Next, and then type either Shut down, Restart, or Hibernate for the name of the shortcut. Once the shortcut is named, click Finish. 

   }
   
   # Tutorial 2: how to call batch scripts from the terminal using Bash on windows {
      (source: https://stackoverflow.com/questions/44739204/how-to-run-bat-or-cmd-files-from-bash-for-windows-10) 
      
      1 - You need to specify the full path to cmd.exe 
            (which is '/mnt/c/Windows/System32/cmd.exe /c') 

          If you want to run a script, you issue the command: 
            'mnt/c/Windows/System32/cmd.exe /c some-file-that-in-this-case-is-a-link.lnk'

      2 - You can add the following to your ~/.bash_aliases to enable you to easily run the command: 
            alias cmd='/mnt/c/Windows/System32/cmd.exe /c'
         
          Now you can run *.bat files with:
            '$ cmd ./test.bat'

      3 - You can also alias a specific file forever with:
            alias go-file='/mnt/c/Windows/System32/cmd.exe /c ~/example-directory/specific.file.bat' 
   }
