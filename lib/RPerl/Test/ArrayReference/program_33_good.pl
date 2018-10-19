#!/usr/bin/env perl

# Learning RPerl, Section 3.4: Array Length & Negative Indices

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'have $greetings->[-1] = howdy' >>>
# <<< EXECUTE_SUCCESS: 'have $greetings->[-2] = hi' >>>
# <<< EXECUTE_SUCCESS: 'have $greetings->[-3] = hello' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my string_arrayref $greetings        = ['hello', 'hi', 'howdy'];
print 'have $greetings->[-1] = ', $greetings->[-1], "\n";
print 'have $greetings->[-2] = ', $greetings->[-2], "\n";
print 'have $greetings->[-3] = ', $greetings->[-3], "\n";
