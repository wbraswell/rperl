use strict;  use warnings;
package RPerl::DataType::Number;

our @ISA = ('RPerl::DataType::Scalar');
use RPerl::DataType::Scalar;
use RPerl::DataType::String;  # for stringify()

# DEV NOTE:
# a number is any numeric value, meaning either an integer or a floating-point number;
# Integer and Float are both sub-classes of Number; 
# the hidden Perl semantics are SvIOKp() for ints, and SvNOKp() for numbers;
# these numbers appear to act as C long doubles and are implemented as such in RPerl;
# there is no SvFOKp() for floats, so float currently inherits everything from number,
# and we generate C long doubles instead of C floats;
# in the future, this can be optimized (for at least memory usage) by implementing full Float semantics
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


# [[[ SWITCH CONTEXT BACK TO MAIN PACKAGE ]]]
package RPerl::DataType::Number;

# [[[ OPERATIONS & DATA TYPES ]]]
our string $ops_number = sub { return('PERL'); };
our string $types_number = sub { return('PERL'); };

# [[[ STRINGIFY ]]]
our string $stringify_number = sub { (my $input_number) = @_;  return("$input_number"); };

# [[[ TYPE TESTING ]]]
# [[[ TYPE TESTING ]]]
# [[[ TYPE TESTING ]]]
use RPerl::DataType::Void;
our number $typetest___void__in___number__out = sub { my number $retval = 22 / 7;  print "in Perl Number::typetest___void__in___number__out(), have \$retval $retval, BATBOZ\n";  return($retval); };
our number $typetest___number__in___number__out = sub { (my number $lucky_number) = @_;  print "in Perl Number::typetest___number__in___number__out(), have \$lucky_number $lucky_number, BATBOZ\n";  return($lucky_number * 2); };