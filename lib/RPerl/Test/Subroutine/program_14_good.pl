#!/usr/bin/env perl

# Learning RPerl, Section 4.5.2: Persistent State

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'inside foo(), received $pseudo_state_in_foo = 0' >>>
# <<< EXECUTE_SUCCESS: 'inside foo(), have modified $pseudo_state_in_foo = 1' >>>
# <<< EXECUTE_SUCCESS: 'inside foo(), received $pseudo_state_in_foo = 1' >>>
# <<< EXECUTE_SUCCESS: 'inside foo(), have modified $pseudo_state_in_foo = 2' >>>
# <<< EXECUTE_SUCCESS: 'inside foo(), received $pseudo_state_in_foo = 2' >>>
# <<< EXECUTE_SUCCESS: 'inside foo(), have modified $pseudo_state_in_foo = 3' >>>
# <<< EXECUTE_SUCCESS: 'inside foo(), received $pseudo_state_in_foo = 3' >>>
# <<< EXECUTE_SUCCESS: 'inside foo(), have modified $pseudo_state_in_foo = 4' >>>
# <<< EXECUTE_SUCCESS: 'inside foo(), received $pseudo_state_in_foo = 4' >>>
# <<< EXECUTE_SUCCESS: 'inside foo(), have modified $pseudo_state_in_foo = 5' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ SUBROUTINES ]]]
sub foo {
    { my integer $RETURN_TYPE };
    ( my integer $pseudo_state_in_foo ) = @ARG;
    print 'inside foo(), received $pseudo_state_in_foo = ', $pseudo_state_in_foo, "\n";
    $pseudo_state_in_foo++;
    print 'inside foo(), have modified $pseudo_state_in_foo = ', $pseudo_state_in_foo, "\n";
    return ($pseudo_state_in_foo);
}

# [[[ OPERATIONS ]]]
my integer $pseudo_state = 0;

$pseudo_state = foo($pseudo_state);
$pseudo_state = foo($pseudo_state);
$pseudo_state = foo($pseudo_state);
$pseudo_state = foo($pseudo_state);
$pseudo_state = foo($pseudo_state);

