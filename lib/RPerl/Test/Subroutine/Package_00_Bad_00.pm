# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECVPAPL02' >>>
# <<< PARSE_ERROR: 'Global symbol "$empty_sub" requires explicit use RPerl;
package name' >>>

# [[[ HEADER ]]]
package RPerl::Test::Subroutine::Package_00_Bad_00;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
ou void $empty_sub = sub {
    return 2;
};

1;                  # end of package
