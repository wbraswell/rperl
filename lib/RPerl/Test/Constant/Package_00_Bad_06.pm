# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECVPAPL02' >>>
# <<< PARSE_ERROR: 'No such class number' >>>

# [[[ HEADER ]]]
package RPerl::Test::Constant::Package_00_Bad_06;
use constant PI  => my number $TYPED_PI  = 3.141_59;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CONSTANTS ]]]
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants
use constant PIE => my string $TYPED_PIE = 'pecan';

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub { return 2; };

1;                  # end of package
