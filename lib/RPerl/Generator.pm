## no critic qw(ProhibitExcessMainComplexity)  # SYSTEM SPECIAL 4: allow complex code outside subroutines, must be on line 1
# [[[ HEADER ]]]
package RPerl::Generator;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.002_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);
use RPerl::CompileUnit::Module::Class;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitStringyEval)  # SYSTEM DEFAULT 1: allow eval()

# [[[ INCLUDES ]]]
use RPerl::Grammar;
use rperltypesconv;

#use RPerl::Parser;
#require RPerl::Parser;
#eval 'require RPerl::Parser;';
eval { require RPerl::Parser; };
if ( $EVAL_ERROR and ( $EVAL_ERROR =~ /attempt to reload/i ) ) {
    delete $INC{'RPerl::Parser'};
    require RPerl::Parser;
}
elsif ( $EVAL_ERROR ne q{} ) { die $EVAL_ERROR; }

use English qw(-no_match_vars);    # for $OSNAME; NEED ANSWER: why isn't this included from 'require RPerl::Config', which is included from 'use RPerl' above?

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ PROCEDURAL SUBROUTINES ]]]

# convert array max index to array size (difference of 1)
our object $arrayref_convert_index_max_to_size = sub {
    ( my object $subexpression ) = @_;

#    RPerl::diag( 'in Generator->arrayref_convert_index_max_to_size(), received $subexpression = ' . "\n" . RPerl::Parser::rperl_ast__dump($subexpression) . "\n" );

    my object $subexpression_original = $subexpression;
    my boolean $is_modified = 0;
    my integer $nested_parenthesis = 0;
    
    # look inside nested parenthesis-as-subexpressions, always length 1 so no need to check length
    while ((ref $subexpression) eq 'SubExpression_143') {  # RPerl::Operation::Expression::SubExpression::Parenthesis
        $subexpression = $subexpression->{children}->[1];
        $nested_parenthesis++;
    }
 
#    RPerl::diag( 'in Generator->arrayref_convert_index_max_to_size(), have post-nested-parens $subexpression = ' . "\n" . RPerl::Parser::rperl_ast__dump($subexpression) . "\n" );

    if ( $subexpression->{children}->[0]->isa('RPerl::Operation::Expression::Operator') ) {
        if ( $subexpression->{children}->[0]->{children}->[0]->isa('RPerl::Operation::Expression::Operator::Arithmetic::AddSubtract') ) {
            if (    ( exists $subexpression->{children}->[0]->{children}->[0]->{children}->[1] )
                and ( $subexpression->{children}->[0]->{children}->[0]->{children}->[1] =~ /^-\s*$/xms ) )
            {
                if ( $subexpression->{children}->[0]->{children}->[0]->{children}->[2]->isa('RPerl::Operation::Expression::SubExpression::Literal') ) {
                    if ( $subexpression->{children}->[0]->{children}->[0]->{children}->[2]->{children}->[0]
                        ->isa('RPerl::Operation::Expression::SubExpression::Literal::Number') )
                    {
                        if ( $subexpression->{children}->[0]->{children}->[0]->{children}->[2]->{children}->[0]->{children}->[0] eq q{1} ) {
                            # '$foo - 1' becomes '$foo'
#                            RPerl::diag( 'in Generator->arrayref_convert_index_max_to_size(), setting ($foo - 1) to ($foo)' . "\n");
                            $subexpression = $subexpression->{children}->[0]->{children}->[0]->{children}->[0];
                            $is_modified = 1;
                            $nested_parenthesis = 0;  # discard parens if present
                        }
                        else {
                            # '$foo - 10' becomes '$foo - 9'
                            my number $tmp_number
                                = string_to_number( $subexpression->{children}->[0]->{children}->[0]->{children}->[2]->{children}->[0]->{children}->[0] );
#                            RPerl::diag( 'in Generator->arrayref_convert_index_max_to_size(), setting ($foo - ' . $tmp_number . ') to ($foo - ' . ($tmp_number - 1)  .')' . "\n");
                            $tmp_number--;
                            $subexpression->{children}->[0]->{children}->[0]->{children}->[2]->{children}->[0]->{children}->[0]
                                = number_to_string($tmp_number);
                            $is_modified = 1;
                            if ($nested_parenthesis) { $nested_parenthesis = 1; }  # keep 1 set of parens if 1 or more is present
                        }
                    }
                }
            }
        }
    }
#    else { RPerl::diag( 'in Generator->arrayref_convert_index_max_to_size(), have non-Operator $subexpression, not modifying' . "\n"); }

    if ($is_modified) {
        if ($nested_parenthesis) {
            # create new-but-equivalent object to alert caller of modification
            my object $subexpression_modified = RPerl::CompileUnit::Module::Class::new('SubExpression_143');
            $subexpression_modified->{children}->[0] = '(';
            $subexpression_modified->{children}->[1] = $subexpression;
            $subexpression_modified->{children}->[2] = ')';
            $subexpression = $subexpression_modified;
        }
        else {
            # create new-but-equivalent object to alert caller of modification
            my object $subexpression_modified = RPerl::CompileUnit::Module::Class::new(ref $subexpression);
            $subexpression_modified->{children} = $subexpression->{children};
            $subexpression = $subexpression_modified;
        }
    }
    return $subexpression;
};

