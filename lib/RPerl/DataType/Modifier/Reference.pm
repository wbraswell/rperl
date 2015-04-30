use strict; use warnings;
package RPerl::DataType::Modifier::Reference;

our @ISA = ('RPerl::DataType::Modifier');
use RPerl::DataType::Modifier;

# a reference is the location of a data type or data structure;
# a reference is not a data type, regardless of Perl's internal RV type, use 'unknown' instead
# DEV NOTE: overload Perl's 'ref' keyword
package ref;
our @ISA = ('RPerl::DataType::Modifier::Reference');
