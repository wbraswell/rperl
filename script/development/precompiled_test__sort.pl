#!/usr/bin/perl  ## no critic qw(ProhibitUselessNoCritic PodSpelling) # DEVELOPER DEFAULT 1a: allow unreachable & POD-commented code, must be on line 1
# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.003_021;

# [[[ CRITICS, INCLUDES ]]]
## no critic qw(ProhibitUnreachableCode RequirePodSections RequirePodAtEnd) # DEVELOPER DEFAULT 1b: allow unreachable & POD-commented code, must be after line 1
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator

use Time::HiRes qw(time);    # for benchmarking

# [[[ OPERATIONS ]]]

# UNCOMMENT TO ENABLE PERL TYPES FOR C++ OPS
rperltypes::types_enable('PERL');

# UNCOMMENT TO ENABLE C++ TYPES FOR C++ OPS
#rperltypes::types_enable('CPP');

# TOGGLE COMMENT TO ENABLE C++ OPS
#use RPerl::Algorithm::Sort::Bubble;  # choose ONE of this
use RPerl::Algorithm::Sort::Bubble_cpp;
RPerl::Algorithm::Sort::Bubble_cpp::cpp_load();    # OR this

# NEED FIX: these Perl packages use RPerl::Algorithm::Sort, which creates a conflict when Bubble_cpp has already loaded Sort.cpp
#use RPerl::Algorithm::Sort::Quick;
#use RPerl::Algorithm::Sort::Merge;

