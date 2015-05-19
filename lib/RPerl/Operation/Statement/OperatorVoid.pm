# [[[ HEADER ]]]
package RPerl::Operation::Statement::OperatorVoid;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.000_020;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Statement);
use RPerl::Operation::Statement;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use RPerl::Test::Foo;
use RPerl::Test::Bar;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {

 #name => my string $TYPED_name = undef,  # object property
 #arguments => my object_arrayref $TYPED_arguments = undef,  # object property
};

# [[[ OO PROPERTIES, CLASS PROPERTY AKA PACKAGE VARIABLE ]]]
our string_hashref $NAMES = {
    'return' => 'RPerl::Operation::Statement::OperatorVoid::Named::Return',
    'croak'  => 'RPerl::Operation::Statement::OperatorVoid::Named::Croak',
    'exit'   => 'RPerl::Operation::Statement::OperatorVoid::Named::Exit',
};

# [[[ OO METHODS ]]]

our string_hashref_method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };
    my string_hashref $rperl_source_subgroup;

    RPerl::diag(
        'in OperatorVoid->ast_to_rperl__generate(), received $self = ' . "\n"
            . RPerl::Parser::rperl_ast__dump($self)
            . "\n" );

    # Print, OperatorNamedVoid, OperatorNamed, LoopControl
    my string $child0_class = ref $self->{children}->[0];
    if (   ( $child0_class eq 'OperatorVoid_110' )
        or ( $child0_class eq 'OperatorVoid_111' )
        or ( $child0_class eq 'OperatorVoid_112' )
        or ( $child0_class eq 'OperatorVoid_113' )
        or ( $child0_class eq 'OperatorVoid_114' )
        or ( $child0_class eq 'OperatorVoid_115' )
        or ( $child0_class eq 'OperatorVoid_116' ) )
    {
        $rperl_source_subgroup
            = $self->{children}->[0]->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );
    }
    else {
        croak
            'ERROR ECVGEAS00, Code Generator, Abstract Syntax to RPerl, token'
            . $child0_class
            . 'found where OperatorVoid_110, OperatorVoid_111, OperatorVoid_112, OperatorVoid_113, OperatorVoid_114, OperatorVoid_115, or OperatorVoid_116 expected, croaking';
    }

    return $rperl_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = {
        CPP => q{// <<< RP::O::S::OV DUMMY CPPOPS_PERLTYPES SOURCE CODE >>>}
            . "\n"
        };

    #...
    return $cpp_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = {
        CPP => q{// <<< RP::O::S::OV DUMMY CPPOPS_PERLTYPES SOURCE CODE >>>}
            . "\n"
        };

    #...
    return $cpp_source_group;
};

1;    # end of class
