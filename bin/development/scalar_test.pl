#!/usr/bin/perl
use strict;
use warnings;
use version; our $VERSION = qv('0.2.1');
use Carp;

## no critic qw(ProhibitMagicNumbers ProhibitUnreachableCode)  ## RPERL allow numeric test values, allow unreachable test code

# RPERL DRIVER BOILERPLATE
BEGIN { package main;  our $RPERL_INCLUDE_PATH = '/tmp/RPerl-latest/lib'; }  # NEED REMOVE hard-coded path
BEGIN { use lib $main::RPERL_INCLUDE_PATH . '/CPAN/';  use MyConfig; }  # RPerl's MyConfig.pm 
BEGIN { use lib $main::RPERL_INCLUDE_PATH;  use RPerl;  use base ('RPerl');  $RPerl::INCLUDE_PATH = $main::RPERL_INCLUDE_PATH; }  # RPerl system files
BEGIN { use Data::Dumper;  our $AUTOLOAD;  sub AUTOLOAD { croak("AUTOLOAD purposefully disabled for debugging, have \$AUTOLOAD = '$AUTOLOAD' and \@_ = \n" . Dumper(\@_) . ', croaking'); } }  ## no critic qw(ProhibitAutoloading RequireArgUnpacking)  ## RPERL SYSTEM allow autoload  ## RPERL SYSTEM allow read-only @_

# UNCOMMENT TO ENABLE PERL TYPES FOR C++ OPS
#types::types_enable('PERL');

# UNCOMMENT TO ENABLE C++ TYPES FOR C++ OPS
#types::types_enable('CPP');

# UNCOMMENT TO ENABLE C++ OPS
#use RPerl::DataType::Integer_cpp;  RPerl::DataType::Integer_cpp::cpp_load();  RPerl::DataType::Integer_cpp::cpp_link();
#use RPerl::DataType::Number_cpp;  RPerl::DataType::Number_cpp::cpp_load();  RPerl::DataType::Number_cpp::cpp_link();
#use RPerl::DataType::String_cpp;  RPerl::DataType::String_cpp::cpp_load();  RPerl::DataType::String_cpp::cpp_link();

