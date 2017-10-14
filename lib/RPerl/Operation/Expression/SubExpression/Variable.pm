# [[[ HEADER ]]]
package RPerl::Operation::Expression::SubExpression::Variable;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.009_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Expression::SubExpression);
use RPerl::Operation::Expression::SubExpression;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

sub ast_to_rperl__generate {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $rperl_source_group = { PMC => q{} };

    #    RPerl::diag( 'in Variable->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;

    # unwrap Variable_191 from SubExpression_152, VariableOrLiteral_241, or VarOrLitOrOpStrOrWord_243
    if ( ( $self_class eq 'SubExpression_152' ) or ( $self_class eq 'VariableOrLiteral_241' ) or ( $self_class eq 'VarOrLitOrOpStrOrWord_243' ) ) {
        $self = $self->{children}->[0];
    }

    $self_class = ref $self;
    if ( $self_class eq 'Variable_191' ) {

        # Variable -> VariableSymbolOrSelf VariableRetrieval*
        my string $symbol_or_self = $self->{children}->[0]->{children}->[0];
        $rperl_source_group->{PMC} .= $symbol_or_self;

        foreach my object $variable_retrieval ( @{ $self->{children}->[1]->{children} } ) {
            my string_hashref $rperl_source_subgroup = $variable_retrieval->ast_to_rperl__generate($modes);
            RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        }
    }
    else {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '
                . ($self_class)
                . ' found where SubExpression_152, VariableOrLiteral_241, VarOrLitOrOpStrOrWord_243, or Variable_191 expected, dying' )
            . "\n";
    }
    return $rperl_source_group;
}

