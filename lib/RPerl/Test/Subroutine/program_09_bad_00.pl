#!/usr/bin/perl

# Learning RPerl, Section 4.4: Subroutine Arguments

# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPARP00' >>>
# <<< PARSE_ERROR: 'Unexpected Token:  bar_args_dynamic' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ SUBROUTINES ]]]
sub bar_args_dynamic {
    my $arg_type = shift @ARG;
    if ($arg_type eq 'integer') {
        my $bar_int = shift @ARG;
        print 'have $bar_int * 3 = ', $bar_int * 3, "\n";
    }
    else {
        my $bar_str = shift @ARG;
        print 'have $bar_str x 3 = ', $bar_str x 3, "\n";
    }
    return;
}

# [[[ OPERATIONS ]]]
bar_args_dynamic('integer', 4);
bar_args_dynamic('string', 'repeat');
