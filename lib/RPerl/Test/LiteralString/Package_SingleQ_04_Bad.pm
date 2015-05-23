# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECVPAPC02' >>>
# <<< PARSE_ERROR: 'Perl::Critic::Policy::ValuesAndExpressions::RequireInterpolationOfMetachars' >>>

# [[[ HEADER ]]]
package RPerl::Test::LiteralString::Package_SingleQ_04_Bad;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our string $empty_sub = sub { return q{$"foo"}; };

1;                  # end of package
