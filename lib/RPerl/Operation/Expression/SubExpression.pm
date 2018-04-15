# [[[ HEADER ]]]
package RPerl::Operation::Expression::SubExpression;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.001_100;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Expression);
use RPerl::Operation::Expression;

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

#    RPerl::diag( 'in SubExpression->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    if (   ( ref $self eq 'SubExpressionOrInput_164' )  # SubExpressionOrInput -> SubExpression
        or ( ref $self eq 'SubExpressionOrVarMod_167' )  # SubExpressionOrVarMod -> SubExpression
        or ( ref $self eq 'ListElement_212' ) )  # ListElement -> SubExpression
    {
        my string_hashref $rperl_source_subgroup = $self->{children}->[0]->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
    }
    elsif ( ref $self eq 'ListElement_213' ) {  # ListElement -> TypeInner SubExpression
        my object $type_inner    = $self->{children}->[0];
        my string_hashref $rperl_source_subgroup = $self->{children}->[0]->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        $rperl_source_subgroup = $self->{children}->[1]->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASRP000, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '
                . ( ref $self )
                . ' found where SubExpressionOrInput_164, SubExpressionOrVarMod_167, ListElement_212, or ListElement_213 expected, dying'
        ) . "\n";
    }
    return $rperl_source_group;
}

sub ast_to_cpp__generate__CPPOPS_PERLTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group = { CPP => q{// <<< RP::O::E::SE __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n" };

    #...
    return $cpp_source_group;
}

sub ast_to_cpp__generate__CPPOPS_CPPTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group = { CPP => q{} };

#    RPerl::diag( 'in SubExpression->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    if (   ( ref $self eq 'SubExpressionOrInput_164' )
        or ( ref $self eq 'SubExpressionOrVarMod_167' )
        or ( ref $self eq 'ListElement_212' ) )
    {
        my string_hashref $cpp_source_subgroup
            = $self->{children}->[0]->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
#        RPerl::diag( 'in SubExpression->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $cpp_source_subgroup = ' . "\n" . RPerl::Parser::rperl_ast__dump($cpp_source_subgroup) . "\n" );
        RPerl::Generator::source_group_append( $cpp_source_group,
            $cpp_source_subgroup );
    }
    elsif ( ref $self eq 'ListElement_213' ) {
        $cpp_source_group = { CPP => q{// <<< RP::O::E::SE __DUMMY_SOURCE_CODE CPPOPS_CPPTYPES >>>} . "\n" };

#        my object $type_inner    = $self->{children}->[0];
#        my string_hashref $cpp_source_subgroup = $self->{children}->[0]->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
#        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
#        $cpp_source_subgroup = $self->{children}->[1]->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
#        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );

    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASCP000, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule '
                . ( ref $self )
                . ' found where SubExpressionOrInput_164, SubExpressionOrVarMod_167, ListElement_212, or ListElement_213 expected, dying'
        ) . "\n";
    }
    return $cpp_source_group;
}

1;    # end of class
