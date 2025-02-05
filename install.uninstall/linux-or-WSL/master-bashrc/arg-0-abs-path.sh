#!/bin/bash
# Title: Script to echo/store the name of the running script

clear

function f_get_script_current_abs_path {

	# no matter from where we will execute this script, $SCRIPT_DIR will indicate the correct directory where this script is located
	_SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
	echo "This script is written/located at:"; 
	echo " > $_SCRIPT_DIR";
	
	function f_test1 {
		# This does not work, it is subjective to change. it depends from where you ryn the script
		_drya_pwd=$(pwd)
		echo " > $_drya_pwd"
	}
}

f_get_script_current_abs_path

echo
echo "Script name:"
echo " > $0"
