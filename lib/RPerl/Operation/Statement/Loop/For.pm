# [[[ HEADER ]]]
package RPerl::Operation::Statement::Loop::For;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.003_100;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Statement::Loop);
use RPerl::Operation::Statement::Loop;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS & SUBROUTINES ]]]

our string_hashref::method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };

    #    RPerl::diag( 'in Loop::For->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;

    # unwrap LoopFor_165 and LoopFor_166 from Loop_162
    if ( $self_class eq 'Loop_162' ) {    # Loop -> LoopFor
        $self       = $self->{children}->[0];
        $self_class = ref $self;
    }

    if ( $self_class eq 'LoopFor_165' ) {

        # LoopFor -> 'for' MY TYPE_INTEGER VARIABLE_SYMBOL LPAREN SubExpression OP17_LIST_RANGE SubExpression ')' CodeBlock
        my string $for             = $self->{children}->[0];
        my string $my              = $self->{children}->[1];
        my string $type_integer    = $self->{children}->[2];
        my string $variable_symbol = $self->{children}->[3];
        my string $left_paren      = $self->{children}->[4];
        my object $subexpression0  = $self->{children}->[5];
        my string $list_range      = $self->{children}->[6];
        my object $subexpression1  = $self->{children}->[7];
        my string $right_paren     = $self->{children}->[8];
        my object $codeblock       = $self->{children}->[9];

        $rperl_source_group->{PMC} .= $for . q{ } . $my . q{ } . $type_integer . q{ } . $variable_symbol . q{ } . $left_paren . q{ };
        my object $rperl_source_subgroup = $subexpression0->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= q{ } . $list_range . q{ };
        $rperl_source_subgroup = $subexpression1->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= q{ } . $right_paren . q{ };
        $rperl_source_subgroup = $codeblock->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
    }
    elsif ( $self_class eq 'LoopFor_166' ) {

# LoopFor -> 'for' LPAREN_MY TYPE_INTEGER VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN SubExpression ';' VARIABLE_SYMBOL OP11_COMPARE_LT_GT SubExpression ';' SubExpressionOrVarMod ')' CodeBlock
        my string $for                     = $self->{children}->[0];
        my string $left_paren_my           = $self->{children}->[1];
        my string $type_integer            = $self->{children}->[2];
        my string $variable_symbol0        = $self->{children}->[3];
        my string $assign                  = $self->{children}->[4];
        my object $subexpression0          = $self->{children}->[5];
        my string $semicolon0              = $self->{children}->[6];
        my string $variable_symbol1        = $self->{children}->[7];
        my string $compare                 = $self->{children}->[8];
        my object $subexpression1          = $self->{children}->[9];
        my string $semicolon1              = $self->{children}->[10];
        my object $subexpression_or_varmod = $self->{children}->[11];
        my string $right_paren             = $self->{children}->[12];
        my object $codeblock               = $self->{children}->[13];

        if ( $variable_symbol0 ne $variable_symbol1 ) {
            die 'ERROR ECVGEASRP06, CODE GENERATOR, ABSTRACT SYNTAX TO RPerl: C-style for() loop header variable mismatch, initial-condition variable '
                . q{'}
                . $variable_symbol0 . q{'}
                . ' is different than exit-condition variable ' . q{'}
                . $variable_symbol1 . q{'}
                . ', dying' . "\n";
        }

        $rperl_source_group->{PMC} .= $for . q{ } . $left_paren_my . q{ } . $type_integer . q{ } . $variable_symbol0 . q{ } . $assign . q{ };
        my object $rperl_source_subgroup = $subexpression0->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= $semicolon0 . q{ } . $variable_symbol1 . q{ } . $compare . q{ };
        $rperl_source_subgroup = $subexpression1->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= $semicolon1 . q{ };
        $rperl_source_subgroup = $subexpression_or_varmod->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= q{ } . $right_paren . q{ };
        $rperl_source_subgroup = $codeblock->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
    }
    else {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECVGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule '
                . $self_class
                . ' found where Loop_162, LoopFor_165, or LoopFor_166 expected, dying' )
            . "\n";
    }
    return $rperl_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{// <<< RP::O::S::L::F __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string $loop_label, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{} };

    #    RPerl::diag( 'in Loop::For->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;

    # unwrap LoopFor_165 and LoopFor_166 from Loop_162
    if ( $self_class eq 'Loop_162' ) {    # Loop -> LoopFor
        $self       = $self->{children}->[0];
        $self_class = ref $self;
    }

    # LoopFor -> 'for' MY TYPE_INTEGER VARIABLE_SYMBOL LPAREN SubExpression OP17_LIST_RANGE SubExpression ')' CodeBlock
    if ( $self_class eq 'LoopFor_165' ) {
        my string $for             = $self->{children}->[0];
        my string $type_integer    = $self->{children}->[2];
        my string $variable_symbol = $self->{children}->[3];
        my string $left_paren      = $self->{children}->[4];
        my object $subexpression0  = $self->{children}->[5];
        my object $subexpression1  = $self->{children}->[7];
        my string $right_paren     = $self->{children}->[8];
        my object $codeblock       = $self->{children}->[9];

        substr $variable_symbol, 0, 1, q{};    # remove leading $ sigil

#        RPerl::diag( 'in Loop::For->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $modes->{_symbol_table} = ' . "\n" . Dumper($modes->{_symbol_table}) . "\n" );
#        RPerl::diag( 'in Loop::For->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $modes->{_symbol_table}->{_namespace} = ' . "\n" . Dumper($modes->{_symbol_table}->{_namespace}) . "\n" );
#        RPerl::diag( 'in Loop::For->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $modes->{_symbol_table}->{_subroutine} = ' . "\n" . Dumper($modes->{_symbol_table}->{_subroutine}) . "\n" );
  
        # DEV NOTE: allow re-declaration of loop iterator variables within other loop headers, they should not conflict
        if (( exists $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{ $modes->{_symbol_table}->{_subroutine} }->{$variable_symbol} )
            and ($modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{ $modes->{_symbol_table}->{_subroutine} }->{$variable_symbol}->{isa} ne 'RPerl::Operation::Expression::SubExpression::Variable::LoopIterator')) {
            die 'ERROR ECVGEASCP10, CODE GENERATOR, ABSTRACT SYNTAX TO C++: variable '
                . $variable_symbol
                . ' already declared in this scope, namespace '
                . $modes->{_symbol_table}->{_namespace}
                . ', subroutine/method '
                . $modes->{_symbol_table}->{_subroutine}
                . '(), dying'
                . "\n";
        }
        $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{ $modes->{_symbol_table}->{_subroutine} }->{$variable_symbol}
            = { isa => 'RPerl::Operation::Expression::SubExpression::Variable::LoopIterator', type => $type_integer };  # NEED UPGRADE: replace fake class isa w/ real class here and below?
 
        $cpp_source_group->{CPP} .= $for . q{ } . $left_paren . q{ } . $type_integer . q{ } . $variable_symbol . q{ = };
        my object $cpp_source_subgroup = $subexpression0->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
        $cpp_source_group->{CPP} .= q{; } . $variable_symbol . ' <= ';
        $cpp_source_subgroup = $subexpression1->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
        $cpp_source_group->{CPP} .= q{; } . $variable_symbol . '++ ' . $right_paren . q{ };
        $cpp_source_subgroup = $codeblock->ast_to_cpp__generate__CPPOPS_CPPTYPES($loop_label, $modes);
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
    }
    elsif ( $self_class eq 'LoopFor_166' ) {

# LoopFor -> 'for' LPAREN_MY TYPE_INTEGER VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN SubExpression ';' VARIABLE_SYMBOL OP11_COMPARE_LT_GT SubExpression ';' SubExpressionOrVarMod ')' CodeBlock
        my string $for                     = $self->{children}->[0];
        my string $type_integer            = $self->{children}->[2];
        my string $variable_symbol0        = $self->{children}->[3];
        my string $assign                  = $self->{children}->[4];
        my object $subexpression0          = $self->{children}->[5];
        my string $semicolon0              = $self->{children}->[6];
        my string $variable_symbol1        = $self->{children}->[7];
        my string $compare                 = $self->{children}->[8];
        my object $subexpression1          = $self->{children}->[9];
        my string $semicolon1              = $self->{children}->[10];
        my object $subexpression_or_varmod = $self->{children}->[11];
        my string $right_paren             = $self->{children}->[12];
        my object $codeblock               = $self->{children}->[13];

        if ( $variable_symbol0 ne $variable_symbol1 ) {
            die 'ERROR ECVGEASCP06, CODE GENERATOR, ABSTRACT SYNTAX TO C++: C-style for() loop header variable mismatch, initial-condition variable ' . q{'}
                . $variable_symbol0 . q{'}
                . ' is different than exit-condition variable ' . q{'}
                . $variable_symbol1 . q{'}
                . ' , dying' . "\n";
        }

        substr $variable_symbol0, 0, 1, q{};    # remove leading $ sigil
        substr $variable_symbol1, 0, 1, q{};    # remove leading $ sigil

        if (( exists $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{ $modes->{_symbol_table}->{_subroutine} }->{$variable_symbol0} ) 
            and ($modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{ $modes->{_symbol_table}->{_subroutine} }->{$variable_symbol0}->{isa} ne 'RPerl::Operation::Expression::SubExpression::Variable::LoopIterator')) {
            die 'ERROR ECVGEASCP10, CODE GENERATOR, ABSTRACT SYNTAX TO C++: variable '
                . $variable_symbol0
                . ' already declared in this scope, namespace '
                . $modes->{_symbol_table}->{_namespace}
                . ', subroutine/method '
                . $modes->{_symbol_table}->{_subroutine}
                . '(), dying'
                . "\n";
        }
        $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{ $modes->{_symbol_table}->{_subroutine} }->{$variable_symbol0}
            = { isa => 'RPerl::Operation::Expression::SubExpression::Variable::LoopIterator', type => $type_integer };

        $cpp_source_group->{CPP} .= $for . q{ ( } . $type_integer . q{ } . $variable_symbol0 . q{ } . $assign . q{ };
        my object $cpp_source_subgroup = $subexpression0->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
        $cpp_source_group->{CPP} .= $semicolon0 . q{ } . $variable_symbol1 . q{ } . $compare . q{ };
        $cpp_source_subgroup = $subexpression1->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
        $cpp_source_group->{CPP} .= $semicolon1 . q{ };
        $cpp_source_subgroup = $subexpression_or_varmod->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
        $cpp_source_group->{CPP} .= q{ } . $right_paren . q{ };
        $cpp_source_subgroup = $codeblock->ast_to_cpp__generate__CPPOPS_CPPTYPES($loop_label, $modes);
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
    }
    else {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECVGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: grammar rule '
                . $self_class
                . ' found where Loop_162, LoopFor_165, or LoopFor_166 expected, dying' )
            . "\n";
    }
    return $cpp_source_group;
};

1;    # end of class
