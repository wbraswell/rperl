#!/usr/bin/perl
use strict;
use warnings;
our $VERSION = 0.000_003;

# START HERE: full test file template, not just this short baby test
# START HERE: full test file template, not just this short baby test
# START HERE: full test file template, not just this short baby test

use Test::More tests => 3;

BEGIN { use_ok('RPerl'); }

# PERLOPS_PERLTYPES
rperltypes::types_enable('PERL');
BEGIN { use_ok('RPerl::Test::IO::Print_00_Good'); }
use RPerl::Test::IO::Print_00_Good;
RPerl::Test::IO::Print_00_Good::greet_planet(42);

        
# CPPOPS_CPPTYPES
rperltypes::types_enable('CPP');
BEGIN { use_ok('RPerl::Test::IO::Print_00_Good_cpp'); }
RPerl::Test::IO::Print_00_Good_cpp::cpp_load();
#ok( $RPerl::Test::IO::Print_00_Good_cpp::CPP_LOADED, 'Print_00_Good_cpp loaded');  # NEED FIX: CPP_LOADED deprecated
greet_planet(42);

done_testing();