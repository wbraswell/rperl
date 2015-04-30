#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< RUN_ERROR: 'ERROR ENVAVRV03, TYPE-CHECKING MISMATCH' >>>
# <<< RUN_ERROR: 'number_arrayref element value expected but non-number value found at index 2' >>>

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
my number_arrayref $input_vector_1 = [ -999_999, 3.0, 'howdy', 12.0 ];
my number_arrayref $input_vector_2 = [ -999_999, 3.0, 4.0,     -12.0 ];
my number $retval_number
    = inner_product__vector_vector_euclidean( $input_vector_1,
    $input_vector_2 );
print $retval_number . "\n";
