#!/usr/bin/perl  ## no critic qw(ProhibitUselessNoCritic PodSpelling) # DEVELOPER DEFAULT 1a: allow unreachable & POD-commented code, must be on line 1
# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.003_030;

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

print q{in precompiled_test__sort.pl, have RPerl__DataType__Integer__MODE_ID() = '}
    . RPerl__DataType__Integer__MODE_ID() . "'\n";
print q{in precompiled_test__sort.pl, have RPerl__DataType__Number__MODE_ID() = '}
    . RPerl__DataType__Number__MODE_ID() . "'\n";
print q{in precompiled_test__sort.pl, have RPerl__DataType__String__MODE_ID() = '}
    . RPerl__DataType__String__MODE_ID() . "'\n";
print q{in precompiled_test__sort.pl, have array__MODE_ID() = '}
    . array__MODE_ID() . "'\n";
print q{in precompiled_test__sort.pl, have hash__MODE_ID() = '}
    . hash__MODE_ID() . "'\n";

print
    q{in precompiled_test__sort.pl, have RPerl__Algorithm__Sort__Bubble__MODE_ID() = '}
    . RPerl__Algorithm__Sort__Bubble__MODE_ID() . "'\n";

# <<<=== SORT 1 ===>>>
# <<<=== SORT 1 ===>>>
# <<<=== SORT 1 ===>>>

my string $algorithm;
my integer $test__data_size = 20;  # CONSTANT
my string $variant                = undef;
my object $sorter;
my integer_arrayref $integer_data;
my number_arrayref $number_data;
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
my integer $i_MAX = 0;  # CONSTANT
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
#	$integer_data = undef;  # TIVALSOBU01; error EIVAVRV00
#	$integer_data = 2;  # TIVALSOBU02; error EIVAVRV01
#	$integer_data = 2.3;  # TIVALSOBU03; error EIVAVRV01
#	$integer_data = '2';  # TIVALSOBU04; error EIVAVRV01
#	$integer_data = {a_key => 23};  # TIVALSOBU05; error EIVAVRV01
#	$integer_data = [2, 2112, undef, 23, -877, -33, 1701];  # TIVALSOBU10; error EIVAVRV02
#	$integer_data = [2, 2112, 42, 23.3, -877, -33, 1701];  # TIVALSOBU11; error EIVAVRV03
#	$integer_data = [2, 2112, 42, '23', -877, -33, 1701];  # TIVALSOBU12; error EIVAVRV03
#	$integer_data = [2, 2112, 42, [23], -877, -33, 1701];  # TIVALSOBU13; error EIVAVRV03
#	$integer_data = [2, 2112, 42, {a_subkey => 23}, -877, -33, 1701];  # TIVALSOBU14; error EIVAVRV03
#	$integer_data = [23];  # TIVALSOBU20
#	$integer_data = [2, 2112, 42, 23, -877, -33, 1701];  # TIVALSOBU21
#	$integer_data = [reverse 0 .. 7];  # TIVALSOBU22
    $integer_data = [ reverse 0 .. ( $test__data_size - 1 ) ]; # TIVALSOBUXX; manual testing only

#	$integer_data = scalar_linkedlistref->new_from_arrayref([21, 12, 31, 13, 42, 2012, 5555, 1.21, 33.3, 9999, -15, 0]);  # NOT USED FOR BUBBLESORT
    $sorter->set_integer_data($integer_data);                 # OO INTERFACE

    print
        "in precompiled_test__sort.pl $i/$i_MAX, have unsorted \$integer_data =\n"
        . Dumper($integer_data)
        . "\n";    # PROCEDURAL INTERFACE
    print "in precompiled_test__sort.pl $i/$i_MAX, have \$sorter =\n"
        . Dumper($sorter)
        . "\n";    # OO INTERFACE
    print
        "in precompiled_test__sort.pl $i/$i_MAX, have unsorted \$sorter->get_integer_data() =\n"
        . Dumper( $sorter->get_integer_data() )
        . "\n";    # OO INTERFACE

    my $start_time = time;
    $sorter->integer_sort(); # OO INTERFACE, ANYOPS_ANYTYPES needs testing; CPPOPS_CPPTYPS packing/unpacking not here, in accessor/mutator calls instead

#	integer_bubblesort($integer_data);  # PROCEDURAL INTERFACE, PERLOPS_PERLTYPES only
#	DEV NOTE: for procedural interface CPPOPS_CPPTYPES, must set $integer_data to retval because C++ packing/unpacking does not change contents of original $integer_data SV*, so not exactly "in-place";

# PROCEDURAL INTERFACE, ANYOPS_ANYTYPES works; CPPOPS_CPPTYPES packing/unpacking here
#	$integer_data = integer_bubblesort();  # TIVALSOBU00; error PERLOPS EIVAVRV00, CPPOPS "Usage: main::integer_bubblesort(integer_data)"
#	$integer_data = integer_bubblesort($integer_data);  # TIVALSOBUxx, xx > 00

    my $end_time = time;
    my $run_time = $end_time - $start_time;

#	print "in precompiled_test__sort.pl $i/$i_MAX, have sorted \$integer_data =\n" . Dumper($integer_data) . "\n";  # PROCEDURAL INTERFACE
    print
        "in precompiled_test__sort.pl $i/$i_MAX, have sorted \$sorter->get_integer_data() =\n"
        . Dumper( $sorter->get_integer_data() )
        . "\n";    # OO INTERFACE
    print
        "in precompiled_test__sort.pl $i/$i_MAX, have \$run_time = $run_time\n";

    #=cut

#	$string_retval = integer_bubblesort__typetest0();  # TIVALSOBU30; error PERLOPS EIVAVRV00, CPPOPS "Usage: main::integer_bubblesort__typetest0(lucky_integers)"
#	$string_retval = integer_bubblesort__typetest0(2);  # TIVALSOBU31; error EIVAVRV01
#	$string_retval = integer_bubblesort__typetest0([2, 2112, undef, 23, -877, -33, 1701]);  # TIVALSOBU32; error EIVAVRV02
#	$string_retval = integer_bubblesort__typetest0([2, 2112, 42, 23, -877, -33, 1701, [23, -42.3]]);  # TIVALSOBU33; error EIVAVRV03
#	$string_retval = integer_bubblesort__typetest0([2, 2112, 42, 23, -877, -33, 1701]);  # TIVALSOBU34
#	print "in precompiled_test__sort.pl $i/$i_MAX, have \$string_retval =\n$string_retval\n";

    # [[[ NUMBER TESTS ]]]

=disable_SORT_TESTS
#	$number_data = undef;  # TNVALSOBU01; error ENVAVRV00
#	$number_data = 2;  # TNVALSOBU02; error ENVAVRV01
#	$number_data = 2.3;  # TNVALSOBU03; error ENVAVRV01
#	$number_data = '2';  # TNVALSOBU04; error ENVAVRV01
#	$number_data = {a_key => 23};  # TNVALSOBU05; error ENVAVRV01
#	$number_data = [2, 2112, undef, 23, -877, -33, 1701];  # TNVALSOBU10; error ENVAVRV02
#	$number_data = [2, 2112, 42, '23', -877, -33, 1701];  # TNVALSOBU11; error ENVAVRV03
#	$number_data = [2, 2112, 42, [23], -877, -33, 1701];  # TNVALSOBU12; error ENVAVRV03
#	$number_data = [2, 2112, 42, {a_subkey => 23}, -877, -33, 1701];  # TNVALSOBU13; error ENVAVRV03
#	$number_data = [23];  # TNVALSOBU20
#	$number_data = [2, 2112, 42, 23, -877, -33, 1701];  # TNVALSOBU21
#	$number_data = [reverse 0 .. 7];  # TNVALSOBU22
	$number_data = [reverse 0 .. ($test__data_size - 1)];  # TNVALSOBUXX; manual testing only
#	$number_data = [23.2];  # TNVALSOBU23
#	$number_data = [2.1, 2112.2, 42.3, 23, -877, -33, 1701];  # TNVALSOBU24
#	$number_data = [2.1234432112344321, 2112.4321, 42.4567, 23.765444444444444444, -877.5678, -33.876587658765875687658765, 1701.6789];  # TNVALSOBU25
	
#	$number_data = scalar_linkedlistref->new_from_arrayref([21, 12, 31, 13, 42, 2012, 5555, 1.21, 33.3, 9999, -15, 0]);  # NOT USED FOR BUBBLESORT
#	$sorter->set_number_data($number_data);  # OO INTERFACE

	print "in precompiled_test__sort.pl $i/$i_MAX, have unsorted \$number_data =\n" . Dumper($number_data) . "\n";  # PROCEDURAL INTERFACE
#	print "in precompiled_test__sort.pl $i/$i_MAX, have \$sorter =\n" . Dumper($sorter) . "\n";  # OO INTERFACE
#	print "in precompiled_test__sort.pl $i/$i_MAX, have unsorted \$sorter->get_number_data() =\n" . Dumper($sorter->get_number_data()) . "\n";  # OO INTERFACE

	my $start_time = time;
#	$sorter->number_sort();  # OO INTERFACE, ANYOPS_ANYTYPES needs testing; CPPOPS_CPPTYPS packing/unpacking not here, in accessor/mutator calls instead
#	number_bubblesort($number_data);  # PROCEDURAL INTERFACE, PERLOPS_PERLTYPES only
#	DEV NOTE: for procedural interface CPPOPS_CPPTYPES, must set $number_data to retval because C++ packing/unpacking does not change contents of original $number_data SV*, so not exactly "in-place";

    # PROCEDURAL INTERFACE, ANYOPS_ANYTYPES works; CPPOPS_CPPTYPES packing/unpacking here
#	$number_data = number_bubblesort();  # TNVALSOBU00; error PERLOPS ENVAVRV00, CPPOPS "Usage: main::number_bubblesort(number_data)"
	$number_data = number_bubblesort($number_data);  # TNVALSOBUxx, xx > 00

	my $end_time = time;
	my $run_time = $end_time - $start_time;

	print "in precompiled_test__sort.pl $i/$i_MAX, have sorted \$number_data =\n" . Dumper($number_data) . "\n";  # PROCEDURAL INTERFACE
#	print "in precompiled_test__sort.pl $i/$i_MAX, have sorted \$sorter->get_number_data() =\n" . Dumper($sorter->get_number_data()) . "\n";  # OO INTERFACE
	print "in precompiled_test__sort.pl $i/$i_MAX, have \$run_time = $run_time\n";
=cut

#	$string_retval = number_bubblesort__typetest0();  # TNVALSOBU30; error PERLOPS ENVAVRV00, CPPOPS "Usage: main::number_bubblesort__typetest0(lucky_numbers)"
#	$string_retval = number_bubblesort__typetest0(2);  # TNVALSOBU31; error ENVAVRV01
#	$string_retval = number_bubblesort__typetest0([2.1234432112344321, 2112.4321, undef, 23.765444444444444444, -877.5678, -33.876587658765875687658765, 1701.6789]);  # TNVALSOBU32; error ENVAVRV02
#	$string_retval = number_bubblesort__typetest0([2.1234432112344321, 2112.4321, 42.4567, 23.765444444444444444, -877.5678, 'abcdefg', -33.876587658765875687658765, 1701.6789]);  # TNVALSOBU33; error ENVAVRV03
#	$string_retval = number_bubblesort__typetest0([2.1234432112344321, 2112.4321, 42.4567, 23.765444444444444444, -877.5678, -33.876587658765875687658765, 1701.6789]);  # TNVALSOBU34
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

#$sorter2->{data} = scalar_linkedlistref->new_from_arrayref([5, 4, 3, 2, 1, 0]);

print "in precompiled_test__sort.pl, have unsorted \$sorter2->{data} =\n"
    . Dumper( $sorter2->{data} ) . "\n";
$sorter2->sort_method();
print "in precompiled_test__sort.pl, have sorted \$sorter2->{data} =\n"
    . Dumper( $sorter2->{data} ) . "\n";

# <<<=== SORT 3 ===>>>
# <<<=== SORT 3 ===>>>
# <<<=== SORT 3 ===>>>

# NEED CHOOSE: which data structure?
my number_arrayref $integer_data2 = [ 12, 11, 10, 9, 8, 7, 6 ];

#my scalartype_linkedlistref $integer_data2 = scalar_linkedlistref->new_from_arrayref([12, 11, 10, 9, 8, 7, 6]);
print "in precompiled_test__sort.pl, have unsorted \$integer_data2 =\n"
    . Dumper($integer_data2) . "\n";

# NEED CHOOSE: which specific variant algorithm?
my $integer_data2_sorted
    = RPerl::Algorithm::Sort::Bubble::bubblesort($integer_data2);

#my $integer_data2_sorted = RPerl::Algorithm::Sort::Quick::quicksort($integer_data2);
#my $integer_data2_sorted = RPerl::Algorithm::Sort::Quick::quicksort_inplace($integer_data2);
#my $integer_data2_sorted = RPerl::Algorithm::Sort::Merge::mergesort_array_topdown($integer_data2);
#my $integer_data2_sorted = RPerl::Algorithm::Sort::Merge::mergesort_array_bottomup($integer_data2);
#my $integer_data2_sorted = RPerl::Algorithm::Sort::Merge::mergesort_linkedlist_topdown($integer_data2->{head});

print "in precompiled_test__sort.pl, have sorted \$integer_data2_sorted =\n"
    . Dumper($integer_data2_sorted) . "\n";

# re-print SORT 1 data to make sure nothing weird with RPerl has caused it to change during SORT 2 and SORT 3
print "in precompiled_test__sort.pl, STILL have sorted \$sorter->{data} =\n"
    . Dumper( $sorter->{data} ) . "\n";
