#!/usr/bin/perl
use strict;  use warnings;

 # NEED REMOVE hard-coded path
BEGIN { package main;  our $RPERL_INCLUDE_PATH = '/tmp/RPerl-latest/lib'; }

use lib $main::RPERL_INCLUDE_PATH;  # RPerl system files
use RPerl;  our @ISA = ('RPerl');
$RPerl::INCLUDE_PATH = $main::RPERL_INCLUDE_PATH;

use lib $main::RPERL_INCLUDE_PATH . '/CPAN/';  # RPerl's MyConfig.pm 
use MyConfig;


#use RPerl::Algorithm::Inefficient;  # choose ONE of this
use RPerl::Algorithm::Inefficient_cpp;  RPerl::Algorithm::Inefficient_cpp::cpp_load();  RPerl::Algorithm::Inefficient_cpp::cpp_link(); # OR this

#my object $my_object;
#my number__array_ref $my_data;

#$my_object = RPerl::Algorithm::Inefficient->new();
#print "in type_test.pl, have \$my_object =\n" . RPerl::DUMPER($my_object) . "\n" if $RPerl::DEBUG;

typetest___int__in___void__out(2112);
typetest___string__in___void__out('Justice League Founders');
typetest___string__array_ref__in___void__out(['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter']);

my string__array_ref $my_jeffys = typetest___void__in___string__array_ref__out();
print "in type_test.pl, have \$my_jeffys =\n" . RPerl::DUMPER($my_jeffys) . "\n" if $RPerl::DEBUG;

typetest___int__array_ref__in___void__out([2, 2112, 42, 23, 877, 33, 1701]);
