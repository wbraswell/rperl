#!/usr/bin/perl
use strict;
use warnings;
our $VERSION = 0.000_004;
use Carp;

# RPERL DRIVER BOILERPLATE
BEGIN { package main;  our $RPERL_INCLUDE_PATH = 'blib/lib'; }  # NEED REMOVE hard-coded path
BEGIN { use RPerl;  use parent ('RPerl');  $RPerl::INCLUDE_PATH = $main::RPERL_INCLUDE_PATH; }  # RPerl system files
BEGIN { use Data::Dumper;  our $AUTOLOAD;  sub AUTOLOAD { croak("AUTOLOAD purposefully disabled for debugging, have \$AUTOLOAD = '$AUTOLOAD' and \@_ = \n" . Dumper(\@_) . ', croaking'); } }  ## no critic qw(ProhibitAutoloading RequireArgUnpacking)  ## RPERL SYSTEM allow autoload  ## RPERL SYSTEM allow read-only @_

# UNCOMMENT TO ENABLE PERL TYPES FOR C++ OPS
#rperltypes::types_enable('PERL');

# UNCOMMENT TO ENABLE C++ TYPES FOR C++ OPS
rperltypes::types_enable('CPP');


# START HERE: why are we receiving output of some CPPOPS_PERLTYPES instead of all CPPOPS_CPPTYPES???
# START HERE: why are we receiving output of some CPPOPS_PERLTYPES instead of all CPPOPS_CPPTYPES???
# START HERE: why are we receiving output of some CPPOPS_PERLTYPES instead of all CPPOPS_CPPTYPES???


# UNCOMMENT TO CHOOSE PERL OPS OR C++ OPS
#use RPerl::Algorithm::Sort::Bubble;  # choose ONE of this
use RPerl::Algorithm::Sort::Bubble_cpp;  RPerl::Algorithm::Sort::Bubble_cpp::cpp_load();  RPerl::Algorithm::Sort::Bubble_cpp::cpp_link(); # OR this

#print STDERR q{in oo_test.pl, have bubblesort__OPS_TYPES_ID = '} . $RPerl::Algorithm::Sort::Bubble::bubblesort__OPS_TYPES_ID . "'\n" or croak();  # PERL/PERL ONLY
print STDERR q{in oo_test.pl, have bubblesort__ops() = '} . bubblesort__ops() . "'\n" or croak();
print STDERR q{in oo_test.pl, have bubblesort__types() = '} . bubblesort__types() . "'\n" or croak();

# variable declarations
my object $sorter;

# loop to test for memory leaks
my const_integer $i_MAX = 1;
for my integer $i ( 0 .. $i_MAX ) {
	print STDERR "in oo_test.pl, top of for() loop $i/$i_MAX\n" or croak();

	$sorter = RPerl::Algorithm::Sort::Bubble->new();
	print STDERR "in oo_test.pl, have \$i = $i and pre-data \$sorter =\n" . Dumper($sorter) . "\n" if $RPerl::DEBUG;

	$sorter->inherited__Algorithm("Frozen");  # RPerl yes, C++ yes
	$sorter->inherited__Inefficient("Frozen");  # RPerl yes, C++ yes
	$sorter->inherited__Sort("Frozen");  # RPerl yes, C++ yes
	$sorter->inherited__Bubble("Frozen");  # RPerl yes, C++ yes
	print STDERR "\n";
#	RPerl::Algorithm::Sort::inherited($sorter, "Jean Gray");  # RPerl yes, C++ no
#	RPerl::Algorithm::Sort->inherited("Scott Summers");  # RPerl yes, C++ no
	$sorter->inherited("Logan");  # RPerl yes, C++ yes
#	inherited("MANORBEAST?", "Dr. Hank McCoy");  # RPerl no, C++ no; inherited method should only work as method!
	print STDERR "\n";
	uninherited__Algorithm("Claws");  # RPerl yes, C++ yes
	uninherited__Inefficient("Claws");  # RPerl yes, C++ yes
	uninherited__Sort("Claws");  # RPerl yes, C++ yes
	uninherited__Bubble("Claws");  # RPerl yes, C++ yes
	print STDERR "\n";
	uninherited("Wolverine");  # RPerl yes, C++ yes
#	RPerl::Algorithm::Sort::uninherited("Phoenix");  # RPerl yes, C++ no; bypass RPerl POST-INIT symbol table entries that put non-method uninherited() in main::, use AUTOLOAD
	main::uninherited("Wolvie");  # RPerl yes, C++ yes
	::uninherited("wlverine");  # RPerl yes, C++ yes


# HASH FOR REFERENCE
# HASH FOR REFERENCE
# HASH FOR REFERENCE
#	$retval_stringify = stringify_int__hash_ref(2);  # HVIV00; raise/throw exception
#	$retval_stringify = stringify_int__hash_ref({a_key => 23});  # HVIV01
#	print STDERR "in oo_test.pl $i/$i_MAX, have \$retval_stringify =\n$retval_stringify\n" or croak();
#	$retval_jeffys = typetest___int__in___string__hash_ref__out(5);  # HVPV20
#	print STDERR "in type_test.pl, have \$retval_jeffys =\n" . Dumper($retval_jeffys) . "\n" if $RPerl::DEBUG;

croak('Done for now, croaking');
}

#croak('Done for now, croaking');



