# [[[ TEST : 'ERROR ECVPARP00' ]]]
# [[[ TEST : 'Unexpected token:  ##' ]]]
# [[[ HEADER ]]]
package RPerl::Test::Critic::Package_00_Bad_01;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## n critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values and print operator

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub { 2; };

1;                  # end of class
