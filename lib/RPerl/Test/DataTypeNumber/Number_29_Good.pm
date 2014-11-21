# [[[ HEADER ]]]
package RPerl::Test::DataTypeNumber::Number_29_Good;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]

# START HERE: figure out why trailing "# USER DEFAULT 1" comment causes grammar parse error 
# START HERE: figure out why trailing "# USER DEFAULT 1" comment causes grammar parse error 
# START HERE: figure out why trailing "# USER DEFAULT 1" comment causes grammar parse error 

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values and print operator

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub { -0.234_567_8; };

1;
1;    # CODE SEPARATOR: end of package
