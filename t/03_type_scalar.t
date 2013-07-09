#!/usr/bin/perl
use strict;  use warnings;

# SUPPRESS OUTPUT FROM INDIVIDUAL TESTS, EXCLUDING TESTS INSIDE BEGIN{} BLOCKS
open(STDOUT, ">/dev/null") || die "Can't redirect stdout";  ## no critic
open(STDERR, ">/dev/null") || die "Can't redirect stderr";  ## no critic
	
#use Test::More tests => 21;
use Test::More;
use Test::Exception;

# RPERL TEST BOILERPLATE
BEGIN { lives_ok(sub { package main;  our $RPERL_INCLUDE_PATH = '/tmp/RPerl-latest/lib'; }, q(package main;  our $RPERL_INCLUDE_PATH = '/tmp/RPerl-latest/lib';)); }  # NEED REMOVE hard-coded path
BEGIN { lives_ok(sub { use lib $main::RPERL_INCLUDE_PATH . '/CPAN/'; }, q(use lib $main::RPERL_INCLUDE_PATH . '/CPAN/';)); lives_and(sub { use_ok('MyConfig'); }); }  # RPerl's MyConfig.pm 
BEGIN { lives_ok(sub { use lib $main::RPERL_INCLUDE_PATH; }, q(use lib $main::RPERL_INCLUDE_PATH;));  lives_and(sub { use_ok('RPerl'); });  lives_ok(sub { our @ISA = ('RPerl');  $RPerl::INCLUDE_PATH = $main::RPERL_INCLUDE_PATH; }, q(our @ISA = ('RPerl');  $RPerl::INCLUDE_PATH = $main::RPERL_INCLUDE_PATH;)); }  # RPerl system files
BEGIN { lives_and(sub { use_ok('Data::Dumper'); });  lives_ok(sub { our $AUTOLOAD;  sub AUTOLOAD { die("AUTOLOAD purposefully disabled for debugging, have \$AUTOLOAD = '$AUTOLOAD' and \@_ = \n" . Dumper(\@_) . ", dying"); }}, q(our $AUTOLOAD;  sub AUTOLOAD {...})); }  ## no critic


# START HERE: write loop to run tests in all 3 modes, then go on to array tests
# START HERE: write loop to run tests in all 3 modes, then go on to array tests
# START HERE: write loop to run tests in all 3 modes, then go on to array tests


# Number: use, load, link
BEGIN { lives_and(sub { use_ok('RPerl::DataType::Number_cpp'); }); }
lives_and(sub { require_ok('RPerl::DataType::Number_cpp'); });
lives_ok(sub { RPerl::DataType::Number_cpp::cpp_load(); }, q(RPerl::DataType::Number_cpp::cpp_load();));
lives_ok(sub { RPerl::DataType::Number_cpp::cpp_link(); }, q(RPerl::DataType::Number_cpp::cpp_link();));

# Number: pack, unpack
lives_and(sub { is(stringify_number(3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679), '3.14159265358979')}, q(stringify_number(3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679);));
lives_and(sub { cmp_ok(abs(typetest___void__in___number__out() - 3.14285714285714), '<', 0.0000001)}, q(typetest___void__in___number__out();));
lives_and(sub { cmp_ok(abs(typetest___number__in___number__out(3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679) - 6.28318530717959), '<', 0.0000001)}, q(typetest___number__in___number__out(3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679);));

# String: use, load, link
BEGIN { lives_and(sub { use_ok('RPerl::DataType::String_cpp'); }); }
lives_and(sub { require_ok('RPerl::DataType::String_cpp'); });
lives_ok(sub { RPerl::DataType::String_cpp::cpp_load(); }, q(RPerl::DataType::String_cpp::cpp_load();));
lives_ok(sub { RPerl::DataType::String_cpp::cpp_link(); }, q(RPerl::DataType::String_cpp::cpp_link();));

# String: pack, unpack
lives_and(sub { is(typetest___void__in___string__out(), 'Spice')}, q(typetest___void__in___string__out();));
lives_and(sub { is(typetest___string__in___string__out("Melange"), 'MelangeFUZZ')}, q(typetest___string__in___string__out("Melange");));

done_testing();