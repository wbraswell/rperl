# [[[ DOCUMENTATION ]]]
# http://perldoc.perl.org/functions/keys.html
#     SUPPORTED:  keys HASH
#   UNSUPPORTED:  keys ARRAY

# [[[ HEADER ]]]
package RPerl::Operation::Expression::Operator::Named::Keys;
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
use constant NAME          => my string $TYPED_NAME           = 'keys';
use constant ARGUMENTS_MIN => my integer $TYPED_ARGUMENTS_MIN = 1;
use constant ARGUMENTS_MAX => my integer $TYPED_ARGUMENTS_MAX = 1;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

sub ast_to_rperl__generate {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my object $operator_named, my string_hashref $modes) = @ARG;
    my string_hashref $rperl_source_group = { PMC => q{} };

#    RPerl::diag( 'in Operator::Named::Keys->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
#    RPerl::diag( 'in Operator::Named::Keys->ast_to_rperl__generate(), received $operator_named = ' . "\n" . RPerl::Parser::rperl_ast__dump($operator_named) . "\n" );

    my string $operator_named_class = ref $operator_named;
    if ( $operator_named_class eq 'Operation_96' ) { # Operation -> OP01_NAMED_SCOLON
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASRP016, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Named operator '
                . $operator_named->{children}->[0] . ' requires exactly one argument, dying' ) . "\n";
    }
    elsif ( $operator_named_class eq 'Operator_100' ) { # Operator -> OP01_NAMED SubExpression
        $rperl_source_group->{PMC} .= $operator_named->{children}->[0] . q{ };
        my string_hashref $rperl_source_subgroup = $operator_named->{children}->[1]->ast_to_rperl__generate( $modes, $self );
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
    }
    elsif ( $operator_named_class eq 'Operator_101' ) { # Operator -> LPAREN OP01_NAMED ListElement OP21_LIST_COMMA ListElements ')'
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASRP014, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Named operator '
                . $operator_named->{children}->[1] . ' does not accept multiple arguments, dying' ) . "\n";
    }
    elsif ( $operator_named_class eq 'OperatorVoid_140' ) { # OperatorVoid -> OP01_NAMED ListElement OP21_LIST_COMMA ListElements ';'
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASRP014, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Named operator '
                . $operator_named->{children}->[0] . ' does not accept multiple arguments, dying' ) . "\n";
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASRP000, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '
                . ($operator_named_class) . ' found where Operation_96, Operator_100, Operator_101, or OperatorVoid_140 expected, dying' ) . "\n";
    }
    return $rperl_source_group;
}

sub ast_to_cpp__generate__CPPOPS_PERLTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group
        = { CPP => q{// <<< RP::O::E::O::N::K __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n" };

    #...
    return $cpp_source_group;
}

sub ast_to_cpp__generate__CPPOPS_CPPTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my object $operator_named, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group = { CPP => q{} };

#    RPerl::diag( 'in Operator::Named::Keys->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
#    RPerl::diag( 'in Operator::Named::Keys->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $operator_named = ' . "\n" . RPerl::Parser::rperl_ast__dump($operator_named) . "\n" );






    my string $operator_named_class = ref $operator_named;
    if ( $operator_named_class eq 'Operation_96' ) {  # Operation -> OP01_NAMED_SCOLON
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASCP016, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Named operator '
                . $operator_named->{children}->[0] . ' requires exactly one argument, dying' ) . "\n";
    }




    elsif ( $operator_named_class eq 'Operator_100' ) {  # Operator -> OP01_NAMED SubExpression
        # this operator is implemented as a C++ function, must wrap in parentheses 
        $cpp_source_group->{CPP} .= $operator_named->{children}->[0] . q{(};

        # DEV NOTE, CORRELATION #rp031: NEED UPGRADE: implement proper @array vs $arrayref, %hash vs $hashref, dereferencing, etc.

        # START HERE: need unwrap hashref from hash dereference operator as w/ arrayref in Scalar.pm; also need handle PERLOPS_PERLTYPES 'keys' retval being hash not hashref
        # START HERE: need unwrap hashref from hash dereference operator as w/ arrayref in Scalar.pm; also need handle PERLOPS_PERLTYPES 'keys' retval being hash not hashref
        # START HERE: need unwrap hashref from hash dereference operator as w/ arrayref in Scalar.pm; also need handle PERLOPS_PERLTYPES 'keys' retval being hash not hashref

        RPerl::diag( 'in Operator::Named::Keys->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $operator_named->{children}->[1] = ' . "\n" . RPerl::Parser::rperl_ast__dump($operator_named->{children}->[1]) . "\n" );
        die 'TMP DEBUG';

        my string_hashref $cpp_source_subgroup = $operator_named->{children}->[1]->ast_to_rperl__generate( $modes, $self );
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );

        $cpp_source_group->{CPP} .= q{)};



    }



    elsif ( $operator_named_class eq 'Operator_101' ) { # Operator -> LPAREN OP01_NAMED ListElement OP21_LIST_COMMA ListElements ')'
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASCP014, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Named operator '
                . $operator_named->{children}->[1] . ' does not accept multiple arguments, dying' ) . "\n";
    }
    elsif ( $operator_named_class eq 'OperatorVoid_140' ) { # OperatorVoid -> OP01_NAMED ListElement OP21_LIST_COMMA ListElements ';'
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASCP014, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Named operator '
                . $operator_named->{children}->[0] . ' does not accept multiple arguments, dying' ) . "\n";
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASCP000, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule '
                . ($operator_named_class) . ' found where Operation_96, Operator_100, Operator_101, or OperatorVoid_140 expected, dying' ) . "\n";
    }





    return $cpp_source_group;
}

1;    # end of class
