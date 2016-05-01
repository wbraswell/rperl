#!/usr/bin/perl

use RPerl;
use strict;
use warnings;
our $VERSION = 0.002_000;

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# common usage
#my string $foo = 'abc123!?*';
#my string $bar = substr $foo, 2;
#my string $bat = substr $foo, 2, 3;
#my string $bax = substr $foo, 2, 3, 'd45';

# negative offset
#my string $foo = 'abc123!?*';
#my string $bar = substr $foo, -4;
#my string $bat = substr $foo, -4, 3;
#my string $bax = substr $foo, -4, 3, 'd45';

# negative LENGTH
#my string $foo = 'abc123!?*';
#my string $bar = substr $foo, 2;
#my string $bat = substr $foo, 2, -3;
#my string $bax = substr $foo, 2, -3, 'd456';

# negative OFFSET and LENGTH
#my string $foo = 'abc123!?*';
#my string $bar = substr $foo, -6;
#my string $bat = substr $foo, -6, -2;
#my string $bax = substr $foo, -6, -2, 'd456';


# LENGTH less than REPLACEMENT length
#my string $foo = 'abc123!?*';
#my string $bar = substr $foo, 2;
#my string $bat = substr $foo, 2, 3;
#my string $bax = substr $foo, 2, 3, 'd456789';

# LENGTH greater than REPLACEMENT length, empty replacement string
my string $foo = 'abc123!?*';
my string $bar = substr $foo, 2;
my string $bat = substr $foo, 2, 3;
my string $bax = substr $foo, 2, 3, q{};

print 'have $foo = ' . $foo . "\n";
print 'have $bar = ' . $bar . "\n";
print 'have $bat = ' . $bat . "\n";
print 'have $bax = ' . $bax . "\n";

