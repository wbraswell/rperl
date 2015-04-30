# [[[ HEADER ]]]
package RPerl::Test;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.002_001;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);
use RPerl::CompileUnit::Module::Class;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

# [[[ OO METHODS ]]]

# OO INHERITANCE TESTING
our void_method $empty_method = sub {
    ( my object $self ) = @_;
    2;
};

# [[[ SUBROUTINES ]]]

# NEED UPDATE: move below code to lib/RPerl/Modes.pm & correlate to $RPerl::MODES in lib/RPerl/Config.pm

#my string $mode_tagline = sub {  # NEED FIX: RPerl subroutines disabled here
sub mode_tagline {
    ( my scalartype_hashref $mode ) = @_;
    return $mode->{ops} . 'OPS_' . $mode->{types} . 'TYPES';
}

#my string $mode_description = sub {
sub mode_description {
    ( my scalartype_hashref $mode ) = @_;
    return $mode->{ops} . ' operations and ' . $mode->{types} . ' data types';
}

#my void $mode_enable = sub {
sub mode_enable {
    ( my scalartype_hashref $mode ) = @_;
    if ( $mode->{ops} eq 'CPP' ) {
        rperltypes::types_enable( $mode->{types} );
    }
}

1;                  # end of class
