# replaces old non-standard RPerl subroutine header with new standard subroutine header
# OLD:    our integer::method $foo = sub { ... };
# NEW:    sub foo { { my integer::method $RETURN_TYPE }; ... }

# USAGE: find_replace_old_subroutine_headers.sh ./MY_DIRECTORY [YES]
# call with optional trailing argument 'YES' to skip past prompts from find_replace_recurse.sh

# ONE-LINE SECTION
# ONE-LINE SECTION
# ONE-LINE SECTION

echo "[[[ ONE-LINE SUBROUTINES ]]]"
find_replace_recurse.sh '\nour[\t ]+([\w:]+)[\t ]+\$(\w+)[\t ]+\=[\t ]+sub[\t ]+\{([^\n\r]*?)(?:[\t ]+return([\t ]*[^\n\r]*?);[\t ]*)?\};([\t ]*)\n' '\nsub $2 { { my $1 \$RETURN_TYPE };$3 return$4; }$5\n' $1 $2 NO_HELP
echo; echo;

echo "[[[ ONE-LINE SUBROUTINES, DISABLED BY COMMENT ]]]"
find_replace_recurse.sh '\n\#our[\t ]+(\w+)[\t ]+\$(\w+)[\t ]+\=[\t ]+sub[\t ]+\{([^\n\r]*?)(?:[\t ]+return([\t ]*[^\n\r]*?);[\t ]*)?\};([\t ]*)\n' '\n\#sub $2 { { my $1 \$RETURN_TYPE };$3 return$4; }$5\n' $1 $2 NO_HELP
echo; echo;

# START HERE: create else-braces-wrapped-return variant for all cases
# START HERE: create else-braces-wrapped-return variant for all cases
# START HERE: create else-braces-wrapped-return variant for all cases 

echo "[[[ ONE-LINE SUBROUTINES, TRAILING COMMENT, ELSE-BRACES-WRAPPED RETURN ]]]"
find_replace_recurse.sh '\nour[\t ]+(\w+)[\t ]+\$(\w+)[\t ]+\=[\t ]+sub[\t ]+\{([^\n\r]*?)(else[\t ]*\{[\t ]*return[\t ]*[^\n\r]*?;[\t ]*\}[\t ]*)?\};([\t ]*)(\#.*)?\n' '\nsub $2 { { my $1 \$RETURN_TYPE }; $3$4}$5$6\n' $1 $2 NO_HELP
echo; echo;

echo "[[[ ONE-LINE SUBROUTINES, TRAILING COMMENT, NON-WRAPPED RETURN ]]]"
find_replace_recurse.sh '\nour[\t ]+(\w+)[\t ]+\$(\w+)[\t ]+\=[\t ]+sub[\t ]+\{([^\n\r]*?)(?:[\t ]+return([\t ]*[^\n\r]*?);[\t ]*)?\};([\t ]*)(\#.*)?\n' '\nsub $2 { { my $1 \$RETURN_TYPE };$3 return$4; }$5$6\n' $1 $2 NO_HELP
echo; echo;

echo "[[[ ONE-LINE SUBROUTINES, DISABLED BY COMMENT, TRAILING COMMENT ]]]"
find_replace_recurse.sh '\n\#our[\t ]+(\w+)[\t ]+\$(\w+)[\t ]+\=[\t ]+sub[\t ]+\{([^\n\r]*?)(?:[\t ]+return([\t ]*[^\n\r]*?);[\t ]*)?\};([\t ]*)(\#.*)?\n' '\n\#sub $2 { { my $1 \$RETURN_TYPE };$3 return$4; }$5$6\n' $1 $2 NO_HELP
echo; echo;

echo "[[[ ONE-LINE SUBROUTINES, REMOVE EXTRA SPACE BEFORE VOID RETURN ]]]"
find_replace_recurse.sh ';\ \ return' ';\ return' $1 $2 NO_HELP
echo; echo;



# EXPERIMENTAL SECTION
# EXPERIMENTAL SECTION
# EXPERIMENTAL SECTION

#echo "[[[ MULTI-LINE SUBROUTINES, RETURN FOLLOWED BY COMMENT ]]]"
#find_replace_recurse.sh '(.*)\nour\s+([\w:]+)\s+\$(\w+)\s+\=\s+sub\s+\{\n((?:.|\n)*?)(?:\n\s+return(\s*[^\n\r]*?);\s*\#.*?)?\n\};' '$1\nsub $3 {\n    { my $2 \$RETURN_TYPE };\n$4\n    return$5;\n}' $1 $2 NO_HELP
#echo; echo;

