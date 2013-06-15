#!/usr/bin/perl
use lib '/home/wbraswell/austin_perl_mongers/compiler/RPerl/RPerl-latest/lib';  # RPerl system files
use strict;  use warnings;  use RPerl;  our @ISA = ('RPerl');

use lib '/home/wbraswell/austin_perl_mongers/compiler/RPerl/RPerl-latest/lib/CPAN';  # RPerl's MyConfig.pm
use MyConfig;

# test if @INC now gives us access to the Inline libraries
#use Parse::RecDescent;
#use Inline;
#use Inline::C;
#use Inline::CPP;

use RPerl::Algorithm::Sort::Bubble_cpp;

my object $sorter = RPerl::Algorithm::Sort::Bubble->new();
print "in bubble_cpp_test.pl, have \$sorter =\n" . RPerl::DUMPER($sorter) . "\n" if $RPerl::DEBUG;

$sorter->data_set([5, 4, 3, 2, 1, 0]);
print "in bubble_cpp_test.pl, have unsorted \$sorter->data_get() =\n" . RPerl::DUMPER($sorter->data_get()) . "\n" if $RPerl::DEBUG;

$sorter->sort_method();
print "in bubble_cpp_test.pl, have sorted \$sorter->data_get() =\n" . RPerl::DUMPER($sorter->data_get()) . "\n" if $RPerl::DEBUG;