#!/usr/bin/perl
use strict;  use warnings;
use lib '/tmp/RPerl-latest/lib';  # RPerl system files  # NEED REMOVE hard-coded path
use RPerl;  our @ISA = ('RPerl');

use lib '/tmp/RPerl-latest/lib/CPAN';  # RPerl's MyConfig.pm  # NEED REMOVE hard-coded path
use MyConfig;

# supported algorithms
use RPerl::Algorithm::Sort::Bubble;  # choose ONE of this
#use RPerl::Algorithm::Sort::Bubble_cpp;  RPerl::Algorithm::Sort::Bubble_cpp::cpp_load();  RPerl::Algorithm::Sort::Bubble_cpp::cpp_link(); # OR this

# NEED FIX: these Perl packages use RPerl::Algorithm::Sort, which creates a conflict when Bubble_cpp has already loaded Sort.cpp
#use RPerl::Algorithm::Sort::Quick;
#use RPerl::Algorithm::Sort::Merge;

# <<<=== SORT 1 ===>>>
# <<<=== SORT 1 ===>>>
# <<<=== SORT 1 ===>>>

my string $algorithm;
my string $variant = undef;
my object $sorter;
my number__array_ref $data;

# NEED CHOOSE: which general algorithm?
$algorithm = 'RPerl::Algorithm::Sort::Bubble';  # Bubble_cpp's class name is Bubble, so use this one
#$algorithm = 'RPerl::Algorithm::Sort::Quick';
#$algorithm = 'RPerl::Algorithm::Sort::Merge';

# NEED CHOOSE: which specific variant algorithm?
#$variant = 'original';	# QUICKSORT
#$variant = 'inplace';	# QUICKSORT
#$variant = 'topdown';	# MERGESORT
#$variant = 'bottomup';	# MERGESORT

for (my $i = 0; $i < 1;  $i++)
{
	$sorter = $algorithm->new();
	$sorter->set_variant($variant) if (defined($variant));
	print "in multi_sort.pl, have \$i = $i and pre-data \$sorter =\n" . RPerl::DUMPER($sorter) . "\n" if $RPerl::DEBUG;
	
	print "[[[ BEGIN INHERITANCE TESTING ]]]\n"x3;
	$sorter->inherited__Algorithm("Frozen");  # RPerl yes, C++ yes
	$sorter->inherited__Inefficient("Frozen");  # RPerl yes, C++ yes
	$sorter->inherited__Sort("Frozen");  # RPerl yes, C++ yes
	$sorter->inherited__Bubble("Frozen");  # RPerl yes, C++ yes
	print "\n";
#	RPerl::Algorithm::Sort::inherited($sorter, "Jean Gray");  # RPerl yes, C++ no
#	RPerl::Algorithm::Sort->inherited("Scott Summers");  # RPerl yes, C++ no
	$sorter->inherited("Logan");  # RPerl yes, C++ yes
#	inherited("MANORBEAST?", "Dr. Hank McCoy");  # RPerl no, C++ no; inherited method should only work as method!
	print "\n";
	uninherited__Algorithm("Claws");  # RPerl yes, C++ yes
	uninherited__Inefficient("Claws");  # RPerl yes, C++ yes
	uninherited__Sort("Claws");  # RPerl yes, C++ yes
	uninherited__Bubble("Claws");  # RPerl yes, C++ yes
	print "\n";
	uninherited("Wolverine");  # RPerl yes, C++ yes
#	RPerl::Algorithm::Sort::uninherited("Phoenix");  # RPerl yes, C++ no; bypass RPerl POST-INIT symbol table entries that put non-method uninherited() in main::, use AUTOLOAD
	main::uninherited("Wolvie");  # RPerl yes, C++ yes
	::uninherited("wlverine");  # RPerl yes, C++ yes
	print "[[[ END INHERITANCE TESTING ]]]\n"x3;
	
	# NEED CHOOSE: which data structure?
#	$data = [21, 12, 31, 13, 42, 2012, 5555, 1.21, 33.3, 9999, -15, 0];
#	$data = scalar_linkedlist_ref->new_from_array_ref([21, 12, 31, 13, 42, 2012, 5555, 1.21, 33.3, 9999, -15, 0]);
	$data = [reverse(0 ... 5)];
	$sorter->set_data($data);

	print "in multi_sort.pl, have \$i = $i and unsorted \$data =\n" . RPerl::DUMPER($data) . "\n" if $RPerl::DEBUG;
	print "in multi_sort.pl, have \$i = $i and \$sorter =\n" . RPerl::DUMPER($sorter) . "\n" if $RPerl::DEBUG;
#	print "in multi_sort.pl, have \$i = $i and unsorted \$sorter->get_data() =\n" . RPerl::DUMPER($sorter->get_data()) . "\n" if $RPerl::DEBUG;

	my $start_time = time();
#	$sorter->sort();  # OO interface
	bubblesort($data);  # procedural interface
	my $end_time = time();
	my $run_time = $end_time - $start_time;

	print "in multi_sort.pl, have \$i = $i and sorted \$data =\n" . RPerl::DUMPER($data) . "\n" if $RPerl::DEBUG;
#	print "in multi_sort.pl, have \$i = $i and sorted \$sorter->get_data() =\n" . RPerl::DUMPER($sorter->get_data()) . "\n" if $RPerl::DEBUG;
	print "in multi_sort.pl, have \$i = $i and \$run_time = $run_time\n";
}
exit;



