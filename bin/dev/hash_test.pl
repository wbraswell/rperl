#!/usr/bin/perl
use strict;
use warnings;
use version; our $VERSION = qv('0.1.3');
use Carp;

# RPERL DRIVER BOILERPLATE
BEGIN { package main;  our $RPERL_INCLUDE_PATH = '/tmp/RPerl-latest/lib'; }  # NEED REMOVE hard-coded path
BEGIN { use lib $main::RPERL_INCLUDE_PATH . '/CPAN/';  use MyConfig; }  # RPerl's MyConfig.pm 
BEGIN { use lib $main::RPERL_INCLUDE_PATH;  use RPerl;  use base ('RPerl');  $RPerl::INCLUDE_PATH = $main::RPERL_INCLUDE_PATH; }  # RPerl system files
BEGIN { use Data::Dumper;  our $AUTOLOAD;  sub AUTOLOAD { croak("AUTOLOAD purposefully disabled for debugging, have \$AUTOLOAD = '$AUTOLOAD' and \@_ = \n" . Dumper(\@_) . ', croaking'); } }  ## no critic qw(ProhibitAutoloading RequireArgUnpacking)  ## RPERL SYSTEM allow autoload  ## RPERL SYSTEM allow read-only @_

# UNCOMMENT TO ENABLE PERL TYPES FOR C++ OPS
#types::types_enable('PERL');

# UNCOMMENT TO ENABLE C++ TYPES FOR C++ OPS
types::types_enable('CPP');

# UNCOMMENT TO ENABLE C++
use RPerl::DataStructure::Hash_cpp;  RPerl::DataStructure::Hash_cpp::cpp_load();  RPerl::DataStructure::Hash_cpp::cpp_link();

print q{in array_test.pl, have ops_number() = '} . ops_number() . "'\n" or croak();
print q{in array_test.pl, have types_number() = '} . types_number() . "'\n" or croak();
print q{in array_test.pl, have ops_string() = '} . ops_string() . "'\n" or croak();
print q{in array_test.pl, have types_string() = '} . types_string() . "'\n" or croak();
print q{in array_test.pl, have ops_hash() = '} . ops_hash() . "'\n" or croak();
print q{in array_test.pl, have types_hash() = '} . types_hash() . "'\n" or croak();

# variable declarations
my string $retval_stringify;
my int__hash_ref $retval_int__hash_ref;
my number__hash_ref $retval_number__hash_ref;
my string__hash_ref $my_peeps = {};
my string__hash_ref $retval_jeffys;

# loop to test for memory leaks
my const_int $i_MAX = 1;
for my int $i ( 0 .. $i_MAX ) {
	print "in hash_test.pl, top of for() loop $i/$i_MAX\n" or croak();

#	$retval_stringify = stringify_int__hash_ref(2);  # HV00; raise/throw exception
#	$retval_stringify = stringify_int__hash_ref({a_key => 23});  # HV01
#	$retval_stringify = stringify_int__hash_ref({a_key => 2, b_key => 2112, c_key => 42, d_key => 23, e_key => 877, f_key => 33, g_key => 1701});  # HV02
#	$retval_stringify = stringify_int__hash_ref({a_key => 2, b_key => 2112, c_key => 42.3, d_key => 23, e_key => 877, f_key => 33, g_key => 1701});  # HV03; raise/throw exception
	$retval_stringify = stringify_int__hash_ref({a_key => 2, b_key => 2112, c_key => 42, d_key => '23', e_key => 877, f_key => 33, g_key => 1701});  # HV04; raise/throw exception
	print "in hash_test.pl $i/$i_MAX, have \$retval_stringify =\n$retval_stringify\n" or croak();

#	$retval_stringify = typetest___int__hash_ref__in___string__out({'binary' => 2, 'rush' => 2112, 'answer' => 42, 'fnord' => 23, 'units' => 877, 'degree' => 33, 'ncc' => 1701});  # HV10
#	$retval_stringify = typetest___int__hash_ref__in___string__out({'binary' => 2, 'rush' => 2112, 'ERROR_FUNKEY' => "abcdefg", 'answer' => 42, 'fnord' => 23, 'units' => 877, 'degree' => 33, 'ncc' => 1701});  # HV11; not-an-int error
#	print "in hash_test.pl $i/$i_MAX, have \$retval_stringify =\n$retval_stringify\n";

croak('Done for now, croaking');

#	$retval_int__hash_ref = typetest___int__in___int__hash_ref__out(5);
#	print "in hash_test.pl $i/$i_MAX, have \$retval_int__hash_ref = \n" . Dumper($retval_int__hash_ref) . "\n";

#	typetest___number__hash_ref__in___void__out({'binary' => 2.1234432112344321, 'rush' => 2112.4321, 'answer' => 42.4567, 'fnord' => 23.765444444444444444, 'units' => 877.5678, 'degree' => 33.876587658765875687658765, 'ncc' => 1701.6789});
#	typetest___number__hash_ref__in___void__out({'binary' => 2.1234432112344321, 'rush' => 2112.4321, 'ERROR_FUNKEY' => "abcdefg", 'answer' => 42.4567, 'fnord' => 23.765444444444444444, 'units' => 877.5678, 'degree' => 33.876587658765875687658765, 'ncc' => 1701.6789});  # not-a-number error

#	$retval_number__hash_ref = typetest___int__in___number__hash_ref__out(5);
#	print "in hash_test.pl $i/$i_MAX, have \$retval_number__hash_ref = \n" . Dumper($retval_number__hash_ref) . "\n";

#	$my_peeps = {'kryptonian_manofsteel_clarkkent' => 'Superman', 'gothamite_darkknight_brucewayne' => 'Batman', 'amazonian_dianathemyscira_dianaprince' => 'Wonder Woman', 'scarletspeedster_barryallenetal' => 'Flash', 'alanscottetal' => 'Green Lantern', 'atlanteanhybrid_aquaticace_arthurcurryorin' => 'Aquaman', 'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter', 'stringified_number' => -2112.23};  # stringifies numbers
#	$my_peeps = {'kryptonian_manofsteel_clarkkent' => 'Superman', 'gothamite_darkknight_brucewayne' => 'Batman', 'amazonian_dianathemyscira_dianaprince' => 'Wonder Woman', 'scarletspeedster_barryallenetal' => 'Flash', 'alanscottetal' => 'Green Lantern', 'atlanteanhybrid_aquaticace_arthurcurryorin' => 'Aquaman', 'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter', 'stringified_number' => -2112.23, 'ERROR_KEY' => {fuzz => 'bizz', bar => "stool!\n", bat => 24}};  # not-a-string error
#	print "in hash_test.pl, have \$my_peeps =\n" . RPerl::DUMPER($my_peeps) . "\n" if $RPerl::DEBUG;
#	typetest___string__hash_ref__in___void__out($my_peeps);

#	$retval_jeffys = typetest___int__in___string__hash_ref__out(5);
#	print "in type_test.pl, have \$retval_jeffys =\n" . RPerl::DUMPER($retval_jeffys) . "\n" if $RPerl::DEBUG;
}

#croak('Done for now, croaking');