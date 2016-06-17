# [[[ HEADER ]]]
package RPerl::CompileUnit;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.000_012;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::GrammarRule);
use RPerl::GrammarRule;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

# [[[ INCLUDES ]]]
use Scalar::Util 'blessed';

# [[[ OO PROPERTIES ]]]
# DEV NOTE: no active properties, this is a stub object for now, see children objects for active properties
our hashref $properties = {
        # Program, Module, Package, and Class objects
        #name        => my string $TYPED_name                   = undef,
        #version     => my string $TYPED_version                = undef,
        #includes    => my object_arrayref $TYPED_includes    = undef,
        #constants   => my object_arrayref $TYPED_constants   = undef,
        #subroutines => my object_arrayref $TYPED_subroutines = undef,

    # Program objects only
    #operations => my object_arrayref $TYPED_operations = undef,

    # Class objects only
    #methods    => my object_arrayref $TYPED_methods    = undef,
    #properties => my object_arrayref $TYPED_properties = undef,
};

# [[[ SUBROUTINES & OO METHODS ]]]

# ...

1;    # end of class
