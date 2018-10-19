#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'have $foo = howdy hello ahoy' >>>
# <<< EXECUTE_SUCCESS: 'have $bar = 1' >>>
# <<< EXECUTE_SUCCESS: 'have $foo = howdy hello ahoy' >>>
# <<< EXECUTE_SUCCESS: 'have $bar = 1' >>>
# <<< EXECUTE_SUCCESS: 'have $foo = Alpha Bravo Charlie 123' >>>
# <<< EXECUTE_SUCCESS: 'have $bar = 1' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

# BIND, LITERAL PATTERN

my string $foo  = 'howdy hello ahoy';
my integer $bar = $foo =~ m/owdy/gxms;

print 'have $foo = ', $foo, "\n";
print 'have $bar = ', $bar, "\n";

# BIND, CHARACTER CLASS PATTERN

$foo  = 'howdy hello ahoy';
$bar = $foo =~ m/h[\w]+/gxms;

print 'have $foo = ', $foo, "\n";
print 'have $bar = ', $bar, "\n";

# BIND NOT, LITERAL PATTERN

$foo = 'Alpha Bravo Charlie 123';
$bar = ( $foo !~ m/owdy/gxms );

print 'have $foo = ', $foo, "\n";
print 'have $bar = ', $bar, "\n";
