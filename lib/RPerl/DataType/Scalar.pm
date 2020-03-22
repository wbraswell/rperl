# [[[ HEADER ]]]
package RPerl::DataType::Scalar;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.006_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::DataType);
use RPerl::DataType;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names

# [[[ CONSTANTS ]]]
use constant INFINITY => my string $TYPED_INFINITY = 'inf';

# [[[ SUB-TYPES ]]]

# a scalartype is a known, non-void data type, meaning a number or a string
# DEV NOTE: do NOT overload Perl's 'scalar' keyword!!!
package  # hide from PAUSE indexing
    scalartype;
use strict;
use warnings;
use parent qw(RPerl::DataType::Scalar);

# method with scalartype return type
package  # hide from PAUSE indexing
    scalartype::method;
use strict;
use warnings;
use parent -norequire, qw(method);

1;  # end of class
