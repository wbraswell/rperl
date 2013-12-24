#!/usr/bin/perl
## no critic qw(ProhibitMagicNumbers ProhibitUnreachableCode)  ## RPERL allow numeric test values, allow unreachable test code
use strict;
use warnings;
use version; our $VERSION = 0.003_012;
use Carp;

# [[[ SETUP ]]]

# RPERL DRIVER BOILERPLATE
BEGIN { package main;  our $RPERL_INCLUDE_PATH = 'lib'; }  # NEED REMOVE hard-coded path
BEGIN { use RPerl; use parent ('RPerl'); $RPerl::INCLUDE_PATH = $main::RPERL_INCLUDE_PATH; }    # RPerl system files
BEGIN { use Data::Dumper;  our $AUTOLOAD;  sub AUTOLOAD { croak("AUTOLOAD purposefully disabled for debugging, have \$AUTOLOAD = '$AUTOLOAD' and \@_ = \n" . Dumper(\@_) . ', croaking'); } }  ## no critic qw(ProhibitAutoloading RequireArgUnpacking)  ## RPERL SYSTEM allow autoload  ## RPERL SYSTEM allow read-only @_

# for benchmarking
use Time::HiRes qw(time);

# UNCOMMENT TO ENABLE PERL TYPES FOR C++ OPS
rperltypes::types_enable('PERL');

# UNCOMMENT TO ENABLE C++ TYPES FOR C++ OPS
#rperltypes::types_enable('CPP');

# TOGGLE COMMENT TO ENABLE C++ OPS
#use RPerl::Algorithm::Sort::Bubble;  # choose ONE of this
use RPerl::Algorithm::Sort::Bubble_cpp;  RPerl::Algorithm::Sort::Bubble_cpp::cpp_load();  RPerl::Algorithm::Sort::Bubble_cpp::cpp_link(); # OR this

# NEED FIX: these Perl packages use RPerl::Algorithm::Sort, which creates a conflict when Bubble_cpp has already loaded Sort.cpp
#use RPerl::Algorithm::Sort::Quick;
#use RPerl::Algorithm::Sort::Merge;

