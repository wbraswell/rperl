use strict;  use warnings;
package RPerl::DataType::String;

our @ISA = ('RPerl::DataType::Scalar');
use RPerl::DataType::Scalar;

# a string is 0 or more letters, digits, or other ASCII (Unicode???) symbols
package string;
our @ISA = ('RPerl::DataType::String');

# string with const value
package const_string;
our @ISA = ('string', 'const');

# ref to string
package string_ref;
our @ISA = ('ref');

# ref to (string with const value)
package const_string_ref;
our @ISA = ('ref');


# [[[ TYPE TESTING ]]]
# [[[ TYPE TESTING ]]]
# [[[ TYPE TESTING ]]]
our string $typetest___void__in___string__out = sub { my string $retval = "Spice";  return($retval); };
our string $typetest___string__in___string__out = sub { (my string $fuzzword) = @_;  print "in Perl String::typetest___string__in___string__out(), have fuzzword '$fuzzword', BAZBOT\n";  return($fuzzword . "FUZZ"); };
