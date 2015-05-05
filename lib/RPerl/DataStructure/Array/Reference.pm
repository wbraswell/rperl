# [[[ HEADER ]]]
package RPerl::DataStructure::Array::Reference;
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

package RPerl::DataStructure::Array::Reference;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS ]]]

our string_hashref_method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };

#    RPerl::diag( 'in Array::Reference->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    if ( ref $self eq 'SubExpression_130' ) {
        $self = $self->{children}->[0];
    }

    if ( ref $self ne 'ArrayReference_182' ) {
        croak
            'ERROR ECVGEAS00, Code Generator, Abstract Syntax to RPerl, token'
            . ( ref $self )
            . 'found where ArrayReference_182 expected, croaking';
    }

    my string $left_bracket           = $self->{children}->[0];
    my object $optional_list_elements = $self->{children}->[1];
    my string $right_bracket          = $self->{children}->[2];

    $rperl_source_group->{PMC} .= $left_bracket;

    if ( exists $optional_list_elements->{children}->[0] ) {
        my string_hashref $rperl_source_subgroup
            = $optional_list_elements->{children}->[0]
            ->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );
    }

    $rperl_source_group->{PMC} .= $right_bracket;

    return $rperl_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = { CPP => q{<<< RP::DS::A::R DUMMY CPPOPS_PERLTYPES SOURCE CODE >>>}
            . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = { CPP => q{<<< RP::DS::A::R DUMMY CPPOPS_PERLTYPES SOURCE CODE >>>}
            . "\n" };

    #...
    return $cpp_source_group;
};

1;    # end of class
