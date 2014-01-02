#!/usr/bin/perl
use strict;
use warnings;
our $VERSION = 0.002_000;
use Carp;
use RPerl;

# [[[ SETUP ]]]

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  ## RPERL USER DEFAULT optionally allow numeric values, print operator
## nfo critic qw(ProhibitUnreachableCode)  ## RPERL USER allow unreachable test code

# UNCOMMENT TO ENABLE PERL TYPES FOR C++ OPS
#rperltypes::types_enable('PERL');

# UNCOMMENT TO ENABLE C++ TYPES FOR C++ OPS
rperltypes::types_enable('CPP');

# TOGGLE COMMENT TO ENABLE C++ OPS
#use RPerl_test_00;    # choose ONE of this
use RPerl_test_00_cpp;
RPerl_test_00_cpp::cpp_load();
RPerl_test_00_cpp::cpp_link();    # OR this

# disabled to avoid attempt to compile RPerl_test_00__*() from RPerl to CPP
#print {*STDERR} q{in RPerl_test_00.pl, have RPerl_test_00__ops() = '} . RPerl_test_00__ops() . "'\n"();
#print {*STDERR} q{in RPerl_test_00.pl, have RPerl_test_00__types() = '} . RPerl_test_00__types() . "'\n"();

greet_planet(23);

#greet_planet();  # EIV00/usage
#greet_planet(undef);  # EIV00
#greet_planet(2.3);  # EIV01
#greet_planet('coffee');  # EIV01
#greet_planet([2]);  # EIV01
#greet_planet({a_key=>2});  # EIV01

#greet_planet( 23, 'coffee' );

#greet_planet( 2, undef );  # EPV00
#greet_planet( 2, 2 );  # EPV01
#greet_planet( 2, 2.3 );  # EPV01

#greet_planet( 2, 'coffee', [ -22.3, 44.5, 67.8912345 ] );

#greet_planet( 2, undef, [ -22.3, 44.5, 67.8912345 ] );  # EPV00
#greet_planet( 2.3, 'coffee', [ -22.3, 44.5, 67.8912345 ] );  # EIV01
#greet_planet( 2, 23, [ -22.3, 44.5, 67.8912345 ] );  # EPV01
#greet_planet( 2, 'coffee', [ -22.3, 44.5, 67.8912345, 'not a number' ] );  # ENVAVRV03
