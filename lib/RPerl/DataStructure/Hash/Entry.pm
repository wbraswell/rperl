# [[[ HEADER ]]]
package RPerl::DataStructure::Hash::Entry;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use RPerl::GrammarRule;
use parent qw(RPerl::GrammarRule);

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS & SUBROUTINES ]]]

our string_hashref_method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };
    my string_hashref $rperl_source_subgroup;

    RPerl::diag(
        'in Hash::Entry->ast_to_rperl__generate(), received $self = ' . "\n"
            . RPerl::Parser::rperl_ast__dump($self)
            . "\n" );

    my string $key                 = $self->{children}->[0];
    my string $key_class           = ref $key;
    my string $fat_arrow           = $self->{children}->[1];
    my object $type_inner_optional = $self->{children}->[2];

    if (   ( $key_class eq 'VariableOrLiteralOrWord_215' )
        or ( $key_class eq 'VariableOrLiteralOrWord_216' ) )
    {    # Variable or Literal
        $rperl_source_subgroup = $key->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );
    }
    elsif ( $key_class eq 'VariableOrLiteralOrWord_217' ) {    # WORD
        $rperl_source_group->{PMC} .= $key->{children}->[0] . q{ };
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            q{ERROR ECVGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule '}
                . ($key_class)
                . q{' found where VariableOrLiteralOrWord_215, VariableOrLiteralOrWord_216, or VariableOrLiteralOrWord_217 expected, dying}
        ) . "\n";
    }

    $rperl_source_group->{PMC} .= $fat_arrow . q{ };

    if ( exists $type_inner_optional->{children}->[0] ) {
        $rperl_source_subgroup = $type_inner_optional->{children}->[0]->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
    }

    my object $subexpression = $self->{children}->[3];

    $rperl_source_subgroup = $subexpression->ast_to_rperl__generate($modes);
    RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );

    return $rperl_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = { CPP =>
              q{// <<< RP::DS::H::ET __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = {
        CPP => q{// <<< RP::DS::H::ET __DUMMY_SOURCE_CODE CPPOPS_CPPTYPES >>>}
            . "\n"
        };

    #...
    return $cpp_source_group;
};

1;    # end of class
