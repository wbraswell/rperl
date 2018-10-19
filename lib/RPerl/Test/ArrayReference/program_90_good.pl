#!/usr/bin/env perl

# DEV NOTE, CORRELATION #rp031: NEED UPGRADE: implement proper @array vs $arrayref, %hash vs $hashref, dereferencing, etc.

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: "in main(), have pre-modify $arrayref_1D = [ 0, 2, 4, 6, 8 ]" >>>
# <<< EXECUTE_SUCCESS: "in modify_arrayref, received $arrayref_1D_input =      [ 0, 2, 4, 6, 8 ]" >>>
# <<< EXECUTE_SUCCESS: "in modify_arrayref, have modified $arrayref_1D_input = [ 0, 2, 99, 6, 8 ]" >>>
# <<< EXECUTE_SUCCESS: "in main(), have post-modify $arrayref_1D = [ 0, 2, 99, 6, 8 ]" >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ SUBROUTINES ]]]

sub modify_arrayref {
    { my void $RETURN_TYPE };
    ( my integer_arrayref $arrayref_1D_input ) = @ARG;

    print 'in modify_arrayref, received $arrayref_1D_input =      ', integer_arrayref_to_string($arrayref_1D_input), "\n";
    $arrayref_1D_input->[2] = 99;

    print 'in modify_arrayref, have modified $arrayref_1D_input = ', integer_arrayref_to_string($arrayref_1D_input), "\n";
    return;
}

# [[[ OPERATIONS ]]]

my integer_arrayref $arrayref_1D = [ 0, 2, 4, 6, 8 ];

print 'in main(), have pre-modify $arrayref_1D = ', integer_arrayref_to_string($arrayref_1D), "\n";

modify_arrayref($arrayref_1D);

print 'in main(), have post-modify $arrayref_1D = ', integer_arrayref_to_string($arrayref_1D), "\n";
