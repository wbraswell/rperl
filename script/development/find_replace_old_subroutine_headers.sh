# replaces old non-standard RPerl subroutine header with new standard subroutine header
# OLD:    our integer::method $foo = sub { ... };
# NEW:    sub foo { { my integer::method $RETURN_TYPE }; ... }

# call with optional trailing argument 'YES' to skip past prompts from find_replace_recurse.sh

echo "[[[ one-line subroutines; w/ return ]]]"
find_replace_recurse.sh '\nour\s+([\w:]+)\s+\$(\w+)\s+\=\s+sub\s+\{(.*?)(\s+return\s*.*?;\s*)\};(\s*)\n' '\nsub $2 { { my $1 \$RETURN_TYPE };$3$4}$5\n' . $1 NO_HELP
echo; echo;
echo "[[[ one-line subroutines; w/out return ]]]"
find_replace_recurse.sh '\nour\s+(\w+)\s+\$(\w+)\s+\=\s+sub\s+\{([^\n\r]+?)(\s*)\};(\s*)\n' '\nsub $2 { { my $1 \$RETURN_TYPE };$3 return; }$5\n' . $1 NO_HELP
echo; echo;

echo "[[[ one-line subroutines, disabled by comment; w/ return ]]]"
find_replace_recurse.sh '\n\#our\s+(\w+)\s+\$(\w+)\s+\=\s+sub\s+\{(.*?)(\s+return\s*.*?;\s*)\};(\s*)\n' '\n\#sub $2 { { my $1 \$RETURN_TYPE };$3$4}$5\n' . $1 NO_HELP
echo; echo;
echo "[[[ one-line subroutines, disabled by comment; w/out return ]]]"
find_replace_recurse.sh '\n\#our\s+(\w+)\s+\$(\w+)\s+\=\s+sub\s+\{([^\n\r]+?)(\s*)\};(\s*)\n' '\n\#sub $2 { { my $1 \$RETURN_TYPE };$3 return; }$5\n' . $1 NO_HELP
echo; echo;

echo "[[[ one-line subroutines, trailing comment; w/ return ]]]"
find_replace_recurse.sh '\nour\s+(\w+)\s+\$(\w+)\s+\=\s+sub\s+\{(.*?)(\s+return\s*.*?;\s*)\};(\s*)(\#.*)?\n' '\nsub $2 { { my $1 \$RETURN_TYPE };$3$4}$5$6\n' . $1 NO_HELP
echo; echo;
echo "[[[ one-line subroutines, trailing comment; w/out return ]]]"
find_replace_recurse.sh '\nour\s+(\w+)\s+\$(\w+)\s+\=\s+sub\s+\{([^\n\r]+?)(\s*)\};(\s*)(\#.*)?\n' '\nsub $2 { { my $1 \$RETURN_TYPE };$3 return; }$5$6\n' . $1 NO_HELP
echo; echo;

echo "[[[ one-line subroutines, disabled by comment, trailing comment; w/ return ]]]"
find_replace_recurse.sh '\n\#our\s+(\w+)\s+\$(\w+)\s+\=\s+sub\s+\{(.*?)(\s+return\s*.*?;\s*)\};(\s*)(\#.*)?\n' '\n\#sub $2 { { my $1 \$RETURN_TYPE };$3$4}$5$6\n' . $1 NO_HELP
echo; echo;
echo "[[[ one-line subroutines, disabled by comment, trailing comment; w/out return ]]]"
find_replace_recurse.sh '\n\#our\s+(\w+)\s+\$(\w+)\s+\=\s+sub\s+\{([^\n\r]+?)(\s*)\};(\s*)(\#.*)?\n' '\n\#sub $2 { { my $1 \$RETURN_TYPE };$3 return; }$5$6\n' . $1 NO_HELP
echo; echo;

echo "[[[ multi-line subroutines; w/ return ]]]"
find_replace_recurse.sh '\nour\s+([\w:]+)\s+\$(\w+)\s+\=\s+sub\s+\{\n((?:.|\n)*?)(\s+return\s*.*?;\s*)\n\};' '\nsub $2 {\n    { my $1 \$RETURN_TYPE };\n$3$4\n}' . $1 NO_HELP
echo; echo;
echo "[[[ multi-line subroutines; w/out return, ASSUMES PREVIOUS FIND & REPLACE WAS RUN ]]]"
find_replace_recurse.sh '\nour\s+(\w+)\s+\$(\w+)\s+\=\s+sub\s+\{\n((?:.|\n)+?)\n\};' '\nsub $2 {\n    { my $1 \$RETURN_TYPE };\n$3\n    return;\n}' . $1 NO_HELP
echo; echo;

echo "[[[ multi-line subroutines, disabled by comments; w/ return ]]]"
find_replace_recurse.sh '\n\#our\s+(\w+)\s+\$(\w+)\s+\=\s+sub\s+\{\n((?:.|\n)*?)(\#\s*return\s*.*?;\s*)\n\#\};' '\n#sub $2 {\n#    { my $1 \$RETURN_TYPE };\n$3$4\n#}' . $1 NO_HELP
echo; echo;
echo "[[[ multi-line subroutines, disabled by comments; w/out return, ASSUMES PREVIOUS FIND & REPLACE WAS RUN ]]]"
find_replace_recurse.sh '\n\#our\s+(\w+)\s+\$(\w+)\s+\=\s+sub\s+\{\n((?:.|\n)+?)\n\#\};' '\n#sub $2 {\n#    { my $1 \$RETURN_TYPE };\n$3\n\#    return;\n#}' . $1 NO_HELP
echo; echo;

