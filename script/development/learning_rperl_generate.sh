#!/bin/bash
# v0.040_000

CURRENT_DIR=`pwd`
TMP_DIR=/tmp/rperl
mkdir -p $TMP_DIR

echo '[[[ Pod ]]]'
echo '[[[ Pod ]]]'
echo '[[[ Pod ]]]'
echo

echo 'podchecker...'
#podchecker -warnings -warnings lib/RPerl/Learning.pm
podchecker lib/RPerl/Learning.pm
#podchecker -nowarnings lib/RPerl/Learning.pm
echo 'DONE'
echo

echo 'pod2text...'
rm -f $TMP_DIR/learning_rperl__pod2text*
pod2text lib/RPerl/Learning.pm $TMP_DIR/learning_rperl__pod2text.txt
perl -e 'my $f = 0; my $s = ""; my $e = ""; foreach $l (<>) { if($f) { if($l eq "\$b = q{<<< END TEXT EVAL >>>};\n") { $f = 0; $e = eval $s; print $e; } else { $s .= $l; } } elsif($l eq "my \$b = q{<<< BEGIN TEXT EVAL >>>};\n") { $f = 1; $s = $l; } else { print $l; } }' $TMP_DIR/learning_rperl__pod2text.txt > $TMP_DIR/learning_rperl__pod2text__eval.txt  # tables, eval to generate
mv $TMP_DIR/learning_rperl__pod2text__eval.txt $TMP_DIR/learning_rperl__pod2text.txt
echo 'DONE'
echo

echo 'pod2text color...'
rm -f $TMP_DIR/learning_rperl__pod2text__color*
pod2text --color lib/RPerl/Learning.pm $TMP_DIR/learning_rperl__pod2text__color.txt
perl -e 'my $f = 0; my $s = ""; my $e = ""; foreach $l (<>) { if($f) { if($l eq "\$b = q{<<< END TEXT EVAL >>>};\n") { $f = 0; $e = eval $s; $e =~ s/(\e\[1m\w+\e\[0m)/\ \ \ \ $1\ \ \ \ /gxms; print $e; } else { $s .= $l; } } elsif($l eq "my \$b = q{<<< BEGIN TEXT EVAL >>>};\n") { $f = 1; $s = $l; } else { print $l; } }' $TMP_DIR/learning_rperl__pod2text__color.txt > $TMP_DIR/learning_rperl__pod2text__color_eval.txt  # tables, eval to generate, regex to fix ASCII color escape code formatting
mv $TMP_DIR/learning_rperl__pod2text__color_eval.txt $TMP_DIR/learning_rperl__pod2text__color.txt
echo 'DONE'
echo

echo 'pod2man...'
rm -f $TMP_DIR/learning_rperl__pod2man*
pod2man lib/RPerl/Learning.pm $TMP_DIR/learning_rperl__pod2man.3
perl -e 'my $f = 0; foreach $l (<>) { if($f) { $f = 0; if($l eq ".PP\n") { next; } } if(($l eq "T\}\@T\{\n") or ($l eq "T\{\n")) { $f = 1; } print $l; }' $TMP_DIR/learning_rperl__pod2man.3 > $TMP_DIR/learning_rperl__pod2man__noPP.3  # tables, remove extraneous .PP formatting tags inserted by pod2man
mv $TMP_DIR/learning_rperl__pod2man__noPP.3 $TMP_DIR/learning_rperl__pod2man.3
echo 'DONE'
echo

echo 'pod2man postscript...'
#rm -f $TMP_DIR/learning_rperl__pod2man*
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
cd $CURRENT_DIR
echo 'DONE'
echo

echo '[[[ PseudoPod ]]]'
echo '[[[ PseudoPod ]]]'
echo '[[[ PseudoPod ]]]'
echo

echo 'ppodchecker...'
ppodchecker lib/RPerl/Learning.pm
echo 'DONE'
echo

echo 'ppod2txt...'
cd $TMP_DIR
rm -f $TMP_DIR/learning_rperl__ppod2txt*
ppod2txt $CURRENT_DIR/lib/RPerl/Learning.pm
mv Learning.txt learning_rperl__ppod2txt.txt
perl -e 'my $f = 0; my $s = ""; my $e = ""; foreach $l (<>) { if($f) { if((substr $l, 0, 36) eq "      \$b = q{<<< END TEXT EVAL >>>};") { $f = 0; $e = eval $s; print $e; } else { $s .= $l; } } elsif((substr $l, 0, 41) eq "      my \$b = q{<<< BEGIN TEXT EVAL >>>};") { $f = 1; $s = $l; } else { print $l; } }' $TMP_DIR/learning_rperl__ppod2txt.txt > $TMP_DIR/learning_rperl__ppod2txt__eval.txt  # tables, eval to generate
mv $TMP_DIR/learning_rperl__ppod2txt__eval.txt $TMP_DIR/learning_rperl__ppod2txt.txt
cd $CURRENT_DIR
echo 'DONE'
echo

echo 'ppod2html...'
cd $TMP_DIR
rm -f $TMP_DIR/learning_rperl__ppod2html*
ppod2html $CURRENT_DIR/lib/RPerl/Learning.pm
mv Learning.html learning_rperl__ppod2html.htm
cd $CURRENT_DIR
echo 'DONE'
echo

echo 'ppod2docbook...'
cd $TMP_DIR
rm -f $TMP_DIR/learning_rperl__ppod2docbook.*
#ppod2docbook $CURRENT_DIR/lib/RPerl/Learning.pm
ppod2docbook -i learning_rperl $CURRENT_DIR/lib/RPerl/Learning.pm
mv book.xml learning_rperl__ppod2docbook.xml
cd $CURRENT_DIR
echo 'DONE'
echo

exit

echo '[[[ Docbook ]]]'
echo '[[[ Docbook ]]]'
echo '[[[ Docbook ]]]'
echo

echo 'docbook2html chunks...'
cd $TMP_DIR
rm -Rf $TMP_DIR/learning_rperl__ppod2docbook2html
#docbook2html -e no-idref -e no-significant -e no-valid -o learning_rperl__ppod2docbook2html learning_rperl__ppod2docbook.xml
docbook2html -e no-idref -e no-significant -e no-valid -o learning_rperl__ppod2docbook2html learning_rperl__ppod2docbook.xml 2> /dev/null
cd $CURRENT_DIR
echo 'DONE'
echo

echo 'docbook2html no chunks...'
cd $TMP_DIR
rm -f $TMP_DIR/learning_rperl__ppod2docbook2html.htm
docbook2html -e no-idref -e no-significant -e no-valid --nochunks learning_rperl__ppod2docbook.xml
#docbook2html -e no-idref -e no-significant -e no-valid --nochunks learning_rperl__ppod2docbook.xml 2> /dev/null
mv learning_rperl__ppod2docbook.html learning_rperl__ppod2docbook2html.htm
cd $CURRENT_DIR
echo 'DONE'
echo

