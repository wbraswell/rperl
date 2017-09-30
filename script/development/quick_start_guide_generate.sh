#!/bin/bash
# v0.001_000

CURRENT_DIR=`pwd`
TMP_DIR=/tmp/rperl
mkdir -p $TMP_DIR

echo '[[[ Pod ]]]'
echo '[[[ Pod ]]]'
echo '[[[ Pod ]]]'
echo

echo 'podchecker...'
#podchecker -warnings -warnings lib/RPerl.pm
podchecker lib/RPerl.pm
#podchecker -nowarnings lib/RPerl.pm
echo 'DONE'
echo

echo 'pod2text...'
rm -f $TMP_DIR/quick_start_guide__pod2text*
pod2text lib/RPerl.pm $TMP_DIR/quick_start_guide__pod2text.txt
perl -e 'my $f = 0; my $s = q{}; my $e = q{}; foreach $l (<>) { if($f) { if($l eq "\$z = q{<<< END TEXT EVAL >>>};\n") { $f = 0; $e = eval $s; print $e; } else { $s .= $l; } } elsif($l eq "my \$z = q{<<< BEGIN TEXT EVAL >>>};\n") { $f = 1; $s = $l; } else { print $l; } }' $TMP_DIR/quick_start_guide__pod2text.txt > $TMP_DIR/quick_start_guide__pod2text__eval.txt  # tables, eval to generate
mv $TMP_DIR/quick_start_guide__pod2text__eval.txt $TMP_DIR/quick_start_guide__pod2text.txt
echo 'DONE'
echo

echo 'pod2text color...'
rm -f $TMP_DIR/quick_start_guide__pod2text__color*
pod2text --color lib/RPerl.pm $TMP_DIR/quick_start_guide__pod2text__color.txt
perl -e 'my $f = 0; my $s = q{}; my $e = q{}; foreach $l (<>) { if($f) { if($l eq "\$z = q{<<< END TEXT EVAL >>>};\n") { $f = 0; $e = eval $s; $e =~ s/(\e\[1m\w+\e\[0m)/\ \ \ \ $1\ \ \ \ /gxms; print $e; } else { $s .= $l; } } elsif($l eq "my \$z = q{<<< BEGIN TEXT EVAL >>>};\n") { $f = 1; $s = $l; } else { print $l; } }' $TMP_DIR/quick_start_guide__pod2text__color.txt > $TMP_DIR/quick_start_guide__pod2text__color_eval.txt  # tables, eval to generate, regex to fix ASCII color escape code formatting
mv $TMP_DIR/quick_start_guide__pod2text__color_eval.txt $TMP_DIR/quick_start_guide__pod2text__color.txt
echo 'DONE'
echo

echo 'pod2man...'
rm -f $TMP_DIR/quick_start_guide__pod2man*
pod2man lib/RPerl.pm $TMP_DIR/quick_start_guide__pod2man.3
perl -e 'my $f = 0; foreach $l (<>) { if($f) { $f = 0; if($l eq ".PP\n") { next; } } if(($l eq "T\}\@T\{\n") or ($l eq "T\{\n")) { $f = 1; } print $l; }' $TMP_DIR/quick_start_guide__pod2man.3 > $TMP_DIR/quick_start_guide__pod2man__noPP.3  # tables, remove extraneous .PP formatting tags inserted by pod2man
mv $TMP_DIR/quick_start_guide__pod2man__noPP.3 $TMP_DIR/quick_start_guide__pod2man.3
echo 'DONE'
echo

echo 'pod2man postscript...'
#rm -f $TMP_DIR/quick_start_guide__pod2man*
#man -t $TMP_DIR/quick_start_guide__pod2man.3 > $TMP_DIR/quick_start_guide__pod2man.ps 2> /dev/null # same a groff below
groff -t -m man $TMP_DIR/quick_start_guide__pod2man.3 > $TMP_DIR/quick_start_guide__pod2man.ps 2> /dev/null # same a man above
echo 'DONE'
echo

echo 'pod2html...'
rm -f $TMP_DIR/quick_start_guide__pod2html.htm
pod2html --podpath=lib:script --infile=lib/RPerl.pm > $TMP_DIR/quick_start_guide__pod2html.htm
echo 'DONE'
echo

