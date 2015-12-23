# [[[ HEADER ]]]
package RPerl::Operation::Expression::SubroutineCall::MethodCall::ConstructorCall;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.002_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Expression::SubroutineCall::MethodCall);
use RPerl::Operation::Expression::SubroutineCall::MethodCall;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS & SUBROUTINES ]]]

our string_hashref::method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };

#    RPerl::diag( 'in ConstructorCall->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    if ( ( ref $self ) ne 'Expression_133' ) {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule '
                . ( ref $self )
                . ' found where Expression_133 expected, dying' )
            . "\n";
    }

    # Expression -> WordScoped OP02_METHOD_THINARROW_NEW ')'
    my object $type                      = $self->{children}->[0];
    my string $thin_arrow_new_left_paren = $self->{children}->[1];
    my string $right_paren               = $self->{children}->[2];

    $rperl_source_group->{PMC}
        .= $type->{children}->[0] . $thin_arrow_new_left_paren . $right_paren;
    return $rperl_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = { CPP =>
            q{// <<< RP::O::E::SC::MC::CC __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
#    RPerl::diag( 'in ConstructorCall->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
    
    my string_hashref $cpp_source_group = { CPP => q{} };

    if ( ( ref $self ) ne 'Expression_133' ) {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: grammar rule '
                . ( ref $self )
                . ' found where Expression_133 expected, dying' )
            . "\n";
    }

    # Expression -> WordScoped OP02_METHOD_THINARROW_NEW ')'
    my object $type                      = $self->{children}->[0]->{children}->[0];
    $type = RPerl::Generator::type_convert_perl_to_cpp($type, 0);  # $pointerify_classes = 0

    $cpp_source_group->{CPP} .= 'new ' . $type;
    return $cpp_source_group;
};

1;    # end of class
