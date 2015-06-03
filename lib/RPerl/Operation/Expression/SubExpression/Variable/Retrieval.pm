# [[[ HEADER ]]]
package RPerl::Operation::Expression::SubExpression::Variable::Retrieval;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Expression::SubExpression);
use RPerl::Operation::Expression::SubExpression;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS & SUBROUTINES ]]]

our string_hashref_method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };

#    RPerl::diag( 'in Variable::Retrieval->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
    
    my string $self_class = ref $self;
    if ($self_class eq 'VariableRetrieval_167') {  # VariableRetrieval -> OP02_ARRAY_THINARROW SubExpression ']'
        my string $arrow_left_bracket = $self->{children}->[0];
        my object $subexpression = $self->{children}->[1];
        my string $right_bracket = $self->{children}->[2];

        $rperl_source_group->{PMC} .= $arrow_left_bracket . q{ };
        my string_hashref $rperl_source_subgroup = $subexpression->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup ); 
        $rperl_source_group->{PMC} .= q{ } . $right_bracket;
    }
    elsif ($self_class eq 'VariableRetrieval_168') {  # VariableRetrieval -> OP02_HASH_THINARROW SubExpression '}'
        my string $arrow_left_brace = $self->{children}->[0];
        my object $subexpression = $self->{children}->[1];
        my string $right_brace = $self->{children}->[2];

        $rperl_source_group->{PMC} .= $arrow_left_brace . q{ };
        my string_hashref $rperl_source_subgroup = $subexpression->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup ); 
        $rperl_source_group->{PMC} .= q{ } . $right_brace;
    }
    elsif ($self_class eq 'VariableRetrieval_169') {  # VariableRetrieval -> OP02_HASH_THINARROW WORD '}'
        my string $arrow_left_brace = $self->{children}->[0];
        my string $word = $self->{children}->[1];
        my string $right_brace = $self->{children}->[2];

        $rperl_source_group->{PMC} .= $arrow_left_brace . q{ } . $word . q{ } . $right_brace;
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECVGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule '
                . ( $self_class )
                . ' found where VariableRetrieval_167, VariableRetrieval_167, or VariableRetrieval_167 expected, dying'
        ) . "\n"; 
    }

    return $rperl_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = { CPP => q{// <<< RP::O::E::SE::V::R __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = { CPP => q{// <<< RP::O::E::SE::V::R __DUMMY_SOURCE_CODE CPPOPS_CPPTYPES >>>}
            . "\n" };

    #...
    return $cpp_source_group;
};

1;  # end of class
