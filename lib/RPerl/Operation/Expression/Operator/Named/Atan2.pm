# [[[ DOCUMENTATION ]]]
# http://perldoc.perl.org/functions/atan2.html
#     SUPPORTED:  atan2 Y,X

# [[[ HEADER ]]]
package RPerl::Operation::Expression::Operator::Named::Atan2;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Expression::Operator::Named);
use RPerl::Operation::Expression::Operator::Named;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants

# [[[ CONSTANTS ]]]
use constant NAME => my string $TYPED_NAME = 'atan2';

# DEV NOTE: with min & max args of 1, compile-time args length checking short-circuited first by Parse Phase 0 ERROR ECOPAPL03 'Useless use of FOO in void context'
# or ERROR ECOPARP00 'Unexpected Token:  ,'; short-circuited second by ERROR ECOGEASRP13 on Operator_95 & OperatorVoid_134 multiple-argument productions below;
# can't figure out how to create test which gets past ECOPAPL03 & ECOPARP00 to trigger ECOGEASRP13
use constant ARGUMENTS_MIN => my integer $TYPED_ARGUMENTS_MIN = 2;
use constant ARGUMENTS_MAX => my integer $TYPED_ARGUMENTS_MAX = 2;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS & SUBROUTINES ]]]

sub ast_to_rperl__generate {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my object $operator_named, my string_hashref $modes) = @ARG;
    my string_hashref $rperl_source_group = { PMC => q{} };

#    RPerl::diag( 'in Operator::Named::Atan2->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
#    RPerl::diag( 'in Operator::Named::Atan2->ast_to_rperl__generate(), received $operator_named = ' . "\n" . RPerl::Parser::rperl_ast__dump($operator_named) . "\n" );

    my string $operator_named_class = ref $operator_named;
    if ( $operator_named_class eq 'Operation_90' ) {    # Operation -> OP01_NAMED_SCOLON
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASRP15, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: named operator '
                . $operator_named->{children}->[0]
                . ' requires exactly two arguments, dying' )
            . "\n";
    }
    elsif ( $operator_named_class eq 'Operator_94' ) {    # Operator -> OP01_NAMED SubExpression
	die RPerl::Parser::rperl_rule__replace(
	    'ERROR ECOGEASRP18, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Named operator '
	    	. $operator_named->{children}->[0]
		. 'requires excatly two arguments, dying' )
	    . "\n";
    }
    elsif ( $operator_named_class eq 'Operator_95' ) {    # Operator -> LPAREN OP01_NAMED ListElement OP21_LIST_COMMA ListElements ')'
	my string $left_paren = $operator_named->{children}->[0];
	my string $operator_name = $operator_named->{children}->[1];
	my object $argument0 = $operator_named->{children}->[2];
	my string $list_comma = $operator_named->{children}->[3];
	my object $arguments = $operator_named->{children}->[4];
	my string $right_paren = $operator_named->{children}->[5];

	$rperl_source_group->{PMC} .= $left_paren . q{ } . $operator_name . q{ };
	my string_hashref $rperl_source_subgroup = $argument0->ast_to_rperl__generate( $modes, $self );
	RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
	$rperl_source_group->{PMC} .= $list_comma . q{ };
	$rperl_source_subgroup = $arguments->ast_to_rperl__generate( $modes, $self );
	RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
	$rperl_source_group->{PMC} .= q{ } . $right_paren;
    }
    elsif ( $operator_named_class eq 'OperatorVoid_134' ) {    # OperatorVoid -> OP01_NAMED ListElement OP21_LIST_COMMA ListElements ';'
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASRP13b, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: named operator '
                . $operator_named->{children}->[0]
                . ' does not accept multiple arguments, dying' )
            . "\n";
    }
    else {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule '
                . ($operator_named_class)
                . ' found where Operation_90, Operator_94, Operator_95, or OperatorVoid_134 expected, dying' )
            . "\n";
    }
    return $rperl_source_group;
}

sub ast_to_cpp__generate__CPPOPS_PERLTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group = { CPP => q{// <<< RP::O::E::O::N::Abs __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n" };

    #...
    return $cpp_source_group;
}

sub ast_to_cpp__generate__CPPOPS_CPPTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my object $operator_named, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group = { CPP => q{} };

#    RPerl::diag( 'in Operator::Named::Atan2->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
#    RPerl::diag( 'in Operator::Named::Atan2->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $operator_named = ' . "\n" . RPerl::Parser::rperl_ast__dump($operator_named) . "\n" );

    my string $operator_named_class = ref $operator_named;
    if ( $operator_named_class eq 'Operation_90' ) {    # Operation -> OP01_NAMED_SCOLON
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP15, CODE GENERATOR, ABSTRACT SYNTAX TO C++: named operator '
                . $operator_named->{children}->[0]
                . ' requires exactly one argument, dying' )
            . "\n";
    }
    elsif ( $operator_named_class eq 'Operator_94' ) {    # Operator -> OP01_NAMED SubExpression
	die RPerl::Parser::rperl_rule__replace(
	    'ERROR ECOGEASCP18, CODE GENERATOR, ABSTRACT SYNTAX TO C++ Named operator '
	    . $operator_named->{children}->[0]
	    . 'requires excatly two arguments, dying' )
	. "\n";
    }
    elsif ( $operator_named_class eq 'Operator_95' ) {    # Operator -> LPAREN OP01_NAMED ListElement OP21_LIST_COMMA ListElements ')'
	my string $left_paren = $operator_named->{children}->[0];
	my string $operator_name = $operator_named->{children}->[1];
	my object $argument0 = $operator_named->{children}->[2];
	my string $list_comma = $operator_named->{children}->[3];
	my object $arguments = $operator_named->{children}->[4];
	my string $right_paren = $operator_named->{children}->[5];

	$cpp_source_group->{CPP} .= $left_paren . q{ } . $operator_name . q{(};
	my string_hashref $cpp_source_subgroup = $argument0->ast_to_cpp__generate__CPPOPS_CPPTYPES( $modes, $self );
	RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
	$cpp_source_group->{CPP} .= $list_comma . q{ };
	$cpp_source_subgroup = $arguments->ast_to_cpp__generate__CPPOPS_CPPTYPES( $modes, $self );
	RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
	$cpp_source_group->{CPP} .= q{)} . $right_paren;
    }
    elsif ( $operator_named_class eq 'OperatorVoid_134' ) {    # OperatorVoid -> OP01_NAMED ListElement OP21_LIST_COMMA ListElements ';'
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP14b, CODE GENERATOR, ABSTRACT SYNTAX TO C++: named operator '
                . $operator_named->{children}->[0]
                . ' does not accept multiple arguments, dying' )
            . "\n";
    }
    else {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: grammar rule '
                . ($operator_named_class)
                . ' found where Operation_90, Operator_94, Operator_95, or OperatorVoid_134 expected, dying' )
            . "\n";
    }
    return $cpp_source_group;
}

1;    # end of class
