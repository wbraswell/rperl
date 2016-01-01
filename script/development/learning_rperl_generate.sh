#!/bin/bash

mkdir -p /tmp/rperl

echo 'podchecker...'
#podchecker -warnings -warnings lib/RPerl/Learning.pm
podchecker lib/RPerl/Learning.pm
#podchecker -nowarnings lib/RPerl/Learning.pm
echo 'DONE'
echo

echo 'pod2html...'
rm -f /tmp/rperl/learning_rperl__pod2html.htm
#pod2html --infile=lib/RPerl/Learning.pm > /tmp/rperl/learning_rperl__pod2html.htm
pod2html --podpath=lib:script --infile=lib/RPerl/Learning.pm > /tmp/rperl/learning_rperl__pod2html.htm
echo 'DONE'
echo

echo 'pod2cpanhtml...'
rm -f /tmp/rperl/learning_rperl__pod2cpanhtml.htm
#pod2cpanhtml --no-errata lib/RPerl/Learning.pm /tmp/rperl/learning_rperl__pod2cpanhtml.htm  # BROKEN???
#pod2cpanhtml --no-index --no-errata lib/RPerl/Learning.pm /tmp/rperl/learning_rperl__pod2cpanhtml.htm
pod2cpanhtml lib/RPerl/Learning.pm /tmp/rperl/learning_rperl__pod2cpanhtml.htm
echo 'DONE'
echo

echo 'pod2rperlhtml...'
export RPERL_WARNINGS=0
rm -f /tmp/rperl/learning_rperl__pod2rperlhtml.htm
script/development/pod2rperlhtml.pl lib/RPerl/Learning.pm > /tmp/rperl/learning_rperl__pod2rperlhtml.htm
echo 'DONE'
echo
