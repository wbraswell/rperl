#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: "have number_arrayref_to_string_compact($row_1D) = [0.001_002,2,45_676.555_444_321,6,-8.01]" >>>
# <<< EXECUTE_SUCCESS: "have number_arrayref_to_string($row_1D)         = [ 0.001_002, 2, 45_676.555_444_321, 6, -8.01 ]" >>>
# <<< EXECUTE_SUCCESS: "have number_arrayref_to_string_pretty($row_1D)  = [ 0.001_002, 2, 45_676.555_444_321, 6, -8.01 ]" >>>
# <<< EXECUTE_SUCCESS: "have number_arrayref_to_string_expand($row_1D)  =" >>>
# <<< EXECUTE_SUCCESS: "["
# <<< EXECUTE_SUCCESS: "    0.001_002,"
# <<< EXECUTE_SUCCESS: "    2,"
# <<< EXECUTE_SUCCESS: "    45_676.555_444_321,"
# <<< EXECUTE_SUCCESS: "    6,"
# <<< EXECUTE_SUCCESS: "    -8.01"
# <<< EXECUTE_SUCCESS: "]"
# <<< EXECUTE_SUCCESS: "have number_arrayref_to_string_format($row_1D, -2, 0) = [0.001_002,2,45_676.555_444_321,6,-8.01]" >>>
# <<< EXECUTE_SUCCESS: "have number_arrayref_to_string_format($row_1D, -1, 0) = [ 0.001_002, 2, 45_676.555_444_321, 6, -8.01 ]" >>>
# <<< EXECUTE_SUCCESS: "have number_arrayref_to_string_format($row_1D,  0, 0) = [ 0.001_002, 2, 45_676.555_444_321, 6, -8.01 ]" >>>
# <<< EXECUTE_SUCCESS: "have number_arrayref_to_string_format($row_1D,  1, 0) =" >>>
# <<< EXECUTE_SUCCESS: "["
# <<< EXECUTE_SUCCESS: "    0.001_002,"
# <<< EXECUTE_SUCCESS: "    2,"
# <<< EXECUTE_SUCCESS: "    45_676.555_444_321,"
# <<< EXECUTE_SUCCESS: "    6,"
# <<< EXECUTE_SUCCESS: "    -8.01"
# <<< EXECUTE_SUCCESS: "]"
# <<< EXECUTE_SUCCESS: "have number_arrayref_to_string_format($row_1D, -2, 1) = [0.001_002,2,45_676.555_444_321,6,-8.01]" >>>
# <<< EXECUTE_SUCCESS: "have number_arrayref_to_string_format($row_1D, -1, 1) = [ 0.001_002, 2, 45_676.555_444_321, 6, -8.01 ]" >>>
# <<< EXECUTE_SUCCESS: "have number_arrayref_to_string_format($row_1D,  0, 1) = [ 0.001_002, 2, 45_676.555_444_321, 6, -8.01 ]" >>>
# <<< EXECUTE_SUCCESS: "have number_arrayref_to_string_format($row_1D,  1, 1) =" >>>
# <<< EXECUTE_SUCCESS: "    ["
# <<< EXECUTE_SUCCESS: "        0.001_002,"
# <<< EXECUTE_SUCCESS: "        2,"
# <<< EXECUTE_SUCCESS: "        45_676.555_444_321,"
# <<< EXECUTE_SUCCESS: "        6,"
# <<< EXECUTE_SUCCESS: "        -8.01"
# <<< EXECUTE_SUCCESS: "    ]"

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my number_arrayref $row_1D = [ 0.001_002, 2, 45_676.555_444_321, 6, -8.01 ];

print 'have number_arrayref_to_string_compact($row_1D) = ', number_arrayref_to_string_compact($row_1D), "\n";
print 'have number_arrayref_to_string($row_1D)         = ', number_arrayref_to_string($row_1D), "\n";
print 'have number_arrayref_to_string_pretty($row_1D)  = ', number_arrayref_to_string_pretty($row_1D), "\n";
print 'have number_arrayref_to_string_expand($row_1D)  = ', "\n", number_arrayref_to_string_expand($row_1D), "\n";

print 'have number_arrayref_to_string_format($row_1D, -2, 0) = ', number_arrayref_to_string_format($row_1D, -2, 0), "\n";
print 'have number_arrayref_to_string_format($row_1D, -1, 0) = ', number_arrayref_to_string_format($row_1D, -1, 0), "\n";
print 'have number_arrayref_to_string_format($row_1D,  0, 0) = ', number_arrayref_to_string_format($row_1D, 0, 0), "\n";
print 'have number_arrayref_to_string_format($row_1D,  1, 0) = ', "\n", number_arrayref_to_string_format($row_1D, 1, 0), "\n";

print 'have number_arrayref_to_string_format($row_1D, -2, 1) = ', number_arrayref_to_string_format($row_1D, -2, 1), "\n";
print 'have number_arrayref_to_string_format($row_1D, -1, 1) = ', number_arrayref_to_string_format($row_1D, -1, 1), "\n";
print 'have number_arrayref_to_string_format($row_1D,  0, 1) = ', number_arrayref_to_string_format($row_1D, 0, 1), "\n";
print 'have number_arrayref_to_string_format($row_1D,  1, 1) = ', "\n", number_arrayref_to_string_format($row_1D, 1, 1), "\n";
