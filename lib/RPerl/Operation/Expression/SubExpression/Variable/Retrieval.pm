# [[[ HEADER ]]]
package RPerl::Operation::Expression::SubExpression::Variable::Retrieval;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.002_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Expression::SubExpression);
use RPerl::Operation::Expression::SubExpression;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS & SUBROUTINES ]]]

our string_hashref::method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };

#    RPerl::diag( 'in Variable::Retrieval->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
    
    my string $self_class = ref $self;
    if ($self_class eq 'VariableRetrieval_175') {  # VariableRetrieval -> OP02_ARRAY_THINARROW SubExpression ']'
        my string $arrow_left_bracket = $self->{children}->[0];
        my object $subexpression = $self->{children}->[1];
        my string $right_bracket = $self->{children}->[2];

        $rperl_source_group->{PMC} .= $arrow_left_bracket . q{ };
        my string_hashref $rperl_source_subgroup = $subexpression->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup ); 
        $rperl_source_group->{PMC} .= q{ } . $right_bracket;
    }
    elsif ($self_class eq 'VariableRetrieval_176') {  # VariableRetrieval -> OP02_HASH_THINARROW SubExpression '}'
        my string $arrow_left_brace = $self->{children}->[0];
        my object $subexpression = $self->{children}->[1];
        my string $right_brace = $self->{children}->[2];

        $rperl_source_group->{PMC} .= $arrow_left_brace . q{ };
        my string_hashref $rperl_source_subgroup = $subexpression->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup ); 
        $rperl_source_group->{PMC} .= q{ } . $right_brace;
    }
    elsif ($self_class eq 'VariableRetrieval_177') {  # VariableRetrieval -> OP02_HASH_THINARROW WORD '}'
        my string $arrow_left_brace = $self->{children}->[0];
        my string $word = $self->{children}->[1];
        my string $right_brace = $self->{children}->[2];

        $rperl_source_group->{PMC} .= $arrow_left_brace . q{ } . $word . q{ } . $right_brace;
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECVGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule '
                . ( $self_class )
                . ' found where VariableRetrieval_175, VariableRetrieval_175, or VariableRetrieval_175 expected, dying'
        ) . "\n"; 
    }

    return $rperl_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = { CPP => q{// <<< RP::O::E::SE::V::R __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string $variable_symbol, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{} };

#    RPerl::diag( 'in Variable::Retrieval->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

# START HERE: use symtab to make correct retrievals
# START HERE: use symtab to make correct retrievals
# START HERE: use symtab to make correct retrievals
    
    my string $self_class = ref $self;
    if ($self_class eq 'VariableRetrieval_175') {  # VariableRetrieval -> OP02_ARRAY_THINARROW SubExpression ']'
        my object $subexpression = $self->{children}->[1];
        $cpp_source_group->{CPP} .= '[';
        my string_hashref $cpp_source_subgroup = $subexpression->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup ); 
        $cpp_source_group->{CPP} .= ']';
    }
    elsif ($self_class eq 'VariableRetrieval_176') {  # VariableRetrieval -> OP02_HASH_THINARROW SubExpression '}'
        my object $subexpression = $self->{children}->[1];
        if ($variable_symbol eq 'this') {
            $cpp_source_group->{CPP} .= '->';
            my string_hashref $cpp_source_subgroup = $subexpression->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
            RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup ); 
        }
        else {
            $cpp_source_group->{CPP} .= '[';
            my string_hashref $cpp_source_subgroup = $subexpression->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
            RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup ); 
            $cpp_source_group->{CPP} .= ']';
        }
    }
    elsif ($self_class eq 'VariableRetrieval_177') {  # VariableRetrieval -> OP02_HASH_THINARROW WORD '}'
        my string $word = $self->{children}->[1];
        if ($variable_symbol eq 'this') {
            $cpp_source_group->{CPP} .= '->' . $word;
        }
        else {
            $cpp_source_group->{CPP} .= '[' . $word . ']';
        }
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECVGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: grammar rule '
                . ( $self_class )
                . ' found where VariableRetrieval_175, VariableRetrieval_175, or VariableRetrieval_175 expected, dying'
        ) . "\n"; 
    }

    return $cpp_source_group;
};

1;  # end of class
