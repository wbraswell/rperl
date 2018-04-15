#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: "Production rule Loop matched by LoopForEach, iteration item at $my_key = 'c_key', $my_hash->{$my_key} = 'clarabell'" >>>
# <<< EXECUTE_SUCCESS: "Production rule Loop matched by LoopForEach, iteration item at $my_key = 'a_key', $my_hash->{$my_key} = 'howdy'" >>>
# <<< EXECUTE_SUCCESS: "Production rule Loop matched by LoopForEach, iteration item at $my_key = 'b_key', $my_hash->{$my_key} = 'doody'" >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my string_hashref $my_hash = { a_key => 'howdy', b_key => 'doody', c_key => 'clarabell' };
foreach my string $my_key ( keys %{$my_hash} ) {
    print 'Production rule Loop matched by LoopForEach, iteration item at $my_key = ', q{'}, $my_key, q{'}, ', $my_hash->{$my_key} = ', q{'}, $my_hash->{$my_key}, q{'}, "\n";
}
