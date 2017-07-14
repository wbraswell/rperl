#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'have $foo = HOwdy hello aHOy HOw' >>>
# <<< EXECUTE_SUCCESS: 'have $bax = 3' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]


my string $foo  = 'howdy hello ahoy how';
print 'have pre-regex  $foo = ', $foo, "\n";

my integer $bax = ( $foo =~ s/ho/HO/gms );  # DEFAULT scalar, substitution count

print 'have post-regex $foo = ', $foo, "\n";
print 'have $bax = ', $bax, "\n";
