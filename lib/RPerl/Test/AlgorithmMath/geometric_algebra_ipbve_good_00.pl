#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'undef' >>>
# <<< EXECUTE_SUCCESS: '-10.153846' >>>
# <<< EXECUTE_SUCCESS: '3' >>>
# <<< EXECUTE_SUCCESS: '1.538461' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.000_020;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator

# [[[ INCLUDES ]]]
use RPerl::Algorithm::Math::GeometricAlgebra;

# [[[ OPERATIONS ]]]
my number_arrayref $retval_vector;
my number_arrayref $input_bivector;
my number_arrayref $input_vector;

# [ undef, -10.1538461538462, 3, 1.53846153846154 ];
$input_bivector = [ -999_999, 3.0 / 13.0, 4.0 / 13.0, 12.0 / 13.0 ];
$input_vector = [ -999_999, 3.0, 4.0, 12.0 ];
$retval_vector = inner_product__bivector_vector_euclidean( $input_bivector,
    $input_vector );
print Dumper($retval_vector) . "\n";

# NEED FIX: support 'undef' (AKA null) in FOO_arrayref_to_string(), or implement arrayref_to_string()
#print number_arrayref_to_string($retval_vector) . "\n";
