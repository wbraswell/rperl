# [[[ HEADER ]]]
package RPerl::Operation::Statement::VariableDeclaration;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.004_200;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Statement);

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use Scalar::Util 'blessed';

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS & SUBROUTINES ]]]

our string_hashref::method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };
    my string_hashref $rperl_source_subgroup;
    my string $self_class = ref $self;

#    RPerl::diag( 'in VariableDeclaration->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
#    die 'TMP DEBUG, dying';

    # unwrap VariableDeclaration_180, VariableDeclaration_181, VariableDeclaration_182, and VariableDeclaration_183 from Statement_154
    if ( $self_class eq 'Statement_154' ) {    # Statement -> VariableDeclaration
        $self       = $self->{children}->[0];
        $self_class = ref $self;
    }

    if ( $self_class eq 'VariableDeclaration_180' ) {    # VariableDeclaration -> MY Type VARIABLE_SYMBOL ';'
        my string $my        = $self->{children}->[0];
        my string $type      = $self->{children}->[1]->{children}->[0];
        my string $symbol    = $self->{children}->[2];
        my string $semicolon = $self->{children}->[3];
        $rperl_source_group->{PMC} .= $my . q{ } . $type . q{ } . $symbol . $semicolon . "\n";
    }
    elsif ( $self_class eq 'VariableDeclaration_181' ) {    # VariableDeclaration -> MY Type VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN OpNamedScolonOrSubExpIn
        my string $my                     = $self->{children}->[0];
        my string $type                   = $self->{children}->[1]->{children}->[0];
        my string $symbol                 = $self->{children}->[2];
        my string $assign                 = $self->{children}->[3];
        my object $opnamed_or_subexp_or_input_scolon = $self->{children}->[4];
 
#        RPerl::diag( 'in VariableDeclaration->ast_to_rperl__generate(), have $opnamed_or_subexp_or_input_scolon = ' . "\n" . RPerl::Parser::rperl_ast__dump($opnamed_or_subexp_or_input_scolon) . "\n" );

        $rperl_source_group->{PMC} .= $my . q{ } . $type . q{ } . $symbol . q{ } . $assign;

        my string $opnamed_or_subexp_or_input_scolon_type = ref $opnamed_or_subexp_or_input_scolon;
#        RPerl::diag( 'in VariableDeclaration->ast_to_rperl__generate(), have $opnamed_or_subexp_or_input_scolon_type = ' . "\n" . RPerl::Parser::rperl_ast__dump($opnamed_or_subexp_or_input_scolon_type) . "\n" );
 
        if (($opnamed_or_subexp_or_input_scolon_type eq 'OpNamedScolonOrSubExpIn_238') or 
            ($opnamed_or_subexp_or_input_scolon_type eq 'OpNamedScolonOrSubExpIn_239')) {
            # OpNamedScolonOrSubExpIn -> OP01_NAMED_SCOLON
            # OpNamedScolonOrSubExpIn -> OP10_NAMED_UNARY_SCOLON
            $rperl_source_group->{PMC} .= $opnamed_or_subexp_or_input_scolon->{children}->[0];
        }
        elsif ($opnamed_or_subexp_or_input_scolon_type eq 'OpNamedScolonOrSubExpIn_240') {  # OpNamedScolonOrSubExpIn -> SubExpressionOrInput ';'
#            RPerl::diag( 'in VariableDeclaration->ast_to_rperl__generate(), have (ref $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0]->{children}->[0]) = ' . "\n" . RPerl::Parser::rperl_ast__dump((ref $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0]->{children}->[0])) . "\n" );
            
            if ( ( exists $opnamed_or_subexp_or_input_scolon->{children} ) and
                ( exists $opnamed_or_subexp_or_input_scolon->{children}->[0] ) and
                ( blessed($opnamed_or_subexp_or_input_scolon->{children}->[0])) and
                ( exists $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children} ) and
                ( exists $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0] ) and
                ( blessed($opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0])) and
                ( exists $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0]->{children} ) and
                ( exists $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0]->{children}->[0] ) and
                (blessed($opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0]->{children}->[0])) and
                ( $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0]->{children}->[0]->isa('RPerl::Operation::Expression::SubroutineCall::MethodCall::ConstructorCall') ) )
            {
                    my string $constructor_type = $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0]->{children}->[0]->{children}->[0]->{children}->[0];
