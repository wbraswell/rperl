## no critic qw(ProhibitUselessNoCritic PodSpelling ProhibitExcessMainComplexity

# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECVPARP00' >>>
# <<< PARSE_ERROR: 'Unexpected Token:  use RPerl;' >>>

# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::Critic::Package_01_Bad_03;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub {
    return 2;
};

1;                  # end of package
