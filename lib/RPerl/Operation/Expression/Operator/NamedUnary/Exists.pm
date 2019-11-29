# [[[ DOCUMENTATION ]]]
# http://perldoc.perl.org/functions/exists.html
#     SUPPORTED:  exists EXPR

# [[[ HEADER ]]]
package RPerl::Operation::Expression::Operator::NamedUnary::Exists;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.004_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Expression::Operator::NamedUnary);
use RPerl::Operation::Expression::Operator::NamedUnary;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ CONSTANTS ]]]
use constant NAME                  => my string  $TYPED_NAME                  = 'exists';
use constant NAME_CPPOPS_PERLTYPES => my string  $TYPED_NAME_CPPOPS_PERLTYPES = 'DUMMY_OP_SCALAR';
use constant NAME_CPPOPS_CPPTYPES  => my string  $TYPED_NAME_CPPOPS_CPPTYPES  = 'exists';
use constant ARGUMENTS_MIN         => my integer $TYPED_ARGUMENTS_MIN         = 1;
use constant ARGUMENTS_MAX         => my integer $TYPED_ARGUMENTS_MAX         = 1;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

sub ast_to_rperl__generate {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my object $operator_named, my string_hashref $modes) = @ARG;
    my string_hashref $rperl_source_group = { PMC => q{} };

#    RPerl::diag( 'in Operator::NamedUnary::Exists->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
#    RPerl::diag( 'in Operator::NamedUnary::Exists->ast_to_rperl__generate(), received $operator_named = ' . "\n" . RPerl::Parser::rperl_ast__dump($operator_named) . "\n" );

    my string $operator_named_class = ref $operator_named;
    if ( $operator_named_class eq 'Operation_97' ) {    # Operation -> OP10_NAMED_UNARY_SCOLON
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASRP016, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Named operator '
                . $operator_named->{children}->[0]
                . ' requires exactly one argument, dying' )
            . "\n";
    }
    elsif ( $operator_named_class eq 'Operator_116' ) {    # Operator -> OP10_NAMED_UNARY SubExpression
        $rperl_source_group->{PMC} .= $operator_named->{children}->[0] . q{ };
        my string_hashref $rperl_source_subgroup = $operator_named->{children}->[1]->ast_to_rperl__generate( $modes, $self );
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
    }
    elsif ( $operator_named_class eq 'Operator_117' ) {    # Operator -> OP10_NAMED_UNARY
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASRP016, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Named operator '
                . $operator_named->{children}->[0]
                . ' requires exactly one argument, dying' )
            . "\n";
    }
    else {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASRP000, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '
                . ($operator_named_class)
                . ' found where Operation_97, Operator_116, or Operator_117 expected, dying' )
            . "\n";
    }
    return $rperl_source_group;
}


sub ast_to_cpp__generate__CPPOPS_PERLTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group = { CPP => q{// <<< RP::O::E::O::NU::E __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n" };

    #...
    return $cpp_source_group;
}


sub ast_to_cpp__generate__CPPOPS_CPPTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my object $operator_named, my string_hashref $modes) = @ARG;

    my string_hashref $cpp_source_group = { CPP => q{} };