sub ast_to_cpp__generate__CPPOPS_PERLTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group = { CPP => q{// <<< RP::O::E::SE::V __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n" };

    #...
    return $cpp_source_group;
}

sub ast_to_cpp__generate__CPPOPS_CPPTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group = { CPP => q{} };

#    RPerl::diag( 'in Variable->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
#    RPerl::diag( 'in Variable->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $modes = ' . Dumper($modes) . "\n" );

    my string $self_class = ref $self;

    # unwrap Variable_191 from SubExpression_152, VariableOrLiteral_241, or VarOrLitOrOpStrOrWord_243
    if ( ( $self_class eq 'SubExpression_152' ) or ( $self_class eq 'VariableOrLiteral_241' ) or ( $self_class eq 'VarOrLitOrOpStrOrWord_243' ) ) {
        $self = $self->{children}->[0];
    }

    $self_class = ref $self;
    if ( $self_class eq 'Variable_191' ) {

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
                    die 'ERROR ECOGEASCP30, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Variable retrieval, can not retrieve data subcomponent from scalar type ' . $types->[$i] . ', dying' . "\n";
                }
                else { # user-defined type AKA class
                    if ( ( ref $variable_retrieval ) eq 'VariableRetrieval_193' ) {    # VariableRetrieval -> OP02_HASH_THINARROW SubExpression '}'
                        my object $subexpression = $variable_retrieval->{children}->[1];
                        if (( ( ref $subexpression ) eq 'SubExpression_151' )          # SubExpression -> Literal
                            or ( ( ref $subexpression ) eq 'VariableOrLiteral_242' )          # VariableOrLiteral -> Literal
                            or ( ( ref $subexpression ) eq 'VarOrLitOrOpStrOrWord_244' )    # VarOrLitOrOpStrOrWord -> Literal
                            )
                        {
                            my string $number_or_string_literal = $subexpression->{children}->[0]->{children}->[0];
                            $number_or_string_literal = eval "return $number_or_string_literal";  # strip quotations from string and underscores from number, etc.

                            if ((substr $types->[$i], -2, 2) ne '::') { $types->[$i] .= '::'; }  # _properties in _symbol_table are keyed by class/package names ending in ::
#                            RPerl::diag( 'in Variable->ast_to_cpp__generate__CPPOPS_CPPTYPES() #0, for loop $i = ' . $i . ', have $modes->{_symbol_table}->{ $types->[$i] }->{_properties} = ' . $modes->{_symbol_table}->{ $types->[$i] }->{_properties} . "\n" );

                            # check if OO property exists in self class or parent class
                            if ( exists $modes->{_symbol_table}->{ $types->[$i] }->{_properties}->{$number_or_string_literal} ) {
                                $types->[ $i + 1 ] = $modes->{_symbol_table}->{ $types->[$i] }->{_properties}->{$number_or_string_literal}->{type};
                            }
                            else {
                                my $parent_package_names = RPerl::CompileUnit::Module::Class::parent_and_grandparent_package_names(substr $types->[$i], 0, -2);
                                my boolean $property_found = 0;
                                foreach my $parent_package_name (@{$parent_package_names}) {
                                    if (exists $modes->{_symbol_table}->{ $parent_package_name . q{::} }->{_properties}->{$number_or_string_literal}) {
                                        $types->[ $i + 1 ] = $modes->{_symbol_table}->{ $parent_package_name . q{::} }->{_properties}->{$number_or_string_literal}->{type};
                                        $property_found = 1;
                                        last;
                                    }
                                }
                                if (not $property_found) {
                                    if ((not exists $modes->{dependencies}) or
                                        (not defined $modes->{dependencies}) or
                                        ($modes->{dependencies} ne 'ON')) {
                                        die 'ERROR ECOGEASCP31 #0, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Variable retrieval, dependencies disabled, can not verify validity of OO property ' . $number_or_string_literal . ' in user-defined class ' . $types->[$i] . ', dying' . "\n";
                                    }
                                    else {
                                        die 'ERROR ECOGEASCP32 #0, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Variable retrieval, can not retrieve invalid OO property ' . $number_or_string_literal . ' in user-defined class ' . $types->[$i] . ', dying' . "\n";
                                    }
                                }
                            }
                        }
                        else {
                            my string $subexpression_generated = ($subexpression->ast_to_cpp__generate__CPPOPS_CPPTYPES( $modes ))->{CPP};
                            die 'ERROR ECOGEASCP33, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Variable retrieval, can not determine OO property name (and thus type) from non-literal subexpression...' . "\n" . $subexpression_generated . "\n" . '...in user-defined class ' . $types->[$i] . ', dying' . "\n";
                        }
                    }
                    elsif ( ( ref $variable_retrieval ) eq 'VariableRetrieval_194' ) {        # VariableRetrieval -> OP02_HASH_THINARROW WORD '}'
                        if ((substr $types->[$i], -2, 2) ne '::') { $types->[$i] .= '::'; }  # _properties in _symbol_table are keyed by class/package names ending in ::
                        my string $word = $variable_retrieval->{children}->[1];
#                        RPerl::diag( 'in Variable->ast_to_cpp__generate__CPPOPS_CPPTYPES() #1, for loop $i = ' . $i . ', have $word = ' . $word . "\n" );
#                        RPerl::diag( 'in Variable->ast_to_cpp__generate__CPPOPS_CPPTYPES() #1, for loop $i = ' . $i . ', have $types->[$i] = ' . $types->[$i] . "\n" );
#                        RPerl::diag( 'in Variable->ast_to_cpp__generate__CPPOPS_CPPTYPES() #1, for loop $i = ' . $i . ', have $modes->{_symbol_table} = ' . Dumper($modes->{_symbol_table}) . "\n" );
#                        RPerl::diag( 'in Variable->ast_to_cpp__generate__CPPOPS_CPPTYPES() #1, for loop $i = ' . $i . ', have $modes->{_symbol_table}->{ $types->[$i] } = ' . $modes->{_symbol_table}->{ $types->[$i] } . "\n" );
#                        RPerl::diag( 'in Variable->ast_to_cpp__generate__CPPOPS_CPPTYPES() #1, for loop $i = ' . $i . ', have $modes->{_symbol_table}->{ $types->[$i] }->{_properties} = ' . $modes->{_symbol_table}->{ $types->[$i] }->{_properties} . "\n" );

                        # check if OO property exists in self class or parent class
                        if ( exists $modes->{_symbol_table}->{ $types->[$i] }->{_properties}->{$word} ) {
                            $types->[ $i + 1 ] = $modes->{_symbol_table}->{ $types->[$i] }->{_properties}->{$word}->{type};
                        }
                        else {
                            my $parent_package_names = RPerl::CompileUnit::Module::Class::parent_and_grandparent_package_names(substr $types->[$i], 0, -2);
#                            RPerl::diag( 'in Variable->ast_to_cpp__generate__CPPOPS_CPPTYPES(), for loop $i = ' . $i . ', have $parent_package_names = ' . Dumper($parent_package_names) . "\n" );
                            my boolean $property_found = 0;
                            foreach my $parent_package_name (@{$parent_package_names}) {
#                                RPerl::diag( 'in Variable->ast_to_cpp__generate__CPPOPS_CPPTYPES(), for loop $i = ' . $i . ', have $parent_package_name = ' . $parent_package_name . "\n" );
#                                RPerl::diag( 'in Variable->ast_to_cpp__generate__CPPOPS_CPPTYPES(), for loop $i = ' . $i . ', have $modes->{_symbol_table} = ' . Dumper($modes->{_symbol_table}) . "\n" );
                                if (exists $modes->{_symbol_table}->{ $parent_package_name . q{::} }->{_properties}->{$word}) {
                                    $types->[ $i + 1 ] = $modes->{_symbol_table}->{ $parent_package_name . q{::} }->{_properties}->{$word}->{type};
                                    $property_found = 1;
                                    last;
                                }
                            }
                            if (not $property_found) {
                                if ((not exists $modes->{dependencies}) or
                                    (not defined $modes->{dependencies}) or
                                    ($modes->{dependencies} ne 'ON')) {
                                    die 'ERROR ECOGEASCP31 #1, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Variable retrieval, dependencies disabled, can not verify validity of OO property ' . $word . ' in user-defined class ' . $types->[$i] . ', dying' . "\n";
                                }
                                else {
                                    die 'ERROR ECOGEASCP31 #2, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Variable retrieval, can not retrieve invalid OO property ' . $word . ' in user-defined class ' . $types->[$i] . ', dying' . "\n";
                                }
                            }
                        }
                    }
                    else {
                        die 'ERROR ECOGEASCP34, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Variable retrieval, can not use arrayref retrieval on object of user-defined class ' . $types->[$i] . ', dying' . "\n";
                    }
                }
            }
        }
    }
    else {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule '
                . ($self_class)
                . ' found where SubExpression_152, VariableOrLiteral_241, VarOrLitOrOpStrOrWord_243, or Variable_191 expected, dying' )
            . "\n";
    }
    return $cpp_source_group;
}

1;    # end of class
