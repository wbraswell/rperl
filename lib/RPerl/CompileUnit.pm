package RPerl::CompileUnit;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.000_012;

# [[[ SETUP ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
use Scalar::Util 'blessed';

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::GrammarRule);

# [[[ OO PROPERTIES ]]]
# DEV NOTE: no active properties, this is a stub object for now, see children objects for active properties
our hashref $properties = {
        # Program, Module, Package, and Class objects
        #name        => my string $TYPED_name                   = undef,
        #version     => my string $TYPED_version                = undef,
        #includes    => my object_arrayref $TYPED_includes    = undef,
        #constants   => my object_arrayref $TYPED_constants   = undef,
        #subroutines => my object_arrayref $TYPED_subroutines = undef,

    # Program objects only
    #operations => my object_arrayref $TYPED_operations = undef,

    # Class objects only
    #methods    => my object_arrayref $TYPED_methods    = undef,
    #properties => my object_arrayref $TYPED_properties = undef,
};

# [[[ OO METHODS & SUBROUTINES ]]]

# TRANSLATE
our object_method $ppi_to_rperl__translate = sub {
    ( my string $class, my object $node) = @_;    # class method
    my object $node_translated;
    $node_translated = { STUB_AST_OBJECT => 'CREATED BY RPerl::CompileUnit' };
    return ($node_translated);
};

# GENERATE CPPOPS_PERLTYPES
our string_method $rperl_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self ) = @_;                     # object method
    my string $self_generated = q{};
    $self_generated .= 'STUB PERL CODE STRING, CREATED BY RPerl::CompileUnit';
    return ($self_generated);
};

# GENERATE CPPOPS_CPPTYPES
our string_method $rperl_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self ) = @_;                     # object method
    my string $self_generated = q{};
    $self_generated .= 'STUB CPP CODE STRING, CREATED BY RPerl::CompileUnit';
    return ($self_generated);
};

1;
