#!/usr/bin/perl
use strict;
use warnings;
use version; our $VERSION = qv('0.3.0');
use Carp;

# RPERL DRIVER BOILERPLATE
BEGIN { package main;  our $RPERL_INCLUDE_PATH = '/tmp/RPerl-latest/lib'; }  # NEED REMOVE hard-coded path
BEGIN { use lib $main::RPERL_INCLUDE_PATH . '/CPAN/';  use MyConfig; }  # RPerl's MyConfig.pm 
BEGIN { use lib $main::RPERL_INCLUDE_PATH;  use RPerl;  use base ('RPerl');  $RPerl::INCLUDE_PATH = $main::RPERL_INCLUDE_PATH; }  # RPerl system files
BEGIN { use Data::Dumper;  our $AUTOLOAD;  sub AUTOLOAD { croak("AUTOLOAD purposefully disabled for debugging, have \$AUTOLOAD = '$AUTOLOAD' and \@_ = \n" . Dumper(\@_) . ', croaking'); } } ## no critic qw(ProhibitAutoloading RequireArgUnpacking)  ## RPERL SYSTEM allow autoload  ## RPERL SYSTEM allow read-only @_

# UNCOMMENT TO ENABLE PERL TYPES FOR C++ OPS
#types::types_enable('PERL');

# UNCOMMENT TO ENABLE C++ TYPES FOR C++ OPS
types::types_enable('CPP');

# UNCOMMENT TO ENABLE C++ OPS
use RPerl::DataStructure::Array_cpp;  RPerl::DataStructure::Array_cpp::cpp_load();  RPerl::DataStructure::Array_cpp::cpp_link();

