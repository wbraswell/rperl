# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPARP00' >>>
# <<< PARSE_ERROR: 'Unexpected Token:  ##' >>>

# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::Critic::Package_00_Bad_01;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## n critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

# [[[ SUBROUTINES ]]]
sub empty_sub { { my void $RETURN_TYPE }; return 2; }

1;                  # end of package
