# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECVPAPL02' >>>
# <<< PARSE_ERROR: "Can't find string terminator" >>>

# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::LiteralString::Package_DoubleQuotes_18_Bad_01;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our string $empty_sub = sub {
    return "\n\t`~!#%\t\n\t^&*()-_=+[]{}\n|;:'\t,<.\n>/?\";
};

1;    # end of package
