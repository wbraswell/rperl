#!/usr/bin/perl

# NEED UPGRADE: full test file template, not just this short baby test

use strict;
use warnings;
#use Test::More tests => 4;
use Test::More;

BEGIN { use_ok('RPerl'); }

# PERLOPS_PERLTYPES
rperltypes::types_enable('PERL');
BEGIN { use_ok('RPerl::Test::Print_00'); }
use RPerl::Test::Print_00;
RPerl::Test::Print_00::greet_planet(42);

        
# CPPOPS_CPPTYPES
rperltypes::types_enable('CPP');
BEGIN { use_ok('RPerl::Test::Print_00_cpp'); }
RPerl::Test::Print_00_cpp::cpp_load();
#ok( $RPerl::Test::Print_00_cpp::CPP_LOADED, 'Print_00_cpp loaded');  # NEED FIX: CPP_LOADED deprecated
greet_planet(42);

done_testing();