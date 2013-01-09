#!/usr/bin/perl
use strict;  use warnings;  use types;
use Data::Dumper;

#use RPerl::Algorithm::Sort::Bubble;
use RPerl::Algorithm::Sort::Quick;

my scalar_array_ref $data = [21, 12, 31, 13, 42, 2012, 5555, 1.21, 33.3, 9999, -15, 0];

#my object $sorter = RPerl::Algorithm::Sort::Bubble->new();
my object $sorter = RPerl::Algorithm::Sort::Quick->new();

print "in sort.pl, have \$sorter =\n" . Dumper($sorter) . "\n";
$sorter->{data_scalar_array_ref} = $data;

print "in sort.pl, have unsorted \$sorter->{data_scalar_array_ref} =\n" . Dumper($sorter->{data_scalar_array_ref}) . "\n";
$sorter->sort_void();
print "in sort.pl, have sorted \$sorter->{data_scalar_array_ref} =\n" . Dumper($sorter->{data_scalar_array_ref}) . "\n";

#my object $sorter2 = RPerl::Algorithm::Sort::Bubble->new();
my object $sorter2 = RPerl::Algorithm::Sort::Quick->new();

$sorter2->{data_scalar_array_ref} = [5, 4, 3, 2, 1, 0];
$sorter2->sort_void();
print "in sort.pl, have sorted \$sorter2->{data_scalar_array_ref} =\n" . Dumper($sorter2->{data_scalar_array_ref}) . "\n";
print "in sort.pl, have sorted \$sorter->{data_scalar_array_ref} =\n" . Dumper($sorter->{data_scalar_array_ref}) . "\n";

