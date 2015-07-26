# [[[ HEADER ]]]
package RPerl::DataType::Unknown;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.002_000;

# [[[ OO INHERITANCE ]]]
use parent ('RPerl::DataType');
use RPerl::DataType;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names

# [[[ SUB-TYPES ]]]
# unknown means it could be any data type or data structure
package  # hide from PAUSE indexing
    unknown;
use strict;
use warnings;
use RPerl;
use parent ('RPerl::DataType::Unknown');

1;  # end of class
