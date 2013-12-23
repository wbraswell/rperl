#!/usr/bin/perl
## no critic qw(ProhibitMagicNumbers ProhibitUnreachableCode)  ## RPERL allow numeric test values, allow unreachable test code
use strict;
use warnings;
use version; our $VERSION = -0.003_012;
use Carp;

# [[[ SETUP ]]]

# RPERL DRIVER BOILERPLATE
BEGIN { package main;  our $RPERL_INCLUDE_PATH = 'lib'; }  # NEED REMOVE hard-coded path
######BEGIN { use lib $main::RPERL_INCLUDE_PATH . '/CPAN/'; use MyConfig; } # RPerl's MyConfig.pm
######BEGIN { use lib $main::RPERL_INCLUDE_PATH; use RPerl; use parent ('RPerl'); $RPerl::INCLUDE_PATH = $main::RPERL_INCLUDE_PATH; }    # RPerl system files
BEGIN { use RPerl; use parent ('RPerl'); $RPerl::INCLUDE_PATH = $main::RPERL_INCLUDE_PATH; }    # RPerl system files
BEGIN { use Data::Dumper;  our $AUTOLOAD;  sub AUTOLOAD { croak("AUTOLOAD purposefully disabled for debugging, have \$AUTOLOAD = '$AUTOLOAD' and \@_ = \n" . Dumper(\@_) . ', croaking'); } } ## no critic qw(ProhibitAutoloading RequireArgUnpacking)  ## RPERL SYSTEM allow autoload  ## RPERL SYSTEM allow read-only @_

# UNCOMMENT TO ENABLE PERL TYPES FOR C++ OPS
#types::types_enable('PERL');

# UNCOMMENT TO ENABLE C++ TYPES FOR C++ OPS
#types::types_enable('CPP');

# UNCOMMENT TO ENABLE C++ OPS
#use RPerl::DataStructure::Array_cpp;  RPerl::DataStructure::Array_cpp::cpp_load();  RPerl::DataStructure::Array_cpp::cpp_link();

