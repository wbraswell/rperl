#!/bin/bash
# v0.010_000

TMP_DIR=/tmp/rperl
mkdir -p $TMP_DIR

echo 'podchecker...'
#podchecker -warnings -warnings lib/RPerl/Learning.pm
podchecker lib/RPerl/Learning.pm
#podchecker -nowarnings lib/RPerl/Learning.pm
echo 'DONE'
echo

echo 'pod2man...'
rm -f $TMP_DIR/learning_rperl__pod2man*
pod2man lib/RPerl/Learning.pm $TMP_DIR/learning_rperl__pod2man.3
perl -e 'my $f = 0; foreach $l (<>) { if($f) { $f = 0; if($l eq ".PP\n") { next; } } if(($l eq "T\}\@T\{\n") or ($l eq "T\{\n")) { $f = 1; } print $l; }' $TMP_DIR/learning_rperl__pod2man.3 > $TMP_DIR/learning_rperl__pod2man__noPP.3  # remove extraneous .PP formatting tags inserted by pod2man
mv $TMP_DIR/learning_rperl__pod2man__noPP.3 $TMP_DIR/learning_rperl__pod2man.3
#man -t $TMP_DIR/learning_rperl__pod2man.3 > $TMP_DIR/learning_rperl__pod2man.ps 2> /dev/null # same a groff below
groff -t -m man $TMP_DIR/learning_rperl__pod2man.3 > $TMP_DIR/learning_rperl__pod2man.ps 2> /dev/null # same a man above
echo 'DONE'
echo

echo 'pod2html...'
rm -f $TMP_DIR/learning_rperl__pod2html.htm
pod2html --podpath=lib:script --infile=lib/RPerl/Learning.pm > $TMP_DIR/learning_rperl__pod2html.htm
echo 'DONE'
echo

echo 'pod2cpanhtml...'
rm -f $TMP_DIR/learning_rperl__pod2cpanhtml.htm
#pod2cpanhtml --no-errata lib/RPerl/Learning.pm $TMP_DIR/learning_rperl__pod2cpanhtml.htm  # BROKEN???
#pod2cpanhtml --no-index --no-errata lib/RPerl/Learning.pm $TMP_DIR/learning_rperl__pod2cpanhtml.htm
pod2cpanhtml lib/RPerl/Learning.pm $TMP_DIR/learning_rperl__pod2cpanhtml.htm
echo 'DONE'
echo

echo 'pod2rperlhtml...'
export RPERL_WARNINGS=0
rm -f $TMP_DIR/learning_rperl__pod2rperlhtml.htm
script/development/pod2rperlhtml.pl lib/RPerl/Learning.pm > $TMP_DIR/learning_rperl__pod2rperlhtml.htm
mkdir -p $TMP_DIR/stylesheets
cd $TMP_DIR/stylesheets
if [ ! -f metacpan_rperl.css ]
  then
    wget -q https://raw.githubusercontent.com/wbraswell/rperl/gh-pages/stylesheets/metacpan_rperl.css
fi
mkdir -p $TMP_DIR/javascripts
cd $TMP_DIR/javascripts
if [ ! -f metacpan_rperl.js ]
  then
    wget -q https://raw.githubusercontent.com/wbraswell/rperl/gh-pages/javascripts/metacpan_rperl.js
fi
echo 'DONE'
echo
