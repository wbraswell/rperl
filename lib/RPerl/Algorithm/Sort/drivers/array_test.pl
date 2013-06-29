#!/usr/bin/perl
use strict;  use warnings;
use lib '/tmp/RPerl-latest/lib';  # RPerl system files  # NEED REMOVE hard-coded path
use RPerl;  our @ISA = ('RPerl');

use Data::Dumper;
our $AUTOLOAD;  sub AUTOLOAD { die("AUTOLOAD purposefully disabled, have \$AUTOLOAD = '$AUTOLOAD' and \@_ = \n" . Dumper(\@_) . ", dying"); }

use lib '/tmp/RPerl-latest/lib/CPAN';  # RPerl's MyConfig.pm  # NEED REMOVE hard-coded path
use MyConfig;

#use RPerl::DataStructure::Array;  # choose ONE of this
use RPerl::DataStructure::Array_cpp;  RPerl::DataStructure::Array_cpp::cpp_load();  RPerl::DataStructure::Array_cpp::cpp_link();  # OR this

typetest___int__in___void__out(23);

typetest___int__array_ref__in___void__out([2, 2112, 42, 23, 877, 33, 1701]);
my $retval_array_ref = typetest___int__in___int__array_ref__out(5);
print "in array_test.pl, have \$retval_array_ref = \n" . Dumper($retval_array_ref) . "\n";

die("Done for now, dying");

typetest___string__in___void__out("Melange");

##my string__array_ref $my_peeps = ['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter'];
my $my_peeps = ['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter'];

##print "in array_test.pl, have \$my_peeps =\n" . RPerl::DUMPER($my_peeps) . "\n" if $RPerl::DEBUG;
print "in array_test.pl, have \$my_peeps =\n" . Dumper($my_peeps) . "\n";

typetest___string__array_ref__in___void__out($my_peeps);
#typetest___string__array_ref__in___void__out("Should be people, instead just a person!");
#typetest___string__array_ref__in___void__out(['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter']);

my string__array_ref $my_jeffys = typetest___void__in___string__array_ref__out();
print "in type_test.pl, have \$my_jeffys =\n" . RPerl::DUMPER($my_jeffys) . "\n" if $RPerl::DEBUG;



