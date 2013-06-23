use strict;  use warnings;
package RPerl::Code::Subroutine::Method;

our @ISA = ('RPerl::Code::Subroutine');
use RPerl::Code::Subroutine;

# a method is a subroutine belonging to a class or object
package method;
our @ISA = ('RPerl::Subroutine::Method');

# method with void return type
package void__method;
our @ISA = ('method');

# method with int return type
package int__method;
our @ISA = ('method');

# method with (ref to int) return type
package int_ref__method;
our @ISA = ('method');

# method with float return type
package float__method;
our @ISA = ('method');

# method with (ref to float) return type
package float_ref__method;
our @ISA = ('method');

# method with number return type
package number__method;
our @ISA = ('method');

# method with (ref to number) return type
package number_ref__method;
our @ISA = ('method');

# method with char return type
package char__method;
our @ISA = ('method');

# method with (ref to char) return type
package char_ref__method;
our @ISA = ('method');

# method with string return type
package string__method;
our @ISA = ('method');

# method with (ref to string) return type
package string_ref__method;
our @ISA = ('method');

# method with scalar return type
package scalar__method;
our @ISA = ('method');

# method with (ref to scalar) return type
package scalar_ref__method;
our @ISA = ('method');

# method with unknown return type
package unknown__method;
our @ISA = ('method');

# method with (ref to unknown) return type
package unknown_ref__method;
our @ISA = ('method');

# method with object return type
package object__method;
our @ISA = ('method');

# method with (ref to object) return type
package object_ref__method;
our @ISA = ('method');

