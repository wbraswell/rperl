# [[[ TEST : 'ERROR ECVPAPC02' ]]]
# [[[ TEST : 'Perl::Critic::Policy::ValuesAndExpressions::ProhibitInterpolationOfLiterals' ]]]
# [[[ HEADER ]]]
package RPerl::Test::LiteralString::Package_DoubleQuotes_09_Bad;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub { "'foo'"; };

1;                  # end of class
