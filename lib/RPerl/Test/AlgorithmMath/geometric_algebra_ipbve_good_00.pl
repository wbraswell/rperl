#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< RUN_SUCCESS: 'undef' >>>
# <<< RUN_SUCCESS: '-10.153846' >>>
# <<< RUN_SUCCESS: '3' >>>
# <<< RUN_SUCCESS: '1.538461' >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.000_020;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator

# [[[ INCLUDES ]]]
use RPerl::Algorithm::Math::GeometricAlgebra;

# [[[ OPERATIONS ]]]
my number__array_ref $retval_vector;
my number__array_ref $input_bivector;
my number__array_ref $input_vector;

# [ undef, -10.1538461538462, 3, 1.53846153846154 ];
$input_bivector = [ -999_999, 3.0 / 13.0, 4.0 / 13.0, 12.0 / 13.0 ];
$input_vector = [ -999_999, 3.0, 4.0, 12.0 ];
$retval_vector = inner_product__bivector_vector_euclidean( $input_bivector,
    $input_vector );
print Dumper($retval_vector) . "\n";

# NEED FIX: support 'undef' (AKA null) in FOO__array_ref__stringify(), or implement array_ref__stringify()
#print number__array_ref__stringify($retval_vector) . "\n";
