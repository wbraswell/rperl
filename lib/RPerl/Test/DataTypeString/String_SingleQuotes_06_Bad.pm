# [[[ TEST : 'ERROR ECVPAPC02' ]]]
# [[[ TEST : 'Perl::Critic::Policy::ValuesAndExpressions::RequireInterpolationOfMetachars' ]]]
# [[[ HEADER ]]]
package RPerl::Test::DataTypeString::String_SingleQuotes_06_Bad;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub { '`~!@#$%^&*()-_=+[]{}\|;:",<.>/?'; };

1;                  # end of class