print q{in precompiled_test__sort.pl, have integer__ops() = '}
    . integer__ops() . "'\n";
print q{in precompiled_test__sort.pl, have integer__types() = '}
    . integer__types() . "'\n";
print q{in precompiled_test__sort.pl, have number__ops() = '}
    . number__ops() . "'\n";
print q{in precompiled_test__sort.pl, have number__types() = '}
    . number__types() . "'\n";
print q{in precompiled_test__sort.pl, have string__ops() = '}
    . string__ops() . "'\n";
print q{in precompiled_test__sort.pl, have string__types() = '}
    . string__types() . "'\n";
print q{in precompiled_test__sort.pl, have array__ops() = '}
    . array__ops() . "'\n";
print q{in precompiled_test__sort.pl, have array__types() = '}
    . array__types() . "'\n";
print q{in precompiled_test__sort.pl, have hash__ops() = '}
    . hash__ops() . "'\n";
print q{in precompiled_test__sort.pl, have hash__types() = '}
    . hash__types() . "'\n";

print
    q{in precompiled_test__sort.pl, have RPerl__Algorithm__Sort__Bubble__ops() = '}
    . RPerl__Algorithm__Sort__Bubble__ops() . "'\n";
print
    q{in precompiled_test__sort.pl, have RPerl__Algorithm__Sort__Bubble__types() = '}
    . RPerl__Algorithm__Sort__Bubble__types() . "'\n";

# <<<=== SORT 1 ===>>>
# <<<=== SORT 1 ===>>>
# <<<=== SORT 1 ===>>>

my string $algorithm;
my const_integer $test__data_size = 20;
my string $variant                = undef;
my object $sorter;
my integer__array_ref $integer__data;
my number__array_ref $number__data;
my string $string_retval;

# NEED CHOOSE: which general algorithm?
$algorithm = 'RPerl::Algorithm::Sort::Bubble'; # Bubble_cpp's class name is Bubble, so use this one

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
    print "in precompiled_test__sort.pl, top of for() loop $i/$i_MAX\n";

    $sorter = $algorithm->new();    # OO INTERFACE

   #	if (defined $variant) { $sorter->set_variant($variant); }  # OO INTERFACE
    print
        "in precompiled_test__sort.pl $i/$i_MAX, have pre-data \$sorter =\n"
        . Dumper($sorter)
        . "\n";                     # OO INTERFACE

    # [[[ INTEGER TESTS ]]]

#=disable_SORT_TESTS
#	$integer__data = undef;  # TIVALSOBU01; error EIVAVRV00
#	$integer__data = 2;  # TIVALSOBU02; error EIVAVRV01
#	$integer__data = 2.3;  # TIVALSOBU03; error EIVAVRV01
#	$integer__data = '2';  # TIVALSOBU04; error EIVAVRV01
#	$integer__data = {a_key => 23};  # TIVALSOBU05; error EIVAVRV01
#	$integer__data = [2, 2112, undef, 23, -877, -33, 1701];  # TIVALSOBU10; error EIVAVRV02
#	$integer__data = [2, 2112, 42, 23.3, -877, -33, 1701];  # TIVALSOBU11; error EIVAVRV03
#	$integer__data = [2, 2112, 42, '23', -877, -33, 1701];  # TIVALSOBU12; error EIVAVRV03
#	$integer__data = [2, 2112, 42, [23], -877, -33, 1701];  # TIVALSOBU13; error EIVAVRV03
#	$integer__data = [2, 2112, 42, {a_subkey => 23}, -877, -33, 1701];  # TIVALSOBU14; error EIVAVRV03
#	$integer__data = [23];  # TIVALSOBU20
#	$integer__data = [2, 2112, 42, 23, -877, -33, 1701];  # TIVALSOBU21
#	$integer__data = [reverse 0 .. 7];  # TIVALSOBU22
    $integer__data = [ reverse 0 .. ( $test__data_size - 1 ) ]; # TIVALSOBUXX; manual testing only

#	$integer__data = scalar_linkedlist_ref->new_from_array_ref([21, 12, 31, 13, 42, 2012, 5555, 1.21, 33.3, 9999, -15, 0]);  # NOT USED FOR BUBBLESORT
    $sorter->set_integer__data($integer__data);                 # OO INTERFACE

    print
        "in precompiled_test__sort.pl $i/$i_MAX, have unsorted \$integer__data =\n"
        . Dumper($integer__data)
        . "\n";    # PROCEDURAL INTERFACE
    print "in precompiled_test__sort.pl $i/$i_MAX, have \$sorter =\n"
        . Dumper($sorter)
        . "\n";    # OO INTERFACE
    print
        "in precompiled_test__sort.pl $i/$i_MAX, have unsorted \$sorter->get_integer__data() =\n"
        . Dumper( $sorter->get_integer__data() )
        . "\n";    # OO INTERFACE

    my $start_time = time;
    $sorter->integer__sort(); # OO INTERFACE, ANYOPS_ANYTYPES needs testing; CPPOPS_CPPTYPS packing/unpacking not here, in accessor/mutator calls instead

#	integer__bubblesort($integer__data);  # PROCEDURAL INTERFACE, PERLOPS_PERLTYPES only
#	DEV NOTE: for procedural interface CPPOPS_CPPTYPES, must set $integer__data to retval because C++ packing/unpacking does not change contents of original $integer__data SV*, so not exactly "in-place";

# PROCEDURAL INTERFACE, ANYOPS_ANYTYPES works; CPPOPS_CPPTYPES packing/unpacking here
#	$integer__data = integer__bubblesort();  # TIVALSOBU00; error PERLOPS EIVAVRV00, CPPOPS "Usage: main::integer__bubblesort(integer__data)"
#	$integer__data = integer__bubblesort($integer__data);  # TIVALSOBUxx, xx > 00

    my $end_time = time;
    my $run_time = $end_time - $start_time;

#	print "in precompiled_test__sort.pl $i/$i_MAX, have sorted \$integer__data =\n" . Dumper($integer__data) . "\n";  # PROCEDURAL INTERFACE
    print
        "in precompiled_test__sort.pl $i/$i_MAX, have sorted \$sorter->get_integer__data() =\n"
        . Dumper( $sorter->get_integer__data() )
        . "\n";    # OO INTERFACE
    print
        "in precompiled_test__sort.pl $i/$i_MAX, have \$run_time = $run_time\n";

    #=cut

#	$string_retval = integer__bubblesort__typetest0();  # TIVALSOBU30; error PERLOPS EIVAVRV00, CPPOPS "Usage: main::integer__bubblesort__typetest0(lucky_integers)"
#	$string_retval = integer__bubblesort__typetest0(2);  # TIVALSOBU31; error EIVAVRV01
#	$string_retval = integer__bubblesort__typetest0([2, 2112, undef, 23, -877, -33, 1701]);  # TIVALSOBU32; error EIVAVRV02
#	$string_retval = integer__bubblesort__typetest0([2, 2112, 42, 23, -877, -33, 1701, [23, -42.3]]);  # TIVALSOBU33; error EIVAVRV03
#	$string_retval = integer__bubblesort__typetest0([2, 2112, 42, 23, -877, -33, 1701]);  # TIVALSOBU34
#	print "in precompiled_test__sort.pl $i/$i_MAX, have \$string_retval =\n$string_retval\n";

    # [[[ NUMBER TESTS ]]]

=disable_SORT_TESTS
#	$number__data = undef;  # TNVALSOBU01; error ENVAVRV00
#	$number__data = 2;  # TNVALSOBU02; error ENVAVRV01
#	$number__data = 2.3;  # TNVALSOBU03; error ENVAVRV01
#	$number__data = '2';  # TNVALSOBU04; error ENVAVRV01
#	$number__data = {a_key => 23};  # TNVALSOBU05; error ENVAVRV01
#	$number__data = [2, 2112, undef, 23, -877, -33, 1701];  # TNVALSOBU10; error ENVAVRV02
#	$number__data = [2, 2112, 42, '23', -877, -33, 1701];  # TNVALSOBU11; error ENVAVRV03
#	$number__data = [2, 2112, 42, [23], -877, -33, 1701];  # TNVALSOBU12; error ENVAVRV03
#	$number__data = [2, 2112, 42, {a_subkey => 23}, -877, -33, 1701];  # TNVALSOBU13; error ENVAVRV03
#	$number__data = [23];  # TNVALSOBU20
#	$number__data = [2, 2112, 42, 23, -877, -33, 1701];  # TNVALSOBU21
#	$number__data = [reverse 0 .. 7];  # TNVALSOBU22
	$number__data = [reverse 0 .. ($test__data_size - 1)];  # TNVALSOBUXX; manual testing only
#	$number__data = [23.2];  # TNVALSOBU23
#	$number__data = [2.1, 2112.2, 42.3, 23, -877, -33, 1701];  # TNVALSOBU24
#	$number__data = [2.1234432112344321, 2112.4321, 42.4567, 23.765444444444444444, -877.5678, -33.876587658765875687658765, 1701.6789];  # TNVALSOBU25
	
#	$number__data = scalar_linkedlist_ref->new_from_array_ref([21, 12, 31, 13, 42, 2012, 5555, 1.21, 33.3, 9999, -15, 0]);  # NOT USED FOR BUBBLESORT
#	$sorter->set_number__data($number__data);  # OO INTERFACE

	print "in precompiled_test__sort.pl $i/$i_MAX, have unsorted \$number__data =\n" . Dumper($number__data) . "\n";  # PROCEDURAL INTERFACE
#	print "in precompiled_test__sort.pl $i/$i_MAX, have \$sorter =\n" . Dumper($sorter) . "\n";  # OO INTERFACE
#	print "in precompiled_test__sort.pl $i/$i_MAX, have unsorted \$sorter->get_number__data() =\n" . Dumper($sorter->get_number__data()) . "\n";  # OO INTERFACE

	my $start_time = time;
#	$sorter->number__sort();  # OO INTERFACE, ANYOPS_ANYTYPES needs testing; CPPOPS_CPPTYPS packing/unpacking not here, in accessor/mutator calls instead
#	number__bubblesort($number__data);  # PROCEDURAL INTERFACE, PERLOPS_PERLTYPES only
#	DEV NOTE: for procedural interface CPPOPS_CPPTYPES, must set $number__data to retval because C++ packing/unpacking does not change contents of original $number__data SV*, so not exactly "in-place";

    # PROCEDURAL INTERFACE, ANYOPS_ANYTYPES works; CPPOPS_CPPTYPES packing/unpacking here
#	$number__data = number__bubblesort();  # TNVALSOBU00; error PERLOPS ENVAVRV00, CPPOPS "Usage: main::number__bubblesort(number__data)"
	$number__data = number__bubblesort($number__data);  # TNVALSOBUxx, xx > 00

	my $end_time = time;
	my $run_time = $end_time - $start_time;

	print "in precompiled_test__sort.pl $i/$i_MAX, have sorted \$number__data =\n" . Dumper($number__data) . "\n";  # PROCEDURAL INTERFACE
#	print "in precompiled_test__sort.pl $i/$i_MAX, have sorted \$sorter->get_number__data() =\n" . Dumper($sorter->get_number__data()) . "\n";  # OO INTERFACE
	print "in precompiled_test__sort.pl $i/$i_MAX, have \$run_time = $run_time\n";
=cut

#	$string_retval = number__bubblesort__typetest0();  # TNVALSOBU30; error PERLOPS ENVAVRV00, CPPOPS "Usage: main::number__bubblesort__typetest0(lucky_numbers)"
#	$string_retval = number__bubblesort__typetest0(2);  # TNVALSOBU31; error ENVAVRV01
#	$string_retval = number__bubblesort__typetest0([2.1234432112344321, 2112.4321, undef, 23.765444444444444444, -877.5678, -33.876587658765875687658765, 1701.6789]);  # TNVALSOBU32; error ENVAVRV02
#	$string_retval = number__bubblesort__typetest0([2.1234432112344321, 2112.4321, 42.4567, 23.765444444444444444, -877.5678, 'abcdefg', -33.876587658765875687658765, 1701.6789]);  # TNVALSOBU33; error ENVAVRV03
#	$string_retval = number__bubblesort__typetest0([2.1234432112344321, 2112.4321, 42.4567, 23.765444444444444444, -877.5678, -33.876587658765875687658765, 1701.6789]);  # TNVALSOBU34
#	print "in precompiled_test__sort.pl $i/$i_MAX, have \$string_retval =\n$string_retval\n";

    croak('Done for now, croaking');
}

croak('Done for now, croaking');

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
$sorter2->{data} = [ 5, 4, 3, 2, 1, 0 ];

#$sorter2->{data} = scalar_linkedlist_ref->new_from_array_ref([5, 4, 3, 2, 1, 0]);

print "in precompiled_test__sort.pl, have unsorted \$sorter2->{data} =\n"
    . Dumper( $sorter2->{data} ) . "\n";
$sorter2->sort_method();
print "in precompiled_test__sort.pl, have sorted \$sorter2->{data} =\n"
    . Dumper( $sorter2->{data} ) . "\n";

# <<<=== SORT 3 ===>>>
# <<<=== SORT 3 ===>>>
# <<<=== SORT 3 ===>>>

# NEED CHOOSE: which data structure?
my number__array_ref $integer__data2 = [ 12, 11, 10, 9, 8, 7, 6 ];

#my scalartype_linkedlist_ref $integer__data2 = scalar_linkedlist_ref->new_from_array_ref([12, 11, 10, 9, 8, 7, 6]);
print "in precompiled_test__sort.pl, have unsorted \$integer__data2 =\n"
    . Dumper($integer__data2) . "\n";

# NEED CHOOSE: which specific variant algorithm?
my $integer__data2_sorted
    = RPerl::Algorithm::Sort::Bubble::bubblesort($integer__data2);

#my $integer__data2_sorted = RPerl::Algorithm::Sort::Quick::quicksort($integer__data2);
#my $integer__data2_sorted = RPerl::Algorithm::Sort::Quick::quicksort_inplace($integer__data2);
#my $integer__data2_sorted = RPerl::Algorithm::Sort::Merge::mergesort_array_topdown($integer__data2);
#my $integer__data2_sorted = RPerl::Algorithm::Sort::Merge::mergesort_array_bottomup($integer__data2);
#my $integer__data2_sorted = RPerl::Algorithm::Sort::Merge::mergesort_linkedlist_topdown($integer__data2->{head});

print "in precompiled_test__sort.pl, have sorted \$integer__data2_sorted =\n"
    . Dumper($integer__data2_sorted) . "\n";

# re-print SORT 1 data to make sure nothing weird with RPerl has caused it to change during SORT 2 and SORT 3
print "in precompiled_test__sort.pl, STILL have sorted \$sorter->{data} =\n"
    . Dumper( $sorter->{data} ) . "\n";
