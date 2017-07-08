#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'have $foo = howdy hello ahoy' >>>
# <<< EXECUTE_SUCCESS: 'have changed $foo = HOwdy hello aHOy' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my string $foo  = 'howdy hello ahoy';
print 'have $foo = ', $foo, "\n";

$foo =~ s/ho/HO/gms;
print 'have changed $foo = ', $foo, "\n";

