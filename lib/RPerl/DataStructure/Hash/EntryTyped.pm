# [[[ HEADER ]]]
package RPerl::DataStructure::Hash::EntryTyped;
use strict;
use warnings;
use RPerl::AfterSubclass;
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

our string_hashref::method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };

    #    RPerl::diag( 'in Hash::EntryTyped->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $key           = $self->{children}->[0];
    my string $fat_arrow     = $self->{children}->[1];
    my object $type_inner    = $self->{children}->[2];
    my object $subexpression = $self->{children}->[3];

    my string $type_inner_name = $type_inner->{children}->[3];
    if ( $key ne $type_inner_name ) {
        die 'ERROR ECVGEASRP17, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: redundant name mismatch, OO properties or hash key '
            . $key . ' is different than inner type name ' . $type_inner_name . ', dying' . "\n";
    }

    $rperl_source_group->{PMC} .= $key . q{ } . $fat_arrow . q{ };

    my string_hashref $rperl_source_subgroup = $type_inner->ast_to_rperl__generate($modes);
    RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );

    $rperl_source_group->{PMC} .= q{ };
    $rperl_source_subgroup = $subexpression->ast_to_rperl__generate($modes);
    RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );

    return $rperl_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{// <<< RP::DS::H::ET __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{// <<< RP::DS::H::ET __DUMMY_SOURCE_CODE CPPOPS_CPPTYPES >>>} . "\n" };

    #...
    return $cpp_source_group;
};

1;    # end of class
