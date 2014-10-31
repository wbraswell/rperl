# [[[ TEST : "ERROR ECVPAPL02" ]]]
# [[[ TEST : 'Global symbol "$bar" requires explicit package name' ]]]
# [[[ HEADER ]]]
package RPerl::Test::DataTypeString::String_DoubleQuotes_13_Bad;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub { "foo\t$bar\t"; };

1;
1;    # CODE SEPARATOR: end of package

