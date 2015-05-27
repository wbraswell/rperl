# [[[ HEADER ]]]
package RPerl::DataStructure::Hash::Reference;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::DataType::Modifier::Reference);
use RPerl::DataType::Modifier::Reference;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names

# [[[ INCLUDES ]]]
# DEV NOTE: must pre-declare string_hashref_method and object types here, because this file appears on a lower line number in rperltypes.pm
#require RPerl::CodeBlock::Subroutine::Method;
package string_hashref_method;

#require RPerl::Object;
package object;

package RPerl::DataStructure::Hash::Reference;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS & SUBROUTINES ]]]

our string_hashref_method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };

#    RPerl::diag( 'in Hash::Reference->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    # unwrap HashReference_200 & HashReference_201 from SubExpression_135
    if ( ref $self eq 'SubExpression_135' ) {
        $self = $self->{children}->[0];
    }

    if (    ( ref $self ne 'HashReference_200' )
        and ( ref $self ne 'HashReference_201' ) )
    {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECVGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule '
                . ( ref $self )
                . ' found where HashReference_200 or HashReference_201 expected, dying'
        ) . "\n";
    }

    if ( ref $self eq 'HashReference_201' ) {
        my string $left_brace  = $self->{children}->[0];
        my string $right_brace = $self->{children}->[1];
        $rperl_source_group->{PMC} .= $left_brace . $right_brace;
        return $rperl_source_group;
    }
    else {
        my string $left_brace        = $self->{children}->[0];
        my object $hash_entry        = $self->{children}->[1];
        my object $star_hash_entries = $self->{children}->[2];
        my string $right_brace       = $self->{children}->[3];

        $rperl_source_group->{PMC} .= $left_brace;
        my string_hashref $rperl_source_subgroup
            = $hash_entry->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );

        foreach my $star_hash_entry ( @{ $star_hash_entries->{children} } ) {
            if ( ref $star_hash_entry eq 'TERMINAL' ) {
                if ( $star_hash_entry->{attr} ne q{,} ) {
                    die RPerl::Parser::rperl_rule__replace(
                        q{ERROR ECVGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule '}
                            . $star_hash_entry->{attr}
                            . q{' found where OP21_LIST_COMMA ',' expected, dying}
                    ) . "\n";
                }
                $rperl_source_group->{PMC}
                    .= $star_hash_entry->{attr} . q{ };    # OP21_LIST_COMMA
            }
            else {
                $rperl_source_subgroup
                    = $star_hash_entry->ast_to_rperl__generate($modes);
                RPerl::Generator::source_group_append( $rperl_source_group,
                    $rperl_source_subgroup );
            }
        }

        $rperl_source_group->{PMC} .= $right_brace;
        return $rperl_source_group;
    }
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = {
        CPP => q{// <<< RP::DS::A::R __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n"
        };

    #...
    return $cpp_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = {
        CPP => q{// <<< RP::DS::A::R __DUMMY_SOURCE_CODE CPPOPS_CPPTYPES >>>}
            . "\n"
        };

    #...
    return $cpp_source_group;
};

1;    # end of class
