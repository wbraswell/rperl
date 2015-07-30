#!/usr/bin/perl
use strict;
use warnings;
use RPerl::AfterFilter;
our $VERSION = 0.002_010;

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitUnreachableCode RequirePodSections RequirePodAtEnd PodSpelling) # DEVELOPER DEFAULT 1: allow unreachable & POD-commented code

# UNCOMMENT TO ENABLE PERL TYPES FOR C++ OPS
#rperltypes::types_enable('PERL');

# UNCOMMENT TO ENABLE C++ TYPES FOR C++ OPS
rperltypes::types_enable('CPP');

# TOGGLE COMMENT TO ENABLE C++ OPS
#use RPerl::Test::Print_00;    # choose ONE of this
use RPerl::Test::Print_00_cpp;
RPerl::Test::Print_00_cpp::cpp_load();    # OR this

# disabled to avoid attempt to compile Print_00__*() from RPerl to CPP
#RPerl::diag(q{in compiled_test__print_00.pl, have RPerl_Test_Print_00__MODE_ID() = '} . RPerl_Test_Print_00__MODE_ID() . "'\n");

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
