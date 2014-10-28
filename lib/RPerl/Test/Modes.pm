# [[[ HEADER ]]]
package RPerl::Test::Modes;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_001;

# [[[ INCLUDES ]]]
use base qw(Exporter);
our @EXPORT = qw(testmodes);

# START HERE: convert to Class
# START HERE: convert to Class
# START HERE: convert to Class

# [[[ OO CLASS PROPERTIES ]]]
our %properties_class = ( ## no critic qw(ProhibitPackageVars)  # USER DEFAULT 2: allow OO properties
    name => my string $KEY_name = 'return',
};

sub testmodes {
    map { bless $_ } (
        { index => 0, ops => 'PERL', types => 'PERL' },
        { index => 1, ops => 'CPP',  types => 'PERL' },
        { index => 2, ops => 'CPP',  types => 'CPP' },
    );
}

sub index { shift->{index} }
sub ops   { shift->{ops} }
sub types { shift->{types} }

sub id {
    my $self = shift;
    return $self->{ops} . "OPS_" . $self->{types} . "TYPES";
}

sub description {
    my $self = shift;
    return "$self->{ops} operations and $self->{types} data types";
}

sub enable {
    my $self = shift;
    rperltypes::types_enable( $self->{types} ) if $self->{ops} eq 'CPP';
}

1;
