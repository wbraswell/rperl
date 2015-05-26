# [[[ HEADER ]]]
package RPerl::Generator;
use strict;
use warnings;
our $VERSION = 0.000_032;
use RPerl;

# [[[ OO INHERITANCE ]]]
# <<< CHANGE_ME: leave as base class for no inheritance, or replace with real parent package name >>>
use parent qw(RPerl::CompileUnit::Module::Class);
use RPerl::CompileUnit::Module::Class;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitStringyEval)  # SYSTEM DEFAULT 1: allow eval()

# [[[ INCLUDES ]]]
use RPerl::Grammar;
use RPerl::Parser;
use English qw(-no_match_vars); # for $OSNAME; why isn't this included from 'require RPerl::Config', which is included from 'use RPerl' above?

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ PROCEDURAL SUBROUTINES ]]]

our integer $diff_check_file_vs_string = sub {
    ( my string $file_name, my string $source_string, my string $ops) = @_;

    if ( not -f $file_name ) {
        die 'ERROR ECVGEDI00, RPERL GENERATOR, DIFF CHECK: file not found, '
            . q{'}
            . $file_name . q{'} . "\n"
            . ', dying' . "\n";
    }

    open my filehandleref $FILE_HANDLE, '<', $file_name
        or die
        'ERROR ECVGEDI01, RPERL GENERATOR, DIFF CHECK: Cannot open file '
        . $file_name
        . ' for reading,'
        . $OS_ERROR
        . ', dying' . "\n";

    my string_arrayref $source_string_split
        = [ ( split /\n/xms, $source_string ) ];
    my integer $line_number = 0;
    my string $file_line;
    my string $string_line;
    my $return_value = 0;    # default return value, files do not differ
    while ( $file_line = <$FILE_HANDLE> ) {

# set $string_line before incrementing $line_number; arrays indexed from 0, file lines indexed from 1
        $string_line = $source_string_split->[$line_number];
        $line_number++;

# strip all whitespace & comments, leave critics & shebangs, using unmodified regex from Grammar.eyp
        # NEED FIX: xms regex modifiers don't work here
        $file_line =~ s/((?:\s*(?:[#][^#!].*)?\s*)*)//gxms;
        $string_line =~ s/((?:\s*(?:[#][^#!].*)?\s*)*)//gxms;
        if ( $file_line ne $string_line ) {
            if ( $string_line =~ /DUMMY\sSOURCE\sCODE/xms ) {
                RPerl::warn(
                    'WARNING WCVGEDI00, RPERL GENERATOR, DIFF CHECK: Dummy source code found, abandoning check, pretending files do not differ'
                        . "\n" );
            }
            else {
                $return_value = $line_number;
            }
            last;
        }
    }

    close $FILE_HANDLE
        or die
        'ERROR ECVGEDI02, RPERL GENERATOR, DIFF CHECK: Cannot close file '
        . $file_name
        . ' after reading,'
        . $OS_ERROR
        . ', dying' . "\n";

    return $return_value;
};

# Generate from RPerl AST back to RPerl Source Code
our string_hashref $ast_to_rperl__generate = sub {
    ( my object $node, my string_hashref $modes) = @_;

#    RPerl::diag "in Generator::ast_to_rperl__generate(), received \$node =\n" . RPerl::Parser::rperl_ast__dump($node) . "\n";
#    RPerl::diag "in Generator::ast_to_rperl__generate(), received \$modes =\n" . Dumper($modes) . "\n";

    if ( not( defined $modes->{types} ) ) {
        die 'ERROR ECVGEMO00, RPERL GENERATOR, RPERL TYPES MODE:' . "\n"
            . q{'PERL'}
            . 'expected but undefined/null value found, dying' . "\n";
    }
    if ( not( $modes->{types} eq 'PERL' ) ) {
        die 'ERROR ECVGEMO01, RPERL GENERATOR, RPERL TYPES MODE:' . "\n"
            . q{'PERL'}
            . 'expected but non-matching value found, dying' . "\n";
    }

    grammar_rules__map();

    # NEED FIX: check to ensure we are generating a valid return object
    return ( $node->ast_to_rperl__generate($modes) );
};

# Generate from RPerl AST to C++ Source Code
our string_hashref $ast_to_cpp__generate = sub {
    ( my object $node, my string_hashref $modes) = @_;

#    RPerl::diag "in Generator::ast_to_cpp__generate(), received \$node =\n" . RPerl::Parser::rperl_ast__dump($node) . "\n";
#    RPerl::diag "in Generator::ast_to_cpp__generate(), received \$modes =\n" . Dumper($modes) . "\n";

    if ( not( defined $modes->{types} ) ) {
        die 'ERROR ECVGEMO02, C++ GENERATOR, RPERL TYPES MODE:' . "\n"
            . q{'PERL' or 'CPP'}
            . 'expected but undefined/null value found, dying' . "\n";
    }
    if (not( ( $modes->{types} eq 'PERL' ) or ( $modes->{types} eq 'CPP' ) ) )
    {
        die 'ERROR ECVGEMO03, C++ GENERATOR, RPERL TYPES MODE:' . "\n"
            . q{'PERL' or 'CPP'}
            . 'expected but non-matching value found, dying' . "\n";
    }

    grammar_rules__map();

    # NEED FIX: check to ensure we are generating a valid return object
    if ( $modes->{types} eq 'PERL' ) {
        return ( $node->ast_to_cpp__generate__CPPOPS_PERLTYPES($modes) );
    }
    else { return ( $node->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes) ); }
};

# Append All Source Code Entries From Group 2 Onto The Respective Entries In Group 1
#our string_hashref $source_group_append = sub {
our void $source_group_append = sub {
    (   my string_hashref $rperl_source_group_1,
        my string_hashref $rperl_source_group_2)
        = @_;

#    RPerl::diag('in Generator::source_group_append(), received $rperl_source_group_1 =' . "\n" . Dumper($rperl_source_group_1) . "\n");
#    RPerl::diag('in Generator::source_group_append(), received $rperl_source_group_2 =' . "\n" . Dumper($rperl_source_group_2) . "\n");

    foreach my string $suffix_key ( sort keys %{$rperl_source_group_2} ) {
        if ( defined $rperl_source_group_2->{$suffix_key} ) {

            # init to empty string if not already defined
            if (   ( not exists $rperl_source_group_1->{$suffix_key} )
                or ( not defined $rperl_source_group_1->{$suffix_key} ) )
            {
                $rperl_source_group_1->{$suffix_key} = q{};
            }
            $rperl_source_group_1->{$suffix_key}
                .= $rperl_source_group_2->{$suffix_key};
        }
    }
};

our void $grammar_rules__map = sub {

#    RPerl::diag "in Generator::grammar_rules__map(), have \$RPerl::Grammar::RULES =\n" . Dumper($RPerl::Grammar::RULES) . "\n";
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

#        RPerl::diag 'in Generator::grammar_rules_map(), have 1st $eval_string = ' . "\n" . $eval_string . "\n";
        my integer $eval_retval = eval $eval_string;
        if ( ( not defined $eval_retval ) or ( $EVAL_ERROR ne q{} ) ) {
            die $EVAL_ERROR . "\n";
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

#        RPerl::diag 'in Generator::grammar_rules_map(), have 2nd $eval_string = ' . "\n" . $eval_string . "\n";
        $eval_retval = eval $eval_string;
        if ( ( not defined $eval_retval ) or ( $EVAL_ERROR ne q{} ) ) {
            die $EVAL_ERROR . "\n";
        }
    }
};

1;    # end of class
