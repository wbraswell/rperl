# [[[ TEST : 'ERROR ECVPAPC02' ]]]
# [[[ TEST : 'Perl::Critic::Policy::ValuesAndExpressions::ProhibitMismatchedOperators' ]]]
# [[[ HEADER ]]]
package RPerl::Test::LiteralNumber::Package_16_Bad_01;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values and print operator

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub { 0000 . 2; };

1;                  # end of package
