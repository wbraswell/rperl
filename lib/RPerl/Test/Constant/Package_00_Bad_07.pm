# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPAPL02' >>>
# <<< PARSE_ERROR: 'No such class number' >>>

# [[[ HEADER ]]]
use constant PI  => my number $TYPED_PI  = 3.141_59;
use RPerl;
package RPerl::Test::Constant::Package_00_Bad_07;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CONSTANTS ]]]
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants
use constant PIE => my string $TYPED_PIE = 'pecan';

# [[[ SUBROUTINES ]]]
sub empty_sub { { my void $RETURN_TYPE };
    return 2;
}

1;                  # end of package