print STDERR q{in precompiled_sort_test.pl, have integer__ops() = '} . integer__ops() . "'\n" or croak();
print STDERR q{in precompiled_sort_test.pl, have integer__types() = '} . integer__types() . "'\n" or croak();
print STDERR q{in precompiled_sort_test.pl, have number__ops() = '} . number__ops() . "'\n" or croak();
print STDERR q{in precompiled_sort_test.pl, have number__types() = '} . number__types() . "'\n" or croak();
print STDERR q{in precompiled_sort_test.pl, have string__ops() = '} . string__ops() . "'\n" or croak();
print STDERR q{in precompiled_sort_test.pl, have string__types() = '} . string__types() . "'\n" or croak();
print STDERR q{in precompiled_sort_test.pl, have array__ops() = '} . array__ops() . "'\n" or croak();
print STDERR q{in precompiled_sort_test.pl, have array__types() = '} . array__types() . "'\n" or croak();
print STDERR q{in precompiled_sort_test.pl, have hash__ops() = '} . hash__ops() . "'\n" or croak();
print STDERR q{in precompiled_sort_test.pl, have hash__types() = '} . hash__types() . "'\n" or croak();
print STDERR q{in precompiled_sort_test.pl, have bubblesort__ops() = '} . bubblesort__ops() . "'\n" or croak();
print STDERR q{in precompiled_sort_test.pl, have bubblesort__types() = '} . bubblesort__types() . "'\n" or croak();

# <<<=== SORT 1 ===>>>
# <<<=== SORT 1 ===>>>
# <<<=== SORT 1 ===>>>

my string $algorithm;
my const_integer $integer__data_size = 8;
my string $variant = undef;
my object $sorter;
my integer__array_ref $integer__data;
my number__array_ref $number__data;
my string $string_retval;

# NEED CHOOSE: which general algorithm?
$algorithm = 'RPerl::Algorithm::Sort::Bubble';  # Bubble_cpp's class name is Bubble, so use this one
#$algorithm = 'RPerl::Algorithm::Sort::Quick';
#$algorithm = 'RPerl::Algorithm::Sort::Merge';

# NEED CHOOSE: which specific variant algorithm?
#$variant = 'original';	# QUICKSORT
#$variant = 'inplace';	# QUICKSORT
#$variant = 'topdown';	# MERGESORT
#$variant = 'bottomup';	# MERGESORT

# loop to test for memory leaks
my const_integer $i_MAX = 0;
for my integer $i ( 0 .. $i_MAX ) {
	print STDERR "in precompiled_sort_test.pl, top of for() loop $i/$i_MAX\n" or croak();

=disable_sort
	$sorter = $algorithm->new();
	if (defined $variant) { $sorter->set_variant($variant); }
	print STDERR "in precompiled_sort_test.pl, have \$i = $i and pre-data \$sorter =\n" . Dumper($sorter) . "\n" or croak();

	# PRIMARY SORT TESTS
	$integer__data = [reverse 0 .. 7];  # TIVALSOBU20
#	$integer__data = [reverse 0 .. ($integer__data_size - 1)];
#	$number__data = [21, 12, 31, 13, 42, 2012, 5555, 1.21, 33.3, 9999, -15, 0];
#	$integer__data = scalar_linkedlist_ref->new_from_array_ref([21, 12, 31, 13, 42, 2012, 5555, 1.21, 33.3, 9999, -15, 0]);

	$sorter->set_integer__data($integer__data);

	print STDERR "in precompiled_sort_test.pl, have \$i = $i and unsorted \$integer__data =\n" . Dumper($integer__data) . "\n" or croak();
	print STDERR "in precompiled_sort_test.pl, have \$i = $i and \$sorter =\n" . Dumper($sorter) . "\n" or croak();
#	print STDERR "in precompiled_sort_test.pl, have \$i = $i and unsorted \$sorter->get_integer__data() =\n" . Dumper($sorter->get_integer__data()) . "\n" or croak();

	my $start_time = time;
	$sorter->integer__sort();  # OO interface; CPPOPS_CPPTYPS packing/unpacking not here, in accessor/mutator calls instead
#	DEV NOTE: for procedural interface CPPOPS_CPPTYPES, must set $integer__data to retval because C++ packing/unpacking does not change contents of original $integer__data SV*, so not exactly "in-place";
#   DEV NOTE: for procedural interface CPPOPS_PERLTYPES, must set any variable to retval to avoid weird Perl stack issues
#	bubblesort($integer__data);  # procedural interface, PERLOPS_PERLTYPES only
#	$integer__data = bubblesort($integer__data);  # procedural interface, ANYOPS_ANYTYPES works; CPPOPS_CPPTYPES packing/unpacking here
	my $end_time = time;
	my $run_time = $end_time - $start_time;

#	print STDERR "in precompiled_sort_test.pl, have \$i = $i and sorted \$integer__data =\n" . Dumper($integer__data) . "\n" or croak();
	print STDERR "in precompiled_sort_test.pl, have \$i = $i and sorted \$sorter->get_integer__data() =\n" . Dumper($sorter->get_integer__data()) . "\n" or croak();
	print STDERR "in precompiled_sort_test.pl, have \$i = $i and \$run_time = $run_time\n" or croak();
=cut

	# ADDITIONAL NON-SORT TESTS
	$integer__data = [reverse 0 .. 7];
	$string_retval = integer__bubblesort__typetest0($integer__data);  # TIVALSOBU30
#	$string_retval = integer__bubblesort__typetest0([reverse 0 .. 7]);  # TIVALSOBU30
	print STDERR "in precompiled_sort_test.pl, received return value from integer__bubblesort__typetest0([reverse 0 .. 7]) =\n" . $string_retval . "\n" or croak();
#	print STDERR "in precompiled_sort_test.pl, received return value from integer__bubblesort__typetest0([reverse 0 .. 7]) =\n" . integer__bubblesort__typetest0([reverse 0 .. 7]) . "\n" or croak();
}

croak('Done for now, croaking');








=disable
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

print STDERR "in precompiled_sort_test.pl, have unsorted \$sorter2->{data} =\n" . Dumper($sorter2->{data}) . "\n" or croak();
$sorter2->sort_method();
print STDERR "in precompiled_sort_test.pl, have sorted \$sorter2->{data} =\n" . Dumper($sorter2->{data}) . "\n" or croak();

# <<<=== SORT 3 ===>>>
# <<<=== SORT 3 ===>>>
# <<<=== SORT 3 ===>>>

# NEED CHOOSE: which data structure?
my number__array_ref $integer__data2 = [12, 11, 10, 9, 8, 7, 6];
#my scalar_linkedlist_ref $integer__data2 = scalar_linkedlist_ref->new_from_array_ref([12, 11, 10, 9, 8, 7, 6]);
print STDERR "in precompiled_sort_test.pl, have unsorted \$integer__data2 =\n" . Dumper($integer__data2) . "\n" or croak();

# NEED CHOOSE: which specific variant algorithm?
my $integer__data2_sorted = RPerl::Algorithm::Sort::Bubble::bubblesort($integer__data2);
#my $integer__data2_sorted = RPerl::Algorithm::Sort::Quick::quicksort($integer__data2);
#my $integer__data2_sorted = RPerl::Algorithm::Sort::Quick::quicksort_inplace($integer__data2);
#my $integer__data2_sorted = RPerl::Algorithm::Sort::Merge::mergesort_array_topdown($integer__data2);
#my $integer__data2_sorted = RPerl::Algorithm::Sort::Merge::mergesort_array_bottomup($integer__data2);
#my $integer__data2_sorted = RPerl::Algorithm::Sort::Merge::mergesort_linkedlist_topdown($integer__data2->{head});

print STDERR "in precompiled_sort_test.pl, have sorted \$integer__data2_sorted =\n" . Dumper($integer__data2_sorted) . "\n" or croak();

# re-print STDERR SORT 1 data to make sure nothing weird with RPerl has caused it to change during SORT 2 and SORT 3
print STDERR "in precompiled_sort_test.pl, STILL have sorted \$sorter->{data} =\n" . Dumper($sorter->{data}) . "\n" or croak();
=cut