#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< TYPE_CHECKING: ON >>>
# <<< EXECUTE_SUCCESS: "have $key_does_exist = TRUE" >>>
# <<< EXECUTE_SUCCESS: "have $key_does_not_exist = FALSE" >>>

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

my boolean $key_does_exist     = exists $foo->{key_0};
my boolean $key_does_not_exist = exists $foo->{key_X};

if ($key_does_exist) {
    print 'have $key_does_exist = TRUE', "\n";
}
else {
    print 'have $key_does_exist = FALSE', "\n";
}

if ($key_does_not_exist) {
    print 'have $key_does_not_exist = TRUE', "\n";
}
else {
    print 'have $key_does_not_exist = FALSE', "\n";
}


