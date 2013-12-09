#!/usr/bin/perl
use strict;
use warnings;
use version; our $VERSION = qv('0.1.5');
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

#	$retval_stringify = stringify_int__hash_ref(2);  # HVIV00; raise/throw exception
#	$retval_stringify = stringify_int__hash_ref({a_key => 23});  # HVIV01
#	$retval_stringify = stringify_int__hash_ref({a_key => 2, b_key => 2112, c_key => 42, d_key => 23, e_key => -877, f_key => 33, g_key => 1701});  # HVIV02
#	$retval_stringify = stringify_int__hash_ref({a_key => 2, b_key => 2112, c_key => 42.3, d_key => 23, e_key => -877, f_key => 33, g_key => 1701});  # HVIV03; raise/throw exception
#	$retval_stringify = stringify_int__hash_ref({a_key => 2, b_key => 2112, c_key => 42, d_key => '23', e_key => -877, f_key => 33, g_key => 1701});  # HVIV04; raise/throw exception
#	print "in hash_test.pl $i/$i_MAX, have \$retval_stringify =\n$retval_stringify\n" or croak();

#	$retval_stringify = typetest___int__hash_ref__in___string__out({'binary' => 2, 'rush' => 2112, 'answer' => 42, 'fnord' => 23, 'units' => -877, 'degree' => 33, 'ncc' => 1701});  # HVIV10
#	$retval_stringify = typetest___int__hash_ref__in___string__out({'binary' => 2, 'rush' => 2112, 'ERROR_FUNKEY' => 'abcdefg', 'answer' => 42, 'fnord' => 23, 'units' => -877, 'degree' => 33, 'ncc' => 1701});  # HVIV11; raise/throw exception
#	print "in hash_test.pl $i/$i_MAX, have \$retval_stringify =\n$retval_stringify\n";

#	my $howdy_retval = typetest___int__hash_ref__in___string__out({something => -444, degree => 33, ncc => 1701});  # HVIV12; confirm Perl stack is still functioning properly
#	print "in hash_test.pl $i/$i_MAX, have \$howdy_retval =\n$howdy_retval\n";

#	$retval_int__hash_ref = typetest___int__in___int__hash_ref__out(5);  # HVIV20
#	print "in hash_test.pl $i/$i_MAX, have \$retval_int__hash_ref = \n" . Dumper($retval_int__hash_ref) . "\n";

#	$retval_stringify = stringify_number__hash_ref(2);  # HVNV00; raise/throw exception
#	$retval_stringify = stringify_number__hash_ref({a_key => 23});  # HVNV01
#	$retval_stringify = stringify_number__hash_ref({a_key => 2, b_key => 2112, c_key => 42, d_key => 23, e_key => -877, f_key => 33, g_key => 1701});  # HVNV02
#	$retval_stringify = stringify_number__hash_ref({a_key => 2.1, b_key => 2112.2, c_key => 42.3, d_key => 23, e_key => -877, f_key => 33, g_key => 1701});  # HVNV03
#	$retval_stringify = stringify_number__hash_ref({a_key => 2.1234432112344321, b_key => 2112.4321, c_key => 42.4567, d_key => 23.765444444444444444, e_key => -877.5678, f_key => 33.876587658765875687658765, g_key => 1701.6789});  # HVNV04
#	$retval_stringify = stringify_number__hash_ref({a_key => 2, b_key => 2112, c_key => 42.3, d_key => '23', e_key => -877, f_key => 33, g_key => 1701});  # HVNV05; raise/throw exception
#	print "in hash_test.pl $i/$i_MAX, have \$retval_stringify =\n$retval_stringify\n" or croak();

#	$retval_stringify = typetest___number__hash_ref__in___string__out({'binary' => 2.1234432112344321, 'rush' => 2112.4321, 'answer' => 42.4567, 'fnord' => 23.765444444444444444, 'units' => -877.5678, 'degree' => 33.876587658765875687658765, 'ncc' => 1701.6789});  # HVNV10
#	$retval_stringify = typetest___number__hash_ref__in___string__out({'binary' => 2.1234432112344321, 'rush' => 2112.4321, 'ERROR_FUNKEY' => 'abcdefg', 'answer' => 42.4567, 'fnord' => 23.765444444444444444, 'units' => -877.5678, 'degree' => 33.876587658765875687658765, 'ncc' => 1701.6789});  # HVNV11; raise/throw exception
#	print "in hash_test.pl $i/$i_MAX, have \$retval_stringify =\n$retval_stringify\n";

#	my $howdy_retval = typetest___number__hash_ref__in___string__out({something => -444, degree => 33.876587658765875687658765, ncc => 1701.6789});  # HVNV12; confirm Perl stack is still functioning properly
#	print "in hash_test.pl $i/$i_MAX, have \$howdy_retval =\n$howdy_retval\n";

# START HERE: enable following test HVNV20 in 06_type_hash.t
# START HERE: enable following test HVNV20 in 06_type_hash.t
# START HERE: enable following test HVNV20 in 06_type_hash.t

	$retval_number__hash_ref = typetest___int__in___number__hash_ref__out(5);  # HVNV20
	print "in hash_test.pl $i/$i_MAX, have \$retval_number__hash_ref = \n" . Dumper($retval_number__hash_ref) . "\n";

croak('Done for now, croaking');

#	$retval_number__hash_ref = typetest___int__in___number__hash_ref__out(5);
#	print "in hash_test.pl $i/$i_MAX, have \$retval_number__hash_ref = \n" . Dumper($retval_number__hash_ref) . "\n";

#	$my_peeps = {'kryptonian_manofsteel_clarkkent' => 'Superman', 'gothamite_darkknight_brucewayne' => 'Batman', 'amazonian_dianathemyscira_dianaprince' => 'Wonder Woman', 'scarletspeedster_barryallenetal' => 'Flash', 'alanscottetal' => 'Green Lantern', 'atlanteanhybrid_aquaticace_arthurcurryorin' => 'Aquaman', 'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter', 'stringified_number' => -2112.23};  # stringifies numbers
#	$my_peeps = {'kryptonian_manofsteel_clarkkent' => 'Superman', 'gothamite_darkknight_brucewayne' => 'Batman', 'amazonian_dianathemyscira_dianaprince' => 'Wonder Woman', 'scarletspeedster_barryallenetal' => 'Flash', 'alanscottetal' => 'Green Lantern', 'atlanteanhybrid_aquaticace_arthurcurryorin' => 'Aquaman', 'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter', 'stringified_number' => -2112.23, 'ERROR_KEY' => {fuzz => 'bizz', bar => "stool!\n", bat => 24}};  # raise/throw exception
#	print "in hash_test.pl, have \$my_peeps =\n" . RPerl::DUMPER($my_peeps) . "\n" if $RPerl::DEBUG;
#	typetest___string__hash_ref__in___void__out($my_peeps);

#	$retval_jeffys = typetest___int__in___string__hash_ref__out(5);
#	print "in type_test.pl, have \$retval_jeffys =\n" . RPerl::DUMPER($retval_jeffys) . "\n" if $RPerl::DEBUG;
}

#croak('Done for now, croaking');



