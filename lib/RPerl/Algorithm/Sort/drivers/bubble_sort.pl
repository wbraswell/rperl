#!/usr/bin/perl
use strict;  use warnings;
use Data::Dumper;

use RPerl::Algorithm::Sort::Bubble;

my $data_scalar_array_ref = [21, 12, 31, 13, 42, 2012, 5555, 1.21, 33.3, 9999, -15, 0];

my $bubble_sort_obj = RPerl::Algorithm::Sort::Bubble->new();
print "in bubble_sort.pl, have \$bubble_sort_obj =\n" . Dumper($bubble_sort_obj) . "\n";
$bubble_sort_obj->{data_scalar_array_ref} = $data_scalar_array_ref;

print "in bubble_sort.pl, have unsorted \$bubble_sort_obj->{data_scalar_array_ref} =\n" . Dumper($bubble_sort_obj->{data_scalar_array_ref}) . "\n";
$bubble_sort_obj->sort_void();
print "in bubble_sort.pl, have sorted \$bubble_sort_obj->{data_scalar_array_ref} =\n" . Dumper($bubble_sort_obj->{data_scalar_array_ref}) . "\n";

my $bubble_sort2_obj = RPerl::Algorithm::Sort::Bubble->new();
$bubble_sort2_obj->{data_scalar_array_ref} = [5, 4, 3, 2, 1, 0];
$bubble_sort2_obj->sort_void();
print "in bubble_sort.pl, have sorted \$bubble_sort_obj->{data_scalar_array_ref} =\n" . Dumper($bubble_sort_obj->{data_scalar_array_ref}) . "\n";
print "in bubble_sort.pl, have sorted \$bubble_sort2_obj->{data_scalar_array_ref} =\n" . Dumper($bubble_sort2_obj->{data_scalar_array_ref}) . "\n";
