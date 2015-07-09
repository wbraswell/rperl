## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names
package  # hide from PAUSE indexing
    rperlnamespaces;
use strict;
use warnings;
use rperlnamespaces_generated;
our $VERSION = 0.001_010;

use Data::Dumper;

sub array {
    my $namespaces = [];
    for my $name ( sort keys %main:: ) {
        my $glob = $main::{$name};
        if ( %{$glob} ) {
            push @{$namespaces}, $name;
        }
    }
    return $namespaces;
}

sub hash {
    my $namespaces = {};
    for my $name ( sort keys %main:: ) {
        my $glob = $main::{$name};
        if ( %{$glob} ) {
            $namespaces->{$name} = 1;
        }
    }
    return $namespaces;
}

sub hash_noncore {
#    print 'in hash_noncore(), have $rperlnamespaces_generated::CORE = ' . Dumper($rperlnamespaces_generated::CORE) . "\n";
    my $namespaces = {};
    for my $name ( sort keys %main:: ) {
        my $glob = $main::{$name};
        if ( %{$glob}
            and ( not exists $rperlnamespaces_generated::CORE->{$name} ) )
        {
            $namespaces->{$name} = 1;
        }
    }
    return $namespaces;
}

sub hash_noncore_nonrperl {
#    print 'in hash_noncore(), have $rperlnamespaces_generated::CORE = ' . Dumper($rperlnamespaces_generated::CORE) . "\n";
    my $namespaces = {};
    for my $name ( sort keys %main:: ) {
        my $glob = $main::{$name};
        if (    %{$glob}
            and ( not exists $rperlnamespaces_generated::CORE->{$name} )
            and ( not exists $rperlnamespaces_generated::RPERL->{$name} ) )
        {
            $namespaces->{$name} = 1;
        }
    }
    return $namespaces;
}

1;