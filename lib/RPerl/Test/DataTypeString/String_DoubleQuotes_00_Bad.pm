# [[[ TEST : "ERROR ECVPAPL02" ]]]
# [[[ TEST : "Perl::Critic::Policy::Miscellanea::RequireRcsKeywords" ]]]
# [[[ TEST : "Perl::Critic::Policy::ValuesAndExpressions::ProhibitEmptyQuotes" ]]]
# [[[ TEST : "Perl::Critic::Policy::ValuesAndExpressions::ProhibitInterpolationOfLiterals" ]]]
# [[[ HEADER ]]]
package RPerl::Test::DataTypeString::String_DoubleQuotes_00_Bad;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub { ""; };

1;
1;    # CODE SEPARATOR: end of package

