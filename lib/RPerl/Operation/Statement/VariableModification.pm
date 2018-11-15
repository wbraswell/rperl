# [[[ HEADER ]]]
package RPerl::Operation::Statement::VariableModification;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.005_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Statement);
use RPerl::Operation::Statement;

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
    my string_hashref $rperl_source_subgroup;
    my string $self_class = ref $self;

#    RPerl::diag( 'in VariableModification->ast_to_rperl__generate(), received $self = ', "\n", RPerl::Parser::rperl_ast__dump($self), "\n" );

    # yes semicolon for Statement_176, no semicolon for SubExpressionOrVarMod_168, VariableModification_206, and VariableModification_207
    my string $semicolon = q{};

    if ( $self_class eq 'SubExpressionOrVarMod_168' ) {    # SubExpressionOrVarMod -> VariableModification
        # unwrap VariableModification_206 and VariableModification_207 from SubExpressionOrVarMod_168
        $self       = $self->{children}->[0];
        $self_class = ref $self;
    }
    elsif ( $self_class eq 'Statement_176' ) {    # Statement -> VariableModification ';'
        # unwrap VariableModification_206 and VariableModification_207 from Statement_176; grab semicolon
        $semicolon  = $self->{children}->[1];
        $self       = $self->{children}->[0];
        $self_class = ref $self;
    }

    if ( $self_class eq 'VariableModification_206' ) {    # VariableModification -> Variable OP19_VARIABLE_ASSIGN SubExpressionOrInput
        my object $variable               = $self->{children}->[0];
        my string $assign                 = $self->{children}->[1];
        my object $subexpression_or_stdin = $self->{children}->[2];

        $rperl_source_subgroup = $variable->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= q{ } . $assign . q{ };
        $rperl_source_subgroup = $subexpression_or_stdin->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
    }
    elsif ( $self_class eq 'VariableModification_207' ) {    # VariableModification -> Variable OP19_VARIABLE_ASSIGN_BY SubExpression
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
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASRP000, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule ' . $self_class .
                ' found where SubExpressionOrVarMod_168, Statement_176, VariableModification_206, or VariableModification_207 expected, dying' ) . "\n";
    }

    $rperl_source_group->{PMC} .= $semicolon . "\n";

#    RPerl::diag( 'in VariableModification->ast_to_rperl__generate(), returning $rperl_source_group = ', "\n", RPerl::Parser::rperl_ast__dump($rperl_source_group), "\n" );
    return $rperl_source_group;
}

