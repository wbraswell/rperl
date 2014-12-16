# [[[ PREPROCESSOR ]]]
# <<< COMPILE_ERROR: 'ERROR ECVPAPL02' >>>
# <<< COMPILE_ERROR: 'Illegal declaration of anonymous subroutine' >>>

# [[[ HEADER ]]]
package RPerl::Test::Subroutine::Package_00_Bad_05;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub  2; };

1;                  # end of package
