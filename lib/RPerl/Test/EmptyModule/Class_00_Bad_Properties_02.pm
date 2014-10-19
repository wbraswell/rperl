# [[[ HEADER ]]]
package RPerl::Test::EmptyModule::Class_00_Good;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

use parent qw(RPerl::Test);
use RPerl::Test;

# [[[ OO PROPERTIES ]]]
our  = ( ## no critic qw(ProhibitPackageVars)  # USER DEFAULT 2: allow OO properties
    empty_property => my integer $TYPED_empty_property = 2
);

our void__method $empty_method = sub { 2; };

1;
1;                  # CODE SEPARATOR: end of class
