# [[[ DOCUMENTATION ]]]
# http://perldoc.perl.org/functions/split.html
#     SUPPORTED:  split /PATTERN/,EXPR,LIMIT
#     SUPPORTED:  split /PATTERN/,EXPR
# NOT SUPPORTED:  split /PATTERN/
# NOT SUPPORTED:  split

# [[[ HEADER ]]]
package RPerl::Operation::Expression::Operator::Named::Split;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.002_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Expression::Operator::Named);
use RPerl::Operation::Expression::Operator::Named;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants

# [[[ CONSTANTS ]]]
use constant NAME          => my string $TYPED_NAME           = 'split';

# NEED UPDATE
#use constant ARGUMENTS_MIN => my integer $TYPED_ARGUMENTS_MIN = 2;
#use constant ARGUMENTS_MAX => my integer $TYPED_ARGUMENTS_MAX = 3;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

sub ast_to_rperl__generate {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my object $operator_named, my string_hashref $modes)
        = @ARG;
    my string_hashref $rperl_source_group = { PMC => q{} };

#    RPerl::diag( 'in Operator::Named::Split->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
#    RPerl::diag( 'in Operator::Named::Split->ast_to_rperl__generate(), received $operator_named = ' . "\n" . RPerl::Parser::rperl_ast__dump($operator_named) . "\n" );

    my string $operator_named_class = ref $operator_named;
    if ( $operator_named_class eq 'Operation_96' ) { # Operation -> OP01_NAMED_SCOLON
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASRP018, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Named operator '
                . $operator_named->{children}->[0]
                . ' requires multiple arguments, dying' )
            . "\n";
    }
    elsif ( $operator_named_class eq 'Operator_100' ) { # Operator -> OP01_NAMED SubExpression
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASRP018, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Named operator '
                . $operator_named->{children}->[0]
                . ' requires multiple arguments, dying' )
            . "\n";
    }
    elsif ( $operator_named_class eq 'Operator_101' ) { # Operator -> LPAREN OP01_NAMED ListElement OP21_LIST_COMMA ListElements ')'
        my string $left_paren = $operator_named->{children}->[0];
        my string $operator_name = $operator_named->{children}->[1];
        my object $argument0 = $operator_named->{children}->[2];
        my string $list_comma = $operator_named->{children}->[3];
        my object $arguments = $operator_named->{children}->[4];
        my string $right_paren = $operator_named->{children}->[5];

        my integer $argument_count = $arguments->length() + 1;
        if ( $argument_count < ARGUMENTS_MIN() ) {
            die
                'ERROR ECOGEASRP002, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL:'
                . "\n"
                . 'Argument count '
                . $argument_count
                . ' falls below minimum argument limit '
                . ARGUMENTS_MIN()
                . ' for operation ' . q{'}
                . NAME() . q{'}
                . ', dying' . "\n";
        }
        if ( $argument_count > ARGUMENTS_MAX() ) {
            die
                'ERROR ECOGEASRP003, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL:'
                . "\n"
                . 'Argument count '
                . $argument_count
                . ' exceeds maximum argument limit '
                . ARGUMENTS_MAX()
                . ' for operation ' . q{'}
                . NAME() . q{'}
                . ', dying' . "\n";
        }

        $rperl_source_group->{PMC} .= $left_paren . q{ } . $operator_name . q{ };
        my string_hashref $rperl_source_subgroup = $argument0->ast_to_rperl__generate( $modes, $self );
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= $list_comma . q{ };
        $rperl_source_subgroup = $arguments->ast_to_rperl__generate( $modes, $self );
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= q{ } . $right_paren;
    }
    elsif ( $operator_named_class eq 'OperatorVoid_140' ) { # OperatorVoid -> OP01_NAMED ListElement OP21_LIST_COMMA ListElements ';'
        my string $operator_name = $operator_named->{children}->[0];
        my object $argument0 = $operator_named->{children}->[1];
        my string $list_comma = $operator_named->{children}->[2];
        my object $arguments = $operator_named->{children}->[3];
        my string $semicolon = $operator_named->{children}->[4];

        my integer $argument_count = $arguments->length() + 1;
        if ( $argument_count < ARGUMENTS_MIN() ) {
            die
                'ERROR ECOGEASRP002, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL:'
                . "\n"
                . 'Argument count '
                . $argument_count
                . ' falls below minimum argument limit '
                . ARGUMENTS_MIN()
                . ' for operation ' . q{'}
                . NAME() . q{'}
                . ', dying' . "\n";
        }
        if ( $argument_count > ARGUMENTS_MAX() ) {
            die
                'ERROR ECOGEASRP003, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL:'
                . "\n"
                . 'Argument count '
                . $argument_count
                . ' exceeds maximum argument limit '
                . ARGUMENTS_MAX()
                . ' for operation ' . q{'}
                . NAME() . q{'}
                . ', dying' . "\n";
        }

        $rperl_source_group->{PMC} .= $operator_name . q{ };
        my string_hashref $rperl_source_subgroup = $argument0->ast_to_rperl__generate( $modes, $self );
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= $list_comma . q{ };
        $rperl_source_subgroup = $arguments->ast_to_rperl__generate( $modes, $self );
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= $semicolon . "\n";
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASRP000, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '
                . ($operator_named_class)
                . ' found where Operation_96, Operator_100, Operator_101, or OperatorVoid_140 expected, dying'
        ) . "\n";
    }
    return $rperl_source_group;
}

sub ast_to_cpp__generate__CPPOPS_PERLTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group
        = { CPP =>
            q{// <<< RP::O::E::O::N::Sp __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n" };

    #...
    return $cpp_source_group;
}

sub ast_to_cpp__generate__CPPOPS_CPPTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group
        = { CPP =>
            q{// <<< RP::O::E::O::N::Sp __DUMMY_SOURCE_CODE CPPOPS_CPPTYPES >>>}
            . "\n" };

    #...
    return $cpp_source_group;
}

1;    # end of class
