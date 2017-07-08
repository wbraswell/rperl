#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'have $foo = HOwdy hello aHOy' >>>
# <<< EXECUTE_SUCCESS: 'have $bax = 2' >>>
# <<< EXECUTE_SUCCESS: 'have $foo = AlpHAHA Bravo CHAHArlie 123' >>>
# <<< EXECUTE_SUCCESS: 'have $bax =' >>>

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
my integer $bax = ( $foo =~ s/ho/HO/gms );

print 'have $foo = ', $foo, "\n";
print 'have $bax = ', $bax, "\n";

$foo = 'Alpha Bravo Charlie 123';
$bax = ( $foo !~ s/ha/HAHA/gms );

print 'have $foo = ', $foo, "\n";
print 'have $bax = ', $bax, "\n";

