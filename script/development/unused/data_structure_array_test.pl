#!/usr/bin/perl
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.004_011;

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitUnreachableCode RequirePodSections RequirePodAtEnd PodSpelling)  # DEVELOPER DEFAULT 1: allow unreachable & POD-commented code

# UNCOMMENT TO ENABLE PERL TYPES FOR C++ OPS
#rperltypes::types_enable('PERL');

# UNCOMMENT TO ENABLE C++ TYPES FOR C++ OPS
rperltypes::types_enable('CPP');

# UNCOMMENT TO ENABLE C++ OPS
use RPerl::DataStructure::Array_cpp;
RPerl::DataStructure::Array_cpp::cpp_load();

RPerl::diag(q{in array_test.pl, have RPerl__DataType__Integer__MODE_ID() = '} . RPerl__DataType__Integer__MODE_ID() . "'\n");
RPerl::diag(q{in array_test.pl, have RPerl__DataType__Number__MODE_ID() = '} . RPerl__DataType__Number__MODE_ID() . "'\n");
RPerl::diag(q{in array_test.pl, have RPerl__DataType__String__MODE_ID() = '} . RPerl__DataType__String__MODE_ID() . "'\n");
RPerl::diag(q{in array_test.pl, have array__MODE_ID() = '} . array__MODE_ID() . "'\n");

# variable declarations
my string $retval_stringify;
my integer_arrayref $retval_integer_arrayref;
my number_arrayref $retval_number_arrayref;
my string_arrayref $retval_jeffys;

# loop to test for memory leaks
my integer $i_MAX = 0;  # CONSTANT
for my integer $i ( 0 .. $i_MAX ) {
    RPerl::diag("in array_test.pl, top of for() loop $i/$i_MAX\n");

    # [[[ INTEGER TESTS ]]]

#	$retval_stringify = integer_arrayref_to_string();  # TIVAVRV00; error PERLOPS EIVAVRV00, CPPOPS "Usage: main::integer_arrayref_to_string(input_avref/input_vector)"
#	$retval_stringify = integer_arrayref_to_string(undef);  # TIVAVRV01; error EIVAVRV00
#	$retval_stringify = integer_arrayref_to_string(2);  # TIVAVRV02; error EIVAVRV01
#	$retval_stringify = integer_arrayref_to_string(2.3);  # TIVAVRV03; error EIVAVRV01
#	$retval_stringify = integer_arrayref_to_string('2');  # TIVAVRV04; error EIVAVRV01
#	$retval_stringify = integer_arrayref_to_string({a_key => 23});  # TIVAVRV05; error EIVAVRV01
#	$retval_stringify = integer_arrayref_to_string([2, 2112, undef, 23, -877, -33, 1701]);  # TIVAVRV10; error EIVAVRV02
#	$retval_stringify = integer_arrayref_to_string([2, 2112, 42, 23.3, -877, -33, 1701]);  # TIVAVRV11; error EIVAVRV03
#	$retval_stringify = integer_arrayref_to_string([2, 2112, 42, '23', -877, -33, 1701]);  # TIVAVRV12; error EIVAVRV03
#	$retval_stringify = integer_arrayref_to_string([2, 2112, 42, [23], -877, -33, 1701]);  # TIVAVRV13; error EIVAVRV03
#	$retval_stringify = integer_arrayref_to_string([2, 2112, 42, {a_subkey => 23}, -877, -33, 1701]);  # TIVAVRV14; error EIVAVRV03
    $retval_stringify = integer_arrayref_to_string( [23] );    # TIVAVRV20

#	$retval_stringify = integer_arrayref_to_string([2, 2112, 42, 23, -877, -33, 1701]);  # TIVAVRV21
    RPerl::diag("in array_test.pl $i/$i_MAX, have \$retval_stringify =\n$retval_stringify\n");

#	$retval_stringify = integer_arrayref_typetest0();  # TIVAVRV30; error PERLOPS EIVAVRV00, CPPOPS "Usage: main::integer_arrayref_typetest0(lucky_integers)"
#	$retval_stringify = integer_arrayref_typetest0(2);  # TIVAVRV31; error EIVAVRV01
#	$retval_stringify = integer_arrayref_typetest0([2, 2112, undef, 23, -877, -33, 1701]);  # TIVAVRV32; error EIVAVRV02
#	$retval_stringify = integer_arrayref_typetest0([2, 2112, 42, 'abcdefg', -877, -33, 1701]);  # TIVAVRV33; error EIVAVRV03
#	$retval_stringify = integer_arrayref_typetest0([2, 2112, 42, 23, -877, -33, 1701]);  # TIVAVRV34
#	RPerl::diag("in array_test.pl $i/$i_MAX, have \$retval_stringify =\n$retval_stringify\n");

#	$retval_integer_arrayref = integer_arrayref_typetest1(5);  # TIVAVRV40
#	RPerl::diag("in array_test.pl $i/$i_MAX, have \$retval_integer_arrayref = \n" . Dumper($retval_integer_arrayref) . "\n");

    # [[[ NUMBER TESTS ]]]

#	$retval_stringify = number_arrayref_to_string();  # TNVAVRV00; error PERLOPS ENVAVRV00, CPPOPS "Usage: main::number_arrayref_to_string(input_avref/input_vector)"
#	$retval_stringify = number_arrayref_to_string(undef);  # TNVAVRV01; error ENVAVRV00
#	$retval_stringify = number_arrayref_to_string(2);  # TNVAVRV02; error ENVAVRV01
#	$retval_stringify = number_arrayref_to_string(2.3);  # TNVAVRV03; error ENVAVRV01
#	$retval_stringify = number_arrayref_to_string('2');  # TNVAVRV04; error ENVAVRV01
#	$retval_stringify = number_arrayref_to_string({a_key => 23});  # TNVAVRV05; error ENVAVRV01
#	$retval_stringify = number_arrayref_to_string([2, 2112, undef, 23, -877, -33, 1701]);  # TNVAVRV10; error ENVAVRV02
#	$retval_stringify = number_arrayref_to_string([2, 2112, 42, '23', -877, -33, 1701]);  # TNVAVRV11; error ENVAVRV03
#	$retval_stringify = number_arrayref_to_string([2, 2112, 42, [23], -877, -33, 1701]);  # TNVAVRV12; error ENVAVRV03
#	$retval_stringify = number_arrayref_to_string([2, 2112, 42, {a_subkey => 23}, -877, -33, 1701]);  # TNVAVRV13; error ENVAVRV03
#	$retval_stringify = number_arrayref_to_string([23]);  # TNVAVRV20
#	$retval_stringify = number_arrayref_to_string([2, 2112, 42, 23, -877, -33, 1701]);  # TNVAVRV21
#	$retval_stringify = number_arrayref_to_string([23.2]);  # TNVAVRV22
#	$retval_stringify = number_arrayref_to_string([2.1, 2112.2, 42.3, 23, -877, -33, 1701]);  # TNVAVRV23
#	$retval_stringify = number_arrayref_to_string([2.1234432112344321, 2112.4321, 42.4567, 23.765444444444444444, -877.5678, -33.876587658765875687658765, 1701.6789]);  # TNVAVRV24
#	RPerl::diag("in array_test.pl $i/$i_MAX, have \$retval_stringify =\n$retval_stringify\n");

#	$retval_stringify = number_arrayref_typetest0();  # TNVAVRV30; error PERLOPS ENVAVRV00, CPPOPS "Usage: main::number_arrayref_typetest0(lucky_numbers)"
#	$retval_stringify = number_arrayref_typetest0(2);  # TNVAVRV31; error ENVAVRV01
#	$retval_stringify = number_arrayref_typetest0([2.1234432112344321, 2112.4321, undef, 23.765444444444444444, -877.5678, -33.876587658765875687658765, 1701.6789]);  # TNVAVRV32; error ENVAVRV02
#	$retval_stringify = number_arrayref_typetest0([2.1234432112344321, 2112.4321, 42.4567, 23.765444444444444444, -877.5678, 'abcdefg', -33.876587658765875687658765, 1701.6789]);  # TNVAVRV33; error ENVAVRV03
#	$retval_stringify = number_arrayref_typetest0([2.1234432112344321, 2112.4321, 42.4567, 23.765444444444444444, -877.5678, -33.876587658765875687658765, 1701.6789]);  # TNVAVRV34
#	RPerl::diag("in array_test.pl $i/$i_MAX, have \$retval_stringify =\n$retval_stringify\n");

#	$retval_number_arrayref = number_arrayref_typetest1(5);  # TNVAVRV40
#	RPerl::diag("in array_test.pl $i/$i_MAX, have \$retval_number_arrayref = \n" . Dumper($retval_number_arrayref) . "\n");

    # [[[ STRING TESTS ]]]

#	$retval_stringify = string_arrayref_to_string();  # TPVAVRV00; error PERLOPS EPVAVRV00, CPPOPS "Usage: main::string_arrayref_to_string(input_avref/input_vector)"
#	$retval_stringify = string_arrayref_to_string(undef);  # TPVAVRV01; error EPVAVRV00
#	$retval_stringify = string_arrayref_to_string(2);  # TPVAVRV02; error EPVAVRV01
#	$retval_stringify = string_arrayref_to_string(2.3);  # TPVAVRV03; error EPVAVRV01
#	$retval_stringify = string_arrayref_to_string('Lone Ranger');  # TPVAVRV04; error EPVAVRV01
#	$retval_stringify = string_arrayref_to_string({a_key => 'Lone Ranger'});  # TPVAVRV05; error EPVAVRV01
#	$retval_stringify = string_arrayref_to_string(['Superman', 'Batman', 'Wonder Woman', undef, 'Green Lantern', 'Aquaman', 'Martian Manhunter']);  # TPVAVRV10; error EPVAVRV02
#	$retval_stringify = string_arrayref_to_string(['Superman', 'Batman', 23, 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter']);  # TPVAVRV11; error EPVAVRV03
#	$retval_stringify = string_arrayref_to_string(['Superman', 'Batman', 23.2, 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter']);  # TPVAVRV12; error EPVAVRV03
#	$retval_stringify = string_arrayref_to_string(['Superman', 'Batman', ['Wonder Woman'], 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter']);  # TPVAVRV13; error EPVAVRV03
#	$retval_stringify = string_arrayref_to_string(['Superman', 'Batman', {a_subkey => 'Wonder Woman'}, 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter']);  # TPVAVRV14; error EPVAVRV03
#	$retval_stringify = string_arrayref_to_string(['Howard The Duck', 'Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter']);  # TPVAVRV20
#	$retval_stringify = string_arrayref_to_string(['Superman', 'Martian Manhunter', 'undef']);  # TPVAVRV21
#	$retval_stringify = string_arrayref_to_string(['Superman', 'Martian Manhunter', '23']);  # TPVAVRV22
#	$retval_stringify = string_arrayref_to_string(['Superman', 'Martian Manhunter', '-2112.23']);  # TPVAVRV23
#	$retval_stringify = string_arrayref_to_string(['Superman', 'Martian Manhunter', "[\\'Tonto'\\]"]);  # TPVAVRV24
#	$retval_stringify = string_arrayref_to_string(['Superman', 'Martian Manhunter', '{buzz => 5}']);  # TPVAVRV25
#	RPerl::diag("in array_test.pl $i/$i_MAX, have \$retval_stringify =\n$retval_stringify\n");

#	$retval_stringify = string_arrayref_typetest0();  # TPVAVRV30; error PERLOPS EPVAVRV00, CPPOPS "Usage: main::string_arrayref_typetest0(people)"
#	$retval_stringify = string_arrayref_typetest0(2);  # TPVAVRV31; error EPVAVRV01
#	$retval_stringify = string_arrayref_typetest0(['Superman', 'Batman', 'Wonder Woman', undef, 'Green Lantern', 'Aquaman', 'Martian Manhunter']);  # TPVAVRV32; error EPVAVRV02
#	$retval_stringify = string_arrayref_typetest0(['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter', [23, -42.3]]);  # TPVAVRV33; error EPVAVRV03
#	$retval_stringify = string_arrayref_typetest0(['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter']);  # TPVAVRV34
#	RPerl::diag("in array_test.pl $i/$i_MAX, have \$retval_stringify =\n$retval_stringify\n");

#	$retval_jeffys = string_arrayref_typetest1(5);  # TPVAVRV40
#	RPerl::diag("in array_test.pl $i/$i_MAX, have \$retval_jeffys = \n" . Dumper($retval_jeffys) . "\n");

    croak('Done for now, croaking');
}

#croak('Done for now, croaking');
