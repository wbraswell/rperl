#!/usr/bin/perl
use strict;  use warnings;  use RPerl;  our @ISA = ('RPerl');

#use RPerl::Algorithm::Sort::Bubble;
#use RPerl::Algorithm::Sort::Quick;
use RPerl::Algorithm::Sort::Merge;

my scalar_array_ref $data = [21, 12, 31, 13, 42, 2012, 5555, 1.21, 33.3, 9999, -15, 0];

#my object $sorter = RPerl::Algorithm::Sort::Bubble->new();
#my object $sorter = RPerl::Algorithm::Sort::Quick->new();
my object $sorter = RPerl::Algorithm::Sort::Merge->new();

print "in multi_sort.pl, have \$sorter =\n" . RPerl::DUMPER($sorter) . "\n" if $RPerl::DEBUG;
$sorter->{data} = $data;

print "in multi_sort.pl, have unsorted \$sorter->{data} =\n" . RPerl::DUMPER($sorter->{data}) . "\n" if $RPerl::DEBUG;
$sorter->sort_method();
print "in multi_sort.pl, have sorted \$sorter->{data} =\n" . RPerl::DUMPER($sorter->{data}) . "\n" if $RPerl::DEBUG;

#my object $sorter2 = RPerl::Algorithm::Sort::Bubble->new();
#my object $sorter2 = RPerl::Algorithm::Sort::Quick->new();
my object $sorter2 = RPerl::Algorithm::Sort::Merge->new();

$sorter2->{data} = [5, 4, 3, 2, 1, 0];
$sorter2->sort_method();

my scalar_array_ref $data2 = [12, 11, 10, 9, 8, 7, 6];
print "in multi_sort.pl, have \$data2 =\n" . RPerl::DUMPER($data2) . "\n" if $RPerl::DEBUG;
#my $data2_sorted = RPerl::Algorithm::Sort::Bubble::bubblesort($data2);
#my $data2_sorted = RPerl::Algorithm::Sort::Quick::quicksort($data2);
#my $data2_sorted = RPerl::Algorithm::Sort::Merge::mergesort($data2);
my $data2_sorted = RPerl::Algorithm::Sort::Merge::mergesort_bottom_up($data2);
print "in multi_sort.pl, have \$data2_sorted =\n" . RPerl::DUMPER($data2_sorted) . "\n" if $RPerl::DEBUG;
print "in multi_sort.pl, have sorted \$sorter2->{data} =\n" . RPerl::DUMPER($sorter2->{data}) . "\n" if $RPerl::DEBUG;
print "in multi_sort.pl, have sorted \$sorter->{data} =\n" . RPerl::DUMPER($sorter->{data}) . "\n" if $RPerl::DEBUG;