#echo "[[[ MULTI-LINE SUBROUTINES, ARGUMENTS ON FIRST LINE W/ OPTIONAL TRAILING COMMENT ]]]"
#find_replace_recurse.sh '(.*)\nour\s+([\w:]+)\s+\$(\w+)\s+\=\s+sub\s+\{(?:\s*(\(.*\)\s*\=\s*\@.*?;)\s*)(?:\s*\#.*?)?\n((?:.|\n)*?)(?:\n\s+return(\s*[^\n\r]*?);\s*)?\n\};' '$1\nsub $3 {\n    { my $2 \$RETURN_TYPE };\n    $4\n$5\n    return$6;\n}' $1 $2 NO_HELP
#echo; echo;



# MULTI-LINE SECTION
# MULTI-LINE SECTION
# MULTI-LINE SECTION

# NEED DELETE, UNUSED
#echo "[[[ MULTI-LINE SUBROUTINES, ARGUMENTS ON FIRST LINE, DO NOT MATCH & ADD RETURN STATEMENT ]]]"
#find_replace_recurse.sh '(.*)\nour\s+([\w:]+)\s+\$(\w+)\s+\=\s+sub\s+\{(?:\s*(\(.*?\)\s*\=\s*\@.*?;)\s*)\n((?:.|\n)*?)\n\};' '$1\nsub $3 {\n    { my $2 \$RETURN_TYPE };\n    $4\n$5\n}' $1 $2 NO_HELP
#echo; echo;

# NEED DELETE, UNUSED
echo "[[[ MULTI-LINE SUBROUTINES, ARGUMENTS ON FIRST LINE, MATCH & ADD RETURN STATEMENT ]]]"
find_replace_recurse.sh '(.*)\nour\s+([\w:]+)\s+\$(\w+)\s+\=\s+sub\s+\{(?:[\t ]*(\(.*?\)\s*\=\s*\@.*?;)\s*)\n((?:.|\n)*?)(?:\n\s+return(\s*[^\n\r]*?);\s*)?\n\};' '$1\nsub $3 {\n    { my $2 \$RETURN_TYPE };\n    $4\n$5\n    return$6;\n}' $1 $2 NO_HELP
echo; echo;


# START HERE: add remaining "match & add return statement" cases???
# START HERE: add remaining "match & add return statement" cases???
# START HERE: add remaining "match & add return statement" cases???


#echo "[[[ MULTI-LINE SUBROUTINES, ARGUMENTS ON FIRST LINE, REQUIRE RETURN STATEMENT W/ TRAILING COMMENT ]]]"
#find_replace_recurse.sh '(.*)\nour\s+([\w:]+)\s+\$(\w+)\s+\=\s+sub\s+\{(?:\s*(\(.*?\)\s*\=\s*\@.*?;)\s*)\n((?:.|\n)*?)(?:\n\s+return(\s*[^\n\r]*?);\s*)?\n\};' '$1\nsub $3 {\n    { my $2 \$RETURN_TYPE };\n    $4\n$5\n    return$6;\n}' $1 $2 NO_HELP
#echo; echo;

#echo "[[[ MULTI-LINE SUBROUTINES, ARGUMENTS ON FIRST LINE, OPTIONAL RETURN STATEMENT W/OUT TRAILING COMMENT ]]]"
#find_replace_recurse.sh '(.*)\nour\s+([\w:]+)\s+\$(\w+)\s+\=\s+sub\s+\{(?:\s*(\(.*?\)\s*\=\s*\@.*?;)\s*)\n((?:.|\n)*?)(?:\n\s+return(\s*[^\n\r]*?);\s*)?\n\};' '$1\nsub $3 {\n    { my $2 \$RETURN_TYPE };\n    $4\n$5\n    return$6;\n}' $1 $2 NO_HELP
#echo; echo;



# NEED DELETE, UNUSED
#echo "[[[ MULTI-LINE SUBROUTINES, ARGUMENTS NOT ON FIRST LINE, DO NOT MATCH & ADD RETURN STATEMENT ]]]"
#find_replace_recurse.sh '(.*)\nour\s+([\w:]+)\s+\$(\w+)\s+\=\s+sub\s+\{\n((?:.|\n)*?)\n\};' '$1\nsub $3 {\n    { my $2 \$RETURN_TYPE };\n$4\n}' $1 $2 NO_HELP
#echo; echo;

echo "[[[ MULTI-LINE SUBROUTINES, ARGUMENTS NOT ON FIRST LINE, ELSE-BRACES-WRAPPED RETURN ]]]"
find_replace_recurse.sh '(.*)\nour\s+([\w:]+)\s+\$(\w+)\s+\=\s+sub\s+\{\n((?:.|\n)*?)([\n\r]\s*else[\s\n\r]*\{[\s\n\r]*return\s*[^\n\r]*?;[\s\n\r]*\})[\s\n\r]*\};' '$1\nsub $3 {\n    { my $2 \$RETURN_TYPE };\n$4$5\n}' $1 $2 NO_HELP
echo; echo;

