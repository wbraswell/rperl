# [[[ HEADER ]]]
package RPerl::CodeBlock::Subroutine::Method::Arguments;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_001;

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
    my object $arguments_star          = $self->{children}->[2];
    my string $rparen                  = $self->{children}->[3];
    my string $equal                   = $self->{children}->[4];
    my string $at_underscore_semicolon = $self->{children}->[5];

    $rperl_source_group->{PMC} .= $lparen_my . q{ } . $object_self;

    # (OP21_LIST_COMMA MY Type VARIABLE_SYMBOL)*
    # NEED FIX: destructive to AST!!!
    while ( exists $arguments_star->{children}->[0] ) {
        my object $comma = shift @{ $arguments_star->{children} };
        my object $my    = shift @{ $arguments_star->{children} };
        my object $type  = shift @{ $arguments_star->{children} };
        my object $name  = shift @{ $arguments_star->{children} };
        $rperl_source_group->{PMC}
            .= $comma->{attr} . q{ }
            . $my->{attr} . q{ }
            . $type->{children}->[0] . q{ }
            . $name->{attr};
    }

    $rperl_source_group->{PMC} .= q{ } . $rparen . q{ } . $equal . q{ } . $at_underscore_semicolon . "\n";
    return $rperl_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = { CPP =>
              q{// <<< RP::CB::S::M::A __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = { CPP =>
              q{// <<< RP::CB::S::M::A __DUMMY_SOURCE_CODE CPPOPS_CPPTYPES >>>}
            . "\n" };

    #...
    return $cpp_source_group;
};

1;    # end of class
