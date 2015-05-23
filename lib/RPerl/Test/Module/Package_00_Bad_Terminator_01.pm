# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECVPAPL02' >>>
# <<< PARSE_ERROR: 'Bareword "b" not allowed' >>>

# [[[ HEADER ]]]
package RPerl::Test::Module::Package_00_Bad_Terminator_01;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub { return 2; };

b;                  # end of package
