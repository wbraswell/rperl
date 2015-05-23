# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECVPAPL02' >>>
# <<< PARSE_ERROR: 'Global symbol "$empty_sub" requires explicit package name' >>>

# [[[ HEADER ]]]
package RPerl::Test::Subroutine::Package_00_Bad_00;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
ou void $empty_sub = sub { return 2; };

1;                  # end of package
