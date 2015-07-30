# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECVPAPL02' >>>
# <<< PARSE_ERROR: 'near "@;' >>>

# [[[ HEADER ]]]
package RPerl::Test::SubroutineArguments::Package_07_Bad;
use strict;
use warnings;
use RPerl::AfterFilter;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub {
    ( my number $foo, my string $bar, my scalartype_arrayref $baz, my integer_hashref $bat ) = @;
    return 1;
};

1;    # end of package
