#!/bin/bash
grep -nr $1 ./* > /tmp/rperl/$1.txt
perl -e '$e = pop; @a = (); while (<>) { s/.*($e\w+).*/$1/gxms; push @a, $_; } print join "\n", sort @a;' -- $1 < /tmp/rperl/$1.txt > /tmp/rperl/$1_clean_sort.txt
uniq /tmp/rperl/$1_clean_sort.txt > /tmp/rperl/$1_clean_sort_uniq.txt
cat /tmp/rperl/$1_clean_sort_uniq.txt
