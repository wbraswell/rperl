# [[[ HEADER ]]]
package RPerl::Operation::Expression::Operator::RegularExpression;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.013_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Expression::Operator);
use RPerl::Operation::Expression::Operator;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# COPYRIGHT NOTICE: modifier descriptions copied from JPCRE2 docs under BSD license    https://github.com/jpcre2/jpcre2

# supported and compliant!  :-)
our string_hashref $modifiers_compile = {
    i => 'Case-insensitive. Equivalent to PCRE2_CASELESS option.',
    m => 'Multi-line regex. Equivalent to PCRE2_MULTILINE option.',
    s => 'If this modifier is set, a dot meta-character in the pattern matches all characters, including newlines. Equivalent to PCRE2_DOTALL option.',
    u => 'Enable UTF support.Treat pattern and subjects as UTF strings. It is equivalent to PCRE2_UTF option.',
    x => 'Whitespace data characters in the pattern are totally ignored except when escaped or inside a character class, enables commentary in pattern. Equivalent to PCRE2_EXTENDED option.',
};

=begin DISABLED_UNSUPPORTED_OR_NONCOMPLIANT

# DEV NOTE: there are other unsupported modifiers as well, see the Perl docs    https://perldoc.perl.org/perlre.html#Modifiers
our string_hashref $modifiers_compile_unsupported = {
    xx => 'Whitespace data characters in the pattern are totally ignored except when escaped, EVEN WHEN INSIDE A CHARACTER CLASS.  Requires Perl v5.26 or newer.',
};

# DEV NOTE: some of these noncompliant modifiers may be related to Perl regex assertions, such as 'A'    https://perldoc.perl.org/perlre.html
our string_hashref $modifiers_compile_noncompliant = {
    e => 'Unset back-references in the pattern will match to empty strings. Equivalent to PCRE2_MATCH_UNSET_BACKREF.',
    j => '\u \U \x and unset back-references will act as JavaScript standard. Equivalent to PCRE2_ALT_BSUX | PCRE2_MATCH_UNSET_BACKREF.
\U matches an upper case "U" character (by default it causes a compile error if this option is not set).
\u matches a lower case "u" character unless it is followed by four hexadecimal digits, in which case the hexadecimal number defines the code point to match (by default it causes a compile error if this option is not set).
\x matches a lower case "x" character unless it is followed by two hexadecimal digits, in which case the hexadecimal number defines the code point to match (By default, as in Perl, a hexadecimal number is always expected after \x, but it may have zero, one, or two digits (so, for example, \xz matches a binary zero character followed by z) ).
Unset back-references in the pattern will match to empty strings.',
    n => 'Enable Unicode support for \w \d etc... in pattern. Equivalent to PCRE2_UTF | PCRE2_UCP.',
    A => 'Match only at the first position. It is equivalent to PCRE2_ANCHORED option.',
    D => 'A dollar meta-character in the pattern matches only at the end of the subject string. Without this modifier, a dollar also matches immediately before the final character if it is a newline (but not before any other newlines). This modifier is ignored if m modifier is set. Equivalent to PCRE2_DOLLAR_ENDONLY option.',
    J => 'Allow duplicate names for sub-patterns. Equivalent to PCRE2_DUPNAMES option.',
    S => 'When a pattern is going to be used several times, it is worth spending more time analyzing it in order to speed up the time taken for matching/replacing. It may also be beneficial for a very long subject string or pattern. Equivalent to an extra compilation with JIT_COMPILER with the option PCRE2_JIT_COMPLETE.',
    U => 'This modifier inverts the "greediness" of the quantifiers so that they are not greedy by default, but become greedy if followed by ?. Equivalent to PCRE2_UNGREEDY option.',
};

=end DISABLED_UNSUPPORTED_OR_NONCOMPLIANT

=cut

our string_hashref $modifiers_match = {
    g => 'Global. Will perform global matching or replacement if passed. Equivalent to jpcre2::FIND_ALL for match and PCRE2_SUBSTITUTE_GLOBAL for replace.',
};

=begin DISABLED_UNSUPPORTED_OR_NONCOMPLIANT

our string_hashref $modifiers_match_noncompliant = {
    A => 'Match at start. Equivalent to PCRE2_ANCHORED. Can be used in match operation. Setting this option only at match time (i.e regex was not compiled with this option) will disable optimization during match time.',
};

=end DISABLED_UNSUPPORTED_OR_NONCOMPLIANT

=cut

our string_hashref $modifiers_substitute = {
    g => 'Global. Will perform global matching or replacement if passed. Equivalent to jpcre2::FIND_ALL for match and PCRE2_SUBSTITUTE_GLOBAL for replace.',
};

