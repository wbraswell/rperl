# [[[ HEADER ]]]
package RPerl::Operation::Statement::VariableDeclaration;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.003_400;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Statement);

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
    my string $self_class = ref $self;

    #    RPerl::diag( 'in VariableDeclaration->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    # unwrap VariableDeclaration_178, VariableDeclaration_179, VariableDeclaration_180, and VariableDeclaration_181 from Statement_153
    if ( $self_class eq 'Statement_153' ) {    # Statement -> VariableDeclaration
        $self       = $self->{children}->[0];
        $self_class = ref $self;
    }

    if ( $self_class eq 'VariableDeclaration_178' ) {    # VariableDeclaration -> MY Type VARIABLE_SYMBOL ';'
        my string $my        = $self->{children}->[0];
        my string $type      = $self->{children}->[1]->{children}->[0];
        my string $symbol    = $self->{children}->[2];
        my string $semicolon = $self->{children}->[3];
        $rperl_source_group->{PMC} .= $my . q{ } . $type . q{ } . $symbol . $semicolon . "\n";
    }
    elsif ( $self_class eq 'VariableDeclaration_179' ) {    # VariableDeclaration -> MY Type VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN SubExpressionOrStdin ';'
        my string $my                     = $self->{children}->[0];
        my string $type                   = $self->{children}->[1]->{children}->[0];
        my string $symbol                 = $self->{children}->[2];
        my string $assign                 = $self->{children}->[3];
        my object $subexpression_or_stdin = $self->{children}->[4];
        my string $semicolon              = $self->{children}->[5];

        if ( ((ref $subexpression_or_stdin) eq 'HASH' ) and
            ( exists $subexpression_or_stdin->{children} ) and
            ( exists $subexpression_or_stdin->{children}->[0] ) and
            ( exists $subexpression_or_stdin->{children}->[0]->{children} ) and
            ( exists $subexpression_or_stdin->{children}->[0]->{children}->[0] ) and
            ( $subexpression_or_stdin->{children}->[0]->{children}->[0]->isa('RPerl::Operation::Expression::SubroutineCall::MethodCall::ConstructorCall') ) )
        {
            my string $constructor_type = $subexpression_or_stdin->{children}->[0]->{children}->[0]->{children}->[0]->{children}->[0];
            if ( $type ne $constructor_type ) {
                die RPerl::Parser::rperl_rule__replace( 'ERROR ECVGEASRP16, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: data type mismatch, ' . q{'}
                        . $type . q{'}
                        . ' type is different than ' . q{'}
                        . $constructor_type . q{'}
                        . ' constructor type, dying' )
                    . "\n";
            }
        }

        $rperl_source_group->{PMC} .= $my . q{ } . $type . q{ } . $symbol . q{ } . $assign;
        $rperl_source_subgroup = $subexpression_or_stdin->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= $semicolon . "\n";
    }
    elsif ( $self_class eq 'VariableDeclaration_180' ) { # VariableDeclaration -> MY Type VARIABLE_SYMBOL OP02_ARRAY_THINARROW SubExpression ']' OP19_VARIABLE_ASSIGN 'undef' ';'
        my string $my                 = $self->{children}->[0];
        my string $type               = $self->{children}->[1]->{children}->[0];
        my string $symbol             = $self->{children}->[2];
        my string $arrow_left_bracket = $self->{children}->[3];
        my object $subexpression      = $self->{children}->[4];
        my string $right_bracket      = $self->{children}->[5];
        my string $assign             = $self->{children}->[6];
        my string $undef              = $self->{children}->[7];
        my string $semicolon          = $self->{children}->[8];

        $rperl_source_group->{PMC} .= $my . q{ } . $type . q{ } . $symbol . $arrow_left_bracket . q{ };
        $rperl_source_subgroup = $subexpression->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= q{ } . $right_bracket . q{ } . $assign . q{ } . $undef . $semicolon . "\n";
    }
    elsif ( $self_class eq 'VariableDeclaration_181' ) {    # VariableDeclaration -> MY TYPE_FHREF FHREF_SYMBOL ';'
        my string $my           = $self->{children}->[0];
        my string $type_fhref   = $self->{children}->[1];
        my string $symbol_fhref = $self->{children}->[2];
        my string $semicolon    = $self->{children}->[3];
        $rperl_source_group->{PMC} .= $my . q{ } . $type_fhref . q{ } . $symbol_fhref . $semicolon . "\n";
    }
    else {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECVGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule '
                . $self_class
                . ' found where VariableDeclaration_178, VariableDeclaration_179, VariableDeclaration_180, or VariableDeclaration_181 expected, dying' )
            . "\n";
    }

    return $rperl_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{// <<< RP::O::S::VD __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{} };
    my string_hashref $cpp_source_subgroup;
    my string $self_class = ref $self;

 #    RPerl::diag( 'in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    # unwrap VariableDeclaration_178, VariableDeclaration_179, VariableDeclaration_180, and VariableDeclaration_181 from Statement_153
    if ( $self_class eq 'Statement_153' ) {    # Statement -> VariableDeclaration
        $self       = $self->{children}->[0];
        $self_class = ref $self;
    }

    if ( $self_class eq 'VariableDeclaration_178' ) {    # VariableDeclaration -> MY Type VARIABLE_SYMBOL ';'
        my string $type   = $self->{children}->[1]->{children}->[0];
        my string $symbol = $self->{children}->[2];
        substr $symbol, 0, 1, q{};                       # remove leading $ sigil

        if ( exists $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{ $modes->{_symbol_table}->{_subroutine} }->{$symbol} ) {
            die 'ERROR ECVGEASCP10, CODE GENERATOR, ABSTRACT SYNTAX TO C++: variable '
                . $symbol
                . ' already declared in this scope, namespace '
                . $modes->{_symbol_table}->{_namespace}
                . ', subroutine/method '
                . $modes->{_symbol_table}->{_subroutine}
                . '(), dying'
                . "\n";
        }
        $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{ $modes->{_symbol_table}->{_subroutine} }->{$symbol}
            = { isa => 'RPerl::Operation::Expression::SubExpression::Variable', type => $type };

        $type = RPerl::Generator::type_convert_perl_to_cpp($type, 1);  # $pointerify_classes = 1
        $modes->{_symbol_table}->{$modes->{_symbol_table}->{_namespace}}->{ $modes->{_symbol_table}->{_subroutine} }->{$symbol}->{type_cpp} = $type;  # add converted C++ type to symtab entry

        $cpp_source_group->{CPP} .= $type . q{ } . $symbol . ';' . "\n";
    }
    elsif ( $self_class eq 'VariableDeclaration_179' ) {    # VariableDeclaration -> MY Type VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN SubExpressionOrStdin ';'
        my string $type   = $self->{children}->[1]->{children}->[0];
        my string $symbol = $self->{children}->[2];
        my string $assign = $self->{children}->[3];
        my object $subexpression_or_stdin = $self->{children}->[4];
        my string $semicolon              = $self->{children}->[5];

        substr $symbol, 0, 1, q{};                          # remove leading $ sigil
        my bool $is_constructor_call = 0;

#        RPerl::diag( 'in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $subexpression_or_stdin = ' . "\n" . RPerl::Parser::rperl_ast__dump($subexpression_or_stdin) . "\n" );

        if ( ((ref $subexpression_or_stdin) eq 'SubExpressionOrStdin_143' ) and
            ( exists $subexpression_or_stdin->{children} ) and
            ( exists $subexpression_or_stdin->{children}->[0]->{children} ) and
            ( $subexpression_or_stdin->{children}->[0]->{children}->[0]->isa('RPerl::Operation::Expression::SubroutineCall::MethodCall::ConstructorCall') ) )
        {
            $is_constructor_call = 1;
            my string $constructor_type = $subexpression_or_stdin->{children}->[0]->{children}->[0]->{children}->[0]->{children}->[0];
            if ( $type ne $constructor_type ) {
                die RPerl::Parser::rperl_rule__replace( 'ERROR ECVGEASCP16, CODE GENERATOR, ABSTRACT SYNTAX TO C++: data type mismatch, ' . q{'}
                        . $type . q{'}
                        . ' type is different than ' . q{'}
                        . $constructor_type . q{'}
                        . ' constructor type, dying' )
                    . "\n";
            }
        }

        #        my string $tmp_debug_string = RPerl::Parser::rperl_ast__dump($subexpression_or_stdin);
        #        if ( $tmp_debug_string =~ /constant_sse_number_pair::new_from_singleton_duplicate/ ) {
        #            RPerl::diag( 'in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $subexpression_or_stdin = ' . "\n"
        #                    . RPerl::Parser::rperl_ast__dump($subexpression_or_stdin)
        #                    . "\n" );
        #            die 'TMP DEBUG';
        #        }

        if ( exists $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{ $modes->{_symbol_table}->{_subroutine} }->{$symbol} ) {
            die 'ERROR ECVGEASCP10, CODE GENERATOR, ABSTRACT SYNTAX TO C++: variable '
                . $symbol
                . ' already declared in this scope, namespace '
                . $modes->{_symbol_table}->{_namespace}
                . ', subroutine/method '
                . $modes->{_symbol_table}->{_subroutine}
                . '(), dying'
                . "\n";
        }
        $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{ $modes->{_symbol_table}->{_subroutine} }->{$symbol}
            = { isa => 'RPerl::Operation::Expression::SubExpression::Variable', type => $type };

        $type = RPerl::Generator::type_convert_perl_to_cpp($type, 1);  # $pointerify_classes = 1
        $modes->{_symbol_table}->{$modes->{_symbol_table}->{_namespace}}->{ $modes->{_symbol_table}->{_subroutine} }->{$symbol}->{type_cpp} = $type;  # add converted C++ type to symtab entry

        $cpp_source_group->{CPP} .= $type . q{ } . $symbol;

        if ($is_constructor_call) {
            if ( not exists $rperlnamespaces_generated::RPERL->{ $type . '::' } ) { # not scalar or SSE number pair
                $cpp_source_group->{CPP} .= '(';
                $cpp_source_subgroup = $subexpression_or_stdin->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
                RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
                $cpp_source_group->{CPP} .= ')';
            }
        }
        else {
            $cpp_source_group->{CPP} .= q{ } . $assign . q{ };
            $cpp_source_subgroup = $subexpression_or_stdin->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
            RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
        }
        $cpp_source_group->{CPP} .= $semicolon . "\n";
    }
    elsif ( $self_class eq 'VariableDeclaration_180' ) { # VariableDeclaration -> MY Type VARIABLE_SYMBOL OP02_ARRAY_THINARROW SubExpression ']' OP19_VARIABLE_ASSIGN 'undef' ';'
        my string $type   = $self->{children}->[1]->{children}->[0];
        my string $symbol = $self->{children}->[2];
        my object $subexpression = $self->{children}->[4];
        my string $semicolon     = $self->{children}->[8];

        substr $symbol, 0, 1, q{};                       # remove leading $ sigil
#        RPerl::diag( 'in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $subexpression = ' . RPerl::Parser::rperl_ast__dump($subexpression) . "\n" );

        if ( exists $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{ $modes->{_symbol_table}->{_subroutine} }->{$symbol} ) {
            die 'ERROR ECVGEASCP10, CODE GENERATOR, ABSTRACT SYNTAX TO C++: variable '
                . $symbol
                . ' already declared in this scope, namespace '
                . $modes->{_symbol_table}->{_namespace}
                . ', subroutine/method '
                . $modes->{_symbol_table}->{_subroutine}
                . '(), dying'
                . "\n";
        }
        $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{ $modes->{_symbol_table}->{_subroutine} }->{$symbol}
            = { isa => 'RPerl::Operation::Expression::SubExpression::Variable', type => $type };

        $type = RPerl::Generator::type_convert_perl_to_cpp($type, 1);  # $pointerify_classes = 1
        $modes->{_symbol_table}->{$modes->{_symbol_table}->{_namespace}}->{ $modes->{_symbol_table}->{_subroutine} }->{$symbol}->{type_cpp} = $type;  # add converted C++ type to symtab entry

        my string $subexpression_address = "$subexpression";
        # POSSIBLE COMPILE-TIME OPTIMIZATION #01: avoids compensation addition below
        $subexpression = RPerl::Generator::arrayref_convert_index_max_to_size($subexpression);

        $cpp_source_group->{CPP} .= $type . q{ } . $symbol . $semicolon . "\n";
        $cpp_source_group->{CPP} .= $symbol . q{.resize(};
        $cpp_source_subgroup = $subexpression->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
        if ( $subexpression_address eq "$subexpression" ) {  # not compensated automatically, must compensate manually
            # 'foo() * $bar' becomes '(foo() * $bar) + 1'
            $cpp_source_subgroup->{CPP} = q{(} . $cpp_source_subgroup->{CPP} . q{) + 1};
        }
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
        $cpp_source_group->{CPP} .= q{)} . $semicolon . "\n";
    }
    elsif ( $self_class eq 'VariableDeclaration_181' ) {    # VariableDeclaration -> MY TYPE_FHREF FHREF_SYMBOL ';'
        my string $type_fhref   = $self->{children}->[1];
        my string $symbol_fhref = $self->{children}->[2];
        substr $symbol_fhref, 0, 1, q{};                    # remove leading $ sigil

        if ( exists $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{ $modes->{_symbol_table}->{_subroutine} }->{$symbol_fhref} ) {
            die 'ERROR ECVGEASCP10, CODE GENERATOR, ABSTRACT SYNTAX TO C++: variable '
                . $symbol_fhref
                . ' already declared in this scope, namespace '
                . $modes->{_symbol_table}->{_namespace}
                . ', subroutine/method '
                . $modes->{_symbol_table}->{_subroutine}
                . '(), dying'
                . "\n";
        }
        $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{ $modes->{_symbol_table}->{_subroutine} }->{$symbol_fhref}
            = { isa => 'RPerl::Operation::Expression::SubExpression::Variable', type => $type_fhref };


        # NEED ANSWER: should we enable type_convert_perl_to_cpp() for future use of constant_filehandleref type?
#        $type_fhref = RPerl::Generator::type_convert_perl_to_cpp($type_fhref, 1);  # $pointerify_classes = 1
        $modes->{_symbol_table}->{$modes->{_symbol_table}->{_namespace}}->{ $modes->{_symbol_table}->{_subroutine} }->{$symbol_fhref}->{type_cpp} = $type_fhref;  # add converted C++ type to symtab entry

        $cpp_source_group->{CPP} .= $type_fhref . q{ } . $symbol_fhref . ';' . "\n";
    }
    else {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECVGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: grammar rule '
                . $self_class
                . ' found where VariableDeclaration_178, VariableDeclaration_179, VariableDeclaration_180, or VariableDeclaration_181 expected, dying' )
            . "\n";
    }

    return $cpp_source_group;
};

1;    # end of class
