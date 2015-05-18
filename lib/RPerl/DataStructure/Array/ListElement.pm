# [[[ HEADER ]]]
package RPerl::DataStructure::Array::ListElement;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.000_100;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::GrammarRule);
use RPerl::GrammarRule;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS ]]]

our string_hashref_method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };

#    RPerl::diag( 'in Array::ListElement->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    if ( ref $self eq 'ListElement_177' ) {
        my string_hashref $rperl_source_subgroup
            = $self->{children}->[0]->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );
    }
    elsif ( ref $self eq 'ListElement_178' ) {
        my object $type_inner    = $self->{children}->[0];
        my string $type_inner_my = $type_inner->{children}->[0];
        my string $type_inner_type
            = $type_inner->{children}->[1]->{children}->[0];
        my string $type_inner_TYPED = $type_inner->{children}->[2];
        my string $type_inner_name  = $type_inner->{children}->[3];
        my string $type_inner_equal = $type_inner->{children}->[4];

        $rperl_source_group->{PMC}
            . $type_inner_my . q{ }
            . $type_inner_type . q{ }
            . $type_inner_TYPED
            . $type_inner_name . q{ }
            . $type_inner_equal . q{ };

        my string_hashref $rperl_source_subgroup
            = $self->{children}->[1]->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );
    }
    elsif ( ref $self eq 'ListElement_179' ) {
        my string $qw            = $self->{children}->[0];
        my string $element_names = q{};
        my object $elements      = $self->{children}->[1];

        foreach my object $element ( @{ $elements->{children} } ) {
#            RPerl::diag( 'in Array::ListElement->ast_to_rperl__generate(), have $element = ' . "\n" . RPerl::Parser::rperl_ast__dump($element) . "\n" );
            my string $element_name = $element->{attr};
            if ( $element_names ne q{} ) {
                $element_names .= q{ };
            }
            $element_names .= $element_name;
        }

        my string $right_parenthesis = $self->{children}->[2];

        $rperl_source_group->{PMC}
            .= $qw . $element_names . $right_parenthesis . "\n";
    }
    return $rperl_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = { CPP => q{// <<< RP::DS::A::LE DUMMY CPPOPS_PERLTYPES SOURCE CODE >>>}
            . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = { CPP => q{// <<< RP::DS::A::LE DUMMY CPPOPS_PERLTYPES SOURCE CODE >>>}
            . "\n" };

    #...
    return $cpp_source_group;
};

1;    # end of class
