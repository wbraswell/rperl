# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECVPAPL02' >>>
# <<< PARSE_ERROR: 'Misplaced _ in number' >>>

# [[[ HEADER ]]]
package RPerl::Test::LiteralNumber::Package_48_Bad_01;
use strict;
use warnings;
use RPerl::AfterFilter;
our $VERSION = 0.001_000;

our number $empty_sub = sub {
    return 23_456._2;
};

1;    # end of package
