# [[[ PREPROCESSOR ]]]
# <<< COMPILE_ERROR: 'ERROR ECVPAPL03' >>>
# <<< COMPILE_ERROR: 'Misplaced _ in number' >>>

# [[[ HEADER ]]]
package RPerl::Test::LiteralNumber::Package_47_Bad_02;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

# [[[ SUBROUTINES ]]]
our number $empty_sub = sub { return -23_456__789.234_56; };

1;                  # end of package

