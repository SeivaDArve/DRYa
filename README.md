# DRYa

# DRYa acronym
### Do not repeat yourself!  Install one of these utilities to backup your config files and this way, after a fresh format, all your settings will be there. You may use this software to improve your tasks, making your computer (machine) work for you instead of you working for the machine. You should simply automate your tasks once and save them at your choosen Butler.
"Don't + Repeat + Yourself + Application": Your personal assistant. Similar to Alexa, Cortana, Siri, jarvis... but as a config manager. Keep your tools and workflow always up to date in all your devices. Later domotics will be added to the project with proper documentation until it becomes Fool/noob proof.

# Description
- This script is an incentive to always tweak your machine by the command line OR to automate all GUI tasks, so that you don't have to repeat them
- This is the result of a Linux newbie studying and creating a cross platform app from scratch. I don't think there is no better exercise to practice Linux other than developing my own cross platform util. Drya is a git repository that after downloading, gives you the choice to depoy into your system, a software buttler. The bash buttler (the main one so far) is called Jarve.

# Brainstorming
This is a list of all ideas to be put into the project before starting coding
- "If you don't have good friends, program one".
- drya should be the first program installed as soon as you touch any new machine and then can deploy your personal butler, just like a Bash butler called Jarve or a python butler called Mia
- When you open drya app, it should work like a browser where your installed apps may be bookmarked to appear at the main page (gitMenu, jarve, combyene, mia, etc...)
- drya is supposed to be a "software bender". It means that the user may be able to do every single thing in real life with the help of drya nust by givinh simple commands. "If you don't have good friends, program one".

# Instalation
- DRYa is mainly a bash shell script
- Open a terminal and clone the repository from github and paste it into ~/Repositories/DRYa with the command: `print("git clone https://github.com/SeivaDArve/DRYa.git ~/Repositories/DRYa")`
- at your ~/.bashrc you simply "source" DRYa.sh manually or you can use the in-built script at ~/Repositories/DRYa/install.uninstall
- All scripts must be commented inside the code so that you can read and know what it is doing... The purpouse is to learn while being usefull. If the code is not commwnted enough, you can contribute ti it by a pull request

# uDev
"Under Development"
Whenever you open a script from either this repository or any Seiva's github, it means "a message for further development". It is noting down what needs to be done there

## Drya can deploy these buttlers:
+ jarve (for home keeping and remote assistance - an automated linux account on raspberry pi)
+ Clone + Delete any util from Seiva D'Arve's github.com
+ ... 

# Software under development
Jarve is the main focus so far because you can find Bash everywhere, even in a Termux terminal (Androi app)

## DRYa's main focus
It is under development to integrate inside jarve in the future as a package manager also

#### Jarve in termux
Do you need to format your machine? jarve may help you while your machine is offline, guiding your steps through the installation. You should also save your configs during the installation into jarve so that the nest time you remember. By remembering your previous user nickname (for example), jarve may restore all your config files into the fresh install without them breaking (if your saved configs have another user name, they will not correspond with the new user name, right?)

# GitHub - "Seiva D'Arve"
Overview: 	https://github.com/SeivaDArve
Repositories:	https://github.com/SeivaDArve?tab=repositories 
