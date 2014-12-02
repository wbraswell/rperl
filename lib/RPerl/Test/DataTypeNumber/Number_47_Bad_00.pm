# [[[ TEST : 'ERROR ECVPAPL02' ]]]
# [[[ TEST : 'Can't modify constant item in predecrement' ]]]
# [[[ HEADER ]]]
package RPerl::Test::DataTypeNumber::Number_47_Bad_00;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values and print operator

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub { --23_456_789.234_567_89; };

1;                  # end of class
