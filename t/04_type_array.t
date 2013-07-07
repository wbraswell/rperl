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

# Number: use, load, link
BEGIN { use_ok('RPerl::DataType::Number_cpp'); }
require_ok('RPerl::DataType::Number_cpp');
RPerl::DataType::Number_cpp::cpp_load();
is($@, '', 'RPerl::DataType::Number_cpp, call cpp_load(), no error');
RPerl::DataType::Number_cpp::cpp_link();
is($@, '', 'RPerl::DataType::Number_cpp, call cpp_link(), no error');

# Number: pack, unpack
my number $number_retval;
$number_retval = stringify(3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679);
is($number_retval, '3.14159265358979', 'RPerl::DataType::Number_cpp, call stringify(), correct return value');
$number_retval = typetest___void__in___number__out();
cmp_ok(abs($number_retval - 3.14285714285714), '<', 0.0000001, 'RPerl::DataType::Number_cpp, call typetest___void__in___number__out(), correct return value');
$number_retval = typetest___number__in___number__out(3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679);
cmp_ok(abs($number_retval - 6.28318530717959), '<', 0.0000001, 'RPerl::DataType::Number_cpp, call typetest___number__in___number__out(), correct return value');

# String: use, load, link
BEGIN { use_ok('RPerl::DataType::String_cpp'); }
require_ok('RPerl::DataType::String_cpp');
RPerl::DataType::String_cpp::cpp_load();
is($@, '', 'RPerl::DataType::String_cpp, call cpp_load(), no error');
RPerl::DataType::String_cpp::cpp_link();
is($@, '', 'RPerl::DataType::String_cpp, call cpp_link(), no error');

# String: pack, unpack
my string $string_retval;
$string_retval = typetest___void__in___string__out();
is($string_retval, 'Spice', 'RPerl::DataType::String_cpp, call typetest___void__in___string__out(), correct return value');
$string_retval = typetest___string__in___string__out("Melange");
is($string_retval, 'MelangeFUZZ', 'RPerl::DataType::String_cpp, call typetest___string__in___string__out(), correct return value');

done_testing();