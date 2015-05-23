# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECVPAPL03' >>>
# <<< PARSE_ERROR: 'Useless use of a constant' >>>

# [[[ HEADER ]]]
package RPerl::Test::Module::Package_00_Bad_Terminator_02;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub { return 2; };

1 + 1;                  # end of package
