# [[[ HEADER ]]]
package RPerl::DataType::GMPInteger;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::DataType::Scalar);
use RPerl::DataType::Scalar;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names

# [[[ SUB-TYPES ]]]
# a gmp_integer is multi-precision integer using the GMP library
package  # hide from PAUSE indexing
    gmp_integer;
use strict;
use warnings;
use parent qw(RPerl::DataType::GMPInteger);

# [[[ SWITCH CONTEXT BACK TO PRIMARY PACKAGE ]]]
package RPerl::DataType::GMPInteger;
use strict;
use warnings;

# [[[ INCLUDES ]]]
use RPerl::DataType::String;    # need stringy type
use Math::BigInt lib => 'GMP';  # we still actually use GMP in PERLOPS_PERLTYPES mode, albeit indirectly via Math::BigInt::GMP

# [[[ CONSTRUCTOR ]]]
sub new { return Math::BigInt->new(); }

# START HERE: implement gmp_integer type conversion subs
# START HERE: implement gmp_integer type conversion subs
# START HERE: implement gmp_integer type conversion subs

# [[[ TYPE-CHECKING ]]]
# [[[ BOOLIFY ]]]
# [[[ NUMBERIFY ]]]
# [[[ CHARIFY ]]]
# [[[ STRINGIFY ]]]
# [[[ TYPE TESTING ]]]

# NEED ADD TYPE CHECKING, CONVERSION, AND TYPE TESTING SUBROUTINES

1;  # end of class
