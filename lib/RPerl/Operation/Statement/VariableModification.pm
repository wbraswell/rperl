# [[[ HEADER ]]]
package RPerl::Operation::Statement::VariableModification;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Statement);
use RPerl::Operation::Statement;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS & SUBROUTINES ]]]

our string_hashref_method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };
    my string_hashref $rperl_source_subgroup;
    my string $self_class = ref $self;

#    RPerl::diag( 'in VariableModification->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

# unwrap VariableModification_173, and VariableModification_174 from Statement_147
    if ( $self_class eq 'Statement_147' ) { # Statement -> VariableModification
        $self = $self->{children}->[0];
        $self_class = ref $self;
    }

    if ( $self_class eq 'VariableModification_173' ) { # VariableModification -> Variable OP19_VARIABLE_ASSIGN SubExpressionOrStdin ';'
        my object $variable               = $self->{children}->[0];
        my string $assign                 = $self->{children}->[1];
        my object $subexpression_or_stdin = $self->{children}->[2];
        my string $semicolon              = $self->{children}->[3];

        $rperl_source_subgroup = $variable->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= q{ } . $assign . q{ };
        $rperl_source_subgroup
            = $subexpression_or_stdin->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= $semicolon;
    }
    elsif ( $self_class eq 'VariableModification_174' ) { # VariableModification -> Variable OP19_VARIABLE_ASSIGN_BY SubExpression ';'
        my object $variable      = $self->{children}->[0];
        my string $assign_by     = $self->{children}->[1];
        my object $subexpression = $self->{children}->[2];
        my string $semicolon     = $self->{children}->[3];

        $rperl_source_subgroup = $variable->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= q{ } . $assign_by . q{ };
        $rperl_source_subgroup
            = $subexpression->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= $semicolon;
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECVGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule '
                . $self_class
                . ' found where VariableModification_173 or VariableModification_174 expected, dying'
        ) . "\n";
    }

#    RPerl::diag( 'in VariableModification->ast_to_rperl__generate(), returning $rperl_source_group = ' . "\n" . RPerl::Parser::rperl_ast__dump($rperl_source_group) . "\n" );
    return $rperl_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = {
        CPP => q{// <<< RP::O::S::VD __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n"
        };

    #...
    return $cpp_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = {
        CPP => q{// <<< RP::O::S::VD __DUMMY_SOURCE_CODE CPPOPS_CPPTYPES >>>}
            . "\n"
        };

    #...
    return $cpp_source_group;
};

1;    # end of class
