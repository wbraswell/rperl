# [[[ HEADER ]]]
package RPerl::Operation::Statement::OperatorVoid::Named;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

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
    'croak'  => 'RPerl::Operation::Statement::OperatorVoid::Named::Croak',
    'exit'   => 'RPerl::Operation::Statement::OperatorVoid::Named::Exit',
};

# [[[ OO METHODS & SUBROUTINES ]]]

our string_hashref_method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };
    my string_hashref $rperl_source_subgroup;

#    RPerl::diag( 'in OperatorVoid::Named->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $child0_name = $self->{children}->[0];
    if ( ( ( substr $child0_name, -1, 1 ) eq q{;} ) or ( ( substr $child0_name, -1, 1 ) eq q{(} )) {
        chop $child0_name;
    }
    if ( not exists $NAMES->{$child0_name} ) {
        die
            q{ERROR ECVGEASRP01, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: unsupported or unrecognized named void operator '}
            . $child0_name
            . q{' found where }
            . ( join ', ', ( sort keys %{$NAMES} ) )
            . ' expected, dying' . "\n";
    }
    my string $child0_class  = $NAMES->{$child0_name};
    my object $child0_object = $child0_class->new();

    $rperl_source_subgroup
        = $child0_object->ast_to_rperl__generate( $modes, $self );
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

our string_hashref_method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = { CPP =>
              q{// <<< RP::O::S::OV::N __DUMMY_SOURCE_CODE CPPOPS_CPPTYPES >>>}
            . "\n" };

    #...
    return $cpp_source_group;
};

1;    # end of class
