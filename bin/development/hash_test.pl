#!/usr/bin/perl
## no critic qw(ProhibitMagicNumbers ProhibitUnreachableCode)  ## RPERL allow numeric test values, allow unreachable test code
use strict;
use warnings;
use version; our $VERSION = qv('0.2.0');
use Carp;

# [[[ SETUP ]]]

# RPERL DRIVER BOILERPLATE
BEGIN { package main;  our $RPERL_INCLUDE_PATH = '/tmp/RPerl-latest/lib'; }  # NEED REMOVE hard-coded path
BEGIN { use lib $main::RPERL_INCLUDE_PATH . '/CPAN/';  use MyConfig; }  # RPerl's MyConfig.pm 
BEGIN { use lib $main::RPERL_INCLUDE_PATH;  use RPerl;  use parent ('RPerl');  $RPerl::INCLUDE_PATH = $main::RPERL_INCLUDE_PATH; }  # RPerl system files
BEGIN { use Data::Dumper;  our $AUTOLOAD;  sub AUTOLOAD { croak("AUTOLOAD purposefully disabled for debugging, have \$AUTOLOAD = '$AUTOLOAD' and \@_ = \n" . Dumper(\@_) . ', croaking'); } }  ## no critic qw(ProhibitAutoloading RequireArgUnpacking)  ## RPERL SYSTEM allow autoload  ## RPERL SYSTEM allow read-only @_

# UNCOMMENT TO ENABLE PERL TYPES FOR C++ OPS
#types::types_enable('PERL');

# UNCOMMENT TO ENABLE C++ TYPES FOR C++ OPS
types::types_enable('CPP');

# UNCOMMENT TO ENABLE C++ OPS
use RPerl::DataStructure::Hash_cpp;  RPerl::DataStructure::Hash_cpp::cpp_load();  RPerl::DataStructure::Hash_cpp::cpp_link();