#    RPerl::diag( 'in Operator::NamedUnary::Exists->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
#    RPerl::diag( 'in Operator::NamedUnary::Exists->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $operator_named = ' . "\n" . RPerl::Parser::rperl_ast__dump($operator_named) . "\n" );

    my string $operator_named_class = ref $operator_named;
    if ( $operator_named_class eq 'Operation_97' ) {    # Operation -> OP10_NAMED_UNARY_SCOLON
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP016, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Named operator '
                . $operator_named->{children}->[0]
                . ' requires exactly one argument, dying' )
            . "\n";
    }
    elsif ( $operator_named_class eq 'Operator_116' ) {    # Operator -> OP10_NAMED_UNARY SubExpression
#        RPerl::diag( 'in Operator::NamedUnary::Exists->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $operator_named->{children}->[1] = ' . "\n" . RPerl::Parser::rperl_ast__dump($operator_named->{children}->[1]) . "\n" );

        $cpp_source_group->{CPP} .= NAME_CPPOPS_CPPTYPES() . q{(};

        # check for Variable_198 object, part of hashref name
        if ((defined $operator_named->{children}->[1]) and

            (exists  $operator_named->{children}->[1]->{children}) and
            (defined $operator_named->{children}->[1]->{children}) and
            (defined $operator_named->{children}->[1]->{children}->[0]) and

            (exists  $operator_named->{children}->[1]->{children}->[0]->{children}) and
            (defined $operator_named->{children}->[1]->{children}->[0]->{children}) and
            (defined $operator_named->{children}->[1]->{children}->[0]->{children}->[0])
        ) {
            # Variable_198 ISA RPerl::Operation::Expression::SubExpression::Variable
            # Variable -> VariableSymbolOrSelf STAR-50
            # Variable -> VariableSymbolOrSelf VariableRetrieval*
            my object $variable_symbol_or_self = $operator_named->{children}->[1]->{children}->[0]->{children}->[0];
            my string $variable_symbol_or_self_class = ref $variable_symbol_or_self;
            
            # check for VariableSymbolOrSelf_253 object, part of hashref name; directly generate if valid
            if ( $variable_symbol_or_self_class eq 'VariableSymbolOrSelf_253' ) {
                if ((exists  $variable_symbol_or_self->{children}) and
                    (defined $variable_symbol_or_self->{children}) and
                    (defined $variable_symbol_or_self->{children}->[0])
                ) {
                    # VariableSymbolOrSelf_253 ISA RPerl::NonGenerator
                    # VariableSymbolOrSelf -> VARIABLE_SYMBOL
                    my string $symbol_or_self = $variable_symbol_or_self->{children}->[0];

#                    RPerl::diag( 'in Exists->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have pre-modification $symbol_or_self = ' . $symbol_or_self . "\n" );

                    substr $symbol_or_self, 0, 1, q{}; # remove leading $ sigil

                    $cpp_source_group->{CPP} .= $symbol_or_self . ', ';
                }
                else {
                    die RPerl::Parser::rperl_rule__replace(
                        'ERROR ECOGEASCP000UG, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Unrecognized grammar rules found where VARIABLE_SYMBOL expected, dying' ) . "\n";
                }
            }
            # VariableSymbolOrSelf_254 ISA RPerl::NonGenerator
            # VariableSymbolOrSelf -> SELF
            elsif ( $variable_symbol_or_self_class eq 'VariableSymbolOrSelf_254' ) {
                die RPerl::Parser::rperl_rule__replace(
                    'ERROR ECOGEASCP000OO, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule '
                        . $variable_symbol_or_self_class . ' found where VariableSymbolOrSelf_253 expected, can not treat $self object like a hash, dying' ) . "\n";
            }
            else {
                die RPerl::Parser::rperl_rule__replace(
                    'ERROR ECOGEASCP000, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule '
                        . $variable_symbol_or_self_class . ' found where VariableSymbolOrSelf_253 expected, dying' ) . "\n";
            }
        }
        else {
            die RPerl::Parser::rperl_rule__replace(
                'ERROR ECOGEASCP000UG, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Unrecognized grammar rules found where Variable_198 expected, dying' ) . "\n";
        }

        # check for VariableRetrieval_200 and Variable_198 objects, part of hash key lookup; generate if valid
        if (
            (defined $operator_named->{children}->[1]) and

            (exists  $operator_named->{children}->[1]->{children}) and
            (defined $operator_named->{children}->[1]->{children}) and
            (defined $operator_named->{children}->[1]->{children}->[0]) and

            (exists  $operator_named->{children}->[1]->{children}->[0]->{children}) and
            (defined $operator_named->{children}->[1]->{children}->[0]->{children}) and
            (defined $operator_named->{children}->[1]->{children}->[0]->{children}->[1]) and

            (exists  $operator_named->{children}->[1]->{children}->[0]->{children}->[1]->{children}) and
            (defined $operator_named->{children}->[1]->{children}->[0]->{children}->[1]->{children}) and
            (defined $operator_named->{children}->[1]->{children}->[0]->{children}->[1]->{children}->[0])
        ) { 
            my object $variable_retrieval = $operator_named->{children}->[1]->{children}->[0]->{children}->[1]->{children}->[0];
            my string $variable_retrieval_class = ref $variable_retrieval;

            # VariableRetrieval_200 ISA RPerl::Operation::Expression::SubExpression::Variable::Retrieval
            # VariableRetrieval -> OP02_HASH_THINARROW SubExpression '}'
            if ( $variable_retrieval_class eq 'VariableRetrieval_200' ) {
#                RPerl::diag( 'in Operator::NamedUnary::Exists->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $variable_retrieval = ' . "\n" . RPerl::Parser::rperl_ast__dump($variable_retrieval) . "\n" );

#$VAR1 = bless( {
#    'children' => [
#        '->{',
#        bless( {
#            'children' => [
#                bless( {
#                    'children' => [
#                        bless( {
#                            'children' => [
#                                '$key_not_valid'
#                            ],
#                            'line_number' => 27
#                        }, 'VariableSymbolOrSelf_253 ISA RPerl::NonGenerator' ),
#                        bless( {
#                            'children' => []
#                        }, '_STAR_LIST' )
#                    ],
#                    'line_number' => 27
#                }, 'Variable_198 ISA RPerl::Operation::Expression::SubExpression::Variable' )
#            ],
#            'line_number' => 27
#        }, 'SubExpression_158 ISA RPerl::Operation::Expression::SubExpression::Variable' ),
#        '}'
#    ],
#    'line_number' => 27
#}, 'VariableRetrieval_200 ISA RPerl::Operation::Expression::SubExpression::Variable::Retrieval' );

                if (
                    (exists  $variable_retrieval->{children}) and
                    (defined $variable_retrieval->{children}) and
                    (defined $variable_retrieval->{children}->[1]) and

                    (exists  $variable_retrieval->{children}->[1]->{children}) and
                    (defined $variable_retrieval->{children}->[1]->{children}) and
                    (defined $variable_retrieval->{children}->[1]->{children}->[0])
                ) {
                    my object $key = $variable_retrieval->{children}->[1]->{children}->[0];
                    my string $key_class = ref $key;

                    if ( $key_class eq 'Variable_198' ) {  # Variable -> VariableSymbolOrSelf VariableRetrieval*
                        my string_hashref $cpp_source_subgroup = $key->ast_to_cpp__generate__CPPOPS_CPPTYPES( $modes, $self );
                        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
                    }
                    else {
                        die RPerl::Parser::rperl_rule__replace(
                            'ERROR ECOGEASCP000, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule '
                                . $key_class . ' found where Variable_198 expected, dying' ) . "\n";
                    }
                }
                else {
                    die RPerl::Parser::rperl_rule__replace(
                        'ERROR ECOGEASCP000UG, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Unrecognized grammar rules found where Variable_198 expected, dying' ) . "\n";
                }
            }
            # VariableRetrieval_201 ISA RPerl::Operation::Expression::SubExpression::Variable::Retrieval
            # VariableRetrieval -> OP02_HASH_THINARROW WORD '}'
            elsif ( $variable_retrieval_class eq 'VariableRetrieval_201' ) {
#                RPerl::diag( 'in Operator::NamedUnary::Exists->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $variable_retrieval = ' . "\n" . RPerl::Parser::rperl_ast__dump($variable_retrieval) . "\n" );

#$VAR1 = bless( {
#    'children' => [
#        '->{',
#        'key_0',
#        '}'
#    ],
#    'line_number' => 24
#}, 'VariableRetrieval_201 ISA RPerl::Operation::Expression::SubExpression::Variable::Retrieval' );

                if (
                    (exists  $variable_retrieval->{children}) and
                    (defined $variable_retrieval->{children}) and
                    (defined $variable_retrieval->{children}->[1])
                ) {
                    my string $key = $variable_retrieval->{children}->[1];

                    if ( $key eq q{} ) { 
                        die RPerl::Parser::rperl_rule__replace(
                            'ERROR ECOGEASCP860, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Empty string provided as hash key, dying' ) . "\n";
                    }
                    # wrap bare-word keys in double quotes and cast to const string
                    $cpp_source_group->{CPP} .= q{((const string) "} . $key . q{")};
                }
                else {
                    die RPerl::Parser::rperl_rule__replace(
                        'ERROR ECOGEASCP000UG, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Unrecognized grammar rules found where Variable_198 expected, dying' ) . "\n";
                }
            }
            else {
                die RPerl::Parser::rperl_rule__replace(
                    'ERROR ECOGEASCP000, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule '
                        . $variable_retrieval_class . ' found where VariableRetrieval_200 expected, dying' ) . "\n";
            }
        }   
        else {
            die RPerl::Parser::rperl_rule__replace(
                'ERROR ECOGEASCP000UG, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Unrecognized grammar rules found where VariableRetrieval_200 and Variable_198 expected, dying' ) . "\n";
        }

        $cpp_source_group->{CPP} .= q{)};
    }
    elsif ( $operator_named_class eq 'Operator_117' ) {    # Operator -> OP10_NAMED_UNARY
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP016, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Named operator '
                . $operator_named->{children}->[0]
                . ' requires exactly one argument, dying' )
            . "\n";
    }
    else {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP000, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '
                . ($operator_named_class)
                . ' found where Operation_97, Operator_116, or Operator_117 expected, dying' )
            . "\n";
    }

#    RPerl::diag( 'in Exists->ast_to_cpp__generate__CPPOPS_CPPTYPES(), about to return $cpp_source_group->{CPP} = ' . "\n" . $cpp_source_group->{CPP} . "\n" );

    return $cpp_source_group;
}

1;    # end of class
