# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPARP00' >>>
# <<< PARSE_ERROR: 'Unexpected Token:  our' >>>

# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::Critic::Package_00_Bad_03;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls

# [[[ SUBROUTINES ]]]
sub empty_sub { { my void $RETURN_TYPE }; return 2; }

1;                  # end of package

