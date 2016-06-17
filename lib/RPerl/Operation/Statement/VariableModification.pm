# [[[ HEADER ]]]
package RPerl::Operation::Statement::VariableModification;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.002_200;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Statement);
use RPerl::Operation::Statement;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

our string_hashref::method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };
    my string_hashref $rperl_source_subgroup;
    my string $self_class = ref $self;

    #    RPerl::diag( 'in VariableModification->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    # yes semicolon for Statement_157, no semicolon for SubExpressionOrVarMod_149, VariableModification_186, and VariableModification_187
    my string $semicolon = q{};

    if ( $self_class eq 'SubExpressionOrVarMod_149' ) {    # SubExpressionOrVarMod -> VariableModification
        # unwrap VariableModification_186 and VariableModification_187 from SubExpressionOrVarMod_149
        $self       = $self->{children}->[0];
        $self_class = ref $self;
    }
    elsif ( $self_class eq 'Statement_157' ) {    # Statement -> VariableModification ';'
        # unwrap VariableModification_186 and VariableModification_187 from Statement_157; grab semicolon
        $semicolon  = $self->{children}->[1];
        $self       = $self->{children}->[0];
        $self_class = ref $self;
    }

    if ( $self_class eq 'VariableModification_186' ) {    # VariableModification -> Variable OP19_VARIABLE_ASSIGN SubExpressionOrInput
        my object $variable               = $self->{children}->[0];
        my string $assign                 = $self->{children}->[1];
        my object $subexpression_or_stdin = $self->{children}->[2];

        $rperl_source_subgroup = $variable->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= q{ } . $assign . q{ };
        $rperl_source_subgroup = $subexpression_or_stdin->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
    }
    elsif ( $self_class eq 'VariableModification_187' ) {    # VariableModification -> Variable OP19_VARIABLE_ASSIGN_BY SubExpression
        my object $variable      = $self->{children}->[0];
        my string $assign_by     = $self->{children}->[1];
        my object $subexpression = $self->{children}->[2];

        $rperl_source_subgroup = $variable->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= q{ } . $assign_by . q{ };
        $rperl_source_subgroup = $subexpression->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
    }
    else {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '
                . $self_class
                . ' found where SubExpressionOrVarMod_149, Statement_157, VariableModification_186, or VariableModification_187 expected, dying' )
            . "\n";
    }

    $rperl_source_group->{PMC} .= $semicolon . "\n";

#    RPerl::diag( 'in VariableModification->ast_to_rperl__generate(), returning $rperl_source_group = ' . "\n" . RPerl::Parser::rperl_ast__dump($rperl_source_group) . "\n" );
    return $rperl_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{// <<< RP::O::S::VM __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{} };
    my string_hashref $cpp_source_subgroup;
    my string $self_class = ref $self;

#    RPerl::diag( 'in VariableModification->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    # yes semicolon for Statement_157, no semicolon for SubExpressionOrVarMod_149, VariableModification_186, and VariableModification_187
    my string $semicolon = undef;

    if ( $self_class eq 'SubExpressionOrVarMod_149' ) {    # SubExpressionOrVarMod -> VariableModification
        # unwrap VariableModification_186 and VariableModification_187 from SubExpressionOrVarMod_149
        $self       = $self->{children}->[0];
        $self_class = ref $self;
    }
    elsif ( $self_class eq 'Statement_157' ) {    # Statement -> VariableModification ';'
        # unwrap VariableModification_186 and VariableModification_187 from Statement_157; grab semicolon
        $semicolon  = $self->{children}->[1];
        $self       = $self->{children}->[0];
        $self_class = ref $self;
    }

    if ( $self_class eq 'VariableModification_186' ) {    # VariableModification -> Variable OP19_VARIABLE_ASSIGN SubExpressionOrInput
        my object $variable               = $self->{children}->[0];
        my string $assign                 = $self->{children}->[1];
        my object $subexpression_or_stdin = $self->{children}->[2];

        $cpp_source_subgroup = $variable->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
        $cpp_source_group->{CPP} .= q{ } . $assign . q{ };
        $cpp_source_subgroup = $subexpression_or_stdin->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
    }
    elsif ( $self_class eq 'VariableModification_187' ) {    # VariableModification -> Variable OP19_VARIABLE_ASSIGN_BY SubExpression
        my object $variable      = $self->{children}->[0];
        my string $assign_by     = $self->{children}->[1];
        my object $subexpression = $self->{children}->[2];

        $cpp_source_subgroup = $variable->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
        $cpp_source_group->{CPP} .= q{ } . $assign_by . q{ };
        $cpp_source_subgroup = $subexpression->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
    }
    else {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '
                . $self_class
                . ' found where SubExpressionOrVarMod_149, Statement_157, VariableModification_186, or VariableModification_187 expected, dying' )
            . "\n";
    }

    if (defined $semicolon) {
        $cpp_source_group->{CPP} .= $semicolon . "\n";
    }

#    RPerl::diag( 'in VariableModification->ast_to_cpp__generate__CPPOPS_CPPTYPES(), returning $cpp_source_group = ' . "\n" . RPerl::Parser::rperl_ast__dump($cpp_source_group) . "\n" );
    return $cpp_source_group;
};

1;    # end of class
