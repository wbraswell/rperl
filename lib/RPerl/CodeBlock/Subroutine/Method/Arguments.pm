# [[[ HEADER ]]]
package RPerl::CodeBlock::Subroutine::Method::Arguments;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CodeBlock::Subroutine::Arguments);
use RPerl::CodeBlock::Subroutine::Arguments;

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

#    RPerl::diag( 'in Method::Arguments->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $lparen_my               = $self->{children}->[0];
    my string $object_self             = $self->{children}->[1];
    my object $star_arguments          = $self->{children}->[2];
    my string $rparen                  = $self->{children}->[3];
    my string $equal                   = $self->{children}->[4];
    my string $at_underscore_semicolon = $self->{children}->[5];

    $rperl_source_group->{PMC} .= $lparen_my . q{ } . $object_self;

    while ( exists $star_arguments->{children}->[0] ) {
        my object $comma = shift @{ $star_arguments->{children} };
        my object $my    = shift @{ $star_arguments->{children} };
        my object $type  = shift @{ $star_arguments->{children} };
        my object $name  = shift @{ $star_arguments->{children} };
        $rperl_source_group->{PMC}
            .= $comma->{attr} . q{ }
            . $my->{attr} . q{ }
            . $type->{children}->[0] . q{ }
            . $name->{attr};
    }

    $rperl_source_group->{PMC} .= $rparen . q{ } . $equal . q{ } . $at_underscore_semicolon . "\n";
    return $rperl_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = { CPP =>
              q{// <<< RP::CB::S::M::A DUMMY CPPOPS_PERLTYPES SOURCE CODE >>>}
            . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = { CPP =>
              q{// <<< RP::CB::S::M::A DUMMY CPPOPS_PERLTYPES SOURCE CODE >>>}
            . "\n" };

    #...
    return $cpp_source_group;
};

1;    # end of class
