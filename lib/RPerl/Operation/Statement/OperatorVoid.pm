package RPerl::Operation::Statement::OperatorVoid;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.000_010;

# [[[ SETUP ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values and print operator

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Statement);

# NEED FIX: create %properties_class

# [[[ OO PROPERTIES ]]]
our %properties = ( ## no critic qw(ProhibitPackageVars)  # USER DEFAULT 3: allow OO properties
                    #name => my string $TYPED_name = undef,  # object property
     #arguments => my object__array_ref $TYPED_arguments = undef,  # object property

    # class property
    _operator_void_names => my string__hash_ref $TYPED__operator_void_names = {
        'print'  => 'RPerl::Operation::Statement::OperatorVoid::Print',
        'return' => 'RPerl::Operation::Statement::OperatorVoid::Return',
        'croak'  => 'RPerl::Operation::Statement::OperatorVoid::Croak',
    },
);

# [[[ OO METHODS ]]]
# TRANSLATE
our object__method $ppi_to_rperl__translate = sub {
    ( my string $class, my object $node) = @_;    # class method
    my object $node_translated;
    $node_translated
        = { STUB_AST_OBJECT =>
            'CREATED BY RPerl::Operation::Statement::OperatorVoid' };
    return ($node_translated);
};

# GENERATE CPPOPS_PERLTYPES
our string__method $rperl_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self ) = @_;                     # object method
    my string $self_generated = q{};
    $self_generated
        .= 'STUB PERL CODE STRING, CREATED BY RPerl::Operation::Statement::OperatorVoid';
    return ($self_generated);
};

# GENERATE CPPOPS_CPPTYPES
our string__method $rperl_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self ) = @_;                     # object method
    my string $self_generated = q{};
    $self_generated
        .= 'STUB CPP CODE STRING, CREATED BY RPerl::Operation::Statement::OperatorVoid';
    return ($self_generated);
};

1;
