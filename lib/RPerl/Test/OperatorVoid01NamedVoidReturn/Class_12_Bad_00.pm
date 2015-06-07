# [[[ PREPROCESSOR ]]]
# <<< GENERATE_ERROR: 'ERROR ECVGEASRP03' >>>
# <<< GENERATE_ERROR: "Argument count 4 exceeds maximum argument limit 1 for operator 'return'" >>>

# [[[ HEADER ]]]
package RPerl::Test::OperatorVoid01NamedVoidReturn::Class_12_Bad_00;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Test);
use RPerl::Test;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS & SUBROUTINES ]]]
our void_method $foo = sub { return 2, 3, 5, 7; };

1;    # end of class
