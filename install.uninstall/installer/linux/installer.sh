#!/bin/bash
# Title: Local installer for drya
# Use: copies files from local drya repo which is under development (or which is a fresh download) and pastes it on the system to run imediatly
# This script is not supposed to be destructive or to uninstall anything.
# README at the bottom of the page to describe the process and the logic

function f_greet {
	echo "This sotware will run smoothly by only invoking .../DRYa/all/drya.sh"
	echo "This installer is an extra to add .desktop entries and all that"
}

function f_export_updated_dryarc {
	# Replace ~/.config/h.h/.dryarc for this updated file: ./dryarc
	mkdir -p ~/.config/h.h/
	cp ./future-dryarc ~/.config/h.h/.dryarc
}

# Add .dryarc to .bashrc
function f_add_dryarc_to_bashrc {
	touch ~/.bashrc  # It updated the file. If it does not exist then it created it

	# Test the file. If grep finds a pattern then "$? = 0". Otherwise if grep does not find a pattern then "$? = 1"
	# This test just needs info at the variable $? and does not need the ouptup of a file. That is why we clear the output by redirecting "1>" to other place hidden "/dev/null"
	grep "#!/bin/bash" ~/.bashrc 1>/dev/null
	echo $? 1>/dev/null
	echo $?

		if [ $? == 0 ]; then echo "a shebang #!/bin/bash is visible inside ~/.bashrc"; fi
		if [ $? == 1 ]; then echo '#!/bin/bash' >> ~/.bashrc; fi

	# Bug: grep is not returning a correct value to $? and this way half of the installation is not possible.
	# Fix: We need to know either if a line of code "source ~/.config/h.h/.dryarc" is written inside the file ~/.bashrc
	# Hint: The $? variable is managed by the terminal itself and is used to tell the user either if the previous command was sucessfull or not
	grep 'source ~/.config/h.h/.dryarc' ~/.bashrc 1>/dev/null
	echo $? 1>/dev/null
	echo $?
		if [ $? == 0 ]; then echo ".dryarc is visible inside .bashrc"; fi
		if [ $? == 1 ]; then echo "adding lines to ~/.bashrc to source all variables from .dryarc"
				#echo "" >> ~/.bashrc
				#echo '# Add visibility for .dryarc in this file' >> ~/.bashrc
				#echo 'source ~/.config/h.h/.dryarc' >> ~/.bashrc
				#echo "added source ~/.config/h.h/.dryarc to ~/.bashrc file"
		fi
}

# Copy drya.desktop to...

# Copy the man page to...

# Export a variable to acess the possibility of editing drya
# Fix: it is included at .dryarc sourced by .bashrc


function f_exec {
	f_greet
	f_export_updated_dryarc
	f_add_dryarc_to_bashrc
	source ~/.bashrc && echo "sourced"
}

f_exec

# README:
# This installer does several things:
# 1. Creates a directory at ~/.config/h.h if it does not exist already
# 2. copies and renames the file future-dryarc to .dryarc at ~/.config/h.h
# 3. Reads the file ~/.bashrc to see it it has a shebang
#	3.1. If if doesn't than adds it
# 4. Reads the file ~/.bashrc again to see if it recognizes and reads the new file ~/.config/h.h
# 	4.1 If it doesn't than adds it
# 5. Sources ~/.bashrc to apply the changes done manually
# 6. Adds icon .desktop to it's correct place according to the distro
# 7. Copies drya man page to it's destination
