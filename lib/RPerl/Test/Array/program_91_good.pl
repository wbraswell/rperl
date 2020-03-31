#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: "in main(), have pre-modify \@array_1D_0 = [ 0, 2, 4, 6, 8 ]" >>>
# <<< EXECUTE_SUCCESS: "in main(), have pre-modify \@array_1D_1 = [ 1, 3, 5, 7, 9 ]" >>>
# <<< EXECUTE_SUCCESS: "in modify_arrayrefs(), received $array_1D_input_0 =      [ 0, 2, 4, 6, 8 ]" >>>
# <<< EXECUTE_SUCCESS: "in modify_arrayrefs(), received $array_1D_input_1 =      [ 1, 3, 5, 7, 9 ]" >>>
# <<< EXECUTE_SUCCESS: "in modify_arrayrefs(), have modified $array_1D_input_0 = [ 0, 2, 99, 6, 8 ]" >>>
# <<< EXECUTE_SUCCESS: "in modify_arrayrefs(), have modified $array_1D_input_1 = [ 1, 3, 66, 7, 9 ]" >>>
# <<< EXECUTE_SUCCESS: "in main(), have post-modify \@array_1D_0 = [ 0, 2, 99, 6, 8 ]" >>>
# <<< EXECUTE_SUCCESS: "in main(), have post-modify \@array_1D_1 = [ 1, 3, 66, 7, 9 ]" >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ SUBROUTINES ]]]

sub modify_arrayrefs {
    { my void $RETURN_TYPE };
    ( my integer_arrayref $array_1D_input_0, my integer_arrayref $array_1D_input_1 ) = @ARG;

    print 'in modify_arrayrefs(), received $array_1D_input_0 =      ', integer_arrayref_to_string($array_1D_input_0), "\n";
    print 'in modify_arrayrefs(), received $array_1D_input_1 =      ', integer_arrayref_to_string($array_1D_input_1), "\n";
    $array_1D_input_0->[2] = 99;
    $array_1D_input_1->[2] = 66;

    print 'in modify_arrayrefs(), have modified $array_1D_input_0 = ', integer_arrayref_to_string($array_1D_input_0), "\n";
    print 'in modify_arrayrefs(), have modified $array_1D_input_1 = ', integer_arrayref_to_string($array_1D_input_1), "\n";

    return;
}

# [[[ OPERATIONS ]]]

my integer_array @array_1D_0 = ( 0, 2, 4, 6, 8 );
my integer_array @array_1D_1 = ( 1, 3, 5, 7, 9 );

print 'in main(), have pre-modify \\@array_1D_0 = ', integer_arrayref_to_string(\@array_1D_0), "\n";
print 'in main(), have pre-modify \\@array_1D_1 = ', integer_arrayref_to_string(\@array_1D_1), "\n";

modify_arrayrefs(\@array_1D_0, \@array_1D_1);

print 'in main(), have post-modify \\@array_1D_0 = ', integer_arrayref_to_string(\@array_1D_0), "\n";
print 'in main(), have post-modify \\@array_1D_1 = ', integer_arrayref_to_string(\@array_1D_1), "\n";