sub ast_to_cpp__generate__CPPOPS_PERLTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group = { CPP => q{// <<< RP::O::S::VM __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n" };

    #...
    return $cpp_source_group;
}

sub ast_to_cpp__generate__CPPOPS_CPPTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group = { CPP => q{} };
    my string_hashref $cpp_source_subgroup;
    my string $self_class = ref $self;

#    RPerl::diag( 'in VariableModification->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ', "\n", RPerl::Parser::rperl_ast__dump($self), "\n" );

    # yes semicolon for Statement_176, no semicolon for SubExpressionOrVarMod_168, VariableModification_206, and VariableModification_207
    my string $semicolon = undef;

    if ( $self_class eq 'SubExpressionOrVarMod_168' ) {    # SubExpressionOrVarMod -> VariableModification
        # unwrap VariableModification_206 and VariableModification_207 from SubExpressionOrVarMod_168
        $self       = $self->{children}->[0];
        $self_class = ref $self;
    }
    elsif ( $self_class eq 'Statement_176' ) {    # Statement -> VariableModification ';'
        # unwrap VariableModification_206 and VariableModification_207 from Statement_176; grab semicolon
        $semicolon  = $self->{children}->[1];
        $self       = $self->{children}->[0];
        $self_class = ref $self;
    }

    if ( $self_class eq 'VariableModification_206' ) {    # VariableModification -> Variable OP19_VARIABLE_ASSIGN SubExpressionOrInput
        my object $variable               = $self->{children}->[0];
        my string $assign                 = $self->{children}->[1];
        my object $subexpression_or_stdin = $self->{children}->[2];
#        RPerl::diag( 'in VariableModification->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $variable = ', "\n", RPerl::Parser::rperl_ast__dump($variable), "\n" );
#        RPerl::diag( 'in VariableModification->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $subexpression_or_stdin = ', "\n", RPerl::Parser::rperl_ast__dump($subexpression_or_stdin), "\n" );

        # detect object constructor move semantics
        # NEED ANSWER: do we also need to add detection of object constructor move semantics to VariableDeclaration?
        # HARD-CODED EXAMPLE:
        # $self->{foo}->{$bar} = Bat::Bax->new();  # Perl
        # this->foo[bar] = new Bat__Bax;  # C++, BAD
        # Bat__Bax_ptr this__foo__bar{new Bat__Bax()};  this->foo[bar] = std::move(this__foo__bar);  # C++, GOOD
        my boolean $rhs_is_constructor_call = 0;
        my boolean $lhs_is_variable_retrieval = 0;
        # NEED UPGRADE: enable detection logic for non-trivial cases where ConstructorCall may be in parentheses or otherwise buried deeper in $subexpression_or_stdin
        if (
            ((ref    $subexpression_or_stdin) eq 'SubExpressionOrInput_164') and 
            (exists  $subexpression_or_stdin->{children}) and
            (defined $subexpression_or_stdin->{children}) and
            (defined $subexpression_or_stdin->{children}->[0]) and
            ((ref    $subexpression_or_stdin->{children}->[0]) eq 'SubExpression_155') and
            (exists  $subexpression_or_stdin->{children}->[0]->{children}) and
            (defined $subexpression_or_stdin->{children}->[0]->{children}) and
            (defined $subexpression_or_stdin->{children}->[0]->{children}->[0]) and
            ((ref    $subexpression_or_stdin->{children}->[0]->{children}->[0]) eq 'Expression_154') # ISA RPerl::Operation::Expression::SubroutineCall::MethodCall::ConstructorCall
            ) {
            $rhs_is_constructor_call = 1;
#            RPerl::diag( 'in VariableModification->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $rhs_is_constructor_call = ', $rhs_is_constructor_call, "\n" );
        }
        # NEED ANSWER: is the for() loop check for VariableRetrieval below correct?  or does the VariableRetrieval need to be at the beginning and/or end of the LHS?
        # NEED UPGRADE: enable detection logic for non-trivial cases where VariableRetrieval may be in parentheses or otherwise buried deeper in $variable
        if (
            $rhs_is_constructor_call and  # short-circuit to skip $lhs_is_variable_retrieval if $rhs_is_constructor_call not detected
            ((ref    $variable) eq 'Variable_198') and  # Variable -> VariableSymbolOrSelf STAR-44
            (exists  $variable->{children}) and
            (defined $variable->{children}) and
            (defined $variable->{children}->[1]) and
            ((ref    $variable->{children}->[1]) eq '_STAR_LIST') and
            (exists  $variable->{children}->[1]->{children}) and
            (defined $variable->{children}->[1]->{children})
            ) {
                foreach my object $lhs_object (@{$variable->{children}->[1]->{children}}) {
                    if (
                        ((ref $lhs_object) eq 'VariableRetrieval_199') or  # VariableRetrieval -> OP02_ARRAY_THINARROW SubExpression ']'
                        ((ref $lhs_object) eq 'VariableRetrieval_200') or  # VariableRetrieval -> OP02_HASH_THINARROW SubExpression '}'
                        ((ref $lhs_object) eq 'VariableRetrieval_201')     # VariableRetrieval -> OP02_HASH_THINARROW WORD '}'
                    ) {
                        $lhs_is_variable_retrieval = 1;
                    }
                }
#            RPerl::diag( 'in VariableModification->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $lhs_is_variable_retrieval = ', $lhs_is_variable_retrieval, "\n" );
        }

        # detect array resize semantics: Perl '$a->[$i - 1] = undef;' becomes C++ 'a.resize(i);'
        my boolean $rhs_is_undef = 0;
        my boolean $lhs_is_array_retrieval_minus_one = 0;
        # short-circuit to skip array resize semantics detection if object constructor move semantics detected
        if (not ($rhs_is_constructor_call or $lhs_is_variable_retrieval)) {
            
            # SubExpression_156 ISA RPerl::Operation::Expression::SubExpression::Literal::Undefined AKA undef
            if (
                ((ref $subexpression_or_stdin) eq 'SubExpressionOrInput_164') and 
                (exists $subexpression_or_stdin->{children}) and
                (defined $subexpression_or_stdin->{children}) and
                (defined $subexpression_or_stdin->{children}->[0]) and
                ((ref $subexpression_or_stdin->{children}->[0]) eq 'SubExpression_156')
                ) {
                $rhs_is_undef = 1; 
#                RPerl::diag( 'in VariableModification->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $rhs_is_undef = ', $rhs_is_undef, "\n" );
            }
            if (
                $rhs_is_undef and  # short-circuit to skip $lhs_is_array_retrieval_minus_one if $rhs_is_undef not detected
                ((ref    $variable) eq 'Variable_198') and  # Variable -> VariableSymbolOrSelf STAR-44
                (exists  $variable->{children}) and
                (defined $variable->{children}) and
                (defined $variable->{children}->[1]) and
                ((ref    $variable->{children}->[1]) eq '_STAR_LIST') and
                (exists  $variable->{children}->[1]->{children}) and
                (defined $variable->{children}->[1]->{children}) and
                (defined $variable->{children}->[1]->{children}->[-1]) and
                ((ref    $variable->{children}->[1]->{children}->[-1]) eq 'VariableRetrieval_199') and  # VariableRetrieval -> OP02_ARRAY_THINARROW SubExpression ']'
                (exists  $variable->{children}->[1]->{children}->[-1]->{children}) and
                (defined $variable->{children}->[1]->{children}->[-1]->{children}) and
                (defined $variable->{children}->[1]->{children}->[-1]->{children}->[1]) and
                ((ref    $variable->{children}->[1]->{children}->[-1]->{children}->[1]) eq 'SubExpression_155') and  # SubExpression -> Expression
                (exists  $variable->{children}->[1]->{children}->[-1]->{children}->[1]->{children}) and
                (defined $variable->{children}->[1]->{children}->[-1]->{children}->[1]->{children}) and
                (defined $variable->{children}->[1]->{children}->[-1]->{children}->[1]->{children}->[0]) and
                ((ref    $variable->{children}->[1]->{children}->[-1]->{children}->[1]->{children}->[0]) eq 'Expression_149') and  # Expression -> Operator
                (exists  $variable->{children}->[1]->{children}->[-1]->{children}->[1]->{children}->[0]->{children}) and
                (defined $variable->{children}->[1]->{children}->[-1]->{children}->[1]->{children}->[0]->{children}) and
                (defined $variable->{children}->[1]->{children}->[-1]->{children}->[1]->{children}->[0]->{children}->[0]) and
                ((ref    $variable->{children}->[1]->{children}->[-1]->{children}->[1]->{children}->[0]->{children}->[0]) eq 'Operator_113') and  # Operator -> SubExpression OP08_MATH_ADD_SUB SubExpression
                (exists  $variable->{children}->[1]->{children}->[-1]->{children}->[1]->{children}->[0]->{children}->[0]->{children}) and
                (defined $variable->{children}->[1]->{children}->[-1]->{children}->[1]->{children}->[0]->{children}->[0]->{children}) and
                (defined $variable->{children}->[1]->{children}->[-1]->{children}->[1]->{children}->[0]->{children}->[0]->{children}->[1]) and
                (        $variable->{children}->[1]->{children}->[-1]->{children}->[1]->{children}->[0]->{children}->[0]->{children}->[1]  eq '- ') and  # subtraction
                (defined $variable->{children}->[1]->{children}->[-1]->{children}->[1]->{children}->[0]->{children}->[0]->{children}->[2]) and
                ((ref    $variable->{children}->[1]->{children}->[-1]->{children}->[1]->{children}->[0]->{children}->[0]->{children}->[2]) eq 'SubExpression_157') and  # SubExpression -> Literal
                (exists  $variable->{children}->[1]->{children}->[-1]->{children}->[1]->{children}->[0]->{children}->[0]->{children}->[2]->{children}) and
                (defined $variable->{children}->[1]->{children}->[-1]->{children}->[1]->{children}->[0]->{children}->[0]->{children}->[2]->{children}) and
                (defined $variable->{children}->[1]->{children}->[-1]->{children}->[1]->{children}->[0]->{children}->[0]->{children}->[2]->{children}->[0]) and
                ((ref    $variable->{children}->[1]->{children}->[-1]->{children}->[1]->{children}->[0]->{children}->[0]->{children}->[2]->{children}->[0]) eq 'Literal_255') and  # Literal -> LITERAL_NUMBER
                (exists  $variable->{children}->[1]->{children}->[-1]->{children}->[1]->{children}->[0]->{children}->[0]->{children}->[2]->{children}->[0]->{children}) and
                (defined $variable->{children}->[1]->{children}->[-1]->{children}->[1]->{children}->[0]->{children}->[0]->{children}->[2]->{children}->[0]->{children}) and
                (defined $variable->{children}->[1]->{children}->[-1]->{children}->[1]->{children}->[0]->{children}->[0]->{children}->[2]->{children}->[0]->{children}->[0]) and
                (        $variable->{children}->[1]->{children}->[-1]->{children}->[1]->{children}->[0]->{children}->[0]->{children}->[2]->{children}->[0]->{children}->[0]  eq '1')  # literal number 1
                ) {
                $lhs_is_array_retrieval_minus_one = 1;
#                RPerl::diag( 'in VariableModification->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $lhs_is_array_retrieval_minus_one = ', $lhs_is_array_retrieval_minus_one, "\n" );
            }
        }

        # object constructor move semantics detected
        if ($rhs_is_constructor_call and $lhs_is_variable_retrieval) {
#            RPerl::diag( 'in VariableModification->ast_to_cpp__generate__CPPOPS_CPPTYPES(), object constructor move semantics detected', "\n" );
            $cpp_source_subgroup = $variable->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
            my string $lhs = $cpp_source_subgroup->{CPP};
#            RPerl::diag( 'in VariableModification->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $lhs = ', q{'}, $lhs, q{'}, "\n" );
            my string $lhs_underscores = $lhs;
            $lhs_underscores =~ s/->/__/g;  # replace -> w/ __
            $lhs_underscores =~ s/\[(.*)\]/__$1/g;  # replace [bar] w/ __bar
#            RPerl::diag( 'in VariableModification->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $lhs_underscores = ', q{'}, $lhs_underscores, q{'}, "\n" );

            my string $rhs_class_underscores;
            if (
                (exists  $subexpression_or_stdin->{children}->[0]->{children}->[0]->{children}) and
                (defined $subexpression_or_stdin->{children}->[0]->{children}->[0]->{children}) and
                (defined $subexpression_or_stdin->{children}->[0]->{children}->[0]->{children}->[0]) and
                (  # class names w/ or w/out '::' scopes
                    ((ref $subexpression_or_stdin->{children}->[0]->{children}->[0]->{children}->[0]) eq 'WordScoped_238') or  # WordScoped -> WORD
                    ((ref $subexpression_or_stdin->{children}->[0]->{children}->[0]->{children}->[0]) eq 'WordScoped_239')     # WordScoped -> WORD_SCOPED
                ) and
                (exists  $subexpression_or_stdin->{children}->[0]->{children}->[0]->{children}->[0]->{children}) and
                (defined $subexpression_or_stdin->{children}->[0]->{children}->[0]->{children}->[0]->{children}) and
                (defined $subexpression_or_stdin->{children}->[0]->{children}->[0]->{children}->[0]->{children}->[0])
                ) {
                $rhs_class_underscores = $subexpression_or_stdin->{children}->[0]->{children}->[0]->{children}->[0]->{children}->[0];
                $rhs_class_underscores =~ s/:/_/g;
            }
            else {
                die 'ERROR ECOGEASCP070, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Object constructor move semantics detected, but RHS class name not found where expected, dying' . "\n";
            }
                
#            RPerl::diag( 'in VariableModification->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $rhs_class_underscores = ', q{'}, $rhs_class_underscores, q{'}, "\n" );
            $cpp_source_group->{CPP} .= $rhs_class_underscores . '_ptr ' . $lhs_underscores . '{new ' . $rhs_class_underscores . '()};  ';
            $cpp_source_group->{CPP} .= $lhs . ' = std::move(' . $lhs_underscores . ')';
        }

        # array resize semantics detected
        elsif ($rhs_is_undef and $lhs_is_array_retrieval_minus_one) {
            my unknown $size = $variable->{children}->[1]->{children}->[-1]->{children}->[1]->{children}->[0]->{children}->[0]->{children}->[0];
            delete $variable->{children}->[1]->{children}->[-1];  # do not generate the final variable retrieval containing the size: ->[size - 1]
#            RPerl::diag( 'in VariableModification->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have modified $variable = ', "\n", RPerl::Parser::rperl_ast__dump($variable), "\n" );
#            RPerl::diag( 'in VariableModification->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $size = ', "\n", RPerl::Parser::rperl_ast__dump($size), "\n" );

            $cpp_source_subgroup = $variable->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
            RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
            $cpp_source_group->{CPP} .= '.resize(';
            $cpp_source_subgroup = $size->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
            RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
            $cpp_source_group->{CPP} .= ')';
        }
        else {  # normal generate
            $cpp_source_subgroup = $variable->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
            RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
            $cpp_source_group->{CPP} .= q{ } . $assign . q{ };
            $cpp_source_subgroup = $subexpression_or_stdin->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
            RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
        }
    }
    elsif ( $self_class eq 'VariableModification_207' ) {    # VariableModification -> Variable OP19_VARIABLE_ASSIGN_BY SubExpression
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
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP000, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule ' . $self_class .
                ' found where SubExpressionOrVarMod_168, Statement_176, VariableModification_206, or VariableModification_207 expected, dying' ) . "\n";
    }

    if (defined $semicolon) {
        $cpp_source_group->{CPP} .= $semicolon . "\n";
    }

#    RPerl::diag( 'in VariableModification->ast_to_cpp__generate__CPPOPS_CPPTYPES(), returning $cpp_source_group = ', "\n", RPerl::Parser::rperl_ast__dump($cpp_source_group), "\n" );
    return $cpp_source_group;
}

1;    # end of class
