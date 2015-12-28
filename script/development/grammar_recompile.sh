#!/bin/bash
read -p "ARE YOU AN RPERL SYSTEM DEVELOPER? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
	echo "Recompiling RPerl Grammar..."
	echo "    eyapp -v -m RPerl::Grammar -o lib/RPerl/Grammar.pm lib/RPerl/Grammar.eyp"
	eyapp -v -m RPerl::Grammar -o lib/RPerl/Grammar.pm lib/RPerl/Grammar.eyp 
	echo "Recompiling RPerl Grammar... DONE!"
fi
