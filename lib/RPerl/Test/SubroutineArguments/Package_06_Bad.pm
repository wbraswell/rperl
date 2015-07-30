# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECVPAPL02' >>>
# <<< PARSE_ERROR: 'near "$bar my number_hashref"' >>>

# [[[ HEADER ]]]
package RPerl::Test::SubroutineArguments::Package_06_Bad;
use strict;
use warnings;
use RPerl::AfterFilter;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub {
    ( my number $foo, my number_arrayref $bar my number_hashref $baz ) = @_;
    return 1;
};

1;    # end of package
