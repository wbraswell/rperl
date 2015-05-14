# [[[ HEADER ]]]
package RPerl::Test::ScopeTypeNameValue::Class_00_Good;
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
our hashref $properties
    = { some_integer => my integer $TYPED_empty_property = 23 };

# [[[ OO METHODS ]]]
our string_method $properties_stnv = sub {
    return main::scope_type_name_value($properties);
};

1;    # end of class