# convert RPerl types to C++ types
our string $type_convert_perl_to_cpp = sub {
    ( my string $return_type, my boolean $pointerify_classes ) = @_;

    #    RPerl::diag('in Generator->type_convert_perl_to_cpp(), received $return_type = ' . $return_type . "\n");
    #    RPerl::diag('in Generator->type_convert_perl_to_cpp(), received $pointerify_classes = ' . $pointerify_classes . "\n");

    if ( exists $rperlnamespaces_generated::RPERL->{ $return_type . '::' } ) {    # RPerl types
        $return_type =~ s/^constant_/const\ /gxms;                                # 'constant_foo' becomes 'const foo'
    }
    else {                                                                        # user-defined types AKA classes
        $return_type =~ s/:/_/gxms;                                               # 'Foo::Bar::Baz' becomes 'Foo__Bar__Baz'
        if ($pointerify_classes) {
            if ( $return_type =~ /_raw$/ ) {
                $return_type =~ s/_raw$/_rawptr/xms;                              # 'Foo__Bar__Baz_raw' becomes 'Foo__Bar__Baz_rawptr'
            }
            elsif ( ( $return_type !~ /_arrayref$/ ) and ( $return_type !~ /_hashref$/ ) ) {

                # don't pointerify arrayrefs or hashrefs, they are already pointerified
                $return_type .= '_ptr';                                           # 'Foo__Bar__Baz' becomes 'Foo__Bar__Baz_ptr'
            }
        }
    }
    return $return_type;                                                          # much meta
};

# search for dummy source code
our boolean $dummy_source_code_find = sub {
    ( my string_hashref $source_group ) = @_;
    foreach my string $suffix_key ( sort keys %{$source_group} ) {
        if ( $source_group->{$suffix_key} =~ /__DUMMY_SOURCE_CODE/xms ) {
            return 1;
        }
    }
    return 0;
};

