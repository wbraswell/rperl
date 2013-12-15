## no critic qw(ProhibitMultiplePackages)  ## RPERL SYSTEM types, allow multiple packages
## no critic qw(Capitalization)  ## RPERL SYSTEM types, allow lowercase packages
package RPerl::Code::Subroutine::Method;
use strict;
use warnings;
use version; our $VERSION = qv('0.2.0');
use Carp;

# [[[ SETUP ]]]
# [[[ SETUP ]]]
# [[[ SETUP ]]]

use parent ('RPerl::Code::Subroutine');
use RPerl::Code::Subroutine;

# a method is a subroutine belonging to a class or object
package method;
use parent ('RPerl::Code::Subroutine::Method');

# [[[ SCALAR & SCALAR REF METHODS ]]]
# [[[ SCALAR & SCALAR REF METHODS ]]]
# [[[ SCALAR & SCALAR REF METHODS ]]]

# method with void return type
package void__method;
use parent -norequire, ('method');

# method with integer return type
package integer__method;
use parent -norequire, ('method');

# method with (ref to integer) return type
package integer_ref__method;
use parent -norequire, ('method');

# method with float return type
package float__method;
use parent -norequire, ('method');

# method with (ref to float) return type
package float_ref__method;
use parent -norequire, ('method');

# method with number return type
package number__method;
use parent -norequire, ('method');

# method with (ref to number) return type
package number_ref__method;
use parent -norequire, ('method');

# method with char return type
package char__method;
use parent -norequire, ('method');

# method with (ref to char) return type
package char_ref__method;
use parent -norequire, ('method');

# method with string return type
package string__method;
use parent -norequire, ('method');

# method with (ref to string) return type
package string_ref__method;
use parent -norequire, ('method');

# method with scalar return type
package scalar__method;
use parent -norequire, ('method');

# method with (ref to scalar) return type
package scalar_ref__method;
use parent -norequire, ('method');

# method with unknown return type
package unknown__method;
use parent -norequire, ('method');

# method with (ref to unknown) return type
package unknown_ref__method;
use parent -norequire, ('method');

# method with object return type
package object__method;
use parent -norequire, ('method');

# method with (ref to object) return type
package object_ref__method;
use parent -norequire, ('method');

# [[[ HASH METHODS ]]]
# [[[ HASH METHODS ]]]
# [[[ HASH METHODS ]]]

package integer__hash_ref__method;
use parent -norequire, ('method');

package number__hash_ref__method;
use parent -norequire, ('method');

package string__hash_ref__method;
use parent -norequire, ('method');

# [[[ ARRAY METHODS ]]]
# [[[ ARRAY METHODS ]]]
# [[[ ARRAY METHODS ]]]

package integer__array_ref__method;
use parent -norequire, ('method');

package number__array_ref__method;
use parent -norequire, ('method');

package string__array_ref__method;
use parent -norequire, ('method');

1;
