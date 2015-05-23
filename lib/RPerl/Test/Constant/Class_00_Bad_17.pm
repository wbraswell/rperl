# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECVPARP00' >>>
# <<< PARSE_ERROR: 'Unexpected Token:  use constant' >>>

# [[[ HEADER ]]]
package RPerl::Test::Constant::Class_00_Bad_17;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Test);
use RPerl::Test;

# [[[ CONSTANTS ]]]
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants
use constant PI => my number $TYPED_PI = 3.141_59;

# [[[ OO PROPERTIES ]]]
our hashref $properties
    = { empty_property => my integer $TYPED_empty_property = 2 };

use constant PIE => my string $TYPED_PIE = 'pecan';

# [[[ OO METHODS & SUBROUTINES ]]]
our void_method $empty_method = sub { return 2; };

1;    # end of class
