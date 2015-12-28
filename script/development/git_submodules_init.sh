#!/bin/bash
read -p "ARE YOU AN RPERL SYSTEM DEVELOPER? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
	echo "Initializing RPerl Git Submodules..."
	echo "    git submodule init"
    git submodule init
	echo "    git submodule status"
    git submodule status
	echo "    git submodule update --recursive"
    git submodule update --recursive
	echo "    git submodule status"
    git submodule status
	echo "Initializing RPerl Git Submodules...  DONE!"
fi
