# [[[ HEADER ]]]
package RPerl::Operation::Expression::SubExpression::Variable;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.004_000;

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

    # unwrap Variable_176 from SubExpression_137, VariableOrLiteral_226, or VarOrLitOrOpStrOrWord_228
    if ( ( $self_class eq 'SubExpression_137' ) or ( $self_class eq 'VariableOrLiteral_226' ) or ( $self_class eq 'VarOrLitOrOpStrOrWord_228' ) ) {
        $self = $self->{children}->[0];
    }

    $self_class = ref $self;
    if ( $self_class eq 'Variable_176' ) {

        # Variable -> VariableSymbolOrSelf VariableRetrieval*
        my string $symbol_or_self = $self->{children}->[0]->{children}->[0];
        $rperl_source_group->{PMC} .= $symbol_or_self;

        foreach my object $variable_retrieval ( @{ $self->{children}->[1]->{children} } ) {
            my string_hashref $rperl_source_subgroup = $variable_retrieval->ast_to_rperl__generate($modes);
            RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        }
    }
    else {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECVGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule '
                . ($self_class)
                . ' found where SubExpression_137, VariableOrLiteral_226, VarOrLitOrOpStrOrWord_228, or Variable_176 expected, dying' )
            . "\n";
    }

    return $rperl_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{// <<< RP::O::E::SE::V __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{} };

    #    RPerl::diag( 'in Variable->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;

    # unwrap Variable_176 from SubExpression_137, VariableOrLiteral_226, or VarOrLitOrOpStrOrWord_228
    if ( ( $self_class eq 'SubExpression_137' ) or ( $self_class eq 'VariableOrLiteral_226' ) or ( $self_class eq 'VarOrLitOrOpStrOrWord_228' ) ) {
        $self = $self->{children}->[0];
    }

    $self_class = ref $self;
    if ( $self_class eq 'Variable_176' ) {

        # Variable -> VariableSymbolOrSelf VariableRetrieval*
        my string $symbol_or_self = $self->{children}->[0]->{children}->[0];
        my string_arrayref $types = [];

#        RPerl::diag( 'in Variable->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have pre-modification $symbol_or_self = ' . $symbol_or_self . "\n" );

        substr $symbol_or_self, 0, 1, q{};    # remove leading $ sigil

        # determine first type
        if ( $symbol_or_self eq 'self' ) {
            $symbol_or_self = 'this';  # Perl OO $self becomes C++ OO this
            $types->[0] = $modes->{_symbol_table}->{_namespace};
        }
        else {
            # variable retrieval (individual or multiple chained) can only be initiated from a variable, which must be in the symtab, in a namespace, in a subroutine
            $types->[0]
                = $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{ $modes->{_symbol_table}->{_subroutine} }->{$symbol_or_self}->{type};
        }

#        RPerl::diag( 'in Variable->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have post-modification $symbol_or_self = ' . $symbol_or_self . "\n" );

        $cpp_source_group->{CPP} = $symbol_or_self;
        my integer $i_max = ( scalar @{ $self->{children}->[1]->{children} } ) - 1;
        for my integer $i ( 0 .. $i_max ) {
            my object $variable_retrieval = $self->{children}->[1]->{children}->[$i];
#            RPerl::diag( 'in Variable->ast_to_cpp__generate__CPPOPS_CPPTYPES(), for loop $i = ' . $i . ', have $types->[$i] = ' . $types->[$i] . "\n" );
#            RPerl::diag( 'in Variable->ast_to_cpp__generate__CPPOPS_CPPTYPES(), for loop $i = ' . $i . ', have $variable_retrieval = ' . "\n" . RPerl::Parser::rperl_ast__dump($variable_retrieval) . "\n" );

            my string_hashref $cpp_source_subgroup = $variable_retrieval->ast_to_cpp__generate__CPPOPS_CPPTYPES( $symbol_or_self, $types->[$i], $modes );
            RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );

            # determine next type
            if ( $i < $i_max ) {
                if ( $types->[$i] =~ /_arrayref$/ ) { # array
                    $types->[ $i + 1 ] = substr $types->[$i], 0, ( ( length $types->[$i] ) - 9 );    # strip trailing '_arrayref'
                }
                elsif ( $types->[$i] =~ /_hashref$/ ) { # hash
                    $types->[ $i + 1 ] = substr $types->[$i], 0, ( ( length $types->[$i] ) - 8 );    # strip trailing '_hashref'
                }
                elsif ( $types->[$i] =~ /sse_number_pair$/xms ) { # SSE number pair
                    $types->[ $i + 1 ] = 'number';
                }
                elsif ( exists $rperlnamespaces_generated::RPERL->{ $types->[$i] . '::' } ) { # scalar
                    die 'ERROR ECVGEASCP18, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Variable retrieval, can not retrieve data subcomponent from scalar type ' . $types->[$i] . ', dying' . "\n";
                }
                else { # user-defined type AKA class
                    if ( ( ref $variable_retrieval ) eq 'VariableRetrieval_178' ) {    # VariableRetrieval -> OP02_HASH_THINARROW SubExpression '}'
                        my object $subexpression = $variable_retrieval->{children}->[1];
                        if (( ( ref $subexpression ) eq 'SubExpression_136' )          # SubExpression -> Literal
                            or ( ( ref $subexpression ) eq 'VariableOrLiteral_227' )          # VariableOrLiteral -> Literal
                            or ( ( ref $subexpression ) eq 'VarOrLitOrOpStrOrWord_229' )    # VarOrLitOrOpStrOrWord -> Literal
                            )
                        {
                            my string $number_or_string_literal = $subexpression->{children}->[0]->{children}->[0];
                            $number_or_string_literal = eval "return $number_or_string_literal";  # strip quotations from string and underscores from number, etc.
                            if ( exists $modes->{_symbol_table}->{ $types->[$i] }->{_properties}->{$number_or_string_literal} ) {
                                $types->[ $i + 1 ] = $modes->{_symbol_table}->{ $types->[$i] }->{_properties}->{$number_or_string_literal}->{type};
                            }
                            else {
                                die 'ERROR ECVGEASCP19, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Variable retrieval, can not retrieve invalid OO property ' . $number_or_string_literal . ' in user-defined class ' . $types->[$i] . ', dying' . "\n";
                            }
                        }
                        else {
                            my string $subexpression_generated = ($subexpression->ast_to_cpp__generate__CPPOPS_CPPTYPES( $modes ))->{CPP};
                            die 'ERROR ECVGEASCP20, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Variable retrieval, can not determine OO property name (and thus type) from non-literal subexpression...' . "\n" . $subexpression_generated . "\n" . '...in user-defined class ' . $types->[$i] . ', dying' . "\n";
                        }
                    }
                    elsif ( ( ref $variable_retrieval ) eq 'VariableRetrieval_179' ) {        # VariableRetrieval -> OP02_HASH_THINARROW WORD '}'
                        my string $word = $variable_retrieval->{children}->[1];
                        if ( exists $modes->{_symbol_table}->{ $types->[$i] }->{_properties}->{$word} ) {
                            $types->[ $i + 1 ] = $modes->{_symbol_table}->{ $types->[$i] }->{_properties}->{$word}->{type};
                        }
                        else {
                            die 'ERROR ECVGEASCP19, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Variable retrieval, can not retrieve invalid OO property ' . $word . ' in user-defined class ' . $types->[$i] . ', dying' . "\n";
                        }
                    }
                    else {
                        die 'ERROR ECVGEASCP21, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Variable retrieval, can not use arrayref retrieval on object of user-defined class ' . $types->[$i] . ', dying' . "\n";
                    }
                }
            }
        }
    }
    else {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECVGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: grammar rule '
                . ($self_class)
                . ' found where SubExpression_137, VariableOrLiteral_226, VarOrLitOrOpStrOrWord_228, or Variable_176 expected, dying' )
            . "\n";
    }

    return $cpp_source_group;
};

1;    # end of class