#                    RPerl::diag( 'in VariableDeclaration->ast_to_rperl__generate(), have $constructor_type = ' . "\n" . RPerl::Parser::rperl_ast__dump($constructor_type) . "\n" );
     
                    if ( $type ne $constructor_type ) {
                        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASRP19, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: data type mismatch, ' . q{'}
                                . $type . q{'}
                                . ' type is different than ' . q{'}
                                . $constructor_type . q{'}
                                . ' constructor type, dying' )
                            . "\n";
                    }
            }

            $rperl_source_subgroup = $opnamed_or_subexp_or_input_scolon->{children}->[0]->ast_to_rperl__generate($modes);  # subexpression
            RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
            $rperl_source_group->{PMC} .= $opnamed_or_subexp_or_input_scolon->{children}->[1];  # semicolon
        }
        else {
            die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule '
                    . $opnamed_or_subexp_or_input_scolon_type
                    . ' found where OpNamedScolonOrSubExpIn_238, OpNamedScolonOrSubExpIn_239, or OpNamedScolonOrSubExpIn_240 expected, dying' )
                . "\n";
        }

        $rperl_source_group->{PMC} .= "\n";
    }
    elsif ( $self_class eq 'VariableDeclaration_182' ) { # VariableDeclaration -> MY Type VARIABLE_SYMBOL OP02_ARRAY_THINARROW SubExpression ']' OP19_VARIABLE_ASSIGN 'undef' ';'
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
    elsif ( $self_class eq 'VariableDeclaration_183' ) {    # VariableDeclaration -> MY TYPE_FHREF FHREF_SYMBOL ';'
        my string $my           = $self->{children}->[0];
        my string $type_fhref   = $self->{children}->[1];
        my string $symbol_fhref = $self->{children}->[2];
        my string $semicolon    = $self->{children}->[3];
        $rperl_source_group->{PMC} .= $my . q{ } . $type_fhref . q{ } . $symbol_fhref . $semicolon . "\n";
    }
    else {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule '
                . $self_class
                . ' found where VariableDeclaration_180, VariableDeclaration_181, VariableDeclaration_182, or VariableDeclaration_183 expected, dying' )
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

    # unwrap VariableDeclaration_180, VariableDeclaration_181, VariableDeclaration_182, and VariableDeclaration_183 from Statement_154
    if ( $self_class eq 'Statement_154' ) {    # Statement -> VariableDeclaration
        $self       = $self->{children}->[0];
        $self_class = ref $self;
    }

    if ( $self_class eq 'VariableDeclaration_180' ) {    # VariableDeclaration -> MY Type VARIABLE_SYMBOL ';'
        my string $type   = $self->{children}->[1]->{children}->[0];
        my string $symbol = $self->{children}->[2];
        substr $symbol, 0, 1, q{};                       # remove leading $ sigil

        if ( exists $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{ $modes->{_symbol_table}->{_subroutine} }->{$symbol} ) {
            die 'ERROR ECOGEASCP10, CODE GENERATOR, ABSTRACT SYNTAX TO C++: variable '
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
    elsif ( $self_class eq 'VariableDeclaration_181' ) {    # VariableDeclaration -> MY Type VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN OpNamedScolonOrSubExpIn
        my string $type                   = $self->{children}->[1]->{children}->[0];
        my string $symbol                 = $self->{children}->[2];
        my string $assign                 = $self->{children}->[3];
        my object $opnamed_or_subexp_or_input_scolon = $self->{children}->[4];
 
#        RPerl::diag( 'in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $opnamed_or_subexp_or_input_scolon = ' . "\n" . RPerl::Parser::rperl_ast__dump($opnamed_or_subexp_or_input_scolon) . "\n" );

        substr $symbol, 0, 1, q{};                          # remove leading $ sigil
        my boolean $is_constructor_call = 0;

        my string $opnamed_or_subexp_or_input_scolon_type = ref $opnamed_or_subexp_or_input_scolon;
#        RPerl::diag( 'in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $opnamed_or_subexp_or_input_scolon_type = ' . "\n" . RPerl::Parser::rperl_ast__dump($opnamed_or_subexp_or_input_scolon_type) . "\n" );
 
        if (($opnamed_or_subexp_or_input_scolon_type eq 'OpNamedScolonOrSubExpIn_238') or 
            ($opnamed_or_subexp_or_input_scolon_type eq 'OpNamedScolonOrSubExpIn_239')) {
            # OpNamedScolonOrSubExpIn -> OP01_NAMED_SCOLON
            # OpNamedScolonOrSubExpIn -> OP10_NAMED_UNARY_SCOLON
            $cpp_source_group->{CPP} .= $opnamed_or_subexp_or_input_scolon->{children}->[0];
        }
        elsif ($opnamed_or_subexp_or_input_scolon_type eq 'OpNamedScolonOrSubExpIn_240') {  # OpNamedScolonOrSubExpIn -> SubExpressionOrInput ';'
            if ( ( exists $opnamed_or_subexp_or_input_scolon->{children} ) and
                ( exists $opnamed_or_subexp_or_input_scolon->{children}->[0] ) and
                ( exists $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children} ) and
                ( exists $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0] ) and
                ( exists $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0]->{children} ) and
                ( exists $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0]->{children}->[0] ) and
                ( $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0]->{children}->[0]->isa('RPerl::Operation::Expression::SubroutineCall::MethodCall::ConstructorCall') ) )
            {
                    $is_constructor_call = 1;
                    my string $constructor_type = $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0]->{children}->[0]->{children}->[0]->{children}->[0];