# <<<=== SORT 2 ===>>>
# <<<=== SORT 2 ===>>>
# <<<=== SORT 2 ===>>>

# NEED CHOOSE: which general algorithm?
my object $sorter2 = RPerl::Algorithm::Sort::Bubble->new();
#my object $sorter2 = RPerl::Algorithm::Sort::Quick->new();
#my object $sorter2 = RPerl::Algorithm::Sort::Merge->new();

# NEED CHOOSE: which specific variant algorithm?
#$sorter2->{variant} = 'original';	# QUICKSORT
#$sorter2->{variant} = 'inplace';	# QUICKSORT
#$sorter2->{variant} = 'topdown';	# MERGESORT
#$sorter2->{variant} = 'bottomup';	# MERGESORT

# NEED CHOOSE: which data structure?
$sorter2->{data} = [5, 4, 3, 2, 1, 0];
#$sorter2->{data} = scalar_linkedlist_ref->new_from_array_ref([5, 4, 3, 2, 1, 0]);

print "in multi_sort.pl, have unsorted \$sorter2->{data} =\n" . RPerl::DUMPER($sorter2->{data}) . "\n" if $RPerl::DEBUG;
$sorter2->sort_method();
print "in multi_sort.pl, have sorted \$sorter2->{data} =\n" . RPerl::DUMPER($sorter2->{data}) . "\n" if $RPerl::DEBUG;

# <<<=== SORT 3 ===>>>
# <<<=== SORT 3 ===>>>
# <<<=== SORT 3 ===>>>

# NEED CHOOSE: which data structure?
my number__array_ref $data2 = [12, 11, 10, 9, 8, 7, 6];
#my scalar_linkedlist_ref $data2 = scalar_linkedlist_ref->new_from_array_ref([12, 11, 10, 9, 8, 7, 6]);
print "in multi_sort.pl, have unsorted \$data2 =\n" . RPerl::DUMPER($data2) . "\n" if $RPerl::DEBUG;

# NEED CHOOSE: which specific variant algorithm?
my $data2_sorted = RPerl::Algorithm::Sort::Bubble::bubblesort($data2);
#my $data2_sorted = RPerl::Algorithm::Sort::Quick::quicksort($data2);
#my $data2_sorted = RPerl::Algorithm::Sort::Quick::quicksort_inplace($data2);
#my $data2_sorted = RPerl::Algorithm::Sort::Merge::mergesort_array_topdown($data2);
#my $data2_sorted = RPerl::Algorithm::Sort::Merge::mergesort_array_bottomup($data2);
#my $data2_sorted = RPerl::Algorithm::Sort::Merge::mergesort_linkedlist_topdown($data2->{head});

print "in multi_sort.pl, have sorted \$data2_sorted =\n" . RPerl::DUMPER($data2_sorted) . "\n" if $RPerl::DEBUG;

# re-print SORT 1 data to make sure nothing weird with RPerl has caused it to change during SORT 2 and SORT 3
print "in multi_sort.pl, STILL have sorted \$sorter->{data} =\n" . RPerl::DUMPER($sorter->{data}) . "\n" if $RPerl::DEBUG;
