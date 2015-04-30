package RPerl::CodeBlock::Subroutine::Method;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.003_000;

## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names

use parent qw(RPerl::CodeBlock::Subroutine);
our hashref $properties = {};

# [[[ SETUP ]]]
# [[[ SETUP ]]]
# [[[ SETUP ]]]

# a method is a subroutine belonging to a class or object
package method;
use parent ('RPerl::CodeBlock::Subroutine::Method');

# [[[ SCALAR & SCALAR REF METHODS ]]]
# [[[ SCALAR & SCALAR REF METHODS ]]]
# [[[ SCALAR & SCALAR REF METHODS ]]]

# method with void return type
package void_method;
use parent -norequire, ('method');

# method with integer return type
package integer_method;
use parent -norequire, ('method');

# method with float return type
package float_method;
use parent -norequire, ('method');

# method with number return type
package number_method;
use parent -norequire, ('method');

# method with char return type
package char_method;
use parent -norequire, ('method');

# method with string return type
package string_method;
use parent -norequire, ('method');

# method with scalartype return type
package scalartype_method;
use parent -norequire, ('method');

# method with unknown return type
package unknown_method;
use parent -norequire, ('method');

# method with object return type
package object_method;
use parent -norequire, ('method');

# [[[ HASH METHODS ]]]
# [[[ HASH METHODS ]]]
# [[[ HASH METHODS ]]]

package integer_hashref_method;
use parent -norequire, ('method');

package number_hashref_method;
use parent -norequire, ('method');

package string_hashref_method;
use parent -norequire, ('method');

package object_hashref_method;
use parent -norequire, ('method');

package hashref_hashref_method;
use parent -norequire, ('method');

# [[[ ARRAY METHODS ]]]
# [[[ ARRAY METHODS ]]]
# [[[ ARRAY METHODS ]]]

package integer_arrayref_method;
use parent -norequire, ('method');

package number_arrayref_method;
use parent -norequire, ('method');

package string_arrayref_method;
use parent -norequire, ('method');

package object_arrayref_method;
use parent -norequire, ('method');

package arrayref_arrayref_method;
use parent -norequire, ('method');

1;
