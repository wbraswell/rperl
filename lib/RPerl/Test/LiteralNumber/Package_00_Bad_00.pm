# <<< COMPILE_ERROR: 'ERROR ECVPAPL02' >>>
# <<< COMPILE_ERROR: 'Can't modify constant item in predecrement' >>>
# [[[ HEADER ]]]
package RPerl::Test::LiteralNumber::Package_00_Bad_00;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub { --2; };

1;                  # end of package
