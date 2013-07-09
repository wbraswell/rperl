#!/usr/bin/perl
use strict;  use warnings;

# SUPPRESS OUTPUT FROM INDIVIDUAL TESTS, EXCLUDING TESTS INSIDE BEGIN{} BLOCKS
#open(STDOUT, ">/dev/null") || die "Can't redirect stdout";  ## no critic
#open(STDERR, ">/dev/null") || die "Can't redirect stderr";  ## no critic

#use Test::More tests => 16;
use Test::More;

# RPERL TEST BOILERPLATE
BEGIN { package main;  our $RPERL_INCLUDE_PATH = '/tmp/RPerl-latest/lib'; }  # NEED REMOVE hard-coded path
BEGIN { use lib $main::RPERL_INCLUDE_PATH . '/CPAN/';  use_ok('MyConfig'); }  # RPerl's MyConfig.pm 
BEGIN { use lib $main::RPERL_INCLUDE_PATH;  use_ok('RPerl');  our @ISA = ('RPerl');  $RPerl::INCLUDE_PATH = $main::RPERL_INCLUDE_PATH; }  # RPerl system files
BEGIN { use_ok('Data::Dumper');  our $AUTOLOAD;  sub AUTOLOAD { die("AUTOLOAD purposefully disabled for debugging, have \$AUTOLOAD = '$AUTOLOAD' and \@_ = \n" . Dumper(\@_) . ", dying"); } }  ## no critic

# Array: use, load, link
BEGIN { use_ok('RPerl::DataStructure::Array_cpp'); }
require_ok('RPerl::DataStructure::Array_cpp');
RPerl::DataStructure::Array_cpp::cpp_load();
is($@, '', 'RPerl::DataStructure::Array_cpp, call cpp_load(), no error');
RPerl::DataStructure::Array_cpp::cpp_link();
is($@, '', 'RPerl::DataStructure::Array_cpp, call cpp_link(), no error');

# Int Array: pack, unpack
my string $stringify_retval;
$stringify_retval = stringify_int__array_ref([2]);
is($stringify_retval, '[2]', 'RPerl::DataStructure::Array_cpp, call stringify_int__array_ref(), single-element array, correct return value');
$stringify_retval = stringify_int__array_ref([2, 2112, 42, 23, 877, 33, 1701]);
is($stringify_retval, '[2, 2112, 42, 23, 877, 33, 1701]', 'RPerl::DataStructure::Array_cpp, call stringify_int__array_ref(), multiple-element array, correct return value');
$stringify_retval = stringify_int__array_ref(2);  # raise/throw exception
is($stringify_retval, '[2, 2112, 42, 23, 877, 33, 1701]', 'RPerl::DataStructure::Array_cpp, call stringify_int__array_ref(), multiple-element array, correct return value');






=SNIP
$stringify_retval = typetest___void__in___number__out();
cmp_ok(abs($stringify_retval - 3.14285714285714), '<', 0.0000001, 'RPerl::DataStructure::Array_cpp, call typetest___void__in___number__out(), correct return value');
$stringify_retval = typetest___number__in___number__out(3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679);
cmp_ok(abs($stringify_retval - 6.28318530717959), '<', 0.0000001, 'RPerl::DataStructure::Array_cpp, call typetest___number__in___number__out(), correct return value');
=cut

done_testing();