# [[[ HEADER ]]]
package RPerl::DataStructure::Hash::Properties;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
#use parent qw(RPerl::GrammarRule RPerl::DataStructure::Hash);  # NEED UPGRADE: multiple inheritance
use parent qw(RPerl::GrammarRule);
use RPerl::GrammarRule;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names

# [[[ INCLUDES ]]]
use Scalar::Util 'blessed';

# [[[ OO PROPERTIES ]]]
our hashref $properties = {  # whoah, so meta
    property_entries => my object_hashref $TYPED_property_entries = undef
};

# [[[ OO METHODS & SUBROUTINES ]]]

# ...

# [[[ SUB-TYPES ]]]

# a property is a data structure belonging to a class or object, each RPerl object has a properties hash
package  # hide from PAUSE indexing
    properties;
use strict;
use warnings;
use parent qw(RPerl::DataStructure::Hash::Properties);

1;  # end of class
