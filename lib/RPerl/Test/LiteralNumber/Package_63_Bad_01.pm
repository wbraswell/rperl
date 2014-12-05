# [[[ TEST : 'ERROR ECVPARP00' ]]]
# [[[ HEADER ]]]
package RPerl::Test::LiteralNumber::Package_63_Bad_01;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values and print operator

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub { -23_456.34_567_89; };

1;                  # end of package
