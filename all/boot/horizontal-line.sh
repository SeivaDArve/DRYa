#!/bin/bash
# Title: Horizontal line
# Description: Reads who many columns there are in the current terminal and prints the equivalent ammout in a choosen character

function f_hzl {
   # Prints an horizontal line

   # If the script that used this library does not set the variable that fills the line, then the character is set as default here
      [[ -z $v_hzl ]] && v_hzl="-"
      
   v_cols=$(tput cols)
   printf "%*s" $v_cols | tr " " "$v_hzl"
}
