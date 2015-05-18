# [[[ HEADER ]]]
package RPerl::Operation::Statement;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.000_012;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation);
use RPerl::Operation;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

# [[[ INCLUDES ]]]
use Scalar::Util 'blessed';

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS ]]]

our string_hashref_method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{# <<< RP::O::S DUMMY PERLOPS_PERLTYPES SOURCE CODE >>>} . "\n" };

    RPerl::diag( 'in Statement->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

# START HERE: implement Statement
# START HERE: implement Statement
# START HERE: implement Statement

=DISABLE
    my string_hashref $rperl_source_subgroup;

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

    $rperl_source_group->{PMC}
        .= $rparen . q{ } . $equal . q{ } . $at_underscore_semicolon;
=cut

    return $rperl_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = { CPP =>
              q{// <<< RP::O::S DUMMY CPPOPS_PERLTYPES SOURCE CODE >>>}
            . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = { CPP =>
              q{// <<< RP::O::S DUMMY CPPOPS_PERLTYPES SOURCE CODE >>>}
            . "\n" };

    #...
    return $cpp_source_group;
};

1;    # end of class
