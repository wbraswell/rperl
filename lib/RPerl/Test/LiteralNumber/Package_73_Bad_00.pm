# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECVPARP00' >>>
# <<< PARSE_ERROR: 'Unexpected Token:  +' >>>

# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::LiteralNumber::Package_73_Bad_00;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

# [[[ SUBROUTINES ]]]
our number $empty_sub = sub {
    return +-23_456.234_567_89;
};

1;    # end of package
