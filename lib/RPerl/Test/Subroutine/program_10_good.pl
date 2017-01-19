#!/usr/bin/perl

# Learning RPerl, Section 4.4.1: Variadic Subroutines

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'have $num_args = 1' >>>
# <<< EXECUTE_SUCCESS: 'have $args2 = ' >>>
# <<< EXECUTE_SUCCESS: 'have $args3 = ' >>>
# <<< EXECUTE_SUCCESS: 'have $args4 = ' >>>
# <<< EXECUTE_SUCCESS: 'have $num_args = 2' >>>
# <<< EXECUTE_SUCCESS: 'have $args2 = howdy' >>>
# <<< EXECUTE_SUCCESS: 'have $args3 = ' >>>
# <<< EXECUTE_SUCCESS: 'have $args4 = ' >>>
# <<< EXECUTE_SUCCESS: 'have $num_args = 3' >>>
# <<< EXECUTE_SUCCESS: 'have $args2 = howdy' >>>
# <<< EXECUTE_SUCCESS: 'have $args3 = doody' >>>
# <<< EXECUTE_SUCCESS: 'have $args4 = ' >>>
# <<< EXECUTE_SUCCESS: 'have $num_args = 4' >>>
# <<< EXECUTE_SUCCESS: 'have $args2 = howdy' >>>
# <<< EXECUTE_SUCCESS: 'have $args3 = doody' >>>
# <<< EXECUTE_SUCCESS: 'have $args4 = time' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ SUBROUTINES ]]]

our void $baz_variadic_static = sub {
    # PERLTIDY BUG, failure to put a space between $arg3 and closing )
#    (my integer $num_args, my string_arrayref $args) = @ARG;
    ( my integer $num_args, my string_arrayref $args ) = @ARG;
    my string $arg2 = q{};
    my string $arg3 = q{};
    my string $arg4 = q{};
    if ($num_args >= 2) { $arg2 = $args->[0]; }
    if ($num_args >= 3) { $arg3 = $args->[1]; }
    if ($num_args >= 4) { $arg4 = $args->[2]; }
    print 'have $num_args = ', $num_args, "\n";
    print 'have $args2 = ', $arg2, "\n";
    print 'have $args3 = ', $arg3, "\n";
    print 'have $args4 = ', $arg4, "\n\n";
    return;
};

# [[[ OPERATIONS ]]]
baz_variadic_static(1, []);
baz_variadic_static(2, ['howdy']);
baz_variadic_static(3, ['howdy', 'doody']);
baz_variadic_static(4, ['howdy', 'doody', 'time']);
