#!/bin/bash
# Title: Execute this file simply to source (reset) ~/.bashrc
# description: This file contains 2 ways of sourcing ~/.bashrc (one correct and one wrong)

# Wrong way (because if the script that calles this file is listed under ~/.bashrc than that shell will enter in a loop):
#alias src="source ~/.bashrc"

# CORRECT WAY (you can paste these following functions inside ~/.bashrc or inside a side script called by ~/.bashrc):
alias src="go gnome-terminal; exit" ## This command is same as: "source ~/.bashrc" (but needs the function: go)

function go {
        # This function opens applications apart from the terminal. It means that you can close the terminal after the aplications launch and the terminal being killed does not kill the apps it created
        for v_arg in $@
        do
                setsid $v_arg &>/dev/null
        done
}

