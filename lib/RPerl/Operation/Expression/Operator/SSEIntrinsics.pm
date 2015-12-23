# [[[ HEADER ]]]
package RPerl::Operation::Expression::Operator::SSEIntrinsics;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Expression::Operator);
use RPerl::Operation::Expression::Operator;

# [[[ INCLUDES ]]]
use Exporter 'import';
our @EXPORT = qw(sse_recip_sqrt_32bit_on_64bit);

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS & SUBROUTINES ]]]

#our sse_number_pair $sse_recip_sqrt_32bit_on_64bit = sub {
sub sse_recip_sqrt_32bit_on_64bit {
    ( my sse_number_pair $argument ) = @_;
    my sse_number_pair $retval = sse_number_pair->new();
    my number $argument_0_number = $argument->[0];
    my number $argument_1_number = $argument->[1];
    my string $argument_0_string = "$argument_0_number";
    my string $argument_1_string = "$argument_1_number";
    my boolean $has_decimal = 0;
    if ($argument_0_string =~ /[.]/) { $has_decimal = 1; }
    if ((length $argument_0_string) > (7 + $has_decimal)) {
        $argument_0_string = substr $argument_0_string, 0, (7 + $has_decimal);
    }
    $has_decimal = 0;
    if ($argument_1_string =~ /[.]/) { $has_decimal = 1; }
    if ((length $argument_1_string) > (7 + $has_decimal)) {
        $argument_1_string = substr $argument_1_string, 0, (7 + $has_decimal);
    }
    $retval->[0] = 1/(($argument_0_string + 0)**(0.5));
    $retval->[1] = 1/(($argument_1_string + 0)**(0.5));
    return $retval;
}

1;    # end of class
