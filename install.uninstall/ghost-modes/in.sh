#!/bin/bash
# Title: Ghost in

# Description: Download this file to FAST install DRYa (and give it the meaning DO NOT! REPEAT YOURSELF)
#              It is an instalation sequence by priority. First line is most important, last line it depends

# Use: Do do have a fresh install of an OS? do you have internet? downliad this file and run it. Run once to a fresh machine


# Step
   sudo apt update  -y
   sudo apt upgrade -y

# Step
   sudo apt install git

# Step
   v_RP=~/Repositories/DRYa

   git clone \
      https://github.com/SeivaDArve/DRYa.git $v_RP

# Step
   sudo apt install vim figlet 




sudo apt install vim
