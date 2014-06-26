#!/usr/bin/perl
## no critic qw(ProhibitMagicNumbers ProhibitUnreachableCode)  ## RPERL allow numeric test values, allow unreachable test code
use strict;
use warnings;
our $VERSION = 0.000_001;
use Carp;
use RPerl;
use RPerl::Algorithm::Math::GeometricAlgebra;
use Data::Dumper;

# variable declarations
my number__array_ref $retval_vector;
my number__array_ref $input_bivector;
my number__array_ref $input_vector;

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
my const_integer $i_MAX = 0;
for my integer $i ( 0 .. $i_MAX ) {
	print STDERR "in geometric_algebra_test_2_ipbve.pl, top of for() loop $i/$i_MAX\n" or croak();

    $retval_vector = inner_product__bivector_vector_euclidean($input_bivector, $input_vector);

	print STDERR "in geometric_algebra_test_2_ipbve.pl $i/$i_MAX, have \$retval_vector =\n" . Dumper($retval_vector) . "\n";

    # root sum squared
#    my number $checksum = (($retval_vector->[1])**2 + ($retval_vector->[2])**2 + ($retval_vector->[3])**2)**0.5;
#    my number $checksum = (($retval_vector->[1] * $retval_vector->[1]) + ($retval_vector->[2] * $retval_vector->[2]) + ($retval_vector->[3] * $retval_vector->[3]))**0.5;
#    print STDERR "in geometric_algebra_test_2_ipbve.pl $i/$i_MAX, have \$checksum = $checksum\n";

croak('Done for now, croaking');
}

#croak('Done for now, croaking');
