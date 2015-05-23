# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECVPAPL03' >>>
# <<< PARSE_ERROR: 'Misplaced _ in number' >>>

# [[[ HEADER ]]]
package RPerl::Test::LiteralNumber::Package_16_Bad_03;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

# [[[ SUBROUTINES ]]]
our number $empty_sub = sub { return 0._2; };

1;                  # end of package
