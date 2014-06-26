#!/usr/bin/perl
## no critic qw(ProhibitMagicNumbers ProhibitUnreachableCode)  ## RPERL allow numeric test values, allow unreachable test code
use strict;
use warnings;
our $VERSION = 0.000_020;
use Carp;
use RPerl;
use RPerl::Algorithm::Math::GeometricAlgebra;

# variable declarations
my number $retval_number;
my number__array_ref $input_vector_1;
my number__array_ref $input_vector_2;

# 84
#$input_vector_1 = [-999999, 2.0, 4.0, 6.0];
#$input_vector_2 = [-999999, 3.0, 6.0, 9.0];

# 0
#$input_vector_1 = [-999999, 0.0, 0.0, 0.0];
#$input_vector_2 = [-999999, 3.0, 4.0, 12.0];

# 96
#$input_vector_1 = [-999999, 3.0, 4.0, 12.0];
#$input_vector_2 = [-999999, 4.0, 12.0, 3.0];

# 96
#$input_vector_1 = [-999999, 3.0, 4.0, 12.0];
#$input_vector_2 = [-999999, 12.0, 3.0, 4.0];

# 88
#$input_vector_1 = [-999999, 3.0, 4.0, 12.0];
#$input_vector_2 = [-999999, 12.0, 4.0, 3.0];

# 168
$input_vector_1 = [-999999, 3.0, 4.0, 12.0];
$input_vector_2 = [-999999, 4.0, 3.0, 12.0];

# 105
#$input_vector_1 = [-999999, 3.0, 4.0, 12.0];
#$input_vector_2 = [-999999, 3.0, 12.0, 4.0];

# 151
#$input_vector_1 = [-999999, 3.0, 4.0, 12.0];
#$input_vector_2 = [-999999, -3.0, 4.0, 12.0];

# 137
#$input_vector_1 = [-999999, 3.0, 4.0, 12.0];
#$input_vector_2 = [-999999, 3.0, -4.0, 12.0];

# -119
#$input_vector_1 = [-999999, 3.0, 4.0, 12.0];
#$input_vector_2 = [-999999, 3.0, 4.0, -12.0];

# error 1
#$input_vector_1 = [-999999, 3.0, 4.0];
#$input_vector_2 = [-999999, 3.0, 4.0, -12.0];

# error 1
#$input_vector_1 = [-999999, 3.0, 4.0, 12.0, 0.0];
#$input_vector_2 = [-999999, 3.0, 4.0, -12.0];

# error 2
#$input_vector_1 = [-999999, 3.0, 4.0, 12.0];
#$input_vector_2 = [-999999, 3.0, 4.0];

# error 2
#$input_vector_1 = [-999999, 3.0, 4.0, 12.0];
#$input_vector_2 = [-999999, 3.0, 4.0, -12.0, 0.0];


# loop to test for memory leaks
my const_integer $i_MAX = 0;
for my integer $i ( 0 .. $i_MAX ) {
	print STDERR "in geometric_algebra_test_1_ipvve.pl, top of for() loop $i/$i_MAX\n";

    $retval_number = inner_product__vector_vector_euclidean($input_vector_1, $input_vector_2);

	print STDERR "in geometric_algebra_test_1_ipvve.pl $i/$i_MAX, have \$retval_number =\n$retval_number\n";

croak('Done for now, croaking');
}

#croak('Done for now, croaking');
