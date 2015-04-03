# [[[ PREPROCESSOR ]]]
# <<< COMPILE_ERROR: 'ERROR ECVPAPC02' >>>
# <<< COMPILE_ERROR: 'Perl::Critic::Policy::ValuesAndExpressions::RequireInterpolationOfMetachars' >>>

# [[[ HEADER ]]]
package RPerl::Test::LiteralString::Package_SingleQ_07_Bad;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our string $empty_sub = sub { return q{@$}; };

1;                  # end of package
