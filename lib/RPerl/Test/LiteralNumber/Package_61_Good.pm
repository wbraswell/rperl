# [[[ HEADER ]]]
package RPerl::Test::LiteralNumber::Package_61_Good;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values and print operator

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub { -23_456.234_567_8; };

1;                  # end of package
