# [[[ HEADER ]]]
package RPerl::DataType::Float;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.003_000;

# [[[ OO INHERITANCE ]]]
# DEV NOTE, CORRELATION #rp07:
# NEED FIX, OUTDATED
# Float should have it's own functionality and compile to float C/C++ type for memory optimization, not just be a sub-type of Number
use parent qw(RPerl::DataType::Number);
use RPerl::DataType::Number;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names

# [[[ SUB-TYPES ]]]
# a floating-point number has a fractional/decimal component
package  # hide from PAUSE indexing
    float;
use strict;
use warnings;
use parent qw(RPerl::DataType::Float);

1;  # end of class
