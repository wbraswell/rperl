#!/usr/bin/perl
use strict;
use warnings;
use version; our $VERSION = qv('0.3.4');
use Carp;

# RPERL DRIVER BOILERPLATE
BEGIN { package main;  our $RPERL_INCLUDE_PATH = '/tmp/RPerl-latest/lib'; }  # NEED REMOVE hard-coded path
BEGIN { use lib $main::RPERL_INCLUDE_PATH . '/CPAN/';  use MyConfig; }  # RPerl's MyConfig.pm 
BEGIN { use lib $main::RPERL_INCLUDE_PATH;  use RPerl;  use parent ('RPerl');  $RPerl::INCLUDE_PATH = $main::RPERL_INCLUDE_PATH; }  # RPerl system files
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
my integer__array_ref $retval_integer__array_ref;
my number__array_ref $retval_number__array_ref;
my string__array_ref $my_peeps;
my string__array_ref $retval_jeffys;

# loop to test for memory leaks
my const_integer $i_MAX = 1;
for my integer $i ( 0 .. $i_MAX ) {
	print "in array_test.pl, top of for() loop $i/$i_MAX\n" or croak();

#	$retval_stringify = stringify_integer__array_ref(2);  # AVIV00; raise/throw exception
#	$retval_stringify = stringify_integer__array_ref([2]);  # AVIV01
#	$retval_stringify = stringify_integer__array_ref([2, 2112, 42, 23, -877, 33, 1701]);  # AVIV02
#	$retval_stringify = stringify_integer__array_ref([2, 2112, 42.3, 23, -877, 33, 1701]);  # AVIV03; raise/throw exception
#	$retval_stringify = stringify_integer__array_ref([2, 2112, 42, '23', -877, 33, 1701]);  # AVIV04; raise/throw exception
#	print "in array_test.pl $i/$i_MAX, have \$retval_stringify =\n$retval_stringify\n" or croak();

#	$retval_stringify = typetest___integer__array_ref__in___string__out([2, 2112, 42, 23, -877, 33, 1701]);  # AVIV10
#	$retval_stringify = typetest___integer__array_ref__in___string__out([2, 2112, 42, 23, -877, 'abcdefg', 33, 1701]);  # AVIV11; not-an-integer error
#	print "in array_test.pl $i/$i_MAX, have \$retval_stringify =\n$retval_stringify\n";

#	my $howdy_retval = typetest___integer__array_ref__in___string__out([-444, 33, 1701]);  # AVIV12; confirm Perl stack is still functioning properly
#	print "in array_test.pl $i/$i_MAX, have \$howdy_retval =\n$howdy_retval\n";

#	$retval_integer__array_ref = typetest___integer__in___integer__array_ref__out(5);  # AVIV20
#	print "in array_test.pl $i/$i_MAX, have \$retval_integer__array_ref = \n" . Dumper($retval_integer__array_ref) . "\n";

#	$retval_stringify = stringify_number__array_ref(2);  # AVNV00; raise/throw exception
#	$retval_stringify = stringify_number__array_ref([2]);  # AVNV01
#	$retval_stringify = stringify_number__array_ref([2, 2112, 42, 23, -877, 33, 1701]);  # AVNV02
#	$retval_stringify = stringify_number__array_ref([2.1, 2112.2, 42.3, 23, -877, 33, 1701]);  # AVNV03
#	$retval_stringify = stringify_number__array_ref([2.1234432112344321, 2112.4321, 42.4567, 23.765444444444444444, -877.5678, 33.876587658765875687658765, 1701.6789]);  # AVNV04
#	$retval_stringify = stringify_number__array_ref([2, 2112, 42, '23', -877, 33, 1701]);  # AVNV05; raise/throw exception
#	print "in array_test.pl $i/$i_MAX, have \$retval_stringify =\n$retval_stringify\n";

#	$retval_stringify = typetest___number__array_ref__in___string__out([2.1234432112344321, 2112.4321, 42.4567, 23.765444444444444444, -877.5678, 33.876587658765875687658765, 1701.6789]);  # AVNV10
#	$retval_stringify = typetest___number__array_ref__in___string__out([2.1234432112344321, 2112.4321, 42.4567, 23.765444444444444444, -877.5678, 'abcdefg', 33.876587658765875687658765, 1701.6789]);  # AVNV11; raise/throw exception
#	print "in array_test.pl $i/$i_MAX, have \$retval_stringify =\n$retval_stringify\n";

#	my $howdy_retval = typetest___number__array_ref__in___string__out([-444, 33.876587658765875687658765, 1701.6789]);  # AVNV12; confirm Perl stack is still functioning properly
#	print "in array_test.pl $i/$i_MAX, have \$howdy_retval =\n$howdy_retval\n";

#	$retval_number__array_ref = typetest___integer__in___number__array_ref__out(5);  # AVNV20
#	print "in array_test.pl $i/$i_MAX, have \$retval_number__array_ref = \n" . Dumper($retval_number__array_ref) . "\n";

#	$my_peeps = 'Lone Ranger';  # AVPV00; raise/throw exception
#	$my_peeps = ['Superman'];  # AVPV01
#	$my_peeps = ['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter'];  # AVPV02
#	$my_peeps = ['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter', '23'];  # AVPV03
#	$my_peeps = ['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter', 23];  # AVPV04; raise/throw exception
#	$my_peeps = ['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter', '-2112.23'];  # AVPV05
#	$my_peeps = ['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter', "-2112.23"];  # AVPV06
#	$my_peeps = ['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter', -2112.23];  # AVPV07; raise/throw exception
#	$my_peeps = ['Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter', {fuzz => 'bizz', bar => "stool!\n", bat => 24}];  # AVPV08; raise/throw exception
#	print "in array_test.pl $i/$i_MAX, have \$my_peeps =\n" . RPerl::DUMPER($my_peeps);
#	$retval_stringify = stringify_string__array_ref($my_peeps);	
#	print "in array_test.pl $i/$i_MAX, have \$retval_stringify =\n$retval_stringify\n";

#	$retval_stringify = typetest___string__array_ref__in___string__out($my_peeps);
#	$retval_stringify = typetest___string__array_ref__in___string__out("Should be people, instead just a person!");  # break strict refs and then segfault, not test-worthy!  DEV NOTE: segfault likely due to not running SvROK() and SvTYPE() before SvRV() in CPPOPS_PERLTYPES
#	$retval_stringify = typetest___string__array_ref__in___string__out(['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter']);  # AVPV10
#	$retval_stringify = typetest___string__array_ref__in___string__out(['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter', 23]);  # AVPV11; raise/throw exception
#	print "in array_test.pl $i/$i_MAX, have \$retval_stringify =\n$retval_stringify\n";

	my $howdy_retval = typetest___string__array_ref__in___string__out(['Howard The Duck', 'Aquaman', 'Martian Manhunter']);  # AVPV12; confirm Perl stack is still functioning properly
	print "in array_test.pl $i/$i_MAX, have \$howdy_retval =\n$howdy_retval\n";

croak('Done for now, croaking');
	
	$retval_jeffys = typetest___integer__in___string__array_ref__out(5);  # AVPV20
	print "in array_test.pl $i/$i_MAX, have \$retval_jeffys =\n" . Dumper($retval_jeffys) . "\n";
}

#croak('Done for now, croaking');
