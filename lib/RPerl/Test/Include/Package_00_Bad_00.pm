# [[[ PREPROCESSOR ]]]
# <<< COMPILE_ERROR: 'ERROR ECVPARP00' >>>
# <<< COMPILE_ERROR: 'Unexpected Token:  us' >>>

# [[[ HEADER ]]]
package RPerl::Test::Include::Package_00_Bad_00;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ INCLUDES ]]]
us RPerl::Test::Foo;
use RPerl::Test::Bar;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub { return 2; };

1;                  # end of package
