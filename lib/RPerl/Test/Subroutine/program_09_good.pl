#!/usr/bin/perl

# Learning RPerl, Section 4.4: Subroutine Arguments

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'have $bar_int * 3 = 12' >>>
# <<< EXECUTE_SUCCESS: 'have $bar_str x 3 = repeatrepeatrepeat' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ SUBROUTINES ]]]
our void $bar_args_static = sub {
    (my string $arg_type, my integer $bar_int, my string $bar_str) = @ARG;
    if ($arg_type eq 'integer') {
        print 'have $bar_int * 3 = ', $bar_int * 3, "\n";
    }
    else {
        print 'have $bar_str x 3 = ', $bar_str x 3, "\n";
    }
    return;
};

# [[[ OPERATIONS ]]]
bar_args_static('integer', 4, q{});
bar_args_static('string',  0, 'repeat');
