# [[[ HEADER ]]]
package RPerl::Test;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.002_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);
use RPerl::CompileUnit::Module::Class;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values and print operator
## no critic qw(ProhibitConstantPragma)  # USER DEFAULT 3: allow constants

# [[[ OO CLASS PROPERTIES ]]]
our %properties_class = ( ## no critic qw(ProhibitPackageVars)  # USER DEFAULT 2: allow OO properties
    modes => my hash_ref__array_ref $TYPED_modes = [
        { index => 0, ops => 'PERL', types => 'PERL' },
        { index => 1, ops => 'CPP',  types => 'PERL' },
        { index => 2, ops => 'CPP',  types => 'CPP' }
    ]
);

# [[[ OO METHODS ]]]

# OO INHERITANCE TESTING
our void__method $empty_method = sub {
    ( my object $self ) = @_;
    2;
};

# [[[ SUBROUTINES ]]]

#my string $id = sub {  # NEED FIX: RPerl subroutines disabled here
sub id {
    ( my scalar__hash_ref $mode ) = @_;
    return $mode->{ops} . 'OPS_' . $mode->{types} . 'TYPES';
}

#my string $description = sub {
sub description {
    ( my scalar__hash_ref $mode ) = @_;
    return $mode->{ops} . ' operations and ' . $mode->{types} . ' data types';
}

#my void $enable = sub {
sub enable {
    ( my scalar__hash_ref $mode ) = @_;
    if ( $mode->{ops} eq 'CPP' ) {
        rperltypes::types_enable( $mode->{types} );
    }
}

1;                  # end of class
