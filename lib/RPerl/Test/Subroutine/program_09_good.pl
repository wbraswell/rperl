#!/usr/bin/env perl

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
sub bar_args_static {
    { my void $RETURN_TYPE };
    # PERLTIDY BUG, failure to put a space between $arg3 and closing )
#    (my string $arg_type, my integer $bar_int, my string $bar_str) = @ARG;
    ( my string $arg_type, my integer $bar_int, my string $bar_str ) = @ARG;

# NEED UPGRADE, CORRELATION #rp035: allow multi-line subroutines & other code blocks, where they would be less than 160 chars if on a single line
#    if ($arg_type eq 'integer') {
#        print 'have $bar_int * 3 = ', $bar_int * 3, "\n";
#    }
#    else {
#        print 'have $bar_str x 3 = ', $bar_str x 3, "\n";
#    }
    if ($arg_type eq 'integer') { print 'have $bar_int * 3 = ', $bar_int * 3, "\n"; }
    else { print 'have $bar_str x 3 = ', $bar_str x 3, "\n"; }
    return;
}

# [[[ OPERATIONS ]]]
bar_args_static('integer', 4, q{});
bar_args_static('string',  0, 'repeat');