print q{in scalar_test.pl, have ops_integer() = '} . ops_integer() . "'\n" or croak();
print q{in scalar_test.pl, have types_integer() = '} . types_integer() . "'\n" or croak();
print q{in scalar_test.pl, have ops_number() = '} . ops_number() . "'\n" or croak();
print q{in scalar_test.pl, have types_number() = '} . types_number() . "'\n" or croak();
print q{in scalar_test.pl, have ops_string() = '} . ops_string() . "'\n" or croak();
print q{in scalar_test.pl, have types_string() = '} . types_string() . "'\n" or croak();

# variable declarations
my integer $integer_retval;
my number $number_retval;
my string $string_retval;

# loop to test for memory leaks
my const_integer $i_MAX = 1;
for my integer $i ( 0 .. $i_MAX ) {
	print "in scalar_test.pl, top of for() loop $i/$i_MAX\n" or croak();

    # [[[ INTEGER TESTS ]]]

#	$string_retval = stringify_integer();  # IV00; raise/throw exception  # CPPOPS_BOTHTYPES Usage: main::stringify_integer(input_integer) at ./bin/development/scalar_test.pl line 45.
#	$string_retval = stringify_integer(3);  # IV01
#	$string_retval = stringify_integer(-17);  # IV02
#	$string_retval = stringify_integer(-17.3);  # IV03; raise/throw exception
#	$string_retval = stringify_integer('-17.3');  # IV04; raise/throw exception
#	$string_retval = stringify_integer([3]);  # IV05; raise/throw exception
#	$string_retval = stringify_integer({a_key => 3});  # IV06; raise/throw exception
#	$string_retval = stringify_integer(-1_234_567_890);  # IV07
#	$string_retval = stringify_integer(-1_234_567_890_000);  # IV08; raise/throw exception
#	print "in scalar_test.pl $i/$i_MAX, have \$string_retval = '$string_retval'\n" or croak();

#	$integer_retval = typetest___void__in___integer__out();  # IV10
#	print "in scalar_test.pl $i/$i_MAX, have \$integer_retval = $integer_retval\n" or croak();

#	$integer_retval = typetest___integer__in___integer__out();  # IV20; raise/throw exception  # CPPOPS_BOTHTYPES Usage: main::typetest___integer__in___integer__out(lucky_integer) at ./bin/development/scalar_test.pl line 59.
#	$integer_retval = typetest___integer__in___integer__out(3);  # IV21
#	$integer_retval = typetest___integer__in___integer__out(-17);  # IV22
#	$integer_retval = typetest___integer__in___integer__out(-17.3);  # IV23; raise/throw exception
#	$integer_retval = typetest___integer__in___integer__out('-17.3');  # IV24; raise/throw exception
#	$integer_retval = typetest___integer__in___integer__out([3]);  # IV25; raise/throw exception
#	$integer_retval = typetest___integer__in___integer__out({a_key => 3});  # IV26; raise/throw exception
##	$integer_retval = typetest___integer__in___integer__out(-1_234_567_890);  # ARITHMETIC OVERFLOW, INCORRECT RESULTS
#	$integer_retval = typetest___integer__in___integer__out(-234_567_890);  # IV27
#	$integer_retval = typetest___integer__in___integer__out(-1_234_567_890_000);  # IV28; raise/throw exception
#	print "in scalar_test.pl $i/$i_MAX, have \$integer_retval = $integer_retval\n" or croak();

    # [[[ NUMBER TESTS ]]]

#	$string_retval = stringify_number();  # NV00; raise/throw exception  # CPPOPS_BOTHTYPES Usage: main::stringify_number(input_number) at ./bin/development/scalar_test.pl line 73.
#	$string_retval = stringify_number(3);  # NV01
#	$string_retval = stringify_number(-17);  # NV02
#	$string_retval = stringify_number(-17.3);  # NV03
#	$string_retval = stringify_number('-17.3');  # NV04; raise/throw exception
#	$string_retval = stringify_number([3]);  # NV05; raise/throw exception
#	$string_retval = stringify_number({a_key => 3});  # NV06; raise/throw exception
#	$string_retval = stringify_number(3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679);  # NV07
#	print "in scalar_test.pl $i/$i_MAX, have \$string_retval = '$string_retval'\n" or croak();

#	$number_retval = typetest___void__in___number__out();  # NV10
#	print "in scalar_test.pl $i/$i_MAX, have \$number_retval = $number_retval\n" or croak();

#	$number_retval = typetest___number__in___number__out();  # NV20; raise/throw exception  # CPPOPS_BOTHTYPES Usage: main::typetest___number__in___number__out(lucky_number) at ./bin/development/scalar_test.pl line 86.
#	$number_retval = typetest___number__in___number__out(3);  # NV21
#	$number_retval = typetest___number__in___number__out(-17);  # NV22
#	$number_retval = typetest___number__in___number__out(-17.3);  # NV23
#	$number_retval = typetest___number__in___number__out('-17.3');  # NV24; raise/throw exception
#	$number_retval = typetest___number__in___number__out([3]);  # NV25; raise/throw exception
#	$number_retval = typetest___number__in___number__out({a_key => 3});  # NV26; raise/throw exception
#	$number_retval = typetest___number__in___number__out(3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679);  # NV27
#	print "in scalar_test.pl $i/$i_MAX, have \$number_retval = $number_retval\n" or croak();

    # [[[ STRING TESTS ]]]

	$string_retval = typetest___void__in___string__out();  # PV00
	print "in scalar_test.pl $i/$i_MAX, have \$string_retval = '$string_retval'\n" or croak();

#	$string_retval = typetest___string__in___string__out();  # PV10; raise/throw exception  # CPPOPS_BOTHTYPES Usage: main::typetest___string__in___string__out(lucky_string) at ./bin/development/scalar_test.pl line 101.
#	$string_retval = typetest___string__in___string__out(3);  # PV11; raise/throw exception
#	$string_retval = typetest___string__in___string__out(-17);  # PV12; raise/throw exception
#	$string_retval = typetest___string__in___string__out(-17.3);  # PV13; raise/throw exception
#	$string_retval = typetest___string__in___string__out('-17.3');  # PV14
#	$string_retval = typetest___string__in___string__out([3]);  # PV15; raise/throw exception
#	$string_retval = typetest___string__in___string__out({a_key => 3});  # PV16; raise/throw exception
#	$string_retval = typetest___string__in___string__out('Melange');  # PV17
#	$string_retval = typetest___string__in___string__out("\nThe Spice Extends Life\nThe Spice Expands Consciousness\nThe Spice Is Vital To Space Travel\n");  # PV18
#	print "in scalar_test.pl $i/$i_MAX, have \$string_retval = '$string_retval'\n" or croak();

croak('Done for now, croaking');
}

#croak('Done for now, croaking');




