# [[[ HEADER ]]]
package RPerl::Operation::Expression::SubExpression::Variable::Retrieval;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.004_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Expression::SubExpression);
use RPerl::Operation::Expression::SubExpression;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS & SUBROUTINES ]]]

our string_hashref::method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };

    #    RPerl::diag( 'in Variable::Retrieval->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;
    if ( $self_class eq 'VariableRetrieval_177' ) {    # VariableRetrieval -> OP02_ARRAY_THINARROW SubExpression ']'
        my string $arrow_left_bracket = $self->{children}->[0];
        my object $subexpression      = $self->{children}->[1];
        my string $right_bracket      = $self->{children}->[2];

        $rperl_source_group->{PMC} .= $arrow_left_bracket . q{ };
        my string_hashref $rperl_source_subgroup = $subexpression->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= q{ } . $right_bracket;
    }
    elsif ( $self_class eq 'VariableRetrieval_178' ) {    # VariableRetrieval -> OP02_HASH_THINARROW SubExpression '}'
        my string $arrow_left_brace = $self->{children}->[0];
        my object $subexpression    = $self->{children}->[1];
        my string $right_brace      = $self->{children}->[2];

        $rperl_source_group->{PMC} .= $arrow_left_brace . q{ };
        my string_hashref $rperl_source_subgroup = $subexpression->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= q{ } . $right_brace;
    }
    elsif ( $self_class eq 'VariableRetrieval_179' ) {    # VariableRetrieval -> OP02_HASH_THINARROW WORD '}'
        my string $arrow_left_brace = $self->{children}->[0];
        my string $word             = $self->{children}->[1];
        my string $right_brace      = $self->{children}->[2];

        $rperl_source_group->{PMC} .= $arrow_left_brace . q{ } . $word . q{ } . $right_brace;
    }
    else {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule '
                . ($self_class)
                . ' found where VariableRetrieval_177, VariableRetrieval_177, or VariableRetrieval_177 expected, dying' )
            . "\n";
    }

    return $rperl_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{// <<< RP::O::E::SE::V::R __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string $variable_symbol, my string $base_type, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{} };

 #    RPerl::diag( 'in Variable::Retrieval->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;
    my string $subtype;
    if ( $self_class eq 'VariableRetrieval_177' ) {    # VariableRetrieval -> OP02_ARRAY_THINARROW SubExpression ']'
        my object $subexpression = $self->{children}->[1];
        if ( $base_type =~ /_arrayref$/ ) {            # array
            $subtype = substr $base_type, 0, ( ( length $base_type ) - 9 );          # strip trailing '_arrayref'
            if ( exists $rperlnamespaces_generated::RPERL->{ $subtype . '::' } ) {
                if ( $subtype eq 'arrayref' ) {                                      # arrayref of arrayrefs
                    die 'NEED TEST & IMPLEMENT!!!';
                }
                elsif ( $subtype eq 'hashref' ) {                                    # arrayref of hashrefs
                    die 'NEED TEST & IMPLEMENT!!!';
                }
                elsif ( $subtype =~ /sse_number_pair$/xms ) {                        # arrayref of SSE number pairs
                    die 'NEED TEST & IMPLEMENT!!!';
                }
                else {                                                               # arrayref of scalars
                    $cpp_source_group->{CPP} .= '[';
                    my string_hashref $cpp_source_subgroup = $subexpression->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
                    RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
                    $cpp_source_group->{CPP} .= ']';
                }
            }
            else {                                                                   # arrayref of user-defined data types (objects)
                $cpp_source_group->{CPP} .= '[';
                my string_hashref $cpp_source_subgroup = $subexpression->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
                RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
                $cpp_source_group->{CPP} .= ']';
            }
        }
        elsif ( $base_type eq 'sse_number_pair' ) {                                     # SSE 2-element array
            $cpp_source_group->{CPP} .= '[';
            my string_hashref $cpp_source_subgroup = $subexpression->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
            RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
            $cpp_source_group->{CPP} .= ']';
        }
        elsif ( $base_type =~ /_hashref$/ ) {                                        # hash
            die 'ERROR ECOGEASCP21, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Variable retrieval, can not use arrayref retrieval on hashref type ' . $base_type . ', dying' . "\n";
        }
        elsif ( exists $rperlnamespaces_generated::RPERL->{ $base_type . '::' } ) {    # scalar
            die 'ERROR ECOGEASCP21, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Variable retrieval, can not use arrayref retrieval on scalar type ' . $base_type . ', dying' . "\n";
        }
        else {                                                                         # user-defined type AKA class
            die 'ERROR ECOGEASCP21, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Variable retrieval, can not use arrayref retrieval on object of user-defined class ' . $base_type . ', dying' . "\n";
        }
    }
    elsif ( $self_class eq 'VariableRetrieval_178' ) {                                 # VariableRetrieval -> OP02_HASH_THINARROW SubExpression '}'
        my object $subexpression = $self->{children}->[1];
        if ( $base_type =~ /_arrayref$/ ) {                                            # array
            die 'ERROR ECOGEASCP21, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Variable retrieval, can not use hashref retrieval on arrayref type ' . $base_type . ', dying' . "\n";
        }
        elsif ( $base_type eq 'sse_number_pair' ) {
            die 'ERROR ECOGEASCP21, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Variable retrieval, can not use hashref retrieval on SSE type ' . $base_type . ', dying' . "\n";
        }
        elsif ( $base_type =~ /_hashref$/ ) {                                          # hash
            $subtype = substr $base_type, 0, ( ( length $base_type ) - 8 );            # strip trailing '_hashref'
            if ( exists $rperlnamespaces_generated::RPERL->{ $subtype . '::' } ) {
                if ( $subtype eq 'arrayref' ) {                                        # hashrefs of arrayrefs
                    die 'NEED TEST & IMPLEMENT!!!';
                }
                elsif ( $subtype eq 'hashref' ) {                                      # hashrefs of hashrefs
                    die 'NEED TEST & IMPLEMENT!!!';
                }
                elsif ( $subtype =~ /sse_number_pair$/xms ) {                          # hashref of SSE number pairs
                    die 'NEED TEST & IMPLEMENT!!!';
                }
                else {                                                                 # hashrefs of scalars
                    $cpp_source_group->{CPP} .= '[';
                    my string_hashref $cpp_source_subgroup = $subexpression->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
                    RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
                    $cpp_source_group->{CPP} .= ']';
                }
            }
            else {                                                                     # hashref of user-defined data types (objects)
                $cpp_source_group->{CPP} .= '[';
                my string_hashref $cpp_source_subgroup = $subexpression->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
                RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
                $cpp_source_group->{CPP} .= ']';
            }
        }
        elsif ( exists $rperlnamespaces_generated::RPERL->{ $base_type . '::' } ) {    # scalar
            die 'ERROR ECOGEASCP21, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Variable retrieval, can not use hashref retrieval on scalar type ' . $base_type . ', dying' . "\n";
        }
        else {                                                                         # user-defined type AKA class
            $cpp_source_group->{CPP} .= '->';
            my string_hashref $cpp_source_subgroup = $subexpression->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
            RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
        }
    }
    elsif ( $self_class eq 'VariableRetrieval_179' ) {                                 # VariableRetrieval -> OP02_HASH_THINARROW WORD '}'
        my string $word = $self->{children}->[1];

        if ( $base_type =~ /_arrayref$/ ) {                                            # array
            die 'ERROR ECOGEASCP21, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Variable retrieval, can not use hashref retrieval on arrayref type ' . $base_type . ', dying' . "\n";
        }
        elsif ( $base_type eq 'sse_number_pair' ) {
            die 'ERROR ECOGEASCP21, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Variable retrieval, can not use hashref retrieval on SSE type ' . $base_type . ', dying' . "\n";
        }
        elsif ( $base_type =~ /_hashref$/ ) {                                          # hash
            $subtype = substr $base_type, 0, ( ( length $base_type ) - 8 );            # strip trailing '_hashref'
            if ( exists $rperlnamespaces_generated::RPERL->{ $subtype . '::' } ) {
                if ( $subtype eq 'arrayref' ) {                                        # hashrefs of arrayrefs
                    die 'NEED TEST & IMPLEMENT!!!';
                }
                elsif ( $subtype eq 'hashref' ) {                                      # hashrefs of hashrefs
                    die 'NEED TEST & IMPLEMENT!!!';
                }
                elsif ( $subtype =~ /sse_number_pair$/xms ) {                          # hashref of SSE number pairs
                    die 'NEED TEST & IMPLEMENT!!!';
                }
                else {                                                                 # hashrefs of scalars
                    $cpp_source_group->{CPP} .= '[' . $word . ']';
                }
            }
            else {                                                                     # hashref of user-defined data types (objects)
                $cpp_source_group->{CPP} .= '[' . $word . ']';
            }
        }
        elsif ( exists $rperlnamespaces_generated::RPERL->{ $base_type . '::' } ) {    # scalar
            die 'ERROR ECOGEASCP21, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Variable retrieval, can not use hashref retrieval on scalar type ' . $base_type . ', dying' . "\n";
        }
        else {                                                                         # user-defined type AKA class
            $cpp_source_group->{CPP} .= '->' . $word;
        }

    }
    else {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: grammar rule '
                . ($self_class)
                . ' found where VariableRetrieval_177, VariableRetrieval_177, or VariableRetrieval_177 expected, dying' )
            . "\n";
    }

    return $cpp_source_group;
};

1;    # end of class
