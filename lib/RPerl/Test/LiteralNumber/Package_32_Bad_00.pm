# [[[ PREPROCESSOR ]]]
# <<< COMPILE_ERROR: 'ERROR ECVPAPL02' >>>
# <<< COMPILE_ERROR: 'Can't modify constant item in predecrement' >>>

# [[[ HEADER ]]]
package RPerl::Test::LiteralNumber::Package_32_Bad_00;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub { return --2.234_56; };

1;                  # end of package
