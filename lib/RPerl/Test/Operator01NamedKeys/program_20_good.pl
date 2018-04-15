#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< TYPE_CHECKING: ON >>>
# <<< EXECUTE_SUCCESS: "have string_arrayref_to_string($foo_keys) = [ 'key_" >>>
# <<< EXECUTE_SUCCESS: "have integer_arrayref_hashref_to_string_pretty($foo) =" >>>
# <<< EXECUTE_SUCCESS: "{" >>>
# <<< EXECUTE_SUCCESS: "    'key_0' => [ 0, 1, 2, 3, 4 ]" >>>
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

# homogeneous 2-dimensional hash of arrays of integers
# DEV NOTE: must be on single one to match auto-generated Perl::Tidy output code
my integer_arrayref_hashref $foo = { key_0 => [ 0, 1, 2, 3, 4 ], key_1 => [ 5, 6, 7, 8, 9 ], key_2 => [ 0, -1, -2, -3, -4 ], key_3 => [ -5, -6, -7, -8, -9 ] };

my string_arrayref $foo_keys = [keys %{$foo}];

print 'have string_arrayref_to_string($foo_keys) = ', string_arrayref_to_string($foo_keys), "\n";
#print 'have string_arrayref_to_string([keys($foo)]) = ', string_arrayref_to_string([keys %{$foo}]), "\n";

print 'have integer_arrayref_hashref_to_string_pretty($foo) = ', "\n", integer_arrayref_hashref_to_string_pretty($foo), "\n";

