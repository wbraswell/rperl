# [[[ HEADER ]]]
package RPerl::Test::EmptyClass_00;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

use parent qw(RPerl::Test);
use RPerl::Test;

# START HERE: debug %properties parsing, then create EmptyPackage_0* and EmptyClass_0* to test version numbers, etc.
# START HERE: debug %properties parsing, then create EmptyPackage_0* and EmptyClass_0* to test version numbers, etc.
# START HERE: debug %properties parsing, then create EmptyPackage_0* and EmptyClass_0* to test version numbers, etc.

# [[[ OO PROPERTIES ]]]
our %properties = ( ## no critic qw(ProhibitPackageVars)  # USER DEFAULT 2: allow OO properties

    #    empty_property => my integer $TYPED_empty_property           = 23,
    #    empty_property => 23
);

our void $foo = sub { 2; };

1;
1;    # CODE SEPARATOR: methods above, subroutines below
