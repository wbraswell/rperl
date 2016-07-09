# [[[ DOCUMENTATION ]]]
# http://perldoc.perl.org/functions/abs.html
#     SUPPORTED:  abs VARIABLE
# NOT SUPPORTED:  abs( LIST )
# NOT SUPPORTED:  abs

# [[[ HEADER ]]]
package RPerl::Operation::Expression::Operator::Named::AbsoluteValue;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.002_100;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Expression::Operator::Named);
use RPerl::Operation::Expression::Operator::Named;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants

# [[[ CONSTANTS ]]]
use constant NAME          => my string $TYPED_NAME           = 'abs';
# DEV NOTE: with min & max args of 1, compile-time args length checking short-circuited first by Parse Phase 0 ERROR ECOPAPL03 'Useless use of FOO in void context'
# or ERROR ECOPARP00 'Unexpected Token:  ,'; short-circuited second by ERROR ECOGEASRP13 on Operator_85 & OperatorVoid_123 multiple-argument productions below;
# can't figure out how to create test which gets past ECOPAPL03 & ECOPARP00 to trigger ECOGEASRP13
use constant ARGUMENTS_MIN => my integer $TYPED_ARGUMENTS_MIN = 1;
use constant ARGUMENTS_MAX => my integer $TYPED_ARGUMENTS_MAX = 1;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS & SUBROUTINES ]]]

our string_hashref::method $ast_to_rperl__generate = sub {
    ( my object $self, my object $operator_named, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };

#    RPerl::diag( 'in Operator::Named::AbsoluteValue->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
#    RPerl::diag( 'in Operator::Named::AbsoluteValue->ast_to_rperl__generate(), received $operator_named = ' . "\n" . RPerl::Parser::rperl_ast__dump($operator_named) . "\n" );

    my string $operator_named_class = ref $operator_named;
    if ( $operator_named_class eq 'Operation_80' ) { # Operation -> OP01_NAMED_SCOLON
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASRP15, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: named operator '
                . $operator_named->{children}->[0]
                . ' requires exactly one argument, dying' )
            . "\n";
    }
    elsif ( $operator_named_class eq 'Operator_84' ) { # Operator -> OP01_NAMED SubExpression
        $rperl_source_group->{PMC} .= $operator_named->{children}->[0] . q{ };
        my string_hashref $rperl_source_subgroup
            = $operator_named->{children}->[1]
            ->ast_to_rperl__generate( $modes, $self );
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );
    }
    elsif ( $operator_named_class eq 'Operator_85' ) { # Operator -> LPAREN OP01_NAMED ListElement OP21_LIST_COMMA ListElements ')'
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASRP13a, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: named operator '
                . $operator_named->{children}->[1]
                . ' does not accept multiple arguments, dying' )
            . "\n";
    }
    elsif ( $operator_named_class eq 'OperatorVoid_123' ) { # OperatorVoid -> OP01_NAMED ListElement OP21_LIST_COMMA ListElements ';'
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASRP13b, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: named operator '
                . $operator_named->{children}->[0]
                . ' does not accept multiple arguments, dying' )
            . "\n";
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule '
                . ($operator_named_class)
                . ' found where Operation_80, Operator_84, Operator_85, or OperatorVoid_123 expected, dying'
        ) . "\n";
    }

    return $rperl_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = { CPP =>
            q{// <<< RP::O::E::O::N::Abs __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my object $operator_named, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = { CPP => q{} };

#    RPerl::diag( 'in Operator::Named::AbsoluteValue->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
#    RPerl::diag( 'in Operator::Named::AbsoluteValue->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $operator_named = ' . "\n" . RPerl::Parser::rperl_ast__dump($operator_named) . "\n" );

    my string $operator_named_class = ref $operator_named;
    if ( $operator_named_class eq 'Operation_80' ) { # Operation -> OP01_NAMED_SCOLON
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASCP15, CODE GENERATOR, ABSTRACT SYNTAX TO C++: named operator '
                . $operator_named->{children}->[0]
                . ' requires exactly one argument, dying' )
            . "\n";
    }
    elsif ( $operator_named_class eq 'Operator_84' ) { # Operator -> OP01_NAMED SubExpression
	# DEV NOTE: math.h is added by default (see RPerl/Inline.pm)
	# DEV NOTE: there are multiple standard abs functions in C++ but std::abs is the most versatile
        $cpp_source_group->{CPP} .= "std::" . $operator_named->{children}->[0] . q{(}; 
        my string_hashref $cpp_source_subgroup
            = $operator_named->{children}->[1]
            ->ast_to_cpp__generate__CPPOPS_CPPTYPES( $modes, $self );
        RPerl::Generator::source_group_append( $cpp_source_group,
            $cpp_source_subgroup );
	$cpp_source_group->{CPP} .= ")"
    }
    elsif ( $operator_named_class eq 'Operator_85' ) { # Operator -> LPAREN OP01_NAMED ListElement OP21_LIST_COMMA ListElements ')'
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASCP13a, CODE GENERATOR, ABSTRACT SYNTAX TO C++: named operator '
                . $operator_named->{children}->[1]
                . ' does not accept multiple arguments, dying' )
            . "\n";
    }
    elsif ( $operator_named_class eq 'OperatorVoid_123' ) { # OperatorVoid -> OP01_NAMED ListElement OP21_LIST_COMMA ListElements ';'
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASCP13b, CODE GENERATOR, ABSTRACT SYNTAX TO C++: named operator '
                . $operator_named->{children}->[0]
                . ' does not accept multiple arguments, dying' )
            . "\n";
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: grammar rule '
                . ($operator_named_class)
                . ' found where Operation_80, Operator_84, Operator_85, or OperatorVoid_123 expected, dying'
        ) . "\n";
    }

    return $cpp_source_group;
};

1;    # end of class
