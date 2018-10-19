#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'Hello, World #(1, 1, 1)!' >>>
# <<< EXECUTE_SUCCESS: 'Hello, World #(1, 1, 2)!' >>>
# <<< EXECUTE_SUCCESS: 'Hello, World #(1, 2, 1)!' >>>
# <<< EXECUTE_SUCCESS: 'Hello, World #(1, 2, 2)!' >>>
# <<< EXECUTE_SUCCESS: 'Hello, World #(1, 3, 1)!' >>>
# <<< EXECUTE_SUCCESS: 'Hello, World #(1, 3, 2)!' >>>
# <<< EXECUTE_SUCCESS: 'Hello, World #(2, 1, 1)!' >>>
# <<< EXECUTE_SUCCESS: 'Hello, World #(2, 1, 2)!' >>>
# <<< EXECUTE_SUCCESS: 'Hello, World #(2, 2, 1)!' >>>
# <<< EXECUTE_SUCCESS: 'Hello, World #(2, 2, 2)!' >>>
# <<< EXECUTE_SUCCESS: 'Hello, World #(2, 3, 1)!' >>>
# <<< EXECUTE_SUCCESS: 'Hello, World #(2, 3, 2)!' >>>
# <<< EXECUTE_SUCCESS: 'Hello, World #(3, 1, 1)!' >>>
# <<< EXECUTE_SUCCESS: 'Hello, World #(3, 1, 2)!' >>>
# <<< EXECUTE_SUCCESS: 'Hello, World #(3, 2, 1)!' >>>
# <<< EXECUTE_SUCCESS: 'Hello, World #(3, 2, 2)!' >>>
# <<< EXECUTE_SUCCESS: 'Hello, World #(3, 3, 1)!' >>>
# <<< EXECUTE_SUCCESS: 'Hello, World #(3, 3, 2)!' >>>
# <<< EXECUTE_SUCCESS: 'Hello, World #(4, 1, 1)!' >>>
# <<< EXECUTE_SUCCESS: 'Hello, World #(4, 1, 2)!' >>>
# <<< EXECUTE_SUCCESS: 'Hello, World #(4, 2, 1)!' >>>
# <<< EXECUTE_SUCCESS: 'Hello, World #(4, 2, 2)!' >>>
# <<< EXECUTE_SUCCESS: 'Hello, World #(4, 3, 1)!' >>>
# <<< EXECUTE_SUCCESS: 'Hello, World #(4, 3, 2)!' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my integer $i = 0;
while ( $i < 4 ) {
    my integer $j = 0;
    while ( $j < 3 ) {
        my integer $k = 0;
        while ( $k < 2 ) {
            print 'Hello, World #(', ( $i + 1 ), ', ', ( $j + 1 ), ', ', ( $k + 1 ), q{)!}, "\n";
            $k++;
        }
        $j++;
    }
    $i++;
}
