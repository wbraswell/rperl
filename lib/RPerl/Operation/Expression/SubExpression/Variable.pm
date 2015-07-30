# [[[ HEADER ]]]
package RPerl::Operation::Expression::SubExpression::Variable;
use strict;
use warnings;
use RPerl::AfterFilter;
our $VERSION = 0.002_020;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Expression::SubExpression);
use RPerl::Operation::Expression::SubExpression;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS & SUBROUTINES ]]]

our string_hashref::method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };

#    RPerl::diag( 'in Variable->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
    
    my string $self_class = ref $self;

    # unwrap Variable_167 from SubExpression_133, VariableOrLiteral_215, or VariableOrLiteralOrWord_217
    if (($self_class eq 'SubExpression_133') or ($self_class eq 'VariableOrLiteral_215') or ($self_class eq 'VariableOrLiteralOrWord_217')) {
        $self = $self->{children}->[0];
    }
    
    $self_class = ref $self;
    if ($self_class eq 'Variable_167') {  # Variable -> VARIABLE_SYMBOL STAR-42
        my string $symbol = $self->{children}->[0];
        $rperl_source_group->{PMC} .= $symbol;
        foreach my object $variable_retrieval (@{$self->{children}->[1]->{children}}) {
            my string_hashref $rperl_source_subgroup = $variable_retrieval->ast_to_rperl__generate($modes);
            RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup ); 
        }
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECVGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule '
                . ( $self_class )
                . ' found where SubExpression_133, VariableOrLiteral_215, VariableOrLiteralOrWord_217, or Variable_167 expected, dying'
        ) . "\n"; 
    }

    return $rperl_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = { CPP => q{// <<< RP::O::E::SE::V __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{} };

#    RPerl::diag( 'in Variable->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
    
    my string $self_class = ref $self;

    # unwrap Variable_167 from SubExpression_133, VariableOrLiteral_215, or VariableOrLiteralOrWord_217
    if (($self_class eq 'SubExpression_133') or ($self_class eq 'VariableOrLiteral_215') or ($self_class eq 'VariableOrLiteralOrWord_217')) {
        $self = $self->{children}->[0];
    }
    
    $self_class = ref $self;
    if ($self_class eq 'Variable_167') {  # Variable -> VARIABLE_SYMBOL STAR-42
        my string $symbol = $self->{children}->[0];
        substr $symbol, 0, 1, '';  # remove leading $ sigil
        if ($symbol eq 'self') { 
            # Perl OO $self becomes C++ OO this
            $symbol = 'this';
        }
        $cpp_source_group->{CPP} = $symbol;
        foreach my object $variable_retrieval (@{$self->{children}->[1]->{children}}) {
            my string_hashref $cpp_source_subgroup = $variable_retrieval->ast_to_cpp__generate__CPPOPS_CPPTYPES($symbol, $modes);
            RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup ); 
        }
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECVGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule '
                . ( $self_class )
                . ' found where SubExpression_133, VariableOrLiteral_215, VariableOrLiteralOrWord_217, or Variable_167 expected, dying'
        ) . "\n"; 
    }

    return $cpp_source_group;
};

1;  # end of class