=begin DISABLED_UNSUPPORTED_OR_NONCOMPLIANT

our string_hashref $modifiers_substitute_noncompliant = {
    e => 'Replaces unset group with empty string. Equivalent to PCRE2_SUBSTITUTE_UNSET_EMPTY.',
    E => 'Extension of e modifier. Sets even unknown groups to empty string. Equivalent to PCRE2_SUBSTITUTE_UNSET_EMPTY | PCRE2_SUBSTITUTE_UNKNOWN_UNSET',
    x => 'Extended replacement operation. Equivalent to PCRE2_SUBSTITUTE_EXTENDED. It enables some Bash like features:
${<n>:-<string>}
${<n>:+<string1>:<string2>}
<n> may be a group number or a name. The first form specifies a default value. If group <n> is set, its value is inserted; if not, <string> is expanded and the result is inserted. The second form specifies strings that are expanded and inserted when group <n> is set or unset, respectively. The first form is just a convenient shorthand for ${<n>:+${<n>}:<string>}.',
};

=end DISABLED_UNSUPPORTED_OR_NONCOMPLIANT

=cut

# [[[ SUBROUTINES & OO METHODS ]]]

sub ast_to_rperl__generate {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $rperl_source_group = { PMC => q{} };

#    RPerl::diag( 'in Operator::RegularExpression->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;
    if ( $self_class eq 'Operator_110' ) { # Operator -> SubExpression OP06_REGEX_BIND OP06_REGEX_PATTERN
        my string_hashref $rperl_source_subgroup
            = $self->{children}->[0]->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= q{ } . $self->{children}->[1] . q{ } . $self->{children}->[2];
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASRP000, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '
                . $self_class
                . ' found where Operator_110 expected, dying' )
            . "\n";
    }
    return $rperl_source_group;
}