# line-by-line comparison of file contents vs string contents;
# returns -1 __DUMMY_SOURCE_CODE found, 0 no difference, >0 line number of first difference
our integer $diff_check_file_vs_string = sub {
    ( my string $filename, my string $source_string, my string $ops) = @_;

#    RPerl::diag('in Generator->diff_check_file_vs_string(), received $filename = ' . $filename . "\n");
#    RPerl::diag('in Generator->diff_check_file_vs_string(), contents of file = ' . "\n");
#    system 'cat', $filename;
#    RPerl::diag('in Generator->diff_check_file_vs_string(), received $source_string = ' . "\n" . $source_string . "\n\n");

    if ( not -f $filename ) {
        die 'ERROR ECOGEDI00, RPERL GENERATOR, DIFF CHECK: file not found, ' . q{'} . $filename . q{'} . "\n" . ', dying' . "\n";
    }

    open my filehandleref $FILE_HANDLE, '<', $filename
        or die 'ERROR ECOGEDI01, RPERL GENERATOR, DIFF CHECK: Cannot open file ' . $filename . ' for reading,' . $OS_ERROR . ', dying' . "\n";

    # read in file, strip comments & blank lines
    my string $file_line;
    my string $file_string = q{};
    while ( $file_line = <$FILE_HANDLE> ) {
        $file_line =~ s/^\s+//xms;    # strip leading whitespace
        if ( ( $ops eq 'PERL' ) and ( $file_line =~ /^[#][^#!]/xms ) ) {
            next;                     # discard whole-line comment, PERLOPS
        }
        elsif ( ( $ops eq 'CPP' ) and ( $file_line =~ m{^//}xms ) ) {
            next;                     # discard whole-line comment, CPPOPS
        }
        elsif ( $file_line =~ /^\s*$/xms ) {
            next;                     # discard blank & all-whitespace lines
        }

        # strip partial-line comment, if present
        if ( $ops eq 'PERL' ) {

            # DEV NOTE: this regex does not account for strings containing # characters
            #            $file_line =~ s/[^#][#][^#!].*$/\n/gxms;

            my string $file_line_tmp = q{};
            my string $current_character;
            my string $next_character;
            my boolean $inside_string = 0;
            my boolean $advance_one   = 0;
            my string $open_quote;
            for my integer $i ( 0 .. ( ( length $file_line ) - 1 ) ) {
                $current_character = substr $file_line, $i, 1;

                # advance one extra character for q{ OR #! OR ##
                if ($advance_one) {
                    $advance_one = 0;
                    $file_line_tmp .= $current_character;
                    next;
                }
                if ( not $inside_string ) {
                    if ( $current_character eq '#' ) {
                        $next_character = substr $file_line, ( $i + 1 ), 1;
                        if (   ( $next_character eq '!' )
                            or ( $next_character eq '#' ) )
                        {
                            $advance_one = 1;

                            #                            next;
                        }
                        else {
                            #                           $file_line = substr $file_line, 0, $i;
                            #                           $file_line .= "\n";
                            $file_line_tmp .= "\n";
                            last;
                        }
                    }
                    elsif ( $current_character eq q{'} ) {
                        $inside_string = 1;
                        $open_quote    = q{'};
                    }
                    elsif ( $current_character eq q{"} ) {
                        $inside_string = 1;
                        $open_quote    = q{"};
                    }
                    elsif ( $current_character eq 'q' ) {
                        $next_character = substr $file_line, ( $i + 1 ), 1;
                        if ( $next_character eq '{' ) {
                            $inside_string = 1;
                            $advance_one   = 1;
                            $open_quote    = 'q{';
                        }
                    }
                    elsif ( $current_character =~ m/[ \t]/ ) {    # remove extra whitespace inserted by Perl::Tidy
                        $next_character = substr $file_line, ( $i + 1 ), 1;
                        if ( $next_character =~ m/[ \t]/ ) {
                            next;
                        }
                    }
                }
                else {                                            # $inside_string
                    if (    ( $current_character eq q{'} )
                        and ( $open_quote eq q{'} ) )
                    {
                        $inside_string = 0;
                    }
                    elsif ( ( $current_character eq q{"} )
                        and ( $open_quote eq q{"} ) )
                    {
                        $inside_string = 0;
                    }
                    elsif ( ( $current_character eq '}' )
                        and ( $open_quote eq 'q{' ) )
                    {
                        $inside_string = 0;
                    }
                }
                $file_line_tmp .= $current_character;
            }
            $file_line = $file_line_tmp;
        }
        else {    # $ops eq 'CPP'
                  # NEED FIX: add comment-strip C++ code, accounting for strings containing // and /*
                  # NEED FIX: add comment-strip C++ code, accounting for strings containing // and /*
                  # NEED FIX: add comment-strip C++ code, accounting for strings containing // and /*

            #            $file_line =~ s{//.*$}{\n}gxms;     # // comments
            #            $file_line =~ s{/\*.*\*/}{}gxms;    # /* comments */
        }

        # strip trailing whitespace, if present
        $file_line =~ s/[ \t]+$//;
        $file_string .= $file_line;
    }

    close $FILE_HANDLE
        or die 'ERROR ECOGEDI02, RPERL GENERATOR, DIFF CHECK: Cannot close file ' . $filename . ' after reading,' . $OS_ERROR . ', dying' . "\n";

    # remove extra blank lines inserted by RPerl generators
    $source_string =~ s/\n\n/\n/gxms;

#    RPerl::diag( 'in Generator->diff_check_file_vs_string(), have $file_string = ' . "\n" . ( q{=} x 60 ) . "\n" . $file_string . "\n" . ( q{=} x 60 ) . "\n\n" );
#    RPerl::diag( 'in Generator->diff_check_file_vs_string(), have $source_string = ' . "\n" . ( q{=} x 60 ) . "\n" . $source_string . "\n" . ( q{=} x 60 ) . "\n\n" );

    # tidy all code
    my string $file_string_tidied;
    my string $source_string_tidied;
    if ( $ops eq 'PERL' ) {

        # tidy file string
        my string $perltidy_stderr_string = undef;
        my scalartype $perltidy_errored   = Perl::Tidy::perltidy(

            # same as Compiler::save_source_files() except '-se' to redirect STDERR
            argv        => q{-pbp --ignore-side-comment-lengths --converge -l=160 -b -nst -bext='/' -q -se},
            source      => \$file_string,
            destination => \$file_string_tidied,
            stderr      => \$perltidy_stderr_string,
        );
        if ($perltidy_errored) {    # serious error in input parameters, no tidied output
            die 'ERROR ECOGEDI03: Perl::Tidy major failure in file ' . q{'} . $filename . q{'} . ' with the following STDERR output, dying' . "\n" . $perltidy_stderr_string . "\n";
        }
        elsif ($perltidy_stderr_string) {
            die 'ERROR ECOGEDI04: Perl::Tidy minor failure in file ' . q{'} . $filename . q{'} . ' with the following STDERR output, dying' . "\n" . $perltidy_stderr_string . "\n";
        }

        # tidy source string
        $perltidy_errored = Perl::Tidy::perltidy(
            argv        => q{-pbp --ignore-side-comment-lengths --converge -l=160 -b -nst -bext='/' -q -se},
            source      => \$source_string,
            destination => \$source_string_tidied,
            stderr      => \$perltidy_stderr_string,
        );
        if ($perltidy_errored) {
            die 'ERROR ECOGEDI05: Perl::Tidy major failure in generated source code string with the following STDERR output, dying' . "\n" . $perltidy_stderr_string . "\n";
        }
        elsif ($perltidy_stderr_string) {
            die 'ERROR ECOGEDI06: Perl::Tidy minor failure in generated source code string with the following STDERR output, dying' . "\n" . $perltidy_stderr_string . "\n";
        }
    }
    else {    # $ops eq 'CPP'
        die 'NEED FIX: add tidy C++ code';

        # NEED FIX: add tidy C++ code
        # NEED FIX: add tidy C++ code
        # NEED FIX: add tidy C++ code
    }

    # remove extra blank lines inserted by Perl::Tidy
    $file_string_tidied =~ s/\n\n/\n/gxms;
    $source_string_tidied =~ s/\n\n/\n/gxms;

#    RPerl::diag( 'in Generator->diff_check_file_vs_string(), have $file_string_tidied = ' . "\n" . ( q{=} x 60 ) . "\n" . $file_string_tidied . "\n" . ( q{=} x 60 ) . "\n\n" );
#    RPerl::diag( 'in Generator->diff_check_file_vs_string(), have $source_string_tidied = ' . "\n" . ( q{=} x 60 ) . "\n" . $source_string_tidied . "\n" . ( q{=} x 60 ) . "\n\n" );

    my string_arrayref $file_string_split   = [ ( split /\n/xms, $file_string_tidied ) ];
    my string_arrayref $source_string_split = [ ( split /\n/xms, $source_string_tidied ) ];
    my string_arrayref $source_string_split_tmp = [];
    my string $string_line;

    # discard blank & all-whitespace lines
    foreach $string_line ( @{$source_string_split} ) {
        if ( $string_line !~ /^\s*$/xms ) {
            push @{$source_string_split_tmp}, $string_line;
        }
    }
    $source_string_split     = $source_string_split_tmp;
    $source_string_split_tmp = undef;

    my $return_value = 0;    # default return value, files do not differ
    for my integer $i ( 0 .. ( ( scalar @{$file_string_split} ) - 1 ) ) {
        $file_line   = $file_string_split->[$i];
        $string_line = $source_string_split->[$i];
        if ( $string_line =~ /__DUMMY_SOURCE_CODE/xms ) {
            RPerl::warning( 'WARNING WCOGEDI00, RPERL GENERATOR, DIFF CHECK: Dummy source code found, abandoning check' . "\n" );
            $return_value = -1;
            last;
        }

        if ( $file_line ne $string_line ) {

            #            RPerl::diag( 'in Generator->diff_check_file_vs_string(), have non-matching $file_line =' . "\n" . $file_line . "\n" );
            #            RPerl::diag( 'in Generator->diff_check_file_vs_string(), have non-matching $string_line =' . "\n" . $string_line . "\n" );
            $return_value = $i + 1;    # arrays indexed from 0, file lines indexed from 1
            last;
        }
    }

#    RPerl::diag( 'in Generator->diff_check_file_vs_string(), about to return $return_value =' . "\n" . $return_value . "\n" );
    return $return_value;
};

# Generate from RPerl AST back to RPerl Source Code
our string_hashref $ast_to_rperl__generate = sub {
    ( my object $node, my string_hashref $modes) = @_;

    #    RPerl::diag("in Generator::ast_to_rperl__generate(), received \$node =\n" . RPerl::Parser::rperl_ast__dump($node) . "\n");
    #    RPerl::diag("in Generator::ast_to_rperl__generate(), received \$modes =\n" . Dumper($modes) . "\n");

    RPerl::verbose('GENERATE:           Generate RPerl syntax...       ');

    if ( not( defined $modes->{types} ) ) {
        die 'ERROR ECOGEMO00, RPERL GENERATOR, RPERL TYPES MODE:' . "\n" . q{'PERL'} . 'expected but undefined/null value found, dying' . "\n";
    }
    if ( not( $modes->{types} eq 'PERL' ) ) {
        die 'ERROR ECOGEMO01, RPERL GENERATOR, RPERL TYPES MODE:' . "\n" . q{'PERL'} . 'expected but non-matching value found, dying' . "\n";
    }

    grammar_rules__map();

    # NEED FIX: check to ensure we are generating a valid return object
    my string_hashref $rperl_source_group = $node->ast_to_rperl__generate($modes);

    RPerl::verbose( ' done.' . "\n" );
    return $rperl_source_group;
};

# Generate from RPerl AST to C++ Source Code
our string_hashref $ast_to_cpp__generate = sub {
    ( my object $node, my string_hashref $modes) = @_;

    #    RPerl::diag("in Generator::ast_to_cpp__generate(), received \$node =\n" . RPerl::Parser::rperl_ast__dump($node) . "\n");
    #    RPerl::diag("in Generator::ast_to_cpp__generate(), received \$modes =\n" . Dumper($modes) . "\n");
    #    RPerl::diag( 'in Generator::ast_to_cpp__generate(), received $modes->{_symbol_table} = ' . "\n" . Dumper($modes->{_symbol_table}) . "\n" );

    RPerl::verbose('GENERATE:           Generate   C++ syntax...       ');

    if ( not( defined $modes->{types} ) ) {
        die 'ERROR ECOGEMO02, C++ GENERATOR, RPERL TYPES MODE:' . "\n" . q{'PERL' or 'CPP'} . 'expected but undefined/null value found, dying' . "\n";
    }
    if ( not( ( $modes->{types} eq 'PERL' ) or ( $modes->{types} eq 'CPP' ) ) ) {
        die 'ERROR ECOGEMO03, C++ GENERATOR, RPERL TYPES MODE:' . "\n" . q{'PERL' or 'CPP'} . 'expected but non-matching value found, dying' . "\n";
    }

    grammar_rules__map();

    # NEED FIX: check to ensure we are generating a valid return object
    my string_hashref $cpp_source_group;

    if ( $modes->{types} eq 'PERL' ) {
        $cpp_source_group = $node->ast_to_cpp__generate__CPPOPS_PERLTYPES($modes);
    }
    else {
        $cpp_source_group = $node->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
    }

    RPerl::verbose( ' done.' . "\n" );
    return $cpp_source_group;
};

# Append All Source Code Entries From Group 2 Onto The Respective Entries In Group 1
#our string_hashref $source_group_append = sub {
our void $source_group_append = sub {
    ( my string_hashref $rperl_source_group_1, my string_hashref $rperl_source_group_2) = @_;

#    RPerl::diag('in Generator::source_group_append(), received $rperl_source_group_1 =' . "\n" . Dumper($rperl_source_group_1) . "\n");
#    RPerl::diag('in Generator::source_group_append(), received $rperl_source_group_2 =' . "\n" . Dumper($rperl_source_group_2) . "\n");

    my string $type_1;
    my string $type_2;
    foreach my string $suffix_key ( sort keys %{$rperl_source_group_2} ) {
        if ( defined $rperl_source_group_2->{$suffix_key} ) {
            $type_2 = ref $rperl_source_group_2->{$suffix_key};
            if ($type_2 eq q{}) { $type_2 = 'SCALAR'; }
            if (   ( exists $rperl_source_group_1->{$suffix_key} )
                and ( defined $rperl_source_group_1->{$suffix_key} ) ) {
                $type_1 = ref $rperl_source_group_1->{$suffix_key};
                if ($type_1 eq q{}) { $type_1 = 'SCALAR'; }
                if ($type_1 ne $type_2) {
                    die 'ERROR ECOGE00, GENERATOR: Source group entries type mismatch, ' . q{'} . $type_1 . q{'} . ' is different than ' . q{'} . $type_2 . q{'} . ', dying' . "\n";
                }
            }
            else { $type_1 = undef; }

#    RPerl::diag('in Generator::source_group_append(), have $type_1 =' .  $type_1 . "\n");
#    RPerl::diag('in Generator::source_group_append(), have $type_2 =' .  $type_2 . "\n");

            # init to empty thing if not already defined
            if ( not defined $type_1 ) {
                if ($type_2 eq 'ARRAY') {
                    $rperl_source_group_1->{$suffix_key} = [];
                }
                elsif ($type_2 eq 'HASH') {
                    $rperl_source_group_1->{$suffix_key} = {};
                }
                else {
                    $rperl_source_group_1->{$suffix_key} = q{};
                }
            }
            if ($type_2 eq 'ARRAY') {
                $rperl_source_group_1->{$suffix_key} = [@{$rperl_source_group_1->{$suffix_key}}, @{$rperl_source_group_2->{$suffix_key}}];
            }
            elsif ($type_2 eq 'HASH') {
                $rperl_source_group_1->{$suffix_key} = {%{$rperl_source_group_1->{$suffix_key}}, %{$rperl_source_group_2->{$suffix_key}}};
            }
            else {
                if (($suffix_key eq '_package_name') or ($suffix_key eq '_package_name_underscores')) {
                    # replace (don't append) special system data items
                    $rperl_source_group_1->{$suffix_key} = $rperl_source_group_2->{$suffix_key};
                }
                else {
                    $rperl_source_group_1->{$suffix_key} .= $rperl_source_group_2->{$suffix_key};
                }
            }
        }
    }
};

our void $grammar_rules__map = sub {

    # do not attempt to re-map grammar rules if already mapped
    if (    ( exists &CompileUnit_5::ast_to_rperl__generate )
        and ( defined &CompileUnit_5::ast_to_rperl__generate ) )
    {
        return;
    }

    #    RPerl::diag("in Generator::grammar_rules__map(), have \$RPerl::Grammar::RULES =\n" . Dumper($RPerl::Grammar::RULES) . "\n");
    foreach my string $rule ( sort keys %{$RPerl::Grammar::RULES} ) {

        # create mapped class/package (namespace) and set up Perl inheritance
        my string $eval_string
            = 'package '
            . $rule
            . q{; use parent qw(}
            . $RPerl::Grammar::RULES->{$rule}
            . q{); use }
            . $RPerl::Grammar::RULES->{$rule}
            . q{; our hashref $properties = {}; 1;};

        #        RPerl::diag('in Generator::grammar_rules_map(), have 1st $eval_string = ' . "\n" . $eval_string . "\n");
        my integer $eval_retval = eval $eval_string;
        if ( ( not defined $eval_retval ) or ( $EVAL_ERROR ne q{} ) ) {
            die 'ERROR ECOGE01, GENERATOR: Grammar rules map, failed to create pre-mapped namespace, dying' . "\n" . $EVAL_ERROR . "\n";
        }

        #        if (not defined $eval_retval) {die $EVAL_ERROR . "\n";}

# copy all subroutines (and thus methods) from original class/package (namespace) into mapped class/package at runtime;
# DEV NOTE: I thought this would be handled automatically by Perl inheritance above, but I guess not, probably due to how Class.pm sets subroutines during INIT compile time
# NEED REMOVE HIGH MAGIC: double-eval'ed short form, long form available in scripts/development/unused/rsubs.pl, possibly replace this entire grammar_rules__map() subroutine with hard-coded *.pm files
        $eval_string
            = q[foreach my $key ( keys %]
            . $RPerl::Grammar::RULES->{$rule}
            . q[:: ) { if (defined &{ $]
            . $RPerl::Grammar::RULES->{$rule}
            . q[::{ $key} } ) { if (not defined eval q<*{]
            . $rule
            . q[::> . $key . q<} = sub { return &{ $]
            . $RPerl::Grammar::RULES->{$rule}
            . q[::{'> . $key . q<'} }(@_); };>) {die $EVAL_ERROR . "\n";} } }];

        #        RPerl::diag('in Generator::grammar_rules_map(), have 2nd $eval_string = ' . "\n" . $eval_string . "\n");
        $eval_retval = eval $eval_string;
        if ( ( not defined $eval_retval ) or ( $EVAL_ERROR ne q{} ) ) {
            die 'ERROR ECOGE02, GENERATOR: Grammar rules map, failed copy subroutines into mapped namespace, dying' . "\n" . $EVAL_ERROR . "\n";
        }
    }
};

1;    # end of class
