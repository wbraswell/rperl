# [[[ HEADER ]]]
package RPerl::Operation::Expression::Operator::Logical::Negation;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.003_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Expression::Operator::Logical);
use RPerl::Operation::Expression::Operator::Logical;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

sub ast_to_rperl__generate {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $rperl_source_group = { PMC => q{} };

#    RPerl::diag( 'in Operator::Logical::Negation->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;
    if (( $self_class eq 'Operator_108' ) # Operator -> OP05_LOGICAL_NEG SubExpression
        or ( $self_class eq 'Operator_127' ) # Operator -> OP22_LOGICAL_NEG SubExpression
        )
    {
        $rperl_source_group->{PMC} .= $self->{children}->[0] . q{ };
        my string_hashref $rperl_source_subgroup = $self->{children}->[1]->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
    }
    elsif ( $self_class eq 'Operator_126' ) { # Operator -> OP22_LOGICAL_NEG_LPAREN SubExpression ')'
        $rperl_source_group->{PMC} .= $self->{children}->[0] . q{ };
        my string_hashref $rperl_source_subgroup = $self->{children}->[1]->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= q{ } . $self->{children}->[2];
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASRP000, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '
                . $self_class
                . ' found where Operator_108, Operator_127, or Operator_126 expected, dying' )
            . "\n";
    }
    return $rperl_source_group;
}

sub ast_to_cpp__generate__CPPOPS_PERLTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group
        = { CPP =>
            q{// <<< RP::O::E::O::Lo::N __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n" };

    #...
    return $cpp_source_group;
}

# DEV NOTE: PERLOPS_PERLTYPES & CPPOPS_CPPTYPES code generation are exactly equivalent
sub ast_to_cpp__generate__CPPOPS_CPPTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group = { CPP => q{} };

#    RPerl::diag( 'in Operator::Logical::Negation->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;
    if (( $self_class eq 'Operator_108' ) # Operator -> OP05_LOGICAL_NEG SubExpression
        or ( $self_class eq 'Operator_127' ) # Operator -> OP22_LOGICAL_NEG SubExpression
        )
    {
        $cpp_source_group->{CPP} .= $self->{children}->[0] . q{ };
        my string_hashref $cpp_source_subgroup = $self->{children}->[1]->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
    }
    elsif ( $self_class eq 'Operator_126' ) { # Operator -> OP22_LOGICAL_NEG_LPAREN SubExpression ')'
        $cpp_source_group->{CPP} .= $self->{children}->[0] . q{ };
        my string_hashref $cpp_source_subgroup = $self->{children}->[1]->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
        $cpp_source_group->{CPP} .= q{ } . $self->{children}->[2];
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASCP000, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule '
                . $self_class
                . ' found where Operator_108, Operator_127, or Operator_126 expected, dying' )
            . "\n";
    }
    return $cpp_source_group;
}

1;    # end of class
