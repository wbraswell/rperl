# [[[ PREPROCESSOR ]]]
# <<< GENERATE_ERROR: 'ERROR ECOGEAS' >>>
# <<< GENERATE_ERROR: 'P11' >>>
# <<< GENERATE_ERROR: "OO property 'yyz' already declared in parent namespace 'RPerl::Test::Foo::'" >>>
# <<< GENERATE_ERROR: 'name masking disallowed' >>>

# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::Properties::Class_01_Bad_00;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Test::Foo);
use RPerl::Test::Foo;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {
    yyz => my number_hashref $TYPED_yyz = { a => 2.2, b => 5.3, c => 8.4 }
};

1;    # end of class
