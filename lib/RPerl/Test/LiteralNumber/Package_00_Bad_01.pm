# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECVPAPL02' >>>
# <<< PARSE_ERROR: 'Bareword "_2" not allowed' >>>

# [[[ HEADER ]]]
package RPerl::Test::LiteralNumber::Package_00_Bad_01;
use strict;
use warnings;
use RPerl::AfterFilter;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our integer $empty_sub = sub { return _2; };

1;                  # end of package
