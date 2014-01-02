package RPerl::Operation::Statement::Loop::For;
use strict;
use warnings;
our $VERSION = 0.000_010;
use Carp;
use RPerl;

# [[[ SETUP ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  ## RPERL USER DEFAULT optionally allow numeric values, print operator
use Data::Dumper;
use Scalar::Util 'blessed';

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Statement::Loop);

# [[[ OO PROPERTIES ]]]
our %properties = ( ## no critic qw(ProhibitPackageVars)  ## RPERL SYSTEM, allow OO properties
    label           => my string $KEY_label           = undef,
    iterator_symbol => my string $KEY_iterator_symbol = undef,
    range_min       => my object $KEY_range_min       = undef,
    range_max       => my object $KEY_range_max       = undef,
    body            => my object $KEY_body            = undef,
);

# [[[ OO METHODS ]]]

# TRANSLATE
our object__method $ppi_to_rperl__translate = sub {
    ( my string $class, my object $node) = @_;    # class method
    my object $node_translated;
    $node_translated = { STUB_AST_OBJECT =>
            'CREATED BY RPerl::Operation::Statement::Loop::For' };
    return ($node_translated);
};

# GENERATE CPPOPS_PERLTYPES
our string__method $rperl_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self ) = @_;                     # object method
    my string $self_generated = q{};
    $self_generated
        .= 'STUB PERL CODE STRING, CREATED BY RPerl::Operation::Statement::Loop::For';
    return ($self_generated);
};

# GENERATE CPPOPS_CPPTYPES
our string__method $rperl_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self ) = @_;                     # object method
    my string $self_generated = q{};
    $self_generated
        .= 'STUB CPP CODE STRING, CREATED BY RPerl::Operation::Statement::Loop::For';
    return ($self_generated);
};

1;
