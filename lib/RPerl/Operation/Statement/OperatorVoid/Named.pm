# [[[ HEADER ]]]
package RPerl::Operation::Statement::OperatorVoid::Named;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.002_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Statement::OperatorVoid);
use RPerl::Operation::Statement::OperatorVoid;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO PROPERTIES, CLASS PROPERTY AKA PACKAGE VARIABLE ]]]
our string_hashref $NAMES = {
    'return' => 'RPerl::Operation::Statement::OperatorVoid::Named::Return',
    'exit'   => 'RPerl::Operation::Statement::OperatorVoid::Named::Exit',
    'die'    => 'RPerl::Operation::Statement::OperatorVoid::Named::Die',
    'croak'  => 'RPerl::Operation::Statement::OperatorVoid::Named::Croak'
};

# [[[ OO METHODS & SUBROUTINES ]]]

our string_hashref_method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };
    my string_hashref $rperl_source_subgroup;

#    RPerl::diag( 'in OperatorVoid::Named->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $operator_void_name = $self->{children}->[0];
    if ( ( ( substr $operator_void_name, -1, 1 ) eq q{;} ) or ( ( substr $operator_void_name, -1, 1 ) eq q{(} )) {
        chop $operator_void_name;
    }
    if ( not exists $NAMES->{$operator_void_name} ) {
        die
            q{ERROR ECVGEASRP01, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: unsupported or unrecognized named void operator '}
            . $operator_void_name
            . q{' found where }
            . ( join ', ', ( sort keys %{$NAMES} ) )
            . ' expected, dying' . "\n";
    }
    my string $operator_void_class  = $NAMES->{$operator_void_name};
    my object $operator_void_object = $operator_void_class->new();

    $rperl_source_subgroup
        = $operator_void_object->ast_to_rperl__generate( $modes, $self );
    RPerl::Generator::source_group_append( $rperl_source_group,
        $rperl_source_subgroup );

    return $rperl_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = { CPP =>
              q{// <<< RP::O::S::OV::N __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n" };

    #...
    return $cpp_source_group;
};

# DEV NOTE: PERLOPS_PERLTYPES & CPPOPS_CPPTYPES code generation are exactly equivalent
our string_hashref_method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{} };
    my string_hashref $cpp_source_subgroup;

#    RPerl::diag( 'in OperatorVoid::Named->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $operator_void_name = $self->{children}->[0];
    if ( ( ( substr $operator_void_name, -1, 1 ) eq q{;} ) or ( ( substr $operator_void_name, -1, 1 ) eq q{(} )) {
        chop $operator_void_name;
    }
    if ( not exists $NAMES->{$operator_void_name} ) {
        die
            q{ERROR ECVGEASCP01, CODE GENERATOR, ABSTRACT SYNTAX TO C++: unsupported or unrecognized named void operator '}
            . $operator_void_name
            . q{' found where }
            . ( join ', ', ( sort keys %{$NAMES} ) )
            . ' expected, dying' . "\n";
    }
    my string $operator_void_class  = $NAMES->{$operator_void_name};
    my object $operator_void_object = $operator_void_class->new();

    $cpp_source_subgroup
        = $operator_void_object->ast_to_cpp__generate__CPPOPS_CPPTYPES( $modes, $self );
    RPerl::Generator::source_group_append( $cpp_source_group,
        $cpp_source_subgroup );

    return $cpp_source_group;
};

1;    # end of class
