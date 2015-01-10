# [[[ PREPROCESSOR ]]]
# <<< COMPILE_ERROR: 'ERROR ECVPAPL02' >>>
# <<< COMPILE_ERROR: 'near "=> my numer"' >>>

# [[[ HEADER ]]]
package RPerl::Test::Constant::Class_00_Bad_05;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Test);
use RPerl::Test;

# [[[ CONSTANTS ]]]
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants
use constant PI  => my numer $TYPED_PI   = 3.141_59;
use constant PIE => my string $TYPED_PIE = 'pecan';

# [[[ OO PROPERTIES ]]]
our hash_ref $properties
    = { empty_property => my integer $TYPED_empty_property = 2 };

# [[[ OO METHODS ]]]
our void__method $empty_method = sub { return 2; };

1;    # end of class