print q{in array_test.pl, have integer__ops() = '} . integer__ops() . "'\n" or croak();
print q{in array_test.pl, have integer__types() = '} . integer__types() . "'\n" or croak();
print q{in array_test.pl, have number__ops() = '} . number__ops() . "'\n" or croak();
print q{in array_test.pl, have number__types() = '} . number__types() . "'\n" or croak();
print q{in array_test.pl, have string__ops() = '} . string__ops() . "'\n" or croak();
print q{in array_test.pl, have string__types() = '} . string__types() . "'\n" or croak();
print q{in array_test.pl, have array__ops() = '} . array__ops() . "'\n" or croak();
print q{in array_test.pl, have array__types() = '} . array__types() . "'\n" or croak();

# variable declarations
my string $retval_stringify;
my integer__array_ref $retval_integer__array_ref;
my number__array_ref $retval_number__array_ref;
my string__array_ref $retval_jeffys;

# loop to test for memory leaks
my const_integer $i_MAX = 0;
for my integer $i ( 0 .. $i_MAX ) {
	print "in array_test.pl, top of for() loop $i/$i_MAX\n" or croak();

    # [[[ INTEGER TESTS ]]]

	$retval_stringify = integer__array_ref__stringify();  # TIVAVRV00; error PERLOPS EAVRV00, CPPOPS "Usage: main::integer__array_ref__stringify(input_av_ref/input_vector)"
#	$retval_stringify = integer__array_ref__stringify(undef);  # TIVAVRV01; error EAVRV00
#	$retval_stringify = integer__array_ref__stringify(2);  # TIVAVRV02; error EAVRV01
#	$retval_stringify = integer__array_ref__stringify(2.3);  # TIVAVRV03; error EAVRV01
#	$retval_stringify = integer__array_ref__stringify('2');  # TIVAVRV04; error EAVRV01
#	$retval_stringify = integer__array_ref__stringify({a_key => 23});  # TIVAVRV05; error EAVRV01
#	$retval_stringify = integer__array_ref__stringify([2, 2112, undef, 23, -877, 33, 1701]);  # TIVAVRV10; error EIV00
#	$retval_stringify = integer__array_ref__stringify([2, 2112, 42, 23.3, -877, 33, 1701]);  # TIVAVRV11; error EIV01
#	$retval_stringify = integer__array_ref__stringify([2, 2112, 42, '23', -877, 33, 1701]);  # TIVAVRV12; error EIV01
#	$retval_stringify = integer__array_ref__stringify([2, 2112, 42, [23], -877, 33, 1701]);  # TIVAVRV13; error EIV01
#	$retval_stringify = integer__array_ref__stringify([2, 2112, 42, {a_subkey => 23}, -877, 33, 1701]);  # TIVAVRV14; error EIV01
#	$retval_stringify = integer__array_ref__stringify([23]);  # TIVAVRV20
#	$retval_stringify = integer__array_ref__stringify([2, 2112, 42, 23, -877, 33, 1701]);  # TIVAVRV21
	print "in array_test.pl $i/$i_MAX, have \$retval_stringify =\n$retval_stringify\n" or croak();

#	$retval_stringify = integer__array_ref__typetest0();  # TIVAVRV30; error PERLOPS EAVRV00, CPPOPS "Usage: main::integer__array_ref__typetest0(lucky_integers)"
#	$retval_stringify = integer__array_ref__typetest0(2);  # TIVAVRV31; error EAVRV01
#	$retval_stringify = integer__array_ref__typetest0([2, 2112, undef, 23, -877, 33, 1701]);  # TIVAVRV32; error EIV00
#	$retval_stringify = integer__array_ref__typetest0([2, 2112, 42, 'abcdefg', -877, 33, 1701]);  # TIVAVRV33; error EIV01
#	$retval_stringify = integer__array_ref__typetest0([2, 2112, 42, 23, -877, 33, 1701]);  # TIVAVRV34
#	print "in array_test.pl $i/$i_MAX, have \$retval_stringify =\n$retval_stringify\n";

#	$retval_integer__array_ref = integer__array_ref__typetest1(5);  # TIVAVRV40
#	print "in array_test.pl $i/$i_MAX, have \$retval_integer__array_ref = \n" . Dumper($retval_integer__array_ref) . "\n" or croak();

    # [[[ NUMBER TESTS ]]]

#	$retval_stringify = number__array_ref__stringify();  # TNVAVRV00; error PERLOPS EAVRV00, CPPOPS "Usage: main::number__array_ref__stringify(input_av_ref/input_vector)"
#	$retval_stringify = number__array_ref__stringify(undef);  # TNVAVRV01; error EAVRV00
#	$retval_stringify = number__array_ref__stringify(2);  # TNVAVRV02; error EAVRV01
#	$retval_stringify = number__array_ref__stringify(2.3);  # TNVAVRV03; error EAVRV01
#	$retval_stringify = number__array_ref__stringify('2');  # TNVAVRV04; error EAVRV01
#	$retval_stringify = number__array_ref__stringify({a_key => 23});  # TNVAVRV05; error EAVRV01
#	$retval_stringify = number__array_ref__stringify([2, 2112, undef, 23, -877, 33, 1701]);  # TNVAVRV10; error ENV00
#	$retval_stringify = number__array_ref__stringify([2, 2112, 42, '23', -877, 33, 1701]);  # TNVAVRV11; error ENV01
#	$retval_stringify = number__array_ref__stringify([2, 2112, 42, [23], -877, 33, 1701]);  # TNVAVRV12; error ENV01
#	$retval_stringify = number__array_ref__stringify([2, 2112, 42, {a_subkey => 23}, -877, 33, 1701]);  # TNVAVRV13; error ENV01
#	$retval_stringify = number__array_ref__stringify([23]);  # TNVAVRV20
#	$retval_stringify = number__array_ref__stringify([2, 2112, 42, 23, -877, 33, 1701]);  # TNVAVRV21
#	$retval_stringify = number__array_ref__stringify([23.2]);  # TNVAVRV22
#	$retval_stringify = number__array_ref__stringify([2.1, 2112.2, 42.3, 23, -877, 33, 1701]);  # TNVAVRV23
#	$retval_stringify = number__array_ref__stringify([2.1234432112344321, 2112.4321, 42.4567, 23.765444444444444444, -877.5678, 33.876587658765875687658765, 1701.6789]);  # TNVAVRV24
#	print "in array_test.pl $i/$i_MAX, have \$retval_stringify =\n$retval_stringify\n" or croak();

#	$retval_stringify = number__array_ref__typetest0();  # TNVAVRV30; error PERLOPS EAVRV00, CPPOPS "Usage: main::number__array_ref__typetest0(lucky_numbers)"
#	$retval_stringify = number__array_ref__typetest0(2);  # TNVAVRV31; error EAVRV01
#	$retval_stringify = number__array_ref__typetest0([2.1234432112344321, 2112.4321, undef, 23.765444444444444444, -877.5678, 33.876587658765875687658765, 1701.6789]);  # TNVAVRV32; error ENV00
#	$retval_stringify = number__array_ref__typetest0([2.1234432112344321, 2112.4321, 42.4567, 23.765444444444444444, -877.5678, 'abcdefg', 33.876587658765875687658765, 1701.6789]);  # TNVAVRV33; error ENV01
#	$retval_stringify = number__array_ref__typetest0([2.1234432112344321, 2112.4321, 42.4567, 23.765444444444444444, -877.5678, 33.876587658765875687658765, 1701.6789]);  # TNVAVRV34
#	print "in array_test.pl $i/$i_MAX, have \$retval_stringify =\n$retval_stringify\n";

#	$retval_number__array_ref = number__array_ref__typetest1(5);  # TNVAVRV40
#	print "in array_test.pl $i/$i_MAX, have \$retval_number__array_ref = \n" . Dumper($retval_number__array_ref) . "\n" or croak();

    # [[[ STRING TESTS ]]]

#	$retval_stringify = string__array_ref__stringify();  # TPVAVRV00; error PERLOPS EAVRV00, CPPOPS "Usage: main::string__array_ref__stringify(input_av_ref/input_vector)"
#	$retval_stringify = string__array_ref__stringify(undef);  # TPVAVRV01; error EAVRV00
#	$retval_stringify = string__array_ref__stringify(2);  # TPVAVRV02; error EAVRV01
#	$retval_stringify = string__array_ref__stringify(2.3);  # TPVAVRV03; error EAVRV01
#	$retval_stringify = string__array_ref__stringify('Lone Ranger');  # TPVAVRV04; error EAVRV01
#	$retval_stringify = string__array_ref__stringify({a_key => 'Lone Ranger'});  # TPVAVRV05; error EAVRV01
#	$retval_stringify = string__array_ref__stringify(['Superman', 'Batman', 'Wonder Woman', undef, 'Green Lantern', 'Aquaman', 'Martian Manhunter']);  # TPVAVRV10; error EPV00
#	$retval_stringify = string__array_ref__stringify(['Superman', 'Batman', 23, 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter']);  # TPVAVRV11; error EPV01
#	$retval_stringify = string__array_ref__stringify(['Superman', 'Batman', 23.2, 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter']);  # TPVAVRV12; error EPV01
#	$retval_stringify = string__array_ref__stringify(['Superman', 'Batman', ['Wonder Woman'], 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter']);  # TPVAVRV13; error EPV01
#	$retval_stringify = string__array_ref__stringify(['Superman', 'Batman', {a_subkey => 'Wonder Woman'}, 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter']);  # TPVAVRV14; error EPV01
#	$retval_stringify = string__array_ref__stringify(['Howard The Duck', 'Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter']);  # TPVAVRV20
#	$retval_stringify = string__array_ref__stringify(['Superman', 'Martian Manhunter', 'undef']);  # TPVAVRV21
#	$retval_stringify = string__array_ref__stringify(['Superman', 'Martian Manhunter', '23']);  # TPVAVRV22
#	$retval_stringify = string__array_ref__stringify(['Superman', 'Martian Manhunter', '-2112.23']);  # TPVAVRV23
#	$retval_stringify = string__array_ref__stringify(['Superman', 'Martian Manhunter', "[\\'Tonto'\\]"]);  # TPVAVRV24
#	$retval_stringify = string__array_ref__stringify(['Superman', 'Martian Manhunter', '{buzz => 5}']);  # TPVAVRV25
#	print "in array_test.pl $i/$i_MAX, have \$retval_stringify =\n$retval_stringify\n" or croak();

#	$retval_stringify = string__array_ref__typetest0();  # TPVAVRV30; error PERLOPS EAVRV00, CPPOPS "Usage: main::string__array_ref__typetest0(people)"
#	$retval_stringify = string__array_ref__typetest0(2);  # TPVAVRV31; error EAVRV01
#	$retval_stringify = string__array_ref__typetest0(['Superman', 'Batman', 'Wonder Woman', undef, 'Green Lantern', 'Aquaman', 'Martian Manhunter']);  # TPVAVRV32; error EPV00
#	$retval_stringify = string__array_ref__typetest0(['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter', [23, -42.3]]);  # TPVAVRV33; error EPV01
#	$retval_stringify = string__array_ref__typetest0(['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter']);  # TPVAVRV34
#	print "in array_test.pl $i/$i_MAX, have \$retval_stringify =\n$retval_stringify\n";

#	$retval_jeffys = string__array_ref__typetest1(5);  # TPVAVRV40
#	print "in array_test.pl $i/$i_MAX, have \$retval_jeffys = \n" . Dumper($retval_jeffys) . "\n" or croak();

croak('Done for now, croaking');
}

#croak('Done for now, croaking');
