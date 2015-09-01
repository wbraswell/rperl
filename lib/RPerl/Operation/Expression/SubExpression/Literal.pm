# [[[ HEADER ]]]
package RPerl::Operation::Expression::SubExpression::Literal;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.002_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Expression::SubExpression);
use RPerl::Operation::Expression::SubExpression;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS & SUBROUTINES ]]]

our string_hashref::method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group;

#    RPerl::diag( 'in Literal->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;

    if (( $self_class eq 'SubExpression_136' )    # SubExpression -> Literal
        or ( $self_class eq 'VariableOrLiteral_225' ) # VariableOrLiteral -> Literal
        or ( $self_class eq 'VariableOrLiteralOrWord_227' ) # VariableOrLiteralOrWord -> Literal
        )
    {
        my object $number_or_string = $self->{children}->[0];
        $rperl_source_group = $number_or_string->ast_to_rperl__generate($modes);
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECVGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule '
                . $self_class
                . ' found where SubExpression_136, VariableOrLiteral_225, or VariableOrLiteralOrWord_227 expected, dying'
        ) . "\n"; 
    }

    return $rperl_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = { CPP =>
            q{// <<< RP::O::E::SE::L __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group;

#    RPerl::diag( 'in Literal->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;

    if (( $self_class eq 'SubExpression_136' )    # SubExpression -> Literal
        or ( $self_class eq 'VariableOrLiteral_225' ) # VariableOrLiteral -> Literal
        or ( $self_class eq 'VariableOrLiteralOrWord_227' ) # VariableOrLiteralOrWord -> Literal
        )
    {
        my object $number_or_string = $self->{children}->[0];
        $cpp_source_group = $number_or_string->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECVGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule '
                . $self_class
                . ' found where SubExpression_136, VariableOrLiteral_225, or VariableOrLiteralOrWord_227 expected, dying'
        ) . "\n"; 
    }

    return $cpp_source_group;
};

1;    # end of class
