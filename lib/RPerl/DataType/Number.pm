use strict;  use warnings;
package RPerl::DataType::Number;

our @ISA = ('RPerl::DataType::Scalar');
use RPerl::DataType::Scalar;

# a number is any numeric value, meaning either an integer or a floating-point number
package number;
our @ISA = ('RPerl::DataType::Number');

# number with const value
package const_number;
our @ISA = ('number', 'const');

# ref to number
package number_ref;
our @ISA = ('ref');

# ref to (number with const value)
package const_number_ref;
our @ISA = ('ref');


# [[[ TYPE TESTING ]]]
# [[[ TYPE TESTING ]]]
# [[[ TYPE TESTING ]]]
use RPerl::DataType::Void;
our void $typetest___number__in___void__out = sub { (my number $lucky_number) = @_;  print "in Perl Number::typetest___number__in___void__out(), have \$lucky_number $lucky_number, BATBOZ\n"; };
our number $typetest___void__in___number__out = sub { my number $retval = 22 / 7;  print "in Perl Number::typetest___void__in___number__out(), have \$retval $retval, BATBOZ\n";  return($retval); };
