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
#	$self->{data} = quicksort($self->{data});  # original algorithm
	$self->{data} = quicksort_in_place($self->{data});  # in-place algorithm
};

# original algorithm: O(n log n) average time, O(n) worst-case extra space 
# sort data, return sorted data
our scalar_array_ref $quicksort = sub {(my scalar_array_ref $data) = @_;
;
	my const_int $data_length = scalar(@{$data});
	
	print "in quicksort(), have \$data = \n" . RPerl::DUMPER($data) . "\n" if $RPerl::DEBUG;
	print "in quicksort(), have \$data_length = $data_length\n" if $RPerl::DEBUG;
	return $data if ($data_length <= 1);
	
	my int $i;
	my scalar $element;
	my @less_scalar_array = ();
	my @greater_scalar_array = ();
	
#	my const_int $i_pivot = $data_length - 1;  # pivot is last element in partition; okay for small, not-already-sorted arrays
	my const_int $i_pivot = int($data_length / 2);  # pivot is middle element in partition; okay for large, already-sorted, or repetitive arrays
	print "in quicksort(), have \$i_pivot = $i_pivot\n" if $RPerl::DEBUG;

	my const_scalar $pivot = $data->[$i_pivot];
	print "in quicksort(), have \$pivot = $pivot\n" if $RPerl::DEBUG;

	for ($i = 0; $i < $data_length; $i++)
	{
		next if ($i == $i_pivot);  # do not compare pivot to itself, do not store in @less or @greater
		$element = $data->[$i];
		print "in quicksort(), have \$element = $element\n" if $RPerl::DEBUG;
		if ($element <= $pivot)
			{ push(@less_scalar_array, $element); }
		else
			{ push(@greater_scalar_array, $element); }
	}
	print "in quicksort(), have \@less_scalar_array = \n" . RPerl::DUMPER(\@less_scalar_array) . "\n" if $RPerl::DEBUG;
	print "in quicksort(), have \@greater_scalar_array = \n" . RPerl::DUMPER(\@greater_scalar_array) . "\n" if $RPerl::DEBUG;
	
	$data = [@{quicksort(\@less_scalar_array)}, $pivot, @{quicksort(\@greater_scalar_array)}];
	return $data;
};

# in-place algorithm: O(n log n) average time, O(log n) worst-case extra space
# call out to sort data, return sorted data
our scalar_array_ref $quicksort_in_place = sub {(my scalar_array_ref $data) = @_;
;
	return quicksort_in_place_left_right($data, 0, (scalar @{$data}) - 1);
};

# in-place algorithm; sort data, return sorted data
our scalar_array_ref $quicksort_in_place_left_right = sub { (my scalar_array_ref $data, my const_int $i_left, my const_int $i_right) = @_;
;
	print "in quicksort_in_place_left_right(), have \$data = \n" . RPerl::DUMPER($data) . "\n" if $RPerl::DEBUG;
	
	my int $i_pivot;
	
	if ($i_left < $i_right)
	{
		$i_pivot = int($i_left + (($i_right - $i_left) / 2));  # pivot is middle element in partition; okay for large, already-sorted, or repetitive arrays
		$i_pivot = partition($data, $i_left, $i_right, $i_pivot);
		quicksort_in_place_left_right($data, $i_left, $i_pivot - 1);  # ignore return values on recursive calls
		quicksort_in_place_left_right($data, $i_pivot + 1, $i_right);
	}
	
	return $data;
};

# in-place algorithm; partition data, return store index
our int $partition = sub {(my scalar_array_ref $data, my const_int $i_left, my const_int $i_right, my const_int $i_pivot) = @_;
;
	my scalar $swap;
	my int $i_store;
	my int $i;
	
	my const_scalar $pivot = $data->[$i_pivot];	
	print "in partition(), have \$pivot = $pivot\n" if $RPerl::DEBUG;
	
	# temporarily move pivot to the end of sublist to keep it out of the way
	$data->[$i_pivot] = $data->[$i_right];
	$data->[$i_right] = $pivot;
	
	$i_store = $i_left;
	
	for ($i = $i_left; $i < $i_right; $i++)
	{
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