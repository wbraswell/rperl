# [[[ DOCUMENTATION ]]]
# http://perldoc.perl.org/functions/keys.html
#     SUPPORTED:  keys HASH
#     SUPPORTED:  keys ARRAY
#     SUPPORTED:  keys EXPR

# [[[ HEADER ]]]
package RPerl::Operation::Expression::Operator::Named::Keys;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Expression::Operator::Named);
use RPerl::Operation::Expression::Operator::Named;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants

# [[[ CONSTANTS ]]]
use constant NAME          => my string $TYPED_NAME           = 'keys';
use constant ARGUMENTS_MIN => my integer $TYPED_ARGUMENTS_MIN = 1;
use constant ARGUMENTS_MAX => my integer $TYPED_ARGUMENTS_MAX = 1;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS & SUBROUTINES ]]]

our string_hashref_method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes, my object $operator_named)
        = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };

#    RPerl::diag( 'in Operator::Named::Keys->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
#    RPerl::diag( 'in Operator::Named::Keys->ast_to_rperl__generate(), received $operator_named = ' . "\n" . RPerl::Parser::rperl_ast__dump($operator_named) . "\n" );

    my string $operator_named_class = ref $operator_named;
    if ( $operator_named_class eq 'Operator_79' ) # Operator -> OP01_NAMED SubExpression
    {
        $rperl_source_group->{PMC} .= $operator_named->{children}->[0] . q{ };
        my string_hashref $rperl_source_subgroup
            = $operator_named->{children}->[1]
            ->ast_to_rperl__generate( $modes, $self );
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );
    }
    elsif ( $operator_named_class eq 'Operator_80' ) { # Operator -> LPAREN OP01_NAMED ListElement OP21_LIST_COMMA ListElements ')'
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECVGEASRP13, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: named operator '
                . $operator_named->{children}->[1]
                . ' does not accept multiple arguments, dying' )
            . "\n";
    }
    elsif ( $operator_named_class eq 'OperatorVoid_117' ) { # OperatorVoid -> OP01_NAMED ListElement OP21_LIST_COMMA ListElements ';'
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECVGEASRP13, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: named operator '
                . $operator_named->{children}->[0]
                . ' does not accept multiple arguments, dying' )
            . "\n";
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECVGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule '
                . ($operator_named_class)
                . ' found where Operator_79, Operator_80, or OperatorVoid_117 expected, dying'
        ) . "\n";
    }

    return $rperl_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = { CPP =>
            q{// <<< RP::O::E::O::N::K __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = { CPP =>
            q{// <<< RP::O::E::O::N::K __DUMMY_SOURCE_CODE CPPOPS_CPPTYPES >>>}
            . "\n" };

    #...
    return $cpp_source_group;
};

1;    # end of class
