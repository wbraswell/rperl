# [[[ TEST : 'ERROR ECVPAPC02' ]]]
# [[[ TEST : 'Perl::Critic::Policy::Variables::ProhibitPunctuationVars' ]]]
# [[[ HEADER ]]]
package RPerl::Test::LiteralString::Package_DoubleQuotes_15_Bad_00;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub { "`~!@#$%^&*()-_=+[]{}\|;:',<.>/?\n"; };

1;                  # end of class
