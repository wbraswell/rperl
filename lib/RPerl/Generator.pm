package RPerl::Generator;
use strict;
use warnings;
our $VERSION = 0.000_010;
use Carp;

# [[[ SETUP ]]]

use RPerl;
use Data::Dumper;
use Scalar::Util 'blessed';

# [[[ PROCEDURAL SUBROUTINES ]]]

# Generate from RPerl AST to C++ Source Code
# SOURCE_CODE RULE
our string $rperl_to_cpp__generate = sub {
    ( my object $node, my string__hash_ref $mode) = @_;

    RPerl::diag "in rperl_to_cpp__generate(), received \$node =\n"
        . Dumper($node) . "\n"
        or croak();
    RPerl::diag "in rperl_to_cpp__generate(), received \$mode =\n"
        . Dumper($mode) . "\n"
        or croak();

    if ( not( defined $mode->{types} ) ) {
        croak(
            "\nERROR ECVGEMO00, C++ GENERATOR, RPERL TYPES MODE:\n'PERL' or 'CPP' expected but undefined/null value found,\ncroaking"
        );
    }
    if ( not( ( $mode->{types} eq 'PERL' ) or ( $mode->{types} eq 'CPP' ) ) )
    {
        croak(
            "\nERROR ECVGEMO01, C++ GENERATOR, RPERL TYPES MODE:\n'PERL' or 'CPP' expected but non-matching value found,\ncroaking"
        );
    }

    # NEED UPGRADE: not actually checking which grammar rule we're generating here
    if ($mode->{types} eq 'PERL') { return ( $node->rperl_to_cpp__generate__CPPOPS_PERLTYPES() ); }
    else { return ( $node->rperl_to_cpp__generate__CPPOPS_CPPTYPES() ); }
};

1;
