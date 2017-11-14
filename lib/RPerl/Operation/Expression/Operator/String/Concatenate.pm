# [[[ HEADER ]]]
package RPerl::Operation::Expression::Operator::String::Concatenate;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.002_100;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Expression::Operator::String);
use RPerl::Operation::Expression::Operator::String;

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

#    RPerl::diag( 'in Operator::String::Concatenate->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;
    if ( $self_class eq 'Operator_114' ) {  # Operator -> SubExpression OP08_STRING_CAT SubExpression
        my string_hashref $rperl_source_subgroup = $self->{children}->[0]->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= q{ } . $self->{children}->[1] . q{ };
        $rperl_source_subgroup = $self->{children}->[2]->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '
                . $self_class
                . ' found where Operator_114 expected, dying' )
            . "\n";
    }
    return $rperl_source_group;
}

sub ast_to_cpp__generate__CPPOPS_PERLTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group
        = {
        CPP => q{// <<< RP::O::E::O::S::C __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n"
        };

    #...
    return $cpp_source_group;
}

sub ast_to_cpp__generate__CPPOPS_CPPTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group = { CPP => q{} };

#    RPerl::diag( 'in Operator::String::Concatenate->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    # save to stack of saved flags, when needed
    if ((exists $modes->{_inside_cat_operator}) and (defined $modes->{_inside_cat_operator})) {
        if ((not exists $modes->{_inside_cat_operator_saved}) or (not defined $modes->{_inside_cat_operator_saved})) {
            $modes->{_inside_cat_operator_saved} = [];
        }
        push @{$modes->{_inside_cat_operator_saved}}, $modes->{_inside_cat_operator};
    }
    $modes->{_inside_cat_operator} = 1;

    my string $self_class = ref $self;
    if ( $self_class eq 'Operator_114' ) {  # Operator -> SubExpression OP08_STRING_CAT SubExpression
        my string_hashref $cpp_source_subgroup = $self->{children}->[0]->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
        $cpp_source_group->{CPP} .= ' + ';
        $cpp_source_subgroup = $self->{children}->[2]->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule '
                . $self_class
                . ' found where Operator_114 expected, dying' )
            . "\n";
    }

    # restore from stack of saved flags, when needed
    delete $modes->{_inside_cat_operator};
    if ((exists $modes->{_inside_cat_operator_saved}) and (defined $modes->{_inside_cat_operator_saved}) and (scalar $modes->{_inside_cat_operator_saved})) {
        $modes->{_inside_cat_operator} = pop @{$modes->{_inside_cat_operator_saved}};
        if (not scalar $modes->{_inside_cat_operator_saved}) { delete $modes->{_inside_cat_operator_saved}; }
    }
    return $cpp_source_group;
}

1;    # end of class