echo 'pod2cpanhtml...'
rm -f $TMP_DIR/quick_start_guide__pod2cpanhtml.htm
#pod2cpanhtml --no-errata lib/RPerl.pm $TMP_DIR/quick_start_guide__pod2cpanhtml.htm  # BROKEN???
#pod2cpanhtml --no-index --no-errata lib/RPerl.pm $TMP_DIR/quick_start_guide__pod2cpanhtml.htm
pod2cpanhtml lib/RPerl.pm $TMP_DIR/quick_start_guide__pod2cpanhtml.htm
echo 'DONE'
echo

echo 'pod2rperlhtml...'
export RPERL_WARNINGS=0
rm -f $TMP_DIR/quick_start_guide__pod2rperlhtml.htm
script/development/pod2rperlhtml.pl lib/RPerl.pm > $TMP_DIR/quick_start_guide__pod2rperlhtml.htm
mkdir -p $TMP_DIR/stylesheets
cd $TMP_DIR/stylesheets
if [ ! -f metacpan_rperl.css ]
  then
    wget -q https://raw.githubusercontent.com/wbraswell/rperl/gh-pages/learning/stylesheets/metacpan_rperl.css
fi
mkdir -p $TMP_DIR/javascripts
cd $TMP_DIR/javascripts
if [ ! -f metacpan_rperl.js ]
  then
    wget -q https://raw.githubusercontent.com/wbraswell/rperl/gh-pages/learning/javascripts/metacpan_rperl.js
fi
cd $CURRENT_DIR
echo 'DONE'
echo

echo '[[[ PseudoPod ]]]'
echo '[[[ PseudoPod ]]]'
echo '[[[ PseudoPod ]]]'
echo

echo 'ppodchecker...'
ppodchecker lib/RPerl.pm
echo 'DONE'
echo

echo 'ppod2txt...'
cd $TMP_DIR
rm -f $TMP_DIR/quick_start_guide__ppod2txt*
ppod2txt $CURRENT_DIR/lib/RPerl.pm
mv RPerl.txt quick_start_guide__ppod2txt.txt
perl -e 'my $f = 0; my $s = q{}; my $e = q{}; foreach $l (<>) { if($f) { if((substr $l, 0, 36) eq "      \$z = q{<<< END TEXT EVAL >>>};") { $f = 0; $e = eval $s; print $e; } else { $s .= $l; } } elsif((substr $l, 0, 41) eq "      my \$z = q{<<< BEGIN TEXT EVAL >>>};") { $f = 1; $s = $l; } else { print $l; } }' $TMP_DIR/quick_start_guide__ppod2txt.txt > $TMP_DIR/quick_start_guide__ppod2txt__eval.txt  # tables, eval to generate
mv $TMP_DIR/quick_start_guide__ppod2txt__eval.txt $TMP_DIR/quick_start_guide__ppod2txt.txt
cd $CURRENT_DIR
echo 'DONE'
echo

echo 'ppod2html...'
cd $TMP_DIR
rm -f $TMP_DIR/quick_start_guide__ppod2html*
ppod2html $CURRENT_DIR/lib/RPerl.pm
mv RPerl.html quick_start_guide__ppod2html.htm
cd $CURRENT_DIR
echo 'DONE'
echo

echo 'ppod2docbook...'
cd $TMP_DIR
rm -f $TMP_DIR/quick_start_guide__ppod2docbook.*
#ppod2docbook $CURRENT_DIR/lib/RPerl.pm
ppod2docbook -i quick_start_guide $CURRENT_DIR/lib/RPerl.pm
mv book.xml quick_start_guide__ppod2docbook.xml
perl -e 'my $f = 0; my $s = q{}; my $e = q{}; foreach $l (<>) { if($f) { if((substr $l, -11, 11) eq "</docbook>\n") { $f = 0; substr $l, -11, 11, q{}; $s .= $l; 
$s =~ s/&lt;/</gxms; $s =~ s/&gt;/>/gxms; $s =~ s/&quot;/"/gxms; print $s; } else { $s .= $l; } } elsif($l eq "<docbook>\n") { $f = 1; $s = q{}; } else { print $l; } }' $TMP_DIR/quick_start_guide__ppod2docbook.xml > $TMP_DIR/quick_start_guide__ppod2docbook_fix.xml  # tables, regex to fix SGML tag control characters
mv $TMP_DIR/quick_start_guide__ppod2docbook_fix.xml $TMP_DIR/quick_start_guide__ppod2docbook.xml
cd $CURRENT_DIR
echo 'DONE'
echo



