#!/usr/bin/perl
use strict;
use warnings;
use RPerl;
our $VERSION = 0.000_002;

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitUnreachableCode RequirePodSections RequirePodAtEnd PodSpelling) # DEVELOPER DEFAULT 1: allow unreachable & POD-commented code

use RPerl::Algorithm::Math::GeometricAlgebra;
use Data::Dumper;

# variable declarations
my number_arrayref $retval_vector;
my number_arrayref $input_bivector;
my number_arrayref $input_vector;

# [ undef, -10.1538461538462, 3, 1.53846153846154 ];
$input_bivector = [-999999, 3.0/13.0, 4.0/13.0, 12.0/13.0];
$input_vector = [-999999, 3.0, 4.0, 12.0];

# error 1
#$input_bivector = [-999999, 3.0, 4.0];
#$input_vector = [-999999, 3.0, 4.0, -12.0];

# error 1
#$input_bivector = [-999999, 3.0, 4.0, 12.0, 0.0];
#$input_vector = [-999999, 3.0, 4.0, -12.0];

# error 2
#$input_bivector = [-999999, 3.0, 4.0, 12.0];
#$input_vector = [-999999, 3.0, 4.0];

# error 2
#$input_bivector = [-999999, 3.0, 4.0, 12.0];
#$input_vector = [-999999, 3.0, 4.0, -12.0, 0.0];


# loop to test for memory leaks
my integer $i_MAX = 0;  # CONSTANT
for my integer $i ( 0 .. $i_MAX ) {
	RPerl::diag "in geometric_algebra_test_2_ipbve.pl, top of for() loop $i/$i_MAX\n";

    $retval_vector = inner_product__bivector_vector_euclidean($input_bivector, $input_vector);

	RPerl::diag "in geometric_algebra_test_2_ipbve.pl $i/$i_MAX, have \$retval_vector =\n" . Dumper($retval_vector) . "\n";

    # root sum squared
#    my number $checksum = (($retval_vector->[1])**2 + ($retval_vector->[2])**2 + ($retval_vector->[3])**2)**0.5;
#    my number $checksum = (($retval_vector->[1] * $retval_vector->[1]) + ($retval_vector->[2] * $retval_vector->[2]) + ($retval_vector->[3] * $retval_vector->[3]))**0.5;
#    RPerl::diag "in geometric_algebra_test_2_ipbve.pl $i/$i_MAX, have \$checksum = $checksum\n";

croak('Done for now, croaking');
}

#croak('Done for now, croaking');
