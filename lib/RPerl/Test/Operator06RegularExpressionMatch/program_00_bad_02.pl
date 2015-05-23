#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECVPAPC02' >>>
# <<< PARSE_ERROR: 'Perl::Critic::Policy::RegularExpressions::RequireExtendedFormatting' >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my string $foo  = 'howdy hello ahoy';
my integer $bar = $foo =~ m/owdy/msx;
my integer $bat = ( $foo =~ m/Hello/msx );
my integer $baz = ( $foo =~ m/\s[Aa]hoy$/ms );
my integer $bax = ( $foo =~ s/ho/HO/gms );

print 'have $foo = ', $foo, "\n";
print 'have $bar = ', $bar, "\n";
print 'have $bat = ', $bat, "\n";
print 'have $baz = ', $baz, "\n";
print 'have $bax = ', $bax, "\n";

$foo = 'Alpha Bravo Charlie 123';
$bar = ( $foo !~ m/owdy/msx );
$bat = ( $foo !~ m/ravo/msx );
$baz = ( $foo !~ m/\s[Cc]harlie\s\d*$/msx );
$bax = ( $foo !~ s/ha/HAHA/gms );

print 'have $foo = ', $foo, "\n";
print 'have $bar = ', $bar, "\n";
print 'have $bat = ', $bat, "\n";
print 'have $baz = ', $baz, "\n";
print 'have $bax = ', $bax, "\n";
