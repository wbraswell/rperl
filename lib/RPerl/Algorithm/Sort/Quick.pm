package RPerl::Algorithm::Sort::Quick;
use strict;  use warnings;

our @ISA = ('RPerl::Algorithm::Sort');
use RPerl::Algorithm::Sort;

our %properties =
(
	data => my scalar_array_ref $KEY_data,
);

# call out to sort data, return nothing
our void $sort_method = sub {(my object $self) = @_;
;
	# TODO: handle multiple algorithm choices
##	$self->{data} = quicksort($self->{data});  # original algorithm
	$self->{data} = quicksort_in_place($self->{data});  # in-place algorithm
};

# original algorithm: comparison-based and stable [O(n log n) average total time, O(n) worst-case total extra space]
# sort data, return sorted data
our scalar_array_ref $quicksort = sub {(my scalar_array_ref $data) = @_;
;
	my const_int $data_length = scalar(@{$data});
	
#	print "in quicksort(), have \$data = \n" . RPerl::DUMPER($data) . "\n" if $RPerl::DEBUG;
#	print "in quicksort(), have \$data_length = $data_length\n" if $RPerl::DEBUG;

	# singleton or empty sublists are sorted
	return $data if ($data_length <= 1);
	
	my int $i;
	my scalar $element;
	
	# sublists [O(n) total extra space]
	my @less_scalar_array = ();
	my @greater_scalar_array = ();
	
	# TODO: handle multiple pivot choices
	my const_int $i_pivot = $data_length - 1;  # pivot is last element in partition; okay for small, not-already-sorted arrays; required to be stable???
##	my const_int $i_pivot = int($data_length / 2);  # pivot is middle element in partition; okay for large, already-sorted, or repetitive arrays
#	print "in quicksort(), have \$i_pivot = $i_pivot\n" if $RPerl::DEBUG;

	my const_scalar $pivot = $data->[$i_pivot];
#	print "in quicksort(), have \$pivot = $pivot\n" if $RPerl::DEBUG;

	# iteratively partition elements of length-n list into sublists less-or-greater than pivot [O(n) time, O(n) total extra space for sublists]
	for ($i = 0; $i < $data_length; $i++)
	{
		next if ($i == $i_pivot);  # do not compare pivot to itself, do not store in @less or @greater
		$element = $data->[$i];
#		print "in quicksort(), have \$element = $element\n" if $RPerl::DEBUG;

		# compare element to pivot, this is the core sort comparison
		if ($element <= $pivot) { push(@less_scalar_array, $element); }
		else { push(@greater_scalar_array, $element); }
	}
#	print "in quicksort(), have \@less_scalar_array = \n" . RPerl::DUMPER(\@less_scalar_array) . "\n" if $RPerl::DEBUG;
#	print "in quicksort(), have \@greater_scalar_array = \n" . RPerl::DUMPER(\@greater_scalar_array) . "\n" if $RPerl::DEBUG;
	
	# recursively call this function on the sublists [O(log n) time], then concatenate the sorted sublists and pivot element
	$data = [@{quicksort(\@less_scalar_array)}, $pivot, @{quicksort(\@greater_scalar_array)}];
	
	# data is now sorted [O(n log n) total time, O(n) total extra space] 
	# via iteration during partitioning [O(n) time, O(n) extra space] and top-level recursion [O(log n) time, O(1) extra space?]
	return $data;
};

# in-place algorithm: comparison-based and not stable [O(n log n) average total time, O(log n) worst-case total extra space]
# call out to sort data, return sorted data
our scalar_array_ref $quicksort_in_place = sub {(my scalar_array_ref $data) = @_;
;
	return quicksort_in_place_left_right($data, 0, (scalar @{$data}) - 1);
};

# in-place algorithm; sort data, return sorted data [O(n log n) total time, O(log n) total extra space] 
our scalar_array_ref $quicksort_in_place_left_right = sub { (my scalar_array_ref $data, my const_int $i_left, my const_int $i_right) = @_;
;
#	print "in quicksort_in_place_left_right(), have \$data = \n" . RPerl::DUMPER($data) . "\n" if $RPerl::DEBUG;
	
	my int $i_pivot;
	
	if ($i_left < $i_right)
	{
		$i_pivot = int($i_left + (($i_right - $i_left) / 2));  # pivot is middle element in partition; okay for large, already-sorted, or repetitive arrays
		$i_pivot = partition_in_place($data, $i_left, $i_right, $i_pivot);  # partition data [O(n) time]
		
		# recursively call this function on the list with sublist indices [O(log n) time, O(log n) total extra space for call stack]
		quicksort_in_place_left_right($data, $i_left, $i_pivot - 1);  # ignore recursion return values because data is sorted in-place
		quicksort_in_place_left_right($data, $i_pivot + 1, $i_right);
	}
	# else, singleton or empty sublists are sorted
	
	# data is now sorted [O(n log n) total time, O(log n) total extra space] 
	# via iteration during partitioning [O(n) time, O(1) extra space] and top-level recursion [O(log n) time, O(log n) extra space]
	return $data;
};

# in-place algorithm; partition data, return store index [O(n) time, O(1) extra space]
our int $partition_in_place = sub {(my scalar_array_ref $data, my const_int $i_left, my const_int $i_right, my const_int $i_pivot) = @_;
;
	my scalar $swap;
	my int $i_store;
	my int $i;
	
	my const_scalar $pivot = $data->[$i_pivot];	
#	print "in partition_in_place(), have \$pivot = $pivot\n" if $RPerl::DEBUG;
	
	# temporarily move pivot to the end of sublist to keep it out of the way
	$data->[$i_pivot] = $data->[$i_right];
	$data->[$i_right] = $pivot;
	
	$i_store = $i_left;
	
	# iteratively partition in-place elements of lengths-add-to-n sublists into order of less-or-greater than pivot [O(n) time, O(1) extra space]
	for ($i = $i_left; $i < $i_right; $i++)
	{
		# compare element to pivot, this is the core sort comparison
		if ($data->[$i] < $pivot)
		{
			$swap = $data->[$i];
			$data->[$i] = $data->[$i_store];
			$data->[$i_store] = $swap;
			$i_store++;
		}
	}

	# move pivot back to where it needs to be
	$swap = $data->[$i_store];
	$data->[$i_store] = $data->[$i_right];
	$data->[$i_right] = $swap;
	
	return $i_store;
};