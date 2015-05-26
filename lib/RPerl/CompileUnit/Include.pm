# [[[ HEADER ]]]
package RPerl::CompileUnit::Include;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::GrammarRule);
use RPerl::GrammarRule;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoInclude ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS & SUBROUTINES ]]]

our string_hashref_method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };

#    RPerl::diag( 'in Include->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

#    RPerl::diag( 'in Include->ast_to_rperl__generate(), have ref $self = ' . (ref $self) . "\n" );
#    RPerl::diag( 'in Include->ast_to_rperl__generate(), have $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
    if ( ref $self eq 'Include_39' ) {
        my string $use_keyword = $self->{children}->[0];
        my string $parent_name
            = $self->{children}->[1]->{children}->[0];
        my string $semicolon = $self->{children}->[2];
        $rperl_source_group->{PMC}
            .= $use_keyword . q{ } . $parent_name . $semicolon . "\n";

#        RPerl::diag( 'in Include->ast_to_rperl__generate(), have $parent_name = '  . $parent_name . "\n" );
    }
    else {    # Include_40
        my string $use_keyword = $self->{children}->[0];
        my string $parent_name
            = $self->{children}->[1]->{children}->[0];
        my string $qw            = $self->{children}->[2];
        my string $element_names = q{};
        my object $elements      = $self->{children}->[3];

#        RPerl::diag( 'in Include->ast_to_rperl__generate(), have $elements = ' . "\n" . RPerl::Parser::rperl_ast__dump($elements) . "\n" );
        foreach my object $element ( @{ $elements->{children} } ) {

#            RPerl::diag( 'in Include->ast_to_rperl__generate(), have $element = ' . "\n" . RPerl::Parser::rperl_ast__dump($element) . "\n" );
            my string $element_name = $element->{attr};
            if ( $element_names ne q{} ) {
                $element_names .= q{ };
            }
            $element_names .= $element_name;
        }
        my string $right_parenthesis = $self->{children}->[4];
        my string $semicolon         = $self->{children}->[5];
        $rperl_source_group->{PMC}
            .= $use_keyword . q{ }
            . $parent_name . q{ }
            . $qw
            . $element_names
            . $right_parenthesis
            . $semicolon . "\n";
    }

    return $rperl_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = { CPP => q{// <<< RP::CU::I DUMMY SOURCE CODE CPPOPS_PERLTYPES >>>}
            . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = { CPP => q{// <<< RP::CU::I DUMMY SOURCE CODE CPPOPS_CPPTYPES >>>}
            . "\n" };

    #...
    return $cpp_source_group;
};

1;    # end of class
