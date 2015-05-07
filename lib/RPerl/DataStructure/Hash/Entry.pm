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

# [[[ OO METHODS ]]]

our string_hashref_method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };

    RPerl::diag(
        'in Hash::Entry->ast_to_rperl__generate(), received $self = ' . "\n"
            . RPerl::Parser::rperl_ast__dump($self)
            . "\n" );

    my string $key                 = $self->{children}->[0];
    my string $fat_arrow           = $self->{children}->[1];
    my object $optional_type_inner = $self->{children}->[2];

    $rperl_source_group->{PMC} .= $key . q{ } . $fat_arrow . q{ };

    if ( exists $optional_type_inner->{children}->[0] ) {
        my string $optional_type_inner_my
            = $optional_type_inner->{children}->[0];
        my string $optional_type_inner_type
            = $optional_type_inner->{children}->[1]->{children}->[0];
        my string $optional_type_inner_TYPED
            = $optional_type_inner->{children}->[2];
        my string $optional_type_inner_name
            = $optional_type_inner->{children}->[3];
        my string $optional_type_inner_equal
            = $optional_type_inner->{children}->[4];

        $rperl_source_group->{PMC} .= $optional_type_inner_my . q{ }
            . $optional_type_inner_type . q{ }
            . $optional_type_inner_TYPED
            . $optional_type_inner_name . q{ }
            . $optional_type_inner_equal . q{ };
    }

    my object $subexpression = $self->{children}->[3];

    my string_hashref $rperl_source_subgroup
        = $subexpression->ast_to_rperl__generate($modes);
    RPerl::Generator::source_group_append( $rperl_source_group,
        $rperl_source_subgroup );

    return $rperl_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = { CPP => q{<<< RP::DS::H::ET DUMMY CPPOPS_PERLTYPES SOURCE CODE >>>}
            . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = { CPP => q{<<< RP::DS::H::ET DUMMY CPPOPS_PERLTYPES SOURCE CODE >>>}
            . "\n" };

    #...
    return $cpp_source_group;
};

1;    # end of class
