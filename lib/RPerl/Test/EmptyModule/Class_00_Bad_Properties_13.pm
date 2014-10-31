# [[[ TEST : "ERROR ECVPAPL02" ]]]
# [[[ TEST : "syntax error" ]]]
# [[[ HEADER ]]]
package RPerl::Test::EmptyModule::Class_00_Bad_Properties_13;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Test);
use RPerl::Test;

# [[[ OO PROPERTIES ]]]
our %properties = ( ## no critic qw(ProhibitPackageVars)  # USER DEFAULT 2: allow OO properties
    empty_property => my integer = 2
);

# [[[ OO METHODS ]]]
our void__method $empty_method = sub { 2; };

1;
1;                  # CODE SEPARATOR: end of class

