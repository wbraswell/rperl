#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: '$s = `~' >>>
# <<< EXECUTE_SUCCESS: '$s = ~!' >>>
# <<< EXECUTE_SUCCESS: '$s = !@' >>>
# <<< EXECUTE_SUCCESS: '$s = @$' >>>
# <<< EXECUTE_SUCCESS: '$s = $%' >>>
# <<< EXECUTE_SUCCESS: '$s = %^' >>>
# <<< EXECUTE_SUCCESS: '$s = ^&' >>>
# <<< EXECUTE_SUCCESS: '$s = &*' >>>
# <<< EXECUTE_SUCCESS: '$s = *-' >>>
# <<< EXECUTE_SUCCESS: '$s = -_' >>>
# <<< EXECUTE_SUCCESS: '$s = _=' >>>
# <<< EXECUTE_SUCCESS: '$s = =+' >>>
# <<< EXECUTE_SUCCESS: '$s = +[' >>>
# <<< EXECUTE_SUCCESS: '$s = []' >>>
# <<< EXECUTE_SUCCESS: '$s = ]{' >>>
# <<< EXECUTE_SUCCESS: '$s = {}' >>>
# <<< EXECUTE_SUCCESS: '$s = }|' >>>
# <<< EXECUTE_SUCCESS: '$s = |;' >>>
# <<< EXECUTE_SUCCESS: '$s = ;:' >>>
# <<< EXECUTE_SUCCESS: "$s = :'" >>>
# <<< EXECUTE_SUCCESS: "$s = '"  >>>
# <<< EXECUTE_SUCCESS: '$s = ".' >>>
# <<< EXECUTE_SUCCESS: '$s = .<' >>>
# <<< EXECUTE_SUCCESS: '$s = <>' >>>
# <<< EXECUTE_SUCCESS: '$s = >/' >>>
# <<< EXECUTE_SUCCESS: '$s = /?' >>>
# <<< EXECUTE_SUCCESS: '$s = ?`' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my string_arrayref $s_array = [qw(`~ ~! !@ @$ $% %^ ^& &* *- -_ _= =+ +[ [] ]{ {} }| |; ;: :' '" ". .< <> >/ /? ?`)];
foreach my string $s ( @{$s_array} ) {
    print '$s = ', $s, "\n";
}