print q{in array_test.pl, have ops_integer() = '} . ops_integer() . "'\n" or croak();
print q{in array_test.pl, have types_integer() = '} . types_integer() . "'\n" or croak();
print q{in array_test.pl, have ops_number() = '} . ops_number() . "'\n" or croak();
print q{in array_test.pl, have types_number() = '} . types_number() . "'\n" or croak();
print q{in array_test.pl, have ops_string() = '} . ops_string() . "'\n" or croak();
print q{in array_test.pl, have types_string() = '} . types_string() . "'\n" or croak();
print q{in array_test.pl, have ops_hash() = '} . ops_hash() . "'\n" or croak();
print q{in array_test.pl, have types_hash() = '} . types_hash() . "'\n" or croak();

#print qq{in array_test.pl, have SYMBOL TABLE for package 'main' =\n} . Dumper(\%{*{main::}}) . "\n" or croak();
#print qq{in array_test.pl, have SYMBOL TABLE entry for 'main::stringify_integer__hash_ref' =\n} . Dumper(\%{*{main::stringify_integer__hash_ref}}) . "\n" or croak();
#print qq{in array_test.pl, have 'stringify_integer__hash_ref' =\n} . Dumper(\*stringify_integer__hash_ref) . "\n" or croak();

# variable declarations
my string $retval_stringify;
my integer__hash_ref $retval_integer__hash_ref;
my number__hash_ref $retval_number__hash_ref;
my string__hash_ref $my_peeps = {};
my string__hash_ref $retval_jeffys;

# loop to test for memory leaks
my const_integer $i_MAX = 1;
for my integer $i ( 0 .. $i_MAX ) {
	print "in hash_test.pl, top of for() loop $i/$i_MAX\n" or croak();

    # [[[ INTEGER TESTS ]]]

#	$retval_stringify = stringify_integer__hash_ref();  # TIVHVRV00; error PERLOPS EHVRV00, CPPOPS "Usage: main::stringify_integer__hash_ref(input_unordered_map)"
#	$retval_stringify = stringify_integer__hash_ref(undef);  # TIVHVRV01; error EHVRV00
#	$retval_stringify = stringify_integer__hash_ref(2);  # TIVHVRV02; error EHVRV01
#	$retval_stringify = stringify_integer__hash_ref(2.3);  # TIVHVRV03; error EHVRV01
#	$retval_stringify = stringify_integer__hash_ref('2');  # TIVHVRV04; error EHVRV01
#	$retval_stringify = stringify_integer__hash_ref([2]);  # TIVHVRV05; error EHVRV01
#	$retval_stringify = stringify_integer__hash_ref({a_key => 2, b_key => 2112, c_key => undef, d_key => 23, e_key => -877, f_key => 33, g_key => 1701});  # TIVHVRV10; error EIV00
#	$retval_stringify = stringify_integer__hash_ref({a_key => 2, b_key => 2112, c_key => 42, d_key => 23.3, e_key => -877, f_key => 33, g_key => 1701});  # TIVHVRV11; error EIV01
#	$retval_stringify = stringify_integer__hash_ref({a_key => 2, b_key => 2112, c_key => 42, d_key => '23', e_key => -877, f_key => 33, g_key => 1701});  # TIVHVRV12; error EIV01
#	$retval_stringify = stringify_integer__hash_ref({a_key => 2, b_key => 2112, c_key => 42, d_key => [23], e_key => -877, f_key => 33, g_key => 1701});  # TIVHVRV13; error EIV01
#	$retval_stringify = stringify_integer__hash_ref({a_key => 2, b_key => 2112, c_key => 42, d_key => {a_subkey => 23}, e_key => -877, f_key => 33, g_key => 1701});  # TIVHVRV14; error EIV01
#	$retval_stringify = stringify_integer__hash_ref({a_key => 23});  # TIVHVRV20
#	$retval_stringify = stringify_integer__hash_ref({a_key => 2, b_key => 2112, c_key => 42, d_key => 23, e_key => -877, f_key => 33, g_key => 1701});  # TIVHVRV21
#	print "in hash_test.pl $i/$i_MAX, have \$retval_stringify =\n$retval_stringify\n" or croak();

#	$retval_stringify = typetest___integer__hash_ref__in___string__out();  # TIVHVRV30; error PERLOPS EHVRV00, CPPOPS "Usage: main::typetest___integer__hash_ref__in___string__out(input_unordered_map)"
#	$retval_stringify = typetest___integer__hash_ref__in___string__out(2);  # TIVHVRV31; error EHVRV01
#	$retval_stringify = typetest___integer__hash_ref__in___string__out({'binary' => 2, 'rush' => 2112, 'answer' => 42, 'fnord' => 23, 'units' => -877, 'degree' => 33, 'ncc' => 1701});  # TIVHVRV32
#	$retval_stringify = typetest___integer__hash_ref__in___string__out({'binary' => 2, 'rush' => 2112, 'ERROR_FUNKEY' => undef, 'answer' => 42, 'fnord' => 23, 'units' => -877, 'degree' => 33, 'ncc' => 1701});  # TIVHVRV33; error EIV00
#	$retval_stringify = typetest___integer__hash_ref__in___string__out({'binary' => 2, 'rush' => 2112, 'ERROR_FUNKEY' => 'abcdefg', 'answer' => 42, 'fnord' => 23, 'units' => -877, 'degree' => 33, 'ncc' => 1701});  # TIVHVRV34; error EIV01
#	print "in hash_test.pl $i/$i_MAX, have \$retval_stringify =\n$retval_stringify\n";

#	$retval_integer__hash_ref = typetest___integer__in___integer__hash_ref__out(5);  # TIVHVRV40
#	print "in hash_test.pl $i/$i_MAX, have \$retval_integer__hash_ref = \n" . Dumper($retval_integer__hash_ref) . "\n" or croak();

    # [[[ NUMBER TESTS ]]]

#	$retval_stringify = stringify_number__hash_ref();  # TNVHVRV00; error PERLOPS EHVRV00, CPPOPS "Usage: main::stringify_number__hash_ref(input_unordered_map)"
#	$retval_stringify = stringify_number__hash_ref(undef);  # TNVHVRV01; error EHVRV00
#	$retval_stringify = stringify_number__hash_ref(2);  # TNVHVRV02; error EHVRV01
#	$retval_stringify = stringify_number__hash_ref(2.3);  # TNVHVRV03; error EHVRV01
#	$retval_stringify = stringify_number__hash_ref('2');  # TNVHVRV04; error EHVRV01
#	$retval_stringify = stringify_number__hash_ref([2]);  # TNVHVRV05; error EHVRV01
#	$retval_stringify = stringify_number__hash_ref({a_key => 2, b_key => 2112, c_key => undef, d_key => 23, e_key => -877, f_key => 33, g_key => 1701});  # TNVHVRV10; error ENV00
#	$retval_stringify = stringify_number__hash_ref({a_key => 2, b_key => 2112, c_key => 42.3, d_key => '23', e_key => -877, f_key => 33, g_key => 1701});  # TNVHVRV11; error ENV01
#	$retval_stringify = stringify_number__hash_ref({a_key => 2, b_key => 2112, c_key => 42.3, d_key => [23], e_key => -877, f_key => 33, g_key => 1701});  # TNVHVRV12; error ENV01
#	$retval_stringify = stringify_number__hash_ref({a_key => 2, b_key => 2112, c_key => 42.3, d_key => {a_subkey => 23}, e_key => -877, f_key => 33, g_key => 1701});  # TNVHVRV13; error ENV01
#	$retval_stringify = stringify_number__hash_ref({a_key => 23});  # TNVHVRV20
#	$retval_stringify = stringify_number__hash_ref({a_key => 2, b_key => 2112, c_key => 42, d_key => 23, e_key => -877, f_key => 33, g_key => 1701});  # TNVHVRV21
#	$retval_stringify = stringify_number__hash_ref({a_key => 2.1234432112344321});  # TNVHVRV22
#	$retval_stringify = stringify_number__hash_ref({a_key => 2.1234432112344321, b_key => 2112.4321, c_key => 42.4567, d_key => 23.765444444444444444, e_key => -877.5678, f_key => 33.876587658765875687658765, g_key => 1701.6789});  # TNVHVRV23
#	print "in hash_test.pl $i/$i_MAX, have \$retval_stringify =\n$retval_stringify\n" or croak();

#	$retval_stringify = typetest___number__hash_ref__in___string__out();  # TNVHVRV30; error PERLOPS EHVRV00, CPPOPS "Usage: main::typetest___number__hash_ref__in___string__out(input_unordered_map)"
#	$retval_stringify = typetest___number__hash_ref__in___string__out(2);  # TNVHVRV31; error EHVRV01
#	$retval_stringify = typetest___number__hash_ref__in___string__out({'binary' => 2.1234432112344321, 'rush' => 2112.4321, 'answer' => 42.4567, 'fnord' => 23.765444444444444444, 'units' => -877.5678, 'degree' => 33.876587658765875687658765, 'ncc' => 1701.6789});  # TNVHVRV32
#	$retval_stringify = typetest___number__hash_ref__in___string__out({'binary' => 2.1234432112344321, 'rush' => 2112.4321, 'ERROR_FUNKEY' => undef, 'answer' => 42.4567, 'fnord' => 23.765444444444444444, 'units' => -877.5678, 'degree' => 33.876587658765875687658765, 'ncc' => 1701.6789});  # TNVHVRV33; error ENV00
#	$retval_stringify = typetest___number__hash_ref__in___string__out({'binary' => 2.1234432112344321, 'rush' => 2112.4321, 'ERROR_FUNKEY' => 'abcdefg', 'answer' => 42.4567, 'fnord' => 23.765444444444444444, 'units' => -877.5678, 'degree' => 33.876587658765875687658765, 'ncc' => 1701.6789});  # TNVHVRV34; error ENV01
#	print "in hash_test.pl $i/$i_MAX, have \$retval_stringify =\n$retval_stringify\n";

#	$retval_number__hash_ref = typetest___integer__in___number__hash_ref__out(5);  # TNVHVRV40
#	print "in hash_test.pl $i/$i_MAX, have \$retval_number__hash_ref = \n" . Dumper($retval_number__hash_ref) . "\n" or croak();

    # [[[ STRING TESTS ]]]

#	$retval_stringify = stringify_string__hash_ref();  # TPVHVRV00; error PERLOPS EHVRV00, CPPOPS "Usage: main::stringify_string__hash_ref(input_unordered_map)"
#	$retval_stringify = stringify_string__hash_ref(undef);  # TPVHVRV01; error EHVRV00
#	$retval_stringify = stringify_string__hash_ref(2);  # TPVHVRV02; error EHVRV01
#	$retval_stringify = stringify_string__hash_ref(2.3);  # TPVHVRV03; error EHVRV01
#	$retval_stringify = stringify_string__hash_ref('Lone Ranger');  # TPVHVRV04; error EHVRV01
#	$retval_stringify = stringify_string__hash_ref(['Lone Ranger']);  # TPVHVRV05; error EHVRV01
#	$my_peeps = {'kryptonian_manofsteel_clarkkent' => 'Superman', 'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter', 'UNDEF_NOT_STRING' => undef};  # TPVHVRV10; error EPV00
#	$my_peeps = {'kryptonian_manofsteel_clarkkent' => 'Superman', 'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter', 'INTEGER_NOT_STRING' => 23};  # TPVHVRV11; error EPV01
#	$my_peeps = {'kryptonian_manofsteel_clarkkent' => 'Superman', 'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter', 'NUMBER_NOT_STRING' => -2112.23};  # TPVHVRV12; error EPV01
#	$my_peeps = {'kryptonian_manofsteel_clarkkent' => 'Superman', 'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter', 'ARRAY_NOT_STRING' => ['Tonto']};  # TPVHVRV13; error EPV01
#	$my_peeps = {'kryptonian_manofsteel_clarkkent' => 'Superman', 'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter', 'HASH_NOT_STRING' => {fizz => 3}};  # TPVHVRV14; error EPV01
#	$my_peeps = {'stuckinaworldhenevercreated' => 'Howard The Duck', 'kryptonian_manofsteel_clarkkent' => 'Superman', 'gothamite_darkknight_brucewayne' => 'Batman', 'amazonian_dianathemyscira_dianaprince' => 'Wonder Woman', 'scarletspeedster_barryallenetal' => 'Flash', 'alanscottetal' => 'Green Lantern', 'atlanteanhybrid_aquaticace_arthurcurryorin' => 'Aquaman', 'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter'};  # TPVHVRV20
#	$my_peeps = {'kryptonian_manofsteel_clarkkent' => 'Superman', 'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter', 'STRING_NOT_UNDEF' => 'undef'};  # TPVHVRV21
#	$my_peeps = {'kryptonian_manofsteel_clarkkent' => 'Superman', 'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter', 'STRING_NOT_INTEGER' => '23'};  # TPVHVRV22
#	$my_peeps = {'kryptonian_manofsteel_clarkkent' => 'Superman', 'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter', 'STRING_NOT_NUMBER' => '-2112.23'};  # TPVHVRV23
	$my_peeps = {'kryptonian_manofsteel_clarkkent' => 'Superman', 'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter', "STRING_'NOT'_ARRAY" => "['Tonto']"};  # TPVHVRV24 # DEV NOTE: strings containing single-quotes, will be back-slash delimited by stringify_*()
#	$my_peeps = {'kryptonian_manofsteel_clarkkent' => 'Superman', 'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter', 'STRING_NOT_HASH' => '{buzz => 5}'};  # TPVHVRV25
#	print "in hash_test.pl, have \$my_peeps =\n" . RPerl::DUMPER($my_peeps) . "\n" or croak();
	$retval_stringify = stringify_string__hash_ref($my_peeps);	
	print "in hash_test.pl $i/$i_MAX, have \$retval_stringify =\n$retval_stringify\n";

#	$retval_stringify = typetest___string__hash_ref__in___string__out();  # TPVHVRV30; error PERLOPS EHVRV00, CPPOPS "Usage: main::typetest___string__hash_ref__in___string__out(input_unordered_map)"
#	$retval_stringify = typetest___string__hash_ref__in___string__out(2);  # TPVHVRV31; error EHVRV01
#	$retval_stringify = typetest___string__hash_ref__in___string__out({'kryptonian_manofsteel_clarkkent' => 'Superman', 'gothamite_darkknight_brucewayne' => 'Batman', 'amazonian_dianathemyscira_dianaprince' => 'Wonder Woman', 'scarletspeedster_barryallenetal' => 'Flash', 'alanscottetal' => 'Green Lantern', 'atlanteanhybrid_aquaticace_arthurcurryorin' => 'Aquaman', 'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter'});  # TPVHVRV32
#	$retval_stringify = typetest___string__hash_ref__in___string__out({'kryptonian_manofsteel_clarkkent' => 'Superman', 'gothamite_darkknight_brucewayne' => 'Batman', 'amazonian_dianathemyscira_dianaprince' => 'Wonder Woman', 'scarletspeedster_barryallenetal' => 'Flash', 'alanscottetal' => 'Green Lantern', 'atlanteanhybrid_aquaticace_arthurcurryorin' => 'Aquaman', 'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter', 'UNDEF_NOT_STRING' => undef});  # TPVHVRV33; error EPV00
#	$retval_stringify = typetest___string__hash_ref__in___string__out({'kryptonian_manofsteel_clarkkent' => 'Superman', 'gothamite_darkknight_brucewayne' => 'Batman', 'amazonian_dianathemyscira_dianaprince' => 'Wonder Woman', 'scarletspeedster_barryallenetal' => 'Flash', 'alanscottetal' => 'Green Lantern', 'atlanteanhybrid_aquaticace_arthurcurryorin' => 'Aquaman', 'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter', 'ARRAY_NOT_STRING' => [23, -42.3]});  # TPVHVRV34; error EPV01
#	print "in hash_test.pl $i/$i_MAX, have \$retval_stringify =\n$retval_stringify\n";

#	$retval_jeffys = typetest___integer__in___string__hash_ref__out(5);  # TPVHVRV40
#	print "in hash_test.pl, have \$retval_jeffys =\n" . RPerl::DUMPER($retval_jeffys) . "\n" or croak();

croak('Done for now, croaking');
}

#croak('Done for now, croaking');



