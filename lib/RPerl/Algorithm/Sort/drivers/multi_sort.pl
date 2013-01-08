#!/usr/bin/perl
use strict;  use warnings;
use Data::Dumper;

#use RPerl::Algorithm::Sort::Bubble;
use RPerl::Algorithm::Sort::Quick;

my $data_scalar_array_ref = [21, 12, 31, 13, 42, 2012, 5555, 1.21, 33.3, 9999, -15, 0];

#my $sort_obj = RPerl::Algorithm::Sort::Bubble->new();
my $sort_obj = RPerl::Algorithm::Sort::Quick->new();

print "in sort.pl, have \$sort_obj =\n" . Dumper($sort_obj) . "\n";
$sort_obj->{data_scalar_array_ref} = $data_scalar_array_ref;

print "in sort.pl, have unsorted \$sort_obj->{data_scalar_array_ref} =\n" . Dumper($sort_obj->{data_scalar_array_ref}) . "\n";
$sort_obj->sort_void();
print "in sort.pl, have sorted \$sort_obj->{data_scalar_array_ref} =\n" . Dumper($sort_obj->{data_scalar_array_ref}) . "\n";

#my $sort2_obj = RPerl::Algorithm::Sort::Bubble->new();
my $sort2_obj = RPerl::Algorithm::Sort::Quick->new();

$sort2_obj->{data_scalar_array_ref} = [5, 4, 3, 2, 1, 0];
$sort2_obj->sort_void();
print "in sort.pl, have sorted \$sort2_obj->{data_scalar_array_ref} =\n" . Dumper($sort2_obj->{data_scalar_array_ref}) . "\n";
print "in sort.pl, have sorted \$sort_obj->{data_scalar_array_ref} =\n" . Dumper($sort_obj->{data_scalar_array_ref}) . "\n";

