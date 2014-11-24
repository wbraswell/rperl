# [[[ TEST : 'ERROR ECVPAPC02' ]]]
# [[[ TEST : 'Perl::Critic::Policy::ValuesAndExpressions::ProhibitMagicNumbers' ]]]
# [[[ HEADER ]]]
package RPerl::Test::DataTypeNumber::Number_48_Bad_01;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

our void $empty_sub = sub { 23_456._2; };

1;
1;    # CODE SEPARATOR: end of package

