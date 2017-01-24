# [[[ HEADER ]]]
package RPerl::DataStructure;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.002_000;

# [[[ OO INHERITANCE ]]]
# DEV NOTE: RPerl Data Structures are RPerl Data Types, 
# because we have explicitly implemented each RPerl Data Structure to be usable as a native, compound Data Type;
# other Data Structures, such as MathPerl::DataStructure::*, are not implemented as native RPerl Data Types, 
# instead they are left as RPerl Classes
use parent qw(RPerl::DataType);
use RPerl::DataType;

1;  # end of package
