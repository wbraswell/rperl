use RPerl;
package RPerl::Test::Bar;
use strict;
use warnings;
our $VERSION = 0.001_000;

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

our void $empty_sub = sub {
    print 'I am empty.' . "\n";
};

1;  # end of package
