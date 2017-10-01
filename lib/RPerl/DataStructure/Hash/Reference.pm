# [[[ HEADER ]]]
package RPerl::DataStructure::Hash::Reference;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.003_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::DataType::Modifier::Reference);
use RPerl::DataType::Modifier::Reference;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names

# [[[ INCLUDES ]]]
# DEV NOTE: must pre-declare string_hashref::method and object types here, because this file appears on a lower line number in rperltypes.pm
#require RPerl::CodeBlock::Subroutine::Method;
package  # hide from PAUSE indexing
    string_hashref::method;
use strict;
use warnings;

#require RPerl::Object;
package  # hide from PAUSE indexing
    object;
use strict;
use warnings;

package RPerl::DataStructure::Hash::Reference;
use strict;
use warnings;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

sub ast_to_rperl__generate {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };

#    RPerl::diag( 'in Hash::Reference->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;

    # unwrap HashReference_213 & HashReference_214 from SubExpression_143
    if ( $self_class eq 'SubExpression_143' ) {
        $self = $self->{children}->[0];
        $self_class = ref $self;
    }

    if ( $self_class eq 'HashReference_213' ) { # HashReference -> LBRACE HashEntry STAR-50 '}'
        my string $left_brace        = $self->{children}->[0];
        my object $hash_entry        = $self->{children}->[1];
        my object $hash_entries_star = $self->{children}->[2];
        my string $right_brace       = $self->{children}->[3];

        $rperl_source_group->{PMC} .= $left_brace;
        my string_hashref $rperl_source_subgroup
            = $hash_entry->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );

        foreach my $hash_entry_star ( @{ $hash_entries_star->{children} } ) {
            if ( ref $hash_entry_star eq 'TERMINAL' ) {
                if ( $hash_entry_star->{attr} ne q{,} ) {
                    die RPerl::Parser::rperl_rule__replace(
                        q{ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '}
                            . $hash_entry_star->{attr}
                            . q{' found where OP21_LIST_COMMA ',' expected, dying}
                    ) . "\n";
                }
                $rperl_source_group->{PMC}
                    .= $hash_entry_star->{attr} . q{ };    # OP21_LIST_COMMA
            }
            else {
                $rperl_source_subgroup
                    = $hash_entry_star->ast_to_rperl__generate($modes);
                RPerl::Generator::source_group_append( $rperl_source_group,
                    $rperl_source_subgroup );
            }
        }

        $rperl_source_group->{PMC} .= $right_brace;
    }
    elsif ( $self_class eq 'HashReference_214' ) { # HashReference -> LBRACE '}'
        my string $left_brace  = $self->{children}->[0];
        my string $right_brace = $self->{children}->[1];
        $rperl_source_group->{PMC} .= $left_brace . $right_brace;
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '
                . ($self_class)
                . ' found where HashReference_213, HashReference_214, or SubExpression_143 expected, dying'
        ) . "\n";
    }
    return $rperl_source_group;
}

sub ast_to_cpp__generate__CPPOPS_PERLTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = {
        CPP => q{// <<< RP::DS::H::R __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n"
        };

    #...
    return $cpp_source_group;
}

sub ast_to_cpp__generate__CPPOPS_CPPTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{} };

#    RPerl::diag( 'in Hash::Reference->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;

    # unwrap HashReference_213 & HashReference_214 from SubExpression_143
    if ( $self_class eq 'SubExpression_143' ) {
        $self = $self->{children}->[0];
        $self_class = ref $self;
    }

    if ( $self_class eq 'HashReference_213' ) { # HashReference -> LBRACE HashEntry STAR-50 '}'
        my object $hash_entry        = $self->{children}->[1];
        my object $hash_entries_star = $self->{children}->[2];

        $cpp_source_group->{CPP} .= '{ ';
        my string_hashref $cpp_source_subgroup
            = $hash_entry->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
        RPerl::Generator::source_group_append( $cpp_source_group,
            $cpp_source_subgroup );

        foreach my $hash_entry_star ( @{ $hash_entries_star->{children} } ) {
            if ( ref $hash_entry_star eq 'TERMINAL' ) {
                if ( $hash_entry_star->{attr} ne q{,} ) {
                    die RPerl::Parser::rperl_rule__replace(
                        q{ERROR ECOGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule '}
                            . $hash_entry_star->{attr}
                            . q{' found where OP21_LIST_COMMA ',' expected, dying}
                    ) . "\n";
                }
                $cpp_source_group->{CPP}
                    .= $hash_entry_star->{attr} . q{ };    # OP21_LIST_COMMA
            }
            else {
                $cpp_source_subgroup
                    = $hash_entry_star->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
                RPerl::Generator::source_group_append( $cpp_source_group,
                    $cpp_source_subgroup );
            }
        }

        $cpp_source_group->{CPP} .= ' }';
    }
    elsif ( $self_class eq 'HashReference_214' ) { # HashReference -> LBRACE '}'
        $cpp_source_group->{CPP} .= '{}';
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule '
                . ($self_class)
                . ' found where HashReference_213, HashReference_214, or SubExpression_143 expected, dying'
        ) . "\n";
    }
    return $cpp_source_group;
}

1;    # end of class