echo "[[[ MULTI-LINE SUBROUTINES, ARGUMENTS NOT ON FIRST LINE, NON-WRAPPED RETURN ]]]"
find_replace_recurse.sh '(.*)\nour\s+([\w:]+)\s+\$(\w+)\s+\=\s+sub\s+\{\n((?:.|\n)*?)(?:\n\s+return(\s*[^\n\r]*?);\s*)?\n\};' '$1\nsub $3 {\n    { my $2 \$RETURN_TYPE };\n$4\n    return$5;\n}' $1 $2 NO_HELP
echo; echo;

# NEED DELETE, UNUSED
#echo "[[[ MULTI-LINE SUBROUTINES, FIRST LINE DISABLED BY COMMENT & SECOND LINE NORMAL SUB W/ OPTIONAL TRAILING COMMENT & FINAL LINE NO SEMICOLON, DO NOT MATCH & ADD RETURN STATEMENT ]]]"
#find_replace_recurse.sh '(.*)\n\#our\s+(\w+)\s+\$(\w+)\s+\=\s+sub\s+\{(?:\s*\#.*?)?\n\s*sub\s+\w+\s+\{\n((?:.|\n)*?)\n\}' '$1\nsub $3 {\n    { my $2 \$RETURN_TYPE };\n$4\n}' $1 $2 NO_HELP
#echo; echo;

echo "[[[ MULTI-LINE SUBROUTINES, FIRST LINE DISABLED BY COMMENT & SECOND LINE NORMAL SUB W/ OPTIONAL TRAILING COMMENT & FINAL LINE NO SEMICOLON, REQUIRE RETURN STATEMENT W/ TRAILING COMMENT ]]]"
find_replace_recurse.sh '(.*)\n\#our\s+(\w+)\s+\$(\w+)\s+\=\s+sub\s+\{(?:\s*\#.*?)?\n\s*sub\s+\w+\s+\{\n((?:.|\n)*?)(\n\s+return\s*[^\n\r]*?;\s*\#.*?\n\})' '$1\nsub $3 {\n    { my $2 \$RETURN_TYPE };\n$4$5' $1 $2 NO_HELP
echo; echo;

echo "[[[ MULTI-LINE SUBROUTINES, FIRST LINE DISABLED BY COMMENT & SECOND LINE NORMAL SUB W/ OPTIONAL TRAILING COMMENT & FINAL LINE NO SEMICOLON, OPTIONAL RETURN STATEMENT W/OUT TRAILING COMMENT ]]]"
find_replace_recurse.sh '(.*)\n\#our\s+(\w+)\s+\$(\w+)\s+\=\s+sub\s+\{(?:\s*\#.*?)?\n\s*sub\s+\w+\s+\{\n((?:.|\n)*?)(?:(?:\n\s+return(\s*[^\n\r]*?);\n\})|(?:\n\}))' '$1\nsub $3 {\n    { my $2 \$RETURN_TYPE };\n$4\n    return$5;\n}' $1 $2 NO_HELP
echo; echo;

# NEED DELETE, UNUSED
#echo "[[[ MULTI-LINE SUBROUTINES, DISABLED BY COMMENTS, DO NOT MATCH & ADD RETURN STATEMENT ]]]"
#find_replace_recurse.sh '(.*)\n\#our\s+(\w+)\s+\$(\w+)\s+\=\s+sub\s+\{\n((?:.|\n)*?)\n\#\};' '\n#sub $3 {\n#    { my $2 \$RETURN_TYPE };\n$4\n#}' $1 $2 NO_HELP
#echo; echo;

echo "[[[ MULTI-LINE SUBROUTINES, DISABLED BY COMMENTS, ELSE-BRACES-WRAPPED RETURN ]]]"
find_replace_recurse.sh '(.*)\n\#our\s+(\w+)\s+\$(\w+)\s+\=\s+sub\s+\{\n((?:.|\n)*?)(\#\s*else(?:\s*[\n\r]*\s*\#\s*)?\{(?:\s*[\n\r]*\s*\#\s*)?return\s*[^\n\r]*?;(?:\s*[\n\r]*\s*\#\s*)?\})(?:\s*[\n\r]*\s*\#\s*)?\};' '\n#sub $3 {\n#    { my $2 \$RETURN_TYPE };\n$4\n$5\n#}' $1 $2 NO_HELP
echo; echo;

echo "[[[ MULTI-LINE SUBROUTINES, DISABLED BY COMMENTS, NON-WRAPPED RETURN ]]]"
find_replace_recurse.sh '(.*)\n\#our\s+(\w+)\s+\$(\w+)\s+\=\s+sub\s+\{\n((?:.|\n)*?)(?:\#\s*return(\s*[^\n\r]*?);\s*)?\n\#\};' '\n#sub $3 {\n#    { my $2 \$RETURN_TYPE };\n$4\n#    return$5;\n#}' $1 $2 NO_HELP
echo; echo;

echo "[[[ OLD USAGE OF @_ INSTEAD OF @ARG ]]]"
find_replace_recurse.sh '=\s*\@_;' '= \@ARG;' $1 $2 NO_HELP
echo; echo;

