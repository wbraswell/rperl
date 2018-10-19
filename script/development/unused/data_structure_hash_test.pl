#!/usr/bin/env perl
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.004_010;

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitUnreachableCode RequirePodSections RequirePodAtEnd PodSpelling)  # DEVELOPER DEFAULT 1: allow unreachable & POD-commented code

# UNCOMMENT TO ENABLE PERL TYPES FOR C++ OPS
#rperltypes::types_enable('PERL');

# UNCOMMENT TO ENABLE C++ TYPES FOR C++ OPS
rperltypes::types_enable('CPP');

# UNCOMMENT TO ENABLE C++ OPS
use RPerl::DataStructure::Hash_cpp;  RPerl::DataStructure::Hash_cpp::cpp_load();

$RPerl::DEBUG = 1;
RPerl::diag(q{in hash_test.pl, have RPerl__DataType__Integer__MODE_ID() = '} . RPerl__DataType__Integer__MODE_ID() . "'\n");
RPerl::diag(q{in hash_test.pl, have RPerl__DataType__Number__MODE_ID() = '} . RPerl__DataType__Number__MODE_ID() . "'\n");
RPerl::diag(q{in hash_test.pl, have RPerl__DataType__String__MODE_ID() = '} . RPerl__DataType__String__MODE_ID() . "'\n");
RPerl::diag(q{in hash_test.pl, have hash__MODE_ID() = '} . hash__MODE_ID() . "'\n");

# variable declarations
my string $retval_stringify;
my integer_hashref $retval_integer_hashref;
my number_hashref $retval_number_hashref;
my string_hashref $my_peeps = {};
my string_hashref $retval_jeffys;

# loop to test for memory leaks
my integer $i_MAX = 0;  # CONSTANT
for my integer $i ( 0 .. $i_MAX ) {
	RPerl::diag("in hash_test.pl, top of for() loop $i/$i_MAX\n");

    # [[[ INTEGER TESTS ]]]

#	$retval_stringify = integer_hashref_to_string();  # TIVHVRV00; error PERLOPS EIVHVRV00, CPPOPS "Usage: main::integer_hashref_to_string(input_unordered_map)"
#	$retval_stringify = integer_hashref_to_string(undef);  # TIVHVRV01; error EIVHVRV00
#	$retval_stringify = integer_hashref_to_string(2);  # TIVHVRV02; error EIVHVRV01
#	$retval_stringify = integer_hashref_to_string(2.3);  # TIVHVRV03; error EIVHVRV01
#	$retval_stringify = integer_hashref_to_string('2');  # TIVHVRV04; error EIVHVRV01
#	$retval_stringify = integer_hashref_to_string([2]);  # TIVHVRV05; error EIVHVRV01
#	$retval_stringify = integer_hashref_to_string({a_key => 2, b_key => 2112, c_key => undef, d_key => 23, e_key => -877, f_key => -33, g_key => 1701});  # TIVHVRV10; error EIVHVRV02
#	$retval_stringify = integer_hashref_to_string({a_key => 2, b_key => 2112, c_key => 42, d_key => 23.3, e_key => -877, f_key => -33, g_key => 1701});  # TIVHVRV11; error EIVHVRV03
#	$retval_stringify = integer_hashref_to_string({a_key => 2, b_key => 2112, c_key => 42, d_key => '23', e_key => -877, f_key => -33, g_key => 1701});  # TIVHVRV12; error EIVHVRV03
#	$retval_stringify = integer_hashref_to_string({a_key => 2, b_key => 2112, c_key => 42, d_key => [23], e_key => -877, f_key => -33, g_key => 1701});  # TIVHVRV13; error EIVHVRV03
#	$retval_stringify = integer_hashref_to_string({a_key => 2, b_key => 2112, c_key => 42, d_key => {a_subkey => 23}, e_key => -877, f_key => -33, g_key => 1701});  # TIVHVRV14; error EIVHVRV03
#	$retval_stringify = integer_hashref_to_string({a_key => 23});  # TIVHVRV20
	$retval_stringify = integer_hashref_to_string({a_key => 2, b_key => 2112, c_key => 42, d_key => 23, e_key => -877, f_key => -33, g_key => 1701});  # TIVHVRV21
	RPerl::diag("in hash_test.pl $i/$i_MAX, have \$retval_stringify =\n$retval_stringify\n");

#	$retval_stringify = integer_hashref_typetest0();  # TIVHVRV30; error PERLOPS EIVHVRV00, CPPOPS "Usage: main::integer_hashref_typetest0(input_unordered_map)"
#	$retval_stringify = integer_hashref_typetest0(2);  # TIVHVRV31; error EIVHVRV01
#	$retval_stringify = integer_hashref_typetest0({'binary' => 2, 'rush' => 2112, 'ERROR_FUNKEY' => undef, 'answer' => 42, 'fnord' => 23, 'units' => -877, 'degree' => -33, 'ncc' => 1701});  # TIVHVRV32; error EIVHVRV02
#	$retval_stringify = integer_hashref_typetest0({'binary' => 2, 'rush' => 2112, 'ERROR_FUNKEY' => 'abcdefg', 'answer' => 42, 'fnord' => 23, 'units' => -877, 'degree' => -33, 'ncc' => 1701});  # TIVHVRV33; error EIVHVRV03
#	$retval_stringify = integer_hashref_typetest0({'binary' => 2, 'rush' => 2112, 'answer' => 42, 'fnord' => 23, 'units' => -877, 'degree' => -33, 'ncc' => 1701});  # TIVHVRV34
#	RPerl::diag("in hash_test.pl $i/$i_MAX, have \$retval_stringify =\n$retval_stringify\n");

#	$retval_integer_hashref = integer_hashref_typetest1(5);  # TIVHVRV40
#	RPerl::diag("in hash_test.pl $i/$i_MAX, have \$retval_integer_hashref = \n" . Dumper($retval_integer_hashref) . "\n");

    # [[[ NUMBER TESTS ]]]

#	$retval_stringify = number_hashref_to_string();  # TNVHVRV00; error PERLOPS ENVHVRV00, CPPOPS "Usage: main::number_hashref_to_string(input_unordered_map)"
#	$retval_stringify = number_hashref_to_string(undef);  # TNVHVRV01; error ENVHVRV00
#	$retval_stringify = number_hashref_to_string(2);  # TNVHVRV02; error ENVHVRV01
#	$retval_stringify = number_hashref_to_string(2.3);  # TNVHVRV03; error ENVHVRV01
#	$retval_stringify = number_hashref_to_string('2');  # TNVHVRV04; error ENVHVRV01
#	$retval_stringify = number_hashref_to_string([2]);  # TNVHVRV05; error ENVHVRV01
#	$retval_stringify = number_hashref_to_string({a_key => 2, b_key => 2112, c_key => undef, d_key => 23, e_key => -877, f_key => -33, g_key => 1701});  # TNVHVRV10; error ENVHVRV02
#	$retval_stringify = number_hashref_to_string({a_key => 2, b_key => 2112, c_key => 42.3, d_key => '23', e_key => -877, f_key => -33, g_key => 1701});  # TNVHVRV11; error ENVHVRV03
#	$retval_stringify = number_hashref_to_string({a_key => 2, b_key => 2112, c_key => 42.3, d_key => [23], e_key => -877, f_key => -33, g_key => 1701});  # TNVHVRV12; error ENVHVRV03
#	$retval_stringify = number_hashref_to_string({a_key => 2, b_key => 2112, c_key => 42.3, d_key => {a_subkey => 23}, e_key => -877, f_key => -33, g_key => 1701});  # TNVHVRV13; error ENVHVRV03
#	$retval_stringify = number_hashref_to_string({a_key => 23});  # TNVHVRV20
#	$retval_stringify = number_hashref_to_string({a_key => 2, b_key => 2112, c_key => 42, d_key => 23, e_key => -877, f_key => -33, g_key => 1701});  # TNVHVRV21
#	$retval_stringify = number_hashref_to_string({a_key => 2.1234432112344321});  # TNVHVRV22
#	$retval_stringify = number_hashref_to_string({a_key => 2.1234432112344321, b_key => 2112.4321, c_key => 42.4567, d_key => 23.765444444444444444, e_key => -877.5678, f_key => -33.876587658765875687658765, g_key => 1701.6789});  # TNVHVRV23
#	RPerl::diag("in hash_test.pl $i/$i_MAX, have \$retval_stringify =\n$retval_stringify\n");

#	$retval_stringify = number_hashref_typetest0();  # TNVHVRV30; error PERLOPS ENVHVRV00, CPPOPS "Usage: main::number_hashref_typetest0(input_unordered_map)"
#	$retval_stringify = number_hashref_typetest0(2);  # TNVHVRV31; error ENVHVRV01
#	$retval_stringify = number_hashref_typetest0({'binary' => 2.1234432112344321, 'rush' => 2112.4321, 'ERROR_FUNKEY' => undef, 'answer' => 42.4567, 'fnord' => 23.765444444444444444, 'units' => -877.5678, 'degree' => -33.876587658765875687658765, 'ncc' => 1701.6789});  # TNVHVRV32; error ENVHVRV02
#	$retval_stringify = number_hashref_typetest0({'binary' => 2.1234432112344321, 'rush' => 2112.4321, 'ERROR_FUNKEY' => 'abcdefg', 'answer' => 42.4567, 'fnord' => 23.765444444444444444, 'units' => -877.5678, 'degree' => -33.876587658765875687658765, 'ncc' => 1701.6789});  # TNVHVRV33; error ENVHVRV03
#	$retval_stringify = number_hashref_typetest0({'binary' => 2.1234432112344321, 'rush' => 2112.4321, 'answer' => 42.4567, 'fnord' => 23.765444444444444444, 'units' => -877.5678, 'degree' => -33.876587658765875687658765, 'ncc' => 1701.6789});  # TNVHVRV34
#	RPerl::diag("in hash_test.pl $i/$i_MAX, have \$retval_stringify =\n$retval_stringify\n");

#	$retval_number_hashref = number_hashref_typetest1(5);  # TNVHVRV40
#	RPerl::diag("in hash_test.pl $i/$i_MAX, have \$retval_number_hashref = \n" . Dumper($retval_number_hashref) . "\n");

    # [[[ STRING TESTS ]]]

#	$retval_stringify = string_hashref_to_string();  # TPVHVRV00; error PERLOPS EPVHVRV00, CPPOPS "Usage: main::string_hashref_to_string(input_unordered_map)"
#	$retval_stringify = string_hashref_to_string(undef);  # TPVHVRV01; error EPVHVRV00
#	$retval_stringify = string_hashref_to_string(2);  # TPVHVRV02; error EPVHVRV01
#	$retval_stringify = string_hashref_to_string(2.3);  # TPVHVRV03; error EPVHVRV01
#	$retval_stringify = string_hashref_to_string('Lone Ranger');  # TPVHVRV04; error EPVHVRV01
#	$retval_stringify = string_hashref_to_string(['Lone Ranger']);  # TPVHVRV05; error EPVHVRV01
#	$my_peeps = {'kryptonian_manofsteel_clarkkent' => 'Superman', 'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter', 'UNDEF_NOT_STRING' => undef};  # TPVHVRV10; error EPVHVRV02
#	$my_peeps = {'kryptonian_manofsteel_clarkkent' => 'Superman', 'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter', 'INTEGER_NOT_STRING' => 23};  # TPVHVRV11; error EPVHVRV03
#	$my_peeps = {'kryptonian_manofsteel_clarkkent' => 'Superman', 'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter', 'NUMBER_NOT_STRING' => -2112.23};  # TPVHVRV12; error EPVHVRV03
#	$my_peeps = {'kryptonian_manofsteel_clarkkent' => 'Superman', 'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter', 'ARRAY_NOT_STRING' => ['Tonto']};  # TPVHVRV13; error EPVHVRV03
#	$my_peeps = {'kryptonian_manofsteel_clarkkent' => 'Superman', 'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter', 'HASH_NOT_STRING' => {fizz => 3}};  # TPVHVRV14; error EPVHVRV03
#	$my_peeps = {'stuckinaworldhenevercreated' => 'Howard The Duck', 'kryptonian_manofsteel_clarkkent' => 'Superman', 'gothamite_darkknight_brucewayne' => 'Batman', 'amazonian_dianathemyscira_dianaprince' => 'Wonder Woman', 'scarletspeedster_barryallenetal' => 'Flash', 'alanscottetal' => 'Green Lantern', 'atlanteanhybrid_aquaticace_arthurcurryorin' => 'Aquaman', 'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter'};  # TPVHVRV20
#	$my_peeps = {'kryptonian_manofsteel_clarkkent' => 'Superman', 'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter', 'STRING_NOT_UNDEF' => 'undef'};  # TPVHVRV21
#	$my_peeps = {'kryptonian_manofsteel_clarkkent' => 'Superman', 'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter', 'STRING_NOT_INTEGER' => '23'};  # TPVHVRV22
#	$my_peeps = {'kryptonian_manofsteel_clarkkent' => 'Superman', 'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter', 'STRING_NOT_NUMBER' => '-2112.23'};  # TPVHVRV23
#	$my_peeps = {'kryptonian_manofsteel_clarkkent' => 'Superman', 'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter', "STRING_NOT_ARRAY" => "[Tonto]"};  # TPVHVRV24
#	$my_peeps = {'kryptonian_manofsteel_clarkkent' => 'Superman', 'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter', 'STRING_NOT_HASH' => '{buzz => 5}'};  # TPVHVRV25
#	RPerl::diag("in hash_test.pl, have \$my_peeps =\n" . RPerl::DUMPER($my_peeps) . "\n");
#	$retval_stringify = string_hashref_to_string($my_peeps);	
#	RPerl::diag("in hash_test.pl $i/$i_MAX, have \$retval_stringify =\n$retval_stringify\n");

#	$retval_stringify = string_hashref_typetest0();  # TPVHVRV30; error PERLOPS EPVHVRV00, CPPOPS "Usage: main::string_hashref_typetest0(input_unordered_map)"
#	$retval_stringify = string_hashref_typetest0(2);  # TPVHVRV31; error EPVHVRV01
#	$retval_stringify = string_hashref_typetest0({'kryptonian_manofsteel_clarkkent' => 'Superman', 'gothamite_darkknight_brucewayne' => 'Batman', 'amazonian_dianathemyscira_dianaprince' => 'Wonder Woman', 'scarletspeedster_barryallenetal' => 'Flash', 'alanscottetal' => 'Green Lantern', 'atlanteanhybrid_aquaticace_arthurcurryorin' => 'Aquaman', 'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter', 'UNDEF_NOT_STRING' => undef});  # TPVHVRV32; error EPVHVRV02
#	$retval_stringify = string_hashref_typetest0({'kryptonian_manofsteel_clarkkent' => 'Superman', 'gothamite_darkknight_brucewayne' => 'Batman', 'amazonian_dianathemyscira_dianaprince' => 'Wonder Woman', 'scarletspeedster_barryallenetal' => 'Flash', 'alanscottetal' => 'Green Lantern', 'atlanteanhybrid_aquaticace_arthurcurryorin' => 'Aquaman', 'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter', 'ARRAY_NOT_STRING' => [23, -42.3]});  # TPVHVRV33; error EPVHVRV03
#	$retval_stringify = string_hashref_typetest0({'stuckinaworldhenevercreated' => 'Howard The Duck', 'atlanteanhybrid_aquaticace_arthurcurryorin' => 'Aquaman', 'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter'});  # TPVHVRV34
#	RPerl::diag("in hash_test.pl $i/$i_MAX, have \$retval_stringify =\n$retval_stringify\n");

#	$retval_jeffys = string_hashref_typetest1(5);  # TPVHVRV40
#	RPerl::diag("in hash_test.pl, have \$retval_jeffys =\n" . RPerl::DUMPER($retval_jeffys) . "\n");

croak('Done for now, croaking');
}

#croak('Done for now, croaking');
