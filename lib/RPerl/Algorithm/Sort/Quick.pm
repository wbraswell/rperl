package RPerl::Algorithm::Sort::Quick;
use strict;  use warnings;

our @ISA = ('RPerl::Algorithm::Sort');
use RPerl::Algorithm::Sort;

our hashref $properties =
{
	variant => my string $TYPED_mode = 'original',  # default to original (not in-place) variant
	data => my scalartype_arrayref $TYPED_data
};

# call out to sort data, return nothing
our void_method $sort = sub {(my object $self) = @_;
;
	if ((ref($self->{data}) eq 'ARRAY') or ($self->{data}->isa('arrayref')))
	{
		if ($self->{variant} eq 'original') { $self->{data} = quicksort($self->{data}); }
		elsif ($self->{variant} eq 'inplace') { $self->{data} = quicksort_inplace($self->{data}); }
		else { die("Unsupported variant '" . $self->{variant} . "' detected for arrayref data type (original or inplace supported), dying"); }
	}
	else { die("Unsupported data structure '" . ref($self->{data}) . "' detected (only arrayref supported), dying"); }
};

# original algorithm: comparison-based and stable [O(n log n) average total time, O(n) worst-case total extra space]
# sort data, return sorted data
our scalartype_arrayref $quicksort = sub {(my scalartype_arrayref $data) = @_;
;
	my integer $data_length = scalar(@{$data});  # CONSTANT
	
#	RPerl::diag("in quicksort(), have \$data = \n" . RPerl::DUMPER($data) . "\n");
#	RPerl::diag("in quicksort(), have \$data_length = $data_length\n");

	# singleton or empty sublists are sorted
	return $data if ($data_length <= 1);
	
	my int $i;
	my scalartype $element;
	
	# sublists [O(n) total extra space]
	my @less_scalar__array = ();
	my @greater_scalar__array = ();
	
	# TODO: handle multiple pivot choices
	my integer $i_pivot = $data_length - 1;  # pivot is last element in partition; okay for small, not-already-sorted arrays; required to be stable???  # CONSTANT
##	my int $i_pivot = int($data_length / 2);  # pivot is middle element in partition; okay for large, already-sorted, or repetitive arrays  # CONSTANT
#	RPerl::diag("in quicksort(), have \$i_pivot = $i_pivot\n");

	my scalartype $pivot = $data->[$i_pivot];  # CONSTANT
#	RPerl::diag("in quicksort(), have \$pivot = $pivot\n");

	# iteratively partition elements of length-n list into sublists less-or-greater than pivot [O(n) time, O(n) total extra space for sublists]
	for ($i = 0; $i < $data_length; $i++)
	{
		next if ($i == $i_pivot);  # do not compare pivot to itself, do not store in @less or @greater
		$element = $data->[$i];
#		RPerl::diag("in quicksort(), have \$element = $element\n");

		# compare element to pivot, this is the core sort comparison
		if ($element <= $pivot) { push(@less_scalar__array, $element); }
		else { push(@greater_scalar__array, $element); }
	}
#	RPerl::diag("in quicksort(), have \@less_scalar__array = \n" . RPerl::DUMPER(\@less_scalar__array) . "\n");
#	RPerl::diag("in quicksort(), have \@greater_scalar__array = \n" . RPerl::DUMPER(\@greater_scalar__array) . "\n");
	
	# recursively call this function on the sublists [O(log n) time], then concatenate the sorted sublists and pivot element
	$data = [@{quicksort(\@less_scalar__array)}, $pivot, @{quicksort(\@greater_scalar__array)}];
	
	# data is now sorted [O(n log n) total time, O(n) total extra space] 
	# via iteration during partitioning [O(n) time, O(n) extra space] and top-level recursion [O(log n) time, O(1) extra space?]
	return $data;
};

# in-place algorithm: comparison-based and not stable [O(n log n) average total time, O(log n) worst-case total extra space]
# call out to sort data, return sorted data
our scalartype_arrayref $quicksort_inplace = sub {(my scalartype_arrayref $data) = @_;
;
	return quicksort_inplace_left_right($data, 0, (scalar @{$data}) - 1);
};

# in-place algorithm; sort data, return sorted data [O(n log n) total time, O(log n) total extra space] 
our scalartype_arrayref $quicksort_inplace_left_right = sub { (my scalartype_arrayref $data, my int $i_left, my int $i_right) = @_;  # CONSTANTS $i_left, $i_right
;
#	RPerl::diag("in quicksort_inplace_left_right(), have \$data = \n" . RPerl::DUMPER($data) . "\n");
	
	my int $i_pivot;
	
	if ($i_left < $i_right)
	{
		$i_pivot = int($i_left + (($i_right - $i_left) / 2));  # pivot is middle element in partition; okay for large, already-sorted, or repetitive arrays
		$i_pivot = partition_inplace($data, $i_left, $i_right, $i_pivot);  # partition data [O(n) time]
		
		# recursively call this function on the list with sublist indices [O(log n) time, O(log n) total extra space for call stack]
		quicksort_inplace_left_right($data, $i_left, $i_pivot - 1);  # ignore recursion return values because data is sorted in-place
		quicksort_inplace_left_right($data, $i_pivot + 1, $i_right);
	}
	# else, singleton or empty sublists are sorted
	
	# data is now sorted [O(n log n) total time, O(log n) total extra space] 
	# via iteration during partitioning [O(n) time, O(1) extra space] and top-level recursion [O(log n) time, O(log n) extra space]
	return $data;
};

# in-place algorithm; partition data, return store index [O(n) time, O(1) extra space]
our int $partition_inplace = sub {(my scalartype_arrayref $data, my int $i_left, my int $i_right, my int $i_pivot) = @_;  # CONSTANTS $i_left, $i_right, $i_pivot
;
	my scalartype $swap;
	my int $i_store;
	my int $i;
	
	my scalartype $pivot = $data->[$i_pivot];  # CONSTANT	
#	RPerl::diag("in partition_inplace(), have \$pivot = $pivot\n");
	
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
