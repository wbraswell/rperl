# <<< COMPILE_ERROR: 'ERROR ECVPARP00' >>>
# [[[ HEADER ]]]
package RPerl::Test::LiteralNumber::Package_47_Bad_02;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values and print operator

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub { -23_456__789.234_56; };

1;                  # end of package

