# [[[ PREPROCESSOR ]]]
# <<< GENERATE_ERROR: 'P03, CODE GENERATOR, ABSTRACT SYNTAX TO' >>>
# <<< GENERATE_ERROR: "Argument count 4 exceeds maximum argument limit 1 for operator 'return'" >>>

# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::OperatorVoid01NamedVoidReturn::Class_12_Bad_00;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Test);
use RPerl::Test;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]
sub foo { { my void::method $RETURN_TYPE }; return 2, 3, 5, 7; }

1;    # end of class