print q{in array_test.pl, have ops_number() = '} . ops_number() . "'\n" or croak();
print q{in array_test.pl, have types_number() = '} . types_number() . "'\n" or croak();
print q{in array_test.pl, have ops_string() = '} . ops_string() . "'\n" or croak();
print q{in array_test.pl, have types_string() = '} . types_string() . "'\n" or croak();
print q{in array_test.pl, have ops_array() = '} . ops_array() . "'\n" or croak();
print q{in array_test.pl, have types_array() = '} . types_array() . "'\n" or croak();

# variable declarations
my string $retval_stringify;
my int__array_ref $retval_int__array_ref;
my number__array_ref $retval_number__array_ref;
my string__array_ref $my_peeps;
my string__array_ref $retval_jeffys;

# loop to test for memory leaks
my const_int $i_MAX = 1;
for my int $i ( 0 .. $i_MAX ) {
	print "in array_test.pl, top of for() loop $i/$i_MAX\n" or croak();

#	$retval_stringify = stringify_int__array_ref(2);  # AV00; raise/throw exception
#	$retval_stringify = stringify_int__array_ref([2]);  # AV01
#	$retval_stringify = stringify_int__array_ref([2, 2112, 42, 23, 877, 33, 1701]);  # AV02
#	$retval_stringify = stringify_int__array_ref([2, 2112, 42.3, 23, 877, 33, 1701]);  # AV03; raise/throw exception
#	$retval_stringify = stringify_int__array_ref([2, 2112, '42', 23, 877, 33, 1701]);  # AV04; raise/throw exception
#	print "in array_test.pl $i/$i_MAX, have \$retval_stringify =\n$retval_stringify\n" or croak();

#	$retval_stringify = typetest___int__array_ref__in___string__out([2, 2112, 42, 23, 877, 33, 1701]);  # AV10
	$retval_stringify = typetest___int__array_ref__in___string__out([2, 2112, 42, 23, 877, "abcdefg\n", 33, 1701]);  # AV11; not-an-int error
	print "in array_test.pl $i/$i_MAX, have \$retval_stringify =\n$retval_stringify\n";

croak('Done for now, croaking');

#	my $howdy_retval = typetest___int__array_ref__in___string__out([444, 33, 1701]);  # AV12; confirm Perl stack is still functioning properly
#	print "in array_test.pl $i/$i_MAX, have \$howdy_retval =\n$howdy_retval\n";

#	$retval_int__array_ref = typetest___int__in___int__array_ref__out(5);  # AV20
#	print "in array_test.pl $i/$i_MAX, have \$retval_int__array_ref = \n" . Dumper($retval_int__array_ref) . "\n";

#	$retval_stringify = stringify_number__array_ref(2);  # AV30; raise/throw exception
#	$retval_stringify = stringify_number__array_ref([2]);  # AV31
#	$retval_stringify = stringify_number__array_ref([2, 2112, 42, 23, 877, 33, 1701]);  # AV32
#	$retval_stringify = stringify_number__array_ref([2.1, 2112.2, 42.3, 23, 877, 33, 1701]);  # AV33
#	$retval_stringify = stringify_number__array_ref([2.1234432112344321, 2112.4321, 42.4567, 23.765444444444444444, 877.5678, 33.876587658765875687658765, 1701.6789]);  # AV34
#	$retval_stringify = stringify_number__array_ref([2, 2112, '42', 23, 877, 33, 1701]);  # AV35; raise/throw exception
#	print "in array_test.pl $i/$i_MAX, have \$retval_stringify =\n$retval_stringify\n";

#	$retval_stringify = typetest___number__array_ref__in___string__out([2.1234432112344321, 2112.4321, 42.4567, 23.765444444444444444, 877.5678, 33.876587658765875687658765, 1701.6789]);  # AV40
#	$retval_stringify = typetest___number__array_ref__in___string__out([2.1234432112344321, 2112.4321, 42.4567, 23.765444444444444444, 877.5678, "abcdefg\n", 33.876587658765875687658765, 1701.6789]);  # AV41; raise/throw exception
#	print "in array_test.pl $i/$i_MAX, have \$retval_stringify =\n$retval_stringify\n";

#	$retval_number__array_ref = typetest___int__in___number__array_ref__out(5);  # AV50
#	print "in array_test.pl $i/$i_MAX, have \$retval_number__array_ref = \n" . Dumper($retval_number__array_ref) . "\n";

#	$my_peeps = 'Lone Ranger';  # AV60; raise/throw exception
#	$my_peeps = ['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter'];  # AV61
#	$my_peeps = ['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter', '23'];  # AV62
#	$my_peeps = ['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter', 23];  # AV63; raise/throw exception
#	$my_peeps = ['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter', '-2112.23'];  # AV64
#	$my_peeps = ['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter', "-2112.23"];  # AV65
#	$my_peeps = ['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter', -2112.23];  # AV66; raise/throw exception
#	$my_peeps = ['Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter', {fuzz => 'bizz', bar => "stool!\n", bat => 24}];  # AV67; raise/throw exception
#	print "in array_test.pl $i/$i_MAX, have \$my_peeps =\n" . RPerl::DUMPER($my_peeps);
#	$retval_stringify = stringify_string__array_ref($my_peeps);	
#	print "in array_test.pl $i/$i_MAX, have \$retval_stringify =\n$retval_stringify\n";

#	$retval_stringify = typetest___string__array_ref__in___string__out($my_peeps);
#	$retval_stringify = typetest___string__array_ref__in___string__out("Should be people, instead just a person!");  # break strict refs and then segfault, not test-worthy!  DEV NOTE: segfault likely due to not running SvROK() and SvTYPE() before SvRV() in CPPOPS_PERLTYPES
#	$retval_stringify = typetest___string__array_ref__in___string__out(['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter']);  # AV70
#	$retval_stringify = typetest___string__array_ref__in___string__out(['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter', 23]);  # AV71; raise/throw exception
#	print "in array_test.pl $i/$i_MAX, have \$retval_stringify =\n$retval_stringify\n";

	$retval_jeffys = typetest___int__in___string__array_ref__out(5);  # AV80
	print "in type_test.pl $i/$i_MAX, have \$retval_jeffys =\n" . Dumper($retval_jeffys) . "\n";
}

#croak('Done for now, croaking');
