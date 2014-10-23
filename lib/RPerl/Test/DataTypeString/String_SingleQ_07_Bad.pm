# [[[ HEADER ]]]
package RPerl::Test::DataTypeString::String_SingleQ_07_Bad;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# fails Perl::Critic::Policy::ValuesAndExpressions::RequireInterpolationOfMetachars
# "String *may* require interpolation"
our void $empty_sub = sub { q{@$}; };

1;
1;    # CODE SEPARATOR: end of package
