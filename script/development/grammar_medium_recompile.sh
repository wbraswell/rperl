#!/bin/bash
read -p "ARE YOU AN RPERL SYSTEM DEVELOPER? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
	echo "Recompiling RPerl Grammar, Medium-Magic..."
	echo "    eyapp -v -m RPerl::GrammarMedium -o lib/RPerl/GrammarMedium.pm lib/RPerl/GrammarMedium.eyp"
	eyapp -v -m RPerl::GrammarMedium -o lib/RPerl/GrammarMedium.pm lib/RPerl/GrammarMedium.eyp 
	echo "Recompiling RPerl Grammar, Medium-Magic... DONE!"
fi
