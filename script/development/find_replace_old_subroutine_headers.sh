# replaces old non-standard RPerl subroutine header with new standard subroutine header
# OLD:    our integer::method $foo = sub { ... };
# NEW:    sub foo { { my integer::method $RETURN_TYPE }; ... }

# USAGE: find_replace_old_subroutine_headers.sh ./MY_DIRECTORY [YES]
# call with optional trailing argument 'YES' to skip past prompts from find_replace_recurse.sh

echo "[[[ ONE-LINE SUBROUTINES ]]]"
#find_replace_recurse.sh '\nour\s+([\w:]+)\s+\$(\w+)\s+\=\s+sub\s+\{(.*?)(?:\s+return(\s*.*?);\s*)?\};(\s*)\n' '\nsub $2 { { my $1 \$RETURN_TYPE };$3 return$4; }$5\n' $1 $2 NO_HELP
find_replace_recurse.sh '\nour\s+([\w:]+)\s+\$(\w+)\s+\=\s+sub\s+\{([^\n\r]*?)(?:\s+return(\s*[^\n\r]*?);\s*)?\};(\s*)\n' '\nsub $2 { { my $1 \$RETURN_TYPE };$3 return$4; }$5\n' $1 $2 NO_HELP
echo; echo;

echo "[[[ ONE-LINE SUBROUTINES, DISABLED BY COMMENT ]]]"
#find_replace_recurse.sh '\n\#our\s+(\w+)\s+\$(\w+)\s+\=\s+sub\s+\{(.*?)(?:\s+return(\s*.*?);\s*)?\};(\s*)\n' '\n\#sub $2 { { my $1 \$RETURN_TYPE };$3 return$4; }$5\n' $1 $2 NO_HELP
find_replace_recurse.sh '\n\#our\s+(\w+)\s+\$(\w+)\s+\=\s+sub\s+\{([^\n\r]*?)(?:\s+return(\s*[^\n\r]*?);\s*)?\};(\s*)\n' '\n\#sub $2 { { my $1 \$RETURN_TYPE };$3 return$4; }$5\n' $1 $2 NO_HELP
echo; echo;

echo "[[[ ONE-LINE SUBROUTINES, TRAILING COMMENT ]]]"
#find_replace_recurse.sh '\nour\s+(\w+)\s+\$(\w+)\s+\=\s+sub\s+\{(.*?)(?:\s+return(\s*.*?);\s*)?\};(\s*)(\#.*)?\n' '\nsub $2 { { my $1 \$RETURN_TYPE };$3 return$4; }$5$6\n' $1 $2 NO_HELP
find_replace_recurse.sh '\nour\s+(\w+)\s+\$(\w+)\s+\=\s+sub\s+\{([^\n\r]*?)(?:\s+return(\s*[^\n\r]*?);\s*)?\};(\s*)(\#.*)?\n' '\nsub $2 { { my $1 \$RETURN_TYPE };$3 return$4; }$5$6\n' $1 $2 NO_HELP
echo; echo;

echo "[[[ ONE-LINE SUBROUTINES, DISABLED BY COMMENT, TRAILING COMMENT ]]]"
#find_replace_recurse.sh '\n\#our\s+(\w+)\s+\$(\w+)\s+\=\s+sub\s+\{(.*?)(?:\s+return(\s*.*?);\s*)?\};(\s*)(\#.*)?\n' '\n\#sub $2 { { my $1 \$RETURN_TYPE };$3 return$4; }$5$6\n' $1 $2 NO_HELP
find_replace_recurse.sh '\n\#our\s+(\w+)\s+\$(\w+)\s+\=\s+sub\s+\{([^\n\r]*?)(?:\s+return(\s*[^\n\r]*?);\s*)?\};(\s*)(\#.*)?\n' '\n\#sub $2 { { my $1 \$RETURN_TYPE };$3 return$4; }$5$6\n' $1 $2 NO_HELP
echo; echo;

echo "[[[ ONE-LINE SUBROUTINES, REMOVE EXTRA SPACE BEFORE VOID RETURN ]]]"
find_replace_recurse.sh ';\ \ return' ';\ return' $1 $2 NO_HELP
echo; echo;

echo "[[[ MULTI-LINE SUBROUTINES ]]]"
#find_replace_recurse.sh '\nour\s+([\w:]+)\s+\$(\w+)\s+\=\s+sub\s+\{\n((?:.|\n)*?)(?:\s+return(\s*.*?);\s*)?\n\};' '\nsub $2 {\n    { my $1 \$RETURN_TYPE };\n$3\n    return$4;\n}' $1 $2 NO_HELP
find_replace_recurse.sh '\nour\s+([\w:]+)\s+\$(\w+)\s+\=\s+sub\s+\{\n((?:.|\n)*?)(?:\n\s+return(\s*.*?);\s*)?\n\};' '\nsub $2 {\n    { my $1 \$RETURN_TYPE };\n$3\n    return$4;\n}' $1 $2 NO_HELP
echo; echo;

echo "[[[ MULTI-LINE SUBROUTINES, DISABLED BY COMMENTS ]]]"
find_replace_recurse.sh '\n\#our\s+(\w+)\s+\$(\w+)\s+\=\s+sub\s+\{\n((?:.|\n)*?)(?:\#\s*return(\s*.*?);\s*)?\n\#\};' '\n#sub $2 {\n#    { my $1 \$RETURN_TYPE };\n$3\n#    return$4;\n#}' $1 $2 NO_HELP
echo; echo;

