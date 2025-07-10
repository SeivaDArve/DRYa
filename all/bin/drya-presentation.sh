#!/bin/bash
# Title: Also adding normal text to figlet ascii text

# ASCII text
   clear
   figlet "DRYa"; 

# Normal text top
   tput cup 3 23; 
   echo D.R.Y.a.; 

# Normal text
   tput cup 4 23; 
   echo "Don't Repeat Yourself (app)"; 

# Returning the cursor down
   tput cud 1 
