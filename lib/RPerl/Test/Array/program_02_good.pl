#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: "before loop" >>>
# <<< EXECUTE_SUCCESS: "$i = 17" >>>
# <<< EXECUTE_SUCCESS: "$i = 23" >>>
# <<< EXECUTE_SUCCESS: "$i = 42" >>>
# <<< EXECUTE_SUCCESS: "$i = 1701" >>>
# <<< EXECUTE_SUCCESS: "$i = 2112" >>>
# <<< EXECUTE_SUCCESS: "after loop" >>>
# <<< EXECUTE_SUCCESS: "have integer_arrayref_to_string_compact(\@i_array) =" >>>
# <<< EXECUTE_SUCCESS: "[17,23,42,1_701,2_112]" >>>
# <<< EXECUTE_SUCCESS: "have integer_arrayref_to_string(\@i_array) =" >>>
# <<< EXECUTE_SUCCESS: "[ 17, 23, 42, 1_701, 2_112 ]" >>>
# <<< EXECUTE_SUCCESS: "have integer_arrayref_to_string_pretty(\@i_array) =" >>>
# <<< EXECUTE_SUCCESS: "[ 17, 23, 42, 1_701, 2_112 ]" >>>
# <<< EXECUTE_SUCCESS: "have integer_arrayref_to_string_expand(\@i_array) =" >>>
# <<< EXECUTE_SUCCESS: "[" >>>
# <<< EXECUTE_SUCCESS: "    17," >>>
# <<< EXECUTE_SUCCESS: "    23," >>>
# <<< EXECUTE_SUCCESS: "    42," >>>
# <<< EXECUTE_SUCCESS: "    1_701," >>>
# <<< EXECUTE_SUCCESS: "    2_112" >>>
# <<< EXECUTE_SUCCESS: "]" >>>

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

my integer_arrayref @i_array = ( 17, 23, 42, 1_701, 2_112 );
foreach my integer $i ( @i_array ) {
    print '$i = ', $i, "\n";
}

print 'after loop', "\n";

print 'have integer_arrayref_to_string_compact(\\@i_array) = ', "\n", integer_arrayref_to_string_compact(\@i_array), "\n";

print 'have integer_arrayref_to_string(\\@i_array) = ', "\n", integer_arrayref_to_string(\@i_array), "\n";

print 'have integer_arrayref_to_string_pretty(\\@i_array) = ', "\n", integer_arrayref_to_string_pretty(\@i_array), "\n";

print 'have integer_arrayref_to_string_expand(\\@i_array) = ', "\n", integer_arrayref_to_string_expand(\@i_array), "\n";

