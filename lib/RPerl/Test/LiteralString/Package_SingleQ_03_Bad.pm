# <<< COMPILE_ERROR: 'ERROR ECVPAPC02' >>>
# <<< COMPILE_ERROR: 'Perl::Critic::Policy::ValuesAndExpressions::RequireInterpolationOfMetachars' >>>
# [[[ HEADER ]]]
package RPerl::Test::LiteralString::Package_SingleQ_03_Bad;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub { q{@'foo'}; };

1;                  # end of class
