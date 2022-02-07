#/bin/bash
# Title: install jarve at your home folder (~/.jarve)
# Description: Installing means copy files to ~/.bashrc. In the future you can run it on windows, android and ios
# Mothod: Prompting a menu to choose
# Displaying ASCII logo for jarve. running jarve.
cat ../all/.jarve/all/img/CLI/jarve-icon.txt
# Also in future: display whoami, and give a special ID for the MACHINE, so that it can be listed on jarve-subPocket. the machine, username and id numer, as well as jarve-icon.txt should run at the level of .bashrc"

# Menu
# Asking user: Do you want to Intall, Re-install or Remove?
echo "Hi... do you want to: (i)nstall, (u)ninstall or (l)and your User here?"
read _ans

# If user says "Install jarve":
function _install () {
    # adding files to ~/.jarve
    mkdir ~/.jarve
    cp -r ../all.jarve ~/.jarve/*;	echo "'jv.sh'  was copied correctly"
    cp ../all/jv/readme.md ~/.jarve;	echo "'readme.md' file was copied to the same folder as jv.sh and it's subfolders correctly"


    # Creating a backup file from ~/.bashrc to ~/.jarve/h.h/bak
    cp ~/.bashrc ~/.jarve/h.h/bak;		echo "a copy of '~/.bashrc' was added to '~/.jarve/h.h/bak'"


    # adding jv.sh to ~/.bashrc
    echo " " >> ~/.bashrc
    echo "# jarve command 'jv' sits here:" >> ~/.bashrc
    echo 'alias jv="~/.jarve/jv.sh"' >> ~/.bashrc
    echo "'jv' alias was added to '~/.bashrc' file correctly"


    ## Do you need to run .fish shell commands? 
    ##(No if you asked fish to execute this .bash, Yes if you are running this .bash to install something in .fish)
    ## empty


    # set _varInstalled=1


    # For debugging process:
    echo "--- jarve was installed - code:Jhng" 
}
if [ ${_ans} = "y" ]; then
echo "ready?"
fi 	#_install
echo "--- was jarve installed?? - before this line you should see a matching code:Jhng"











# If user says "Remove jarve":
function _remove () {
    echo "nothing to remove yet"
}
_remove

















# If user says "Restore my pc by installing backup's and then Uninstall":
## empty

# User said: Re-Install
## empty
