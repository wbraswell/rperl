# [[[ HEADER ]]]
package RPerl::Test::Modes;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# START HERE: fix this file, paste contents into github fork of dk's fork of main rperl to eventually get it back into this file
# START HERE: fix this file, paste contents into github fork of dk's fork of main rperl to eventually get it back into this file
# START HERE: fix this file, paste contents into github fork of dk's fork of main rperl to eventually get it back into this file


use base qw(Exporter);
our @EXPORT = qw(testmodes);

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
