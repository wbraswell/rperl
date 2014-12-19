package RPerl::CompileUnit;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.000_011;

# [[[ SETUP ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values and print operator
use Scalar::Util 'blessed';

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::GrammarRule);

# [[[ OO PROPERTIES ]]]
# DEV NOTE: no active properties, this is a stub object for now, see children objects for active properties
our %properties = ( ## no critic qw(ProhibitPackageVars)  # USER DEFAULT 3: allow OO properties
        # Program, Module, Package, and Class objects
        #name        => my string $TYPED_name                   = undef,
        #version     => my string $TYPED_version                = undef,
        #includes    => my object__array_ref $TYPED_includes    = undef,
        #constants   => my object__array_ref $TYPED_constants   = undef,
        #subroutines => my object__array_ref $TYPED_subroutines = undef,

    # Program objects only
    #operations => my object__array_ref $TYPED_operations = undef,

    # Class objects only
    #methods    => my object__array_ref $TYPED_methods    = undef,
    #properties => my object__array_ref $TYPED_properties = undef,
);

# [[[ OO METHODS ]]]

# TRANSLATE
our object__method $ppi_to_rperl__translate = sub {
    ( my string $class, my object $node) = @_;    # class method
    my object $node_translated;
    $node_translated = { STUB_AST_OBJECT => 'CREATED BY RPerl::CompileUnit' };
    return ($node_translated);
};

# GENERATE CPPOPS_PERLTYPES
our string__method $rperl_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self ) = @_;                     # object method
    my string $self_generated = q{};
    $self_generated .= 'STUB PERL CODE STRING, CREATED BY RPerl::CompileUnit';
    return ($self_generated);
};

# GENERATE CPPOPS_CPPTYPES
our string__method $rperl_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self ) = @_;                     # object method
    my string $self_generated = q{};
    $self_generated .= 'STUB CPP CODE STRING, CREATED BY RPerl::CompileUnit';
    return ($self_generated);
};

1;