# SKIP ALL DOCBOOK FOR NOW
if false; then


echo '[[[ Docbook ]]]'
echo '[[[ Docbook ]]]'
echo '[[[ Docbook ]]]'
echo

# INSTALL NOTE: apt-get install sgmltools-lite
echo 'sgmltools onehtml...'
cd $TMP_DIR
rm -f $TMP_DIR/quick_start_guide__ppod2docbook__sgmltools.htm
sgmltools --jade-opt="-E 1000000" quick_start_guide__ppod2docbook.xml 2> /dev/null
mv $TMP_DIR/quick_start_guide__ppod2docbook.html $TMP_DIR/quick_start_guide__ppod2docbook__sgmltools.htm
cd $CURRENT_DIR
echo 'DONE'
echo

# INSTALL NOTE: apt-get install sgml2x
echo 'sgml2x docbook-2-html'
cd $TMP_DIR
rm -Rf $TMP_DIR/quick_start_guide__ppod2docbook__sgml2html
docbook-2-html quick_start_guide__ppod2docbook.xml 2> /dev/null
mv $TMP_DIR/quick_start_guide__ppod2docbook-html $TMP_DIR/quick_start_guide__ppod2docbook__sgml2html
cd $CURRENT_DIR
echo 'DONE'
echo

# INSTALL NOTE: apt-get install docbook-utils
echo 'docbook2html chunks...'
cd $TMP_DIR
rm -Rf $TMP_DIR/quick_start_guide__ppod2docbook2html
#docbook2html -e no-idref -e no-significant -e no-valid -o quick_start_guide__ppod2docbook2html quick_start_guide__ppod2docbook.xml
docbook2html -e no-idref -e no-significant -e no-valid -o quick_start_guide__ppod2docbook2html quick_start_guide__ppod2docbook.xml 2> /dev/null
cd $CURRENT_DIR
echo 'DONE'
echo

echo 'docbook2html no chunks...'
cd $TMP_DIR
rm -f $TMP_DIR/quick_start_guide__ppod2docbook2html.htm
#docbook2html -e no-idref -e no-significant -e no-valid --nochunks quick_start_guide__ppod2docbook.xml
docbook2html -e no-idref -e no-significant -e no-valid --nochunks quick_start_guide__ppod2docbook.xml 2> /dev/null
mv quick_start_guide__ppod2docbook.html quick_start_guide__ppod2docbook2html.htm
cd $CURRENT_DIR
echo 'DONE'
echo


exit

# DEV NOTE: outputs .jtex file instead of .pdf file
echo 'sgml2x docbook-2-pdf'
cd $TMP_DIR
rm -f $TMP_DIR/quick_start_guide__ppod2docbook__sgml2pdf.pdf
docbook-2-pdf quick_start_guide__ppod2docbook.xml 2> /dev/null
#mv $TMP_DIR/quick_start_guide__ppod2docbook.pdf $TMP_DIR/quick_start_guide__ppod2docbook__sgml2pdf.pdf
cd $CURRENT_DIR
echo 'DONE'
echo

# DEV NOTE: segfaults
echo 'docbook2pdf...'
cd $TMP_DIR
rm -f $TMP_DIR/quick_start_guide__ppod2docbook2pdf*
docbook2pdf -e no-idref -e no-significant -e no-valid quick_start_guide__ppod2docbook.xml
mv quick_start_guide__ppod2docbook.pdf quick_start_guide__ppod2docbook2pdf.pdf
cd $CURRENT_DIR
echo 'DONE'
echo


# DONE SKIPPING DOCKBOOK
fi



echo '[[[ Spelling ]]]'
echo '[[[ Spelling ]]]'
echo '[[[ Spelling ]]]'
echo

echo 'ispell...'
perl -e 'my $m = 0; foreach $l (<>) { if ($l eq q{    ~ or ~} . "\n") { $m = 1; } if ($m) { print $l; } }' $TMP_DIR/quick_start_guide__pod2text.txt > $TMP_DIR/quick_start_guide__pod2text_stripped.txt
ispell $TMP_DIR/quick_start_guide__pod2text_stripped.txt
echo 'DONE'
echo


