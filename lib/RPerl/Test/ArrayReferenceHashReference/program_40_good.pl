#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< TYPE_CHECKING: ON >>>

# <<< EXECUTE_SUCCESS: "have number_arrayref_hashref_to_string_compact($foo) =" >>>
# <<< EXECUTE_SUCCESS: "{'key_0'=>[0.1,1.2,2.34,3.45,4.56],'key_1'=>[5.6,6.7,7.89,8.9,9.01],'key_2'=>[0.123_456,-1,-2,-3.456,-4],'key_3'=>[-5,-6.789_012,-7,-8,-9.012]}" >>>
# <<< EXECUTE_SUCCESS: "have number_arrayref_hashref_to_string($foo) =" >>>
# <<< EXECUTE_SUCCESS: "{ 'key_0' => [ 0.1, 1.2, 2.34, 3.45, 4.56 ], 'key_1' => [ 5.6, 6.7, 7.89, 8.9, 9.01 ], 'key_2' => [ 0.123_456, -1, -2, -3.456, -4 ], 'key_3' => [ -5, -6.789_012, -7, -8, -9.012 ] }" >>>
# <<< EXECUTE_SUCCESS: "have number_arrayref_hashref_to_string_pretty($foo) =" >>>
# <<< EXECUTE_SUCCESS: "{" >>>
# <<< EXECUTE_SUCCESS: "    'key_0' => [ 0.1, 1.2, 2.34, 3.45, 4.56 ]," >>>
# <<< EXECUTE_SUCCESS: "    'key_1' => [ 5.6, 6.7, 7.89, 8.9, 9.01 ]," >>>
# <<< EXECUTE_SUCCESS: "    'key_2' => [ 0.123_456, -1, -2, -3.456, -4 ]," >>>
# <<< EXECUTE_SUCCESS: "    'key_3' => [ -5, -6.789_012, -7, -8, -9.012 ]" >>>
# <<< EXECUTE_SUCCESS: "}" >>>
# <<< EXECUTE_SUCCESS: "have number_arrayref_hashref_to_string_expand($foo) =" >>>
# <<< EXECUTE_SUCCESS: "{" >>>
# <<< EXECUTE_SUCCESS: "    'key_0' =>" >>>
# <<< EXECUTE_SUCCESS: "    [" >>>
# <<< EXECUTE_SUCCESS: "        0.1," >>>
# <<< EXECUTE_SUCCESS: "        1.2," >>>
# <<< EXECUTE_SUCCESS: "        2.34," >>>
# <<< EXECUTE_SUCCESS: "        3.45," >>>
# <<< EXECUTE_SUCCESS: "        4.56" >>>
# <<< EXECUTE_SUCCESS: "    ]," >>>
# <<< EXECUTE_SUCCESS: "    'key_1' =>" >>>
# <<< EXECUTE_SUCCESS: "    [" >>>
# <<< EXECUTE_SUCCESS: "        5.6," >>>
# <<< EXECUTE_SUCCESS: "        6.7," >>>
# <<< EXECUTE_SUCCESS: "        7.89," >>>
# <<< EXECUTE_SUCCESS: "        8.9," >>>
# <<< EXECUTE_SUCCESS: "        9.01" >>>
# <<< EXECUTE_SUCCESS: "    ]," >>>
# <<< EXECUTE_SUCCESS: "    'key_2' =>" >>>
# <<< EXECUTE_SUCCESS: "    [" >>>
# <<< EXECUTE_SUCCESS: "        0.123_456," >>>
# <<< EXECUTE_SUCCESS: "        -1," >>>
# <<< EXECUTE_SUCCESS: "        -2," >>>
# <<< EXECUTE_SUCCESS: "        -3.456," >>>
# <<< EXECUTE_SUCCESS: "        -4" >>>
# <<< EXECUTE_SUCCESS: "    ]," >>>
# <<< EXECUTE_SUCCESS: "    'key_3' =>" >>>
# <<< EXECUTE_SUCCESS: "    [" >>>
# <<< EXECUTE_SUCCESS: "        -5," >>>
# <<< EXECUTE_SUCCESS: "        -6.789_012," >>>
# <<< EXECUTE_SUCCESS: "        -7," >>>
# <<< EXECUTE_SUCCESS: "        -8," >>>
# <<< EXECUTE_SUCCESS: "        -9.012" >>>
# <<< EXECUTE_SUCCESS: "    ]" >>>
# <<< EXECUTE_SUCCESS: "}" >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

# homogeneous 2-dimensional hash of arrays of numbers
# DEV NOTE: must be on single one to match auto-generated Perl::Tidy output code
my number_arrayref_hashref $foo = { key_0 => [ 0.1, 1.2, 2.34, 3.45, 4.56 ], key_1 => [ 5.6, 6.7, 7.89, 8.90, 9.01 ], key_2 => [ 0.123_456, -1, -2, -3.456, -4 ], key_3 => [ -5, -6.789_012, -7, -8, -9.012 ] };

print 'have number_arrayref_hashref_to_string_compact($foo) = ', "\n", number_arrayref_hashref_to_string_compact($foo), "\n";

print 'have number_arrayref_hashref_to_string($foo) = ', "\n", number_arrayref_hashref_to_string($foo), "\n";

print 'have number_arrayref_hashref_to_string_pretty($foo) = ', "\n", number_arrayref_hashref_to_string_pretty($foo), "\n";

print 'have number_arrayref_hashref_to_string_expand($foo) = ', "\n", number_arrayref_hashref_to_string_expand($foo), "\n";

