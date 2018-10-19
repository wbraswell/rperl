#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'outside conditional, have $foo = 0' >>>
# <<< EXECUTE_SUCCESS: 'inside  conditional, have $bar = 2' >>>
# <<< EXECUTE_SUCCESS: 'outside conditional, have $foo = 1' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitCascadingIfElse)  # USER DEFAULT 9: allow cascading conditional chains until given-when is implemented

# [[[ OPERATIONS ]]]

my integer $foo = 0;
print 'outside conditional, have $foo = ', $foo, "\n";

if ( $foo < 3 ) {
    $foo++;
    my integer $bar = $foo * 2;
    print 'inside  conditional, have $bar = ', $bar, "\n";
}

print 'outside conditional, have $foo = ', $foo, "\n";
