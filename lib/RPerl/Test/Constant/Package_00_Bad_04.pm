# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECVPARP00' >>>
# <<< PARSE_ERROR: 'Unexpected Token:  use constant' >>>

# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::Constant::Package_00_Bad_04;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CONSTANTS ]]]
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants
use constant PI  => my number $TYPED_PI  = 3.141_59;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub {
    return 2;
};

use constant PIE => my string $TYPED_PIE = 'pecan';

1;                  # end of package
