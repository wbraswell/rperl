#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'have $foo = howdy dowdy hello ahoy' >>>
# <<< EXECUTE_SUCCESS: "have $bar = $foo =~ m/owdy/gxms = '1'" >>>

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

#use Data::Dumper;

my string $foo  = 'howdy dowdy hello ahoy';

my integer $bar = $foo =~ m/owdy/gxms;  # DEFAULT scalar, truth value matched
#my string_arrayref $bar = [$foo =~ m/owdy/gxms];  # array ref, matches
#my integer $bar = scalar @{[$foo =~ m/owdy/gxms]};  # scalar, match count

print 'have $foo = ', $foo, "\n";
print q{have $bar = $foo =~ m/owdy/gxms = '}, $bar, q{'}, "\n";
#print q{have $bar = $foo =~ m/owdy/gxms = '}, Dumper($bar), q{'}, "\n";

