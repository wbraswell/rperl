# [[[ HEADER ]]]
package RPerl::Generator;
use strict;
use warnings;
our $VERSION = 0.000_030;
use RPerl;

# [[[ OO INHERITANCE ]]]
# <<< CHANGE_ME: leave as base class for no inheritance, or replace with real parent package name >>>
use parent qw(RPerl::CompileUnit::Module::Class);
use RPerl::CompileUnit::Module::Class;

# [[[ CRITICS ]]]
## no critic qw(ProhibitStringyEval)  # SYSTEM DEFAULT 1: allow eval()
## no critic qw(ProhibitPackageVars)  # SYSTEM SPECIAL 4c: allow $RPerl::Grammer::rules

# [[[ INCLUDES ]]]
use RPerl::Grammar;
use RPerl::Parser;
use Scalar::Util qw(blessed);

# [[[ PROCEDURAL SUBROUTINES ]]]

our void $grammar_rules__map = sub {

#    RPerl::diag "in Generator::grammar_rules__map(), have \$RPerl::Grammar::rules =\n" . Dumper($RPerl::Grammar::rules) . "\n";
    foreach my string $rule ( sort keys %{$RPerl::Grammar::rules} ) {
        # create mapped class/package (namespace) and set up Perl inheritance
        my string $eval_string
            = 'package '
            . $rule
            . q{; use parent qw(}
            . $RPerl::Grammar::rules->{$rule}
            . q{); use }
            . $RPerl::Grammar::rules->{$rule} . q{; 1;};

#        RPerl::diag 'in Generator::grammar_rules_map(), have 1st $eval_string = ' . "\n" . $eval_string . "\n";
        my integer $eval_retval = eval $eval_string;
        if ( ( not defined $eval_retval ) or ( $EVAL_ERROR ne '' ) ) {
            croak($EVAL_ERROR);
        }

        #        if (not defined $eval_retval) {croak($EVAL_ERROR);}

        # copy all subroutines (and thus methods) from original class/package (namespace) into mapped class/package at runtime;
        # DEV NOTE: I thought this would be handled automatically by Perl inheritance above, but I guess not, probably due to how Class.pm sets subroutines during INIT compile time
        # NEED REMOVE HIGH MAGIC: double-eval'ed short form, long form available in scripts/development/unused/rsubs.pl, possibly replace this entire grammar_rules__map() subroutine with hard-coded *.pm files
        $eval_string
            = q[foreach my $key ( keys %]
            . $RPerl::Grammar::rules->{$rule}
            . q[:: ) { if (defined &{ $]
            . $RPerl::Grammar::rules->{$rule}
            . q[::{ $key} } ) { if (not defined eval q<*{]
            . $rule
            . q[::> . $key . q<} = sub { return &{ $]
            . $RPerl::Grammar::rules->{$rule}
            . q[::{'> . $key . q<'} }(@_); };>) {croak $EVAL_ERROR;} } }];

        RPerl::diag 'in Generator::grammar_rules_map(), have 2nd $eval_string = ' . "\n" . $eval_string . "\n";
        $eval_retval = eval $eval_string;
        if ( ( not defined $eval_retval ) or ( $EVAL_ERROR ne '' ) ) { croak($EVAL_ERROR); }
    }
};

# Generate from RPerl AST back to RPerl Source Code
our string__hash_ref $ast_to_rperl__generate = sub {
    ( my object $node, my string__hash_ref $modes) = @_;

    RPerl::diag "in Generator::ast_to_rperl__generate(), received \$node =\n" . RPerl::Parser::rperl_ast__dump($node) . "\n";
#    RPerl::diag "in Generator::ast_to_rperl__generate(), received \$modes =\n" . Dumper($modes) . "\n";

    if ( not( defined $modes->{types} ) ) {
        croak(
            "\nERROR ECVGEMO00, RPERL GENERATOR, RPERL TYPES MODE:\n'PERL' expected but undefined/null value found,\ncroaking"
        );
    }
    if ( not( $modes->{types} eq 'PERL' ) ) {
        croak(
            "\nERROR ECVGEMO01, RPERL GENERATOR, RPERL TYPES MODE:\n'PERL' expected but non-matching value found,\ncroaking"
        );
    }

    grammar_rules__map();

    # NEED FIX: check to ensure we are generating a valid return object
    return ( $node->ast_to_rperl__generate($modes) );
};

# Generate from RPerl AST to C++ Source Code
our string__hash_ref $ast_to_cpp__generate = sub {
    ( my object $node, my string__hash_ref $modes) = @_;

    RPerl::diag "in Generator::ast_to_cpp__generate(), received \$node =\n"
        . Dumper($node) . "\n";
    RPerl::diag "in Generator::ast_to_cpp__generate(), received \$modes =\n"
        . Dumper($modes) . "\n";

    if ( not( defined $modes->{types} ) ) {
        croak(
            "\nERROR ECVGEMO02, C++ GENERATOR, RPERL TYPES MODE:\n'PERL' or 'CPP' expected but undefined/null value found,\ncroaking"
        );
    }
    if ( not( ( $modes->{types} eq 'PERL' ) or ( $modes->{types} eq 'CPP' ) ) )
    {
        croak(
            "\nERROR ECVGEMO03, C++ GENERATOR, RPERL TYPES MODE:\n'PERL' or 'CPP' expected but non-matching value found,\ncroaking"
        );
    }

    grammar_rules__map();

    # NEED FIX: check to ensure we are generating a valid return object
    if ( $modes->{types} eq 'PERL' ) {
        return ( $node->ast_to_cpp__generate__CPPOPS_PERLTYPES($modes) );
    }
    else { return ( $node->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes) ); }
};

# Append All Source Code Entries From Group 2 Onto The Respective Entries In Group 1
our string__hash_ref $source_group_append = sub {
#our void $source_group_append = sub {
    (my string__hash_ref $rperl_source_group_1, my string__hash_ref $rperl_source_group_2) = @_;
    RPerl::diag('in Generator::source_group_append(), received $rperl_source_group_1 =' . "\n" . Dumper($rperl_source_group_1) . "\n");
    RPerl::diag('in Generator::source_group_append(), received $rperl_source_group_2 =' . "\n" . Dumper($rperl_source_group_2) . "\n");

    foreach my string $suffix_key (sort keys %{$rperl_source_group_2}) {
        if (defined $rperl_source_group_2->{$suffix_key}) {
            # init to empty string if not already defined
            if ((not exists $rperl_source_group_1->{$suffix_key}) or (not defined $rperl_source_group_1->{$suffix_key})) {
                $rperl_source_group_1->{$suffix_key} = q{};
            }
            $rperl_source_group_1->{$suffix_key} .= $rperl_source_group_2->{$suffix_key};
        }
    }
};

1;