#                    RPerl::diag( 'in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $constructor_type = ' . "\n" . RPerl::Parser::rperl_ast__dump($constructor_type) . "\n" );
     
                    if ( $type ne $constructor_type ) {
                        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASRP19, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: data type mismatch, ' . q{'}
                                . $type . q{'}
                                . ' type is different than ' . q{'}
                                . $constructor_type . q{'}
                                . ' constructor type, dying' )
                            . "\n";
                    }
            }

            if ( exists $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{ $modes->{_symbol_table}->{_subroutine} }->{$symbol} ) {
                die 'ERROR ECOGEASCP10, CODE GENERATOR, ABSTRACT SYNTAX TO C++: variable '
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
                    $cpp_source_subgroup = $opnamed_or_subexp_or_input_scolon->{children}->[0]->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);  # subexpression
                    RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
                    $cpp_source_group->{CPP} .= ')';
                }
            }
            else {
                $cpp_source_group->{CPP} .= q{ } . $assign . q{ };
                $cpp_source_subgroup = $opnamed_or_subexp_or_input_scolon->{children}->[0]->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);  # subexpression
                RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
            }
            $cpp_source_group->{CPP} .= $opnamed_or_subexp_or_input_scolon->{children}->[1];  # semicolon
        }
        else {
            die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule '
                    . $opnamed_or_subexp_or_input_scolon_type
                    . ' found where OpNamedScolonOrSubExpIn_238, OpNamedScolonOrSubExpIn_239, or OpNamedScolonOrSubExpIn_240 expected, dying' )
                . "\n";
        }

        $cpp_source_group->{CPP} .= "\n";
    }
    elsif ( $self_class eq 'VariableDeclaration_182' ) { # VariableDeclaration -> MY Type VARIABLE_SYMBOL OP02_ARRAY_THINARROW SubExpression ']' OP19_VARIABLE_ASSIGN 'undef' ';'
        my string $type   = $self->{children}->[1]->{children}->[0];
        my string $symbol = $self->{children}->[2];
        my object $subexpression = $self->{children}->[4];
        my string $semicolon     = $self->{children}->[8];

        substr $symbol, 0, 1, q{};                       # remove leading $ sigil
#        RPerl::diag( 'in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $subexpression = ' . RPerl::Parser::rperl_ast__dump($subexpression) . "\n" );

        if ( exists $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{ $modes->{_symbol_table}->{_subroutine} }->{$symbol} ) {
            die 'ERROR ECOGEASCP10, CODE GENERATOR, ABSTRACT SYNTAX TO C++: variable '
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
    elsif ( $self_class eq 'VariableDeclaration_183' ) {    # VariableDeclaration -> MY TYPE_FHREF FHREF_SYMBOL ';'
        my string $type_fhref   = $self->{children}->[1];
        my string $symbol_fhref = $self->{children}->[2];
        substr $symbol_fhref, 0, 1, q{};                    # remove leading $ sigil

        if ( exists $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{ $modes->{_symbol_table}->{_subroutine} }->{$symbol_fhref} ) {
            die 'ERROR ECOGEASCP10, CODE GENERATOR, ABSTRACT SYNTAX TO C++: variable '
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
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: grammar rule '
                . $self_class
                . ' found where VariableDeclaration_180, VariableDeclaration_181, VariableDeclaration_182, or VariableDeclaration_183 expected, dying' )
            . "\n";
    }

    return $cpp_source_group;
};

1;    # end of class