sub ast_to_cpp__generate__CPPOPS_PERLTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group
        = { CPP =>
            q{// <<< RP::O::E::O::RE __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n" };

    #...
    return $cpp_source_group;
}

sub ast_to_cpp__generate__CPPOPS_CPPTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group = { CPP => q{} };

#    RPerl::diag( 'in Operator::RegularExpression->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;
    if ( $self_class eq 'Operator_110' ) { # Operator -> SubExpression OP06_REGEX_BIND OP06_REGEX_PATTERN
        # generate subexpression, to left of regex bind operator
        my string_hashref $cpp_source_subgroup = $self->{children}->[0]->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );

        # get bind and pattern strings
        my string $bind = $self->{children}->[1];
        my string $pattern = $self->{children}->[2];
        RPerl::diag( q{in Operator::RegularExpression->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $bind = '} . $bind . q{'} . "\n" );
        RPerl::diag( q{in Operator::RegularExpression->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $pattern = '} . $pattern . q{'} . "\n" );

        # NEED FIX: DIE ON !~ BINDING OPERATOR, should actually be logic & code generation to implement !~ binding operator
        if ($bind ne '=~') {
            die q{ERROR ECOGEASCP0xx: Regular expression binding operator '} . $bind . q{' not yet supported, dying};
        }

        # separate pattern into match/substitute flag, bare pattern, and modifiers
        my character $match_or_substitute = substr $pattern, 0, 1;
        my string $modifiers = q{};
        for (my integer $pattern_index = ((length $pattern) - 1); $pattern_index >= 0; $pattern_index--) {
            my character $modifier = substr $pattern, $pattern_index, 1;
            if ($modifier eq '/') { last; }
            $modifiers = $modifier . $modifiers;
        }
        my string $pattern_bare = substr $pattern, 1, ((length $pattern) - ((length $modifiers) + 1));
        RPerl::diag( q{in Operator::RegularExpression->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $match_or_substitute = '} . $match_or_substitute . q{'} . "\n" );
        RPerl::diag( q{in Operator::RegularExpression->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $pattern_bare = '} . $pattern_bare . q{'} . "\n" );
        RPerl::diag( q{in Operator::RegularExpression->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $modifiers = '} . $modifiers . q{'} . "\n" );

        # test for and remove book-end forward slash characters
        if ((substr $pattern_bare, 0, 1) ne q{/}) {
            die q{ERROR ECOGEASCP081: Regular expression pattern '} . $pattern_bare . q{' does not begin with forward slash '/' character, dying};
        }
        if ((substr $pattern_bare, -1, 1) ne q{/}) {
            die q{ERROR ECOGEASCP082: Regular expression pattern '} . $pattern_bare . q{' does not end with forward slash '/' character, dying};
        }
        $pattern_bare = substr $pattern_bare, 1, ((length $pattern_bare) - 2);

        # must backslash-escape backslashes within bare pattern, character class \w must appear as \\w etc, convert all single backslashes into double backslashes
        $pattern_bare =~ s/\\/\\\\/gxms;
        RPerl::diag( q{in Operator::RegularExpression->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have forward-slash-cleaned and backslash-escaped $pattern_bare = '} . $pattern_bare . q{'} . "\n" );

        my string $modifiers_compile_enabled = q{};
        my string $modifiers_match_enabled = q{};
        my string $modifiers_substitute_enabled = q{};
        my string $modifiers_compile_extra = q{};

        # include S compile modifier for optimization on long (presumably more complex) patterns
        if ((length $pattern_bare) > 20) {
            RPerl::diag( q{in Operator::RegularExpression->ast_to_cpp__generate__CPPOPS_CPPTYPES(), setting S modifier to attempt PCRE2 optimization of pattern over length of 20 characters} . "\n" );
            $modifiers_compile_extra = 'S';
        }

        # match
        if ($match_or_substitute eq 'm') {
            # EXAMPLE C++ CODE
            # // check if string matches the pattern, return true or false
            # regex("(\\d)|(\\w)").match("I am the subject")
            # // match all and get the match count using the action modifier 'g', return count
            # regex("(\\d)|(\\w)","m").match("I am the subject","g")
 
            RPerl::diag( q{in Operator::RegularExpression->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have all valid match modifiers = '} . (join ', ', (sort keys %{{%{$modifiers_compile}, %{$modifiers_match}}})) . q{'} . "\n" );

            # validate & sort modifiers
            foreach my character $modifier (split //, $modifiers) {
                if (exists $modifiers_compile->{$modifier}) {
                    RPerl::diag( q{in Operator::RegularExpression->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have valid compile modifier '} . $modifier . q{' with description as follows:} . "\n\t" . $modifiers_compile->{$modifier} . "\n" );
                    $modifiers_compile_enabled .= $modifier;
                }
                elsif (exists $modifiers_match->{$modifier}) {
                    RPerl::diag( q{in Operator::RegularExpression->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have valid match modifier '} . $modifier . q{' with description as follows:} . "\n\t" . $modifiers_match->{$modifier} . "\n" );
                    $modifiers_match_enabled .= $modifier;
                }
                else {
                    die q{ERROR ECOGEASCP083: Non-compliant, unsupported, or unrecognized regular expression modifier '} . $modifier . q{' found, must be one of (} . (join ', ', (sort keys %{{%{$modifiers_compile}, %{$modifiers_match}}})) . q{), dying};
                }
            }
            RPerl::diag( q{in Operator::RegularExpression->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $modifiers_compile_enabled = '} . $modifiers_compile_enabled . "\n" );
            RPerl::diag( q{in Operator::RegularExpression->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $modifiers_match_enabled = '} . $modifiers_match_enabled . "\n" );

            # compose final C++ code for modifiers
            my $modifiers_compile_CPP = q{};
            if (($modifiers_compile_enabled . $modifiers_compile_extra) ne q{}) {
                $modifiers_compile_CPP = q{, "} . ($modifiers_compile_enabled . $modifiers_compile_extra) . q{"};
            }
            my $modifiers_match_CPP = q{};
            if ($modifiers_match_enabled ne q{}) {
                $modifiers_match_CPP = q{, "} . $modifiers_match_enabled . q{"};
            }
            RPerl::diag( q{in Operator::RegularExpression->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $modifiers_compile_CPP = '} . $modifiers_compile_CPP . "\n" );
            RPerl::diag( q{in Operator::RegularExpression->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $modifiers_match_CPP = '} . $modifiers_match_CPP . "\n" );

            # DEV NOTE: $cpp_source_group->{CPP} already contains the generated subexpression to be used as the subject of the regex
            # DEV NOTE: Perl vs JPCRE2 inconsistency, must explicitly cast return value change count as boolean true/false value
            $cpp_source_group->{CPP} = '(boolean) regex("' . $pattern_bare . '"' . $modifiers_compile_CPP . ').match(' . $cpp_source_group->{CPP} . $modifiers_match_CPP . ')';
        }
        # substitute
        elsif ($match_or_substitute eq 's') {
            # EXAMPLE C++ CODE
            # // replace first occurrence of a digit with @
            # string foo = (const string) "I am the subject string 44";
            # regex("\\d").preplace(&foo, "@")
            # // replace all occurrences of a digit with @
            # string foo = (const string) "I am the subject string 44";
            # regex("\\d").preplace(&foo, "@", "g")
            # // swap two parts of a string
            # string foo = (const string) "I am the subject\tTo be swapped according to tab";
            # regex("^([^\t]+)\t([^\t]+)$").preplace(&foo, "$2 $1")

            RPerl::diag( q{in Operator::RegularExpression->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have all valid substitute modifiers = '} . (join ', ', (sort keys %{{%{$modifiers_compile}, %{$modifiers_substitute}}})) . q{'} . "\n" );

            # validate & sort modifiers
            foreach my character $modifier (split //, $modifiers) {
                if (exists $modifiers_compile->{$modifier}) {
                    RPerl::diag( q{in Operator::RegularExpression->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have valid compile modifier '} . $modifier . q{' with description as follows:} . "\n\t" . $modifiers_compile->{$modifier} . "\n" );
                    $modifiers_compile_enabled .= $modifier;
                }
                elsif (exists $modifiers_substitute->{$modifier}) {
                    RPerl::diag( q{in Operator::RegularExpression->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have valid substitute modifier '} . $modifier . q{' with description as follows:} . "\n\t" . $modifiers_substitute->{$modifier} . "\n" );
                    $modifiers_substitute_enabled .= $modifier;
                }
                else {
                    die q{ERROR ECOGEASCP084: Non-compliant, unsupported, or unrecognized regular expression modifier '} . $modifier . q{' found, must be one of (} . (join ', ', (sort keys %{{%{$modifiers_compile}, %{$modifiers_substitute}}})) . q{), dying};
                }
            }

            # compose final C++ code for modifiers
            my $modifiers_compile_CPP = q{};
            if (($modifiers_compile_enabled . $modifiers_compile_extra) ne q{}) {
                $modifiers_compile_CPP = q{, "} . ($modifiers_compile_enabled . $modifiers_compile_extra) . q{"};
            }
            my $modifiers_substitute_CPP = q{};
            if ($modifiers_substitute_enabled ne q{}) {
                $modifiers_substitute_CPP = q{, "} . $modifiers_substitute_enabled . q{"};
            }

            # validate substitute pattern
            my $pattern_forward_slash_count = ( $pattern_bare =~ m/\//gxms );
            if ($pattern_forward_slash_count != 1) {
                die q{ERROR ECOGEASCP085: Substitution regular expression pattern '} . $pattern_bare . q{' does not contain exactly one forward slash '/' character, dying};
            }

            # split find/replace portions of substitute pattern
            my string $pattern_find = q{};
            my string $pattern_replace = q{};
            my boolean $found_slash = 0;
            foreach my character $pattern_character (split //, $pattern_bare) {
                if ($pattern_character eq '/') {
                    $found_slash = 1;
                    next;
                }
                elsif (not $found_slash) {
                    $pattern_find .= $pattern_character;
                }
                else {
                    $pattern_replace .= $pattern_character;
                }
            }

            # START HERE
            # START HERE
            # START HERE
            # NEED ADD ERROR CHECK OR GRAMMAR CHANGE: regex substitution's LHS subexpression can only be a variable, because we must return assign value back to variable to emulate PERLOPS_PERLTYPES behavior
            # NEED ADD SUPPORT: non-destructive regex substitution using Perl's /r modifier, and NOT setting the original variable to the return value in C++
            # NEED ADD LOGIC: bind not !~ instead of only bind =~, disable die on !~ above !!!

            # DEV NOTE: $cpp_source_group->{CPP} already contains the generated subexpression to be used as the subject of the regex

            # EXAMPLE C++ CODE:  regex("FIND", "MODS_COMP").preplace(&foo, "REPLACE_WITH", "MODS_SUBST")
            $cpp_source_group->{CPP} = 'regex("' . $pattern_find . '"' . $modifiers_compile_CPP . ').preplace(&' . $cpp_source_group->{CPP} . ', "' . $pattern_replace . '"' . $modifiers_substitute_CPP . ')';
        }
        else {
            die q{ERROR ECOGEASCP080: Unrecognized regular expression type '} . $match_or_substitute . q{' found, must be 'm' for match or 's' for substitute, dying};
        }
    }
    else {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP000, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule ' . $self_class . ' found where Operator_110 expected, dying' ) . "\n";
    }

    RPerl::diag( 'in Operator::RegularExpression->ast_to_cpp__generate__CPPOPS_CPPTYPES(), about to return $cpp_source_group = ' . "\n" . RPerl::Parser::rperl_ast__dump($cpp_source_group) . "\n" );
    return $cpp_source_group;
}

1;    # end of class
