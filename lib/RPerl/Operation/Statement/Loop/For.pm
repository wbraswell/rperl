# [[[ HEADER ]]]
package RPerl::Operation::Statement::Loop::For;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.005_200;

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
    my string_hashref $rperl_source_subgroup;

    #    RPerl::diag( 'in Loop::For->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;

    # unwrap LoopFor_168 and LoopFor_169 from Loop_165
    if ( $self_class eq 'Loop_165' ) {    # Loop -> LoopFor
        $self       = $self->{children}->[0];
        $self_class = ref $self;
    }

    if ( $self_class eq 'LoopFor_168' ) {

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
        $rperl_source_subgroup = $subexpression0->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= q{ } . $list_range . q{ };
        $rperl_source_subgroup = $subexpression1->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= q{ } . $right_paren . q{ };
        $rperl_source_subgroup = $codeblock->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
    }
    elsif ( $self_class eq 'LoopFor_169' ) {
# LoopFor -> 'for' LPAREN_MY TYPE_INTEGER VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN OpNamedScolonOrSubExp VARIABLE_SYMBOL OP11_COMPARE_LT_GT OpNamedScolonOrSubExp SubExpressionOrVarMod ')' CodeBlock
        my string $for                       = $self->{children}->[0];
        my string $left_paren_my             = $self->{children}->[1];
        my string $type_integer              = $self->{children}->[2];
        my string $variable_symbol0          = $self->{children}->[3];
        my string $assign                    = $self->{children}->[4];
        my object $opnamed_or_subexp_scolon0 = $self->{children}->[5];
        my string $variable_symbol1          = $self->{children}->[6];
        my string $compare                   = $self->{children}->[7];
        my object $opnamed_or_subexp_scolon1 = $self->{children}->[8];
        my object $subexpression_or_varmod   = $self->{children}->[9];
        my string $right_paren               = $self->{children}->[10];
        my object $codeblock                 = $self->{children}->[11];

        if ( $variable_symbol0 ne $variable_symbol1 ) {
            die 'ERROR ECOGEASRP06, CODE GENERATOR, ABSTRACT SYNTAX TO RPerl: C-style for() loop header variable mismatch, initial-condition variable '
                . q{'}
                . $variable_symbol0 . q{'}
                . ' is different than exit-condition variable ' . q{'}
                . $variable_symbol1 . q{'}
                . ', dying' . "\n";
        }

        $rperl_source_group->{PMC} .= $for . q{ } . $left_paren_my . q{ } . $type_integer . q{ } . $variable_symbol0 . q{ } . $assign . q{ };

        my string $opnamed_or_subexp_scolon0_type = ref $opnamed_or_subexp_scolon0;
#        RPerl::diag( 'in Loop::For->ast_to_rperl__generate(), have $opnamed_or_subexp_scolon0_type = ' . "\n" . RPerl::Parser::rperl_ast__dump($opnamed_or_subexp_scolon0_type) . "\n" );

        if (   ( $opnamed_or_subexp_scolon0_type eq 'OpNamedScolonOrSubExp_237' )
            or ( $opnamed_or_subexp_scolon0_type eq 'OpNamedScolonOrSubExp_238' ) )
        {
            # OpNamedScolonOrSubExp -> OP01_NAMED_SCOLON
            # OpNamedScolonOrSubExp -> OP10_NAMED_UNARY_SCOLON
            $rperl_source_group->{PMC} .= $opnamed_or_subexp_scolon0->{children}->[0];
        }
        elsif ( $opnamed_or_subexp_scolon0_type eq 'OpNamedScolonOrSubExp_239' ) {    # OpNamedScolonOrSubExp -> SubExpression ';'
            $rperl_source_subgroup = $opnamed_or_subexp_scolon0->{children}->[0]->ast_to_rperl__generate($modes);    # subexpression
            RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
            $rperl_source_group->{PMC} .= $opnamed_or_subexp_scolon0->{children}->[1];                                         # semicolon
        }
        else {
            die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '
                    . $opnamed_or_subexp_scolon0_type
                    . ' found where OpNamedScolonOrSubExp_237, OpNamedScolonOrSubExp_238, or OpNamedScolonOrSubExp_239 expected, dying' )
                . "\n";
        }

        $rperl_source_group->{PMC} .= q{ } . $variable_symbol1 . q{ } . $compare . q{ };

        my string $opnamed_or_subexp_scolon1_type = ref $opnamed_or_subexp_scolon1;
#        RPerl::diag( 'in Loop::For->ast_to_rperl__generate(), have $opnamed_or_subexp_scolon1_type = ' . "\n" . RPerl::Parser::rperl_ast__dump($opnamed_or_subexp_scolon1_type) . "\n" );

        if (   ( $opnamed_or_subexp_scolon1_type eq 'OpNamedScolonOrSubExp_237' )
            or ( $opnamed_or_subexp_scolon1_type eq 'OpNamedScolonOrSubExp_238' ) )
        {
            # OpNamedScolonOrSubExp -> OP01_NAMED_SCOLON
            # OpNamedScolonOrSubExp -> OP10_NAMED_UNARY_SCOLON
            $rperl_source_group->{PMC} .= $opnamed_or_subexp_scolon1->{children}->[0];
        }
        elsif ( $opnamed_or_subexp_scolon1_type eq 'OpNamedScolonOrSubExp_239' ) {    # OpNamedScolonOrSubExp -> SubExpression ';'
            $rperl_source_subgroup = $opnamed_or_subexp_scolon1->{children}->[0]->ast_to_rperl__generate($modes);    # subexpression
            RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
            $rperl_source_group->{PMC} .= $opnamed_or_subexp_scolon1->{children}->[1];                               # semicolon
        }
        else {
            die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '
                    . $opnamed_or_subexp_scolon1_type
                    . ' found where OpNamedScolonOrSubExp_237, OpNamedScolonOrSubExp_238, or OpNamedScolonOrSubExp_239 expected, dying' )
                . "\n";
        }

        $rperl_source_group->{PMC} .= q{ };
        $rperl_source_subgroup = $subexpression_or_varmod->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= q{ } . $right_paren . q{ };
        $rperl_source_subgroup = $codeblock->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
    }
    else {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '
                . $self_class
                . ' found where Loop_165, LoopFor_168, or LoopFor_169 expected, dying' )
            . "\n";
    }
    return $rperl_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string $loop_label, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{// <<< RP::O::S::L::F __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string $loop_label, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{} };
    my string_hashref $cpp_source_subgroup;

    #    RPerl::diag( 'in Loop::For->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
#    RPerl::diag( 'in Loop::For->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $loop_label = ' . "\n" . RPerl::Parser::rperl_ast__dump($loop_label) . "\n" );

    my string $self_class = ref $self;

    # unwrap LoopFor_168 and LoopFor_169 from Loop_165
    if ( $self_class eq 'Loop_165' ) {    # Loop -> LoopFor
        $self       = $self->{children}->[0];
        $self_class = ref $self;
    }

    # LoopFor -> 'for' MY TYPE_INTEGER VARIABLE_SYMBOL LPAREN SubExpression OP17_LIST_RANGE SubExpression ')' CodeBlock
    if ( $self_class eq 'LoopFor_168' ) {
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
            and ( $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{ $modes->{_symbol_table}->{_subroutine} }->{$variable_symbol}->{isa} ne
                'RPerl::Operation::Expression::SubExpression::Variable::LoopIterator' )
            )
        {
            die 'ERROR ECOGEASCP11, CODE GENERATOR, ABSTRACT SYNTAX TO C++: variable '
                . $variable_symbol
                . ' already declared in this scope, namespace '
                . $modes->{_symbol_table}->{_namespace}
                . ', subroutine/method '
                . $modes->{_symbol_table}->{_subroutine}
                . '(), dying' . "\n";
        }
        $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{ $modes->{_symbol_table}->{_subroutine} }->{$variable_symbol}
            = { isa => 'RPerl::Operation::Expression::SubExpression::Variable::LoopIterator', type => $type_integer }; # NEED UPGRADE: replace fake class isa w/ real class here and below?

        # COMPILE-TIME OPTIMIZATION #02: save loop iterators for declaration at the top of the subroutine/method
        if ( ( not exists $modes->{_loop_iterators} ) or ( not defined $modes->{_loop_iterators} ) ) {
            $modes->{_loop_iterators} = { $variable_symbol => $type_integer };
        }
        else {
            if ( ( exists $modes->{_loop_iterators}->{$variable_symbol} ) and ( $modes->{_loop_iterators}->{$variable_symbol} ne $type_integer ) ) {
                die 'ERROR ECOGEASCP40, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Compile-time optimization, loop iterator '
                    . $variable_symbol
                    . ' declared as non-integer type '
                    . $modes->{_loop_iterators}->{$variable_symbol}
                    . ', dying' . "\n";
            }
            $modes->{_loop_iterators}->{$variable_symbol} = $type_integer;
        }

        $cpp_source_group->{CPP} .= $for . q{ } . $left_paren . q{ } . $variable_symbol . q{ = };
        $cpp_source_subgroup = $subexpression0->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );

        my string $subexpression1_address  = "$subexpression1";
        my object $subexpression1_modified = RPerl::Generator::arrayref_convert_index_max_to_size($subexpression1);
        if ( $subexpression1_address ne "$subexpression1_modified" ) {

            # COMPILE-TIME OPTIMIZATION #03: avoids subtraction and is-equal
            $cpp_source_group->{CPP} .= q{; } . $variable_symbol . ' < ';
            $cpp_source_subgroup = $subexpression1_modified->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
            RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
        }
        else {
            $cpp_source_group->{CPP} .= q{; } . $variable_symbol . ' <= ';
            $cpp_source_subgroup = $subexpression1->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
            RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
        }

        $cpp_source_group->{CPP} .= q{; } . $variable_symbol . '++ ' . $right_paren . q{ };
        $cpp_source_subgroup = $codeblock->ast_to_cpp__generate__CPPOPS_CPPTYPES( $loop_label, $modes );
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
    }
    elsif ( $self_class eq 'LoopFor_169' ) {
# LoopFor -> 'for' LPAREN_MY TYPE_INTEGER VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN OpNamedScolonOrSubExp VARIABLE_SYMBOL OP11_COMPARE_LT_GT OpNamedScolonOrSubExp SubExpressionOrVarMod ')' CodeBlock
        my string $for                       = $self->{children}->[0];
        my string $type_integer              = $self->{children}->[2];
        my string $variable_symbol0          = $self->{children}->[3];
        my string $assign                    = $self->{children}->[4];
        my object $opnamed_or_subexp_scolon0 = $self->{children}->[5];
        my string $variable_symbol1          = $self->{children}->[6];
        my string $compare                   = $self->{children}->[7];
        my object $opnamed_or_subexp_scolon1 = $self->{children}->[8];
        my object $subexpression_or_varmod   = $self->{children}->[9];
        my string $right_paren               = $self->{children}->[10];
        my object $codeblock                 = $self->{children}->[11];

        if ( $variable_symbol0 ne $variable_symbol1 ) {
            die 'ERROR ECOGEASCP06, CODE GENERATOR, ABSTRACT SYNTAX TO C++: C-style for() loop header variable mismatch, initial-condition variable ' . q{'}
                . $variable_symbol0 . q{'}
                . ' is different than exit-condition variable ' . q{'}
                . $variable_symbol1 . q{'}
                . ' , dying' . "\n";
        }

        substr $variable_symbol0, 0, 1, q{};    # remove leading $ sigil
        substr $variable_symbol1, 0, 1, q{};    # remove leading $ sigil

        if (( exists $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{ $modes->{_symbol_table}->{_subroutine} }->{$variable_symbol0} )
            and ( $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{ $modes->{_symbol_table}->{_subroutine} }->{$variable_symbol0}->{isa} ne
                'RPerl::Operation::Expression::SubExpression::Variable::LoopIterator' )
            )
        {
            die 'ERROR ECOGEASCP11, CODE GENERATOR, ABSTRACT SYNTAX TO C++: variable '
                . $variable_symbol0
                . ' already declared in this scope, namespace '
                . $modes->{_symbol_table}->{_namespace}
                . ', subroutine/method '
                . $modes->{_symbol_table}->{_subroutine}
                . '(), dying' . "\n";
        }
        $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{ $modes->{_symbol_table}->{_subroutine} }->{$variable_symbol0}
            = { isa => 'RPerl::Operation::Expression::SubExpression::Variable::LoopIterator', type => $type_integer };

        # COMPILE-TIME OPTIMIZATION #02: save loop iterators for declaration at the top of the subroutine/method
        if ( ( not exists $modes->{_loop_iterators} ) or ( not defined $modes->{_loop_iterators} ) ) {
            $modes->{_loop_iterators} = { $variable_symbol0 => $type_integer };
        }
        else {
            if ( ( exists $modes->{_loop_iterators}->{$variable_symbol0} ) and ( $modes->{_loop_iterators}->{$variable_symbol0} ne $type_integer ) ) {
                die 'ERROR ECOGEASCPxa, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Compile-time optimization, loop iterator '
                    . $variable_symbol0
                    . ' declared as non-integer type '
                    . $modes->{_loop_iterators}->{$variable_symbol0}
                    . ', dying' . "\n";
            }
            $modes->{_loop_iterators}->{$variable_symbol0} = $type_integer;
        }

        $cpp_source_group->{CPP} .= $for . q{ ( } . $variable_symbol0 . q{ } . $assign . q{ };

        my string $opnamed_or_subexp_scolon0_type = ref $opnamed_or_subexp_scolon0;
#        RPerl::diag( 'in Loop::For->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $opnamed_or_subexp_scolon0_type = ' . "\n" . RPerl::Parser::rperl_ast__dump($opnamed_or_subexp_scolon0_type) . "\n" );

        if (   ( $opnamed_or_subexp_scolon0_type eq 'OpNamedScolonOrSubExp_237' )
            or ( $opnamed_or_subexp_scolon0_type eq 'OpNamedScolonOrSubExp_238' ) )
        {
            # OpNamedScolonOrSubExp -> OP01_NAMED_SCOLON
            # OpNamedScolonOrSubExp -> OP10_NAMED_UNARY_SCOLON
            $cpp_source_group->{CPP} .= $opnamed_or_subexp_scolon0->{children}->[0];
        }
        elsif ( $opnamed_or_subexp_scolon0_type eq 'OpNamedScolonOrSubExp_239' ) {    # OpNamedScolonOrSubExp -> SubExpression ';'
            $cpp_source_subgroup = $opnamed_or_subexp_scolon0->{children}->[0]->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);    # subexpression
            RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
            $cpp_source_group->{CPP} .= $opnamed_or_subexp_scolon0->{children}->[1];                                         # semicolon
        }
        else {
            die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '
                    . $opnamed_or_subexp_scolon0_type
                    . ' found where OpNamedScolonOrSubExp_237, OpNamedScolonOrSubExp_238, or OpNamedScolonOrSubExp_239 expected, dying' )
                . "\n";
        }

        $cpp_source_group->{CPP} .= q{ } . $variable_symbol1 . q{ } . $compare . q{ };

        my string $opnamed_or_subexp_scolon1_type = ref $opnamed_or_subexp_scolon1;
#        RPerl::diag( 'in Loop::For->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $opnamed_or_subexp_scolon1_type = ' . "\n" . RPerl::Parser::rperl_ast__dump($opnamed_or_subexp_scolon1_type) . "\n" );

        if (   ( $opnamed_or_subexp_scolon1_type eq 'OpNamedScolonOrSubExp_237' )
            or ( $opnamed_or_subexp_scolon1_type eq 'OpNamedScolonOrSubExp_238' ) )
        {
            # OpNamedScolonOrSubExp -> OP01_NAMED_SCOLON
            # OpNamedScolonOrSubExp -> OP10_NAMED_UNARY_SCOLON
            $cpp_source_group->{CPP} .= $opnamed_or_subexp_scolon1->{children}->[0];
        }
        elsif ( $opnamed_or_subexp_scolon1_type eq 'OpNamedScolonOrSubExp_239' ) {    # OpNamedScolonOrSubExp -> SubExpression ';'
            $cpp_source_subgroup = $opnamed_or_subexp_scolon1->{children}->[0]->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);    # subexpression
            RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
            $cpp_source_group->{CPP} .= $opnamed_or_subexp_scolon1->{children}->[1];                               # semicolon
        }
        else {
            die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '
                    . $opnamed_or_subexp_scolon1_type
                    . ' found where OpNamedScolonOrSubExp_237, OpNamedScolonOrSubExp_238, or OpNamedScolonOrSubExp_239 expected, dying' )
                . "\n";
        }

        $cpp_source_group->{CPP} .= q{ };
        $cpp_source_subgroup = $subexpression_or_varmod->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
        $cpp_source_group->{CPP} .= q{ } . $right_paren . q{ };
        $cpp_source_subgroup = $codeblock->ast_to_cpp__generate__CPPOPS_CPPTYPES($loop_label, $modes);
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
    }
    else {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule '
                . $self_class
                . ' found where Loop_165, LoopFor_168, or LoopFor_169 expected, dying' )
            . "\n";
    }
    return $cpp_source_group;
};

1;    # end of class
