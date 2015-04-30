#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< RUN_ERROR: 'ERROR EAVRV10, BOUND-CHECKING MISMATCH: Argument $input_bivector is not of magnitude 4' >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.000_001;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator

# [[[ INCLUDES ]]]
use RPerl::Algorithm::Math::GeometricAlgebra;

# [[[ OPERATIONS ]]]
my number_arrayref $retval_vector;
my number_arrayref $input_bivector;
my number_arrayref $input_vector;
$input_bivector = [-999999, 3.0, 4.0, 12.0, 0.0];
$input_vector = [-999999, 3.0, 4.0, -12.0];
$retval_vector = inner_product__bivector_vector_euclidean( $input_bivector,
    $input_vector );
print Dumper($retval_vector) . "\n";
