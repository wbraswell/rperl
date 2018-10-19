#!/usr/bin/env perl

# Learning RPerl, Section 4.4.1: Variadic Subroutines

# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPARP00' >>>
# <<< PARSE_ERROR: 'Unexpected Token:  my' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ SUBROUTINES ]]]
sub baz_variadic_dynamic {
    my $num_args = shift @ARG;
    my $arg2 = q{};
    my $arg3 = q{};
    my $arg4 = q{};
    if ($num_args >= 2) { $arg2 = shift @ARG; }
    if ($num_args >= 3) { $arg3 = shift @ARG; }
    if ($num_args >= 4) { $arg4 = shift @ARG; }
    print 'have $num_args = ', $num_args, "\n";
    print 'have $args2 = ', $arg2, "\n";
    print 'have $args3 = ', $arg3, "\n";
    print 'have $args4 = ', $arg4, "\n\n";
    return;
}

# [[[ OPERATIONS ]]]
baz_variadic_dynamic(1);
baz_variadic_dynamic(2, 'howdy');
baz_variadic_dynamic(3, 'howdy', 'doody');
baz_variadic_dynamic(4, 'howdy', 'doody', 'time');


