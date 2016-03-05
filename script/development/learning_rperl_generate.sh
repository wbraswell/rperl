#!/bin/bash
TMP_DIR=/tmp/rperl

mkdir -p $TMP_DIR

echo 'podchecker...'
#podchecker -warnings -warnings lib/RPerl/Learning.pm
podchecker lib/RPerl/Learning.pm
#podchecker -nowarnings lib/RPerl/Learning.pm
echo 'DONE'
echo

echo 'pod2html...'
rm -f $TMP_DIR/learning_rperl__pod2html.htm
#pod2html --infile=lib/RPerl/Learning.pm > $TMP_DIR/learning_rperl__pod2html.htm
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
