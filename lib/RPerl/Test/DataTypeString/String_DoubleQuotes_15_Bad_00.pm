# [[[ TEST : "ERROR ECVPAPL02" ]]]
# [[[ TEST : "Perl::Critic::Policy::Miscellanea::RequireRcsKeywords" ]]]
# [[[ TEST : "Perl::Critic::Policy::Variables::ProhibitPunctuationVars" ]]]
# [[[ HEADER ]]]
package RPerl::Test::DataTypeString::String_DoubleQuotes_15_Bad_00;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub { "`~!@#$%^&*()-_=+[]{}\|;:',<.>/?\n"; };

1;
1;    # CODE SEPARATOR: end of package

