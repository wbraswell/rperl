# [[[ HEADER ]]]
package RPerl::DataType::Void;
use strict;
use warnings;
use RPerl::AfterFilter;
our $VERSION = 0.002_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::DataType);
use RPerl::DataType;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names

# [[[ SUB-TYPES ]]]
# void means no type, void does NOT mean unknown data type, that is RPerl::DataType::Unknown
package  # hide from PAUSE indexing
    void;
use strict;
use warnings;
use parent qw(RPerl::DataType::Void);

1;  # end of class
