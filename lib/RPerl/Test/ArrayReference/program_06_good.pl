#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: "before loop" >>>
# <<< EXECUTE_SUCCESS: "$s = [ 'a', 'b', 'c' ]" >>>
# <<< EXECUTE_SUCCESS: "$s = [ 'howdyhowdyhowdy' ]" >>>
# <<< EXECUTE_SUCCESS: "$s = [ 'd', 'e', 'f' ]" >>>
# <<< EXECUTE_SUCCESS: "$s = [ 'doodydoody' ]" >>>
# <<< EXECUTE_SUCCESS: "$s = [ 'g', 'h', 'i' ]" >>>
# <<< EXECUTE_SUCCESS: "after loop" >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

print 'before loop', "\n";

my string_arrayref $s_array_0 = [ 'a', 'b', 'c' ];
my string_arrayref $s_array_1 = [ 'd', 'e', 'f' ];
my string_arrayref $s_array_2 = [ 'g', 'h', 'i' ];
my string_arrayref $s_array_all = [ $s_array_0, [ 'howdy' x 3 ], $s_array_1, [ 'doody' x 2 ], $s_array_2 ];
foreach my string_arrayref $s ( @{$s_array_all} ) {
    print '$s = ', string_arrayref_to_string($s), "\n";
}

print 'after loop', "\n";