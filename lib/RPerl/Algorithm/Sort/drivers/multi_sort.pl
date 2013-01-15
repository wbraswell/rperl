#!/usr/bin/perl
use strict;  use warnings;  use RPerl;  our @ISA = ('RPerl');

# supported algorithms
use RPerl::Algorithm::Sort::Bubble;
use RPerl::Algorithm::Sort::Quick;
use RPerl::Algorithm::Sort::Merge;

# <<<=== SORT 1 ===>>>
# <<<=== SORT 1 ===>>>
# <<<=== SORT 1 ===>>>

# NEED CHOOSE: which general algorithm?
#my object $sorter = RPerl::Algorithm::Sort::Bubble->new();
#my object $sorter = RPerl::Algorithm::Sort::Quick->new();
my object $sorter = RPerl::Algorithm::Sort::Merge->new();

# NEED CHOOSE: which specific variant algorithm?
$sorter->{variant} = 'topdown';
#$sorter->{variant} = 'bottomup';

# NEED CHOOSE: which data structure?
#$sorter->{data} = [21, 12, 31, 13, 42, 2012, 5555, 1.21, 33.3, 9999, -15, 0];
$sorter->{data} = scalar_linkedlist_ref->new_from_array_ref([21, 12, 31, 13, 42, 2012, 5555, 1.21, 33.3, 9999, -15, 0]);

#print "in multi_sort.pl, have \$sorter =\n" . RPerl::DUMPER($sorter) . "\n" if $RPerl::DEBUG;

print "in multi_sort.pl, have unsorted \$sorter->{data} =\n" . RPerl::DUMPER($sorter->{data}) . "\n" if $RPerl::DEBUG;
$sorter->sort_method();
print "in multi_sort.pl, have sorted \$sorter->{data} =\n" . RPerl::DUMPER($sorter->{data}) . "\n" if $RPerl::DEBUG;

# <<<=== SORT 2 ===>>>
# <<<=== SORT 2 ===>>>
# <<<=== SORT 2 ===>>>

# NEED CHOOSE: which general algorithm?
#my object $sorter2 = RPerl::Algorithm::Sort::Bubble->new();
#my object $sorter2 = RPerl::Algorithm::Sort::Quick->new();
my object $sorter2 = RPerl::Algorithm::Sort::Merge->new();

# NEED CHOOSE: which specific variant algorithm?
$sorter2->{variant} = 'topdown';
#$sorter2->{variant} = 'bottomup';

# NEED CHOOSE: which data structure?
#$sorter2->{data} = [5, 4, 3, 2, 1, 0];
$sorter2->{data} = scalar_linkedlist_ref->new_from_array_ref([5, 4, 3, 2, 1, 0]);
$sorter2->sort_method();

# <<<=== SORT 3 ===>>>
# <<<=== SORT 3 ===>>>
# <<<=== SORT 3 ===>>>

# NEED CHOOSE: which data structure?
#my scalar_array_ref $data2 = [12, 11, 10, 9, 8, 7, 6];
my scalar_linkedlist_ref $data2 = scalar_linkedlist_ref->new_from_array_ref([12, 11, 10, 9, 8, 7, 6]);
print "in multi_sort.pl, have \$data2 =\n" . RPerl::DUMPER($data2) . "\n" if $RPerl::DEBUG;

# NEED CHOOSE: which specific variant algorithm?
#my $data2_sorted = RPerl::Algorithm::Sort::Bubble::bubblesort($data2);
#my $data2_sorted = RPerl::Algorithm::Sort::Quick::quicksort($data2);
#my $data2_sorted = RPerl::Algorithm::Sort::Merge::mergesort_array_topdown($data2);
#my $data2_sorted = RPerl::Algorithm::Sort::Merge::mergesort_array_bottomup($data2);
my $data2_sorted = RPerl::Algorithm::Sort::Merge::mergesort_linkedlist_topdown($data2->{head});

print "in multi_sort.pl, have \$data2_sorted =\n" . RPerl::DUMPER($data2_sorted) . "\n" if $RPerl::DEBUG;
print "in multi_sort.pl, have sorted \$sorter2->{data} =\n" . RPerl::DUMPER($sorter2->{data}) . "\n" if $RPerl::DEBUG;
print "in multi_sort.pl, have sorted \$sorter->{data} =\n" . RPerl::DUMPER($sorter->{data}) . "\n" if $RPerl::DEBUG;
