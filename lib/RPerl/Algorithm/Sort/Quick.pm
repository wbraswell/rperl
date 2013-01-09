package RPerl::Algorithm::Sort::Quick;
use strict;  use warnings;  use types;
use Data::Dumper;

our @ISA = ('RPerl::Algorithm::Sort');
use RPerl::Algorithm::Sort;

our %properties =
(
	data_scalar_array_ref => undef
);

# TODO: REMOVE sort_void() DUPLICATES BY MOVING INTO Sort.pm, HANDLE MULTIPLE VARIANTS
# call out to sort data, return nothing
#sub sort_void($self_object)
sub sort_void
{
	my object $self = shift;
	$self->{data_scalar_array_ref} = sort_scalar_array_ref($self->{data_scalar_array_ref});  # original algorithm
#	$self->{data_scalar_array_ref} = sort_in_place_scalar_array_ref($self->{data_scalar_array_ref});  # in-place variant algorithm
}

# original algorithm: O(n log n) time, O(n) extra space 
# sort data, return sorted data
#sub sort_scalar_array_ref($data_scalar_array_ref)
sub sort_scalar_array_ref
{
	my scalar_array_ref $data = shift;
	my const_int $data_length = scalar @{$data};
	
	print "in sort_scalar_array_ref(), have \$data = \n" . Dumper($data) . "\n" if $RPerl::DEBUG;
	print "in sort_scalar_array_ref(), have \$data_length = $data_length\n" if $RPerl::DEBUG;
	return $data if ($data_length <= 1);
	
	my int $i;
	my scalar $element;
	my @less_scalar = ();
	my @greater_scalar = ();
	
	my const_int $i_pivot = $data_length - 1;  # pivot is last element in partition; okay for small, not-already-sorted arrays
#	my const_int $i_pivot = int($data_length / 2);  # pivot is middle element in partition; okay for large, already-sorted, or repetitive arrays
	print "in sort_scalar_array_ref(), have \$i_pivot = $i_pivot\n" if $RPerl::DEBUG;

	my const_scalar $pivot = $data->[$i_pivot];
	print "in sort_scalar_array_ref(), have \$pivot = $pivot\n" if $RPerl::DEBUG;

	for ($i = 0; $i < $data_length; $i++)
	{
		next if ($i == $i_pivot);  # do not compare pivot to itself, do not store in @less or @greater
		$element = $data->[$i];
		print "in sort_scalar_array_ref(), have \$element = $element\n" if $RPerl::DEBUG;
		if ($element <= $pivot)
			{ push(@less_scalar, $element); }
		else
			{ push(@greater_scalar, $element); }
	}
	print "in sort_scalar_array_ref(), have \@less_scalar = \n" . Dumper(\@less_scalar) . "\n" if $RPerl::DEBUG;
	print "in sort_scalar_array_ref(), have \@greater_scalar = \n" . Dumper(\@greater_scalar) . "\n" if $RPerl::DEBUG;
	
	$data = [@{sort_scalar_array_ref(\@less_scalar)}, $pivot, @{sort_scalar_array_ref(\@greater_scalar)}];
	return $data;
}

# in-place variant: O(n log n) time, O(log n) extra space
# call out to sort data, return sorted data
#sub sort_in_place_scalar_array_ref($data_scalar_array_ref)
sub sort_in_place_scalar_array_ref
{
	my scalar_array_ref $data = shift;
	$data = sort_in_place_left_right_scalar_array_ref($data, 0, (scalar @{$data}) - 1);
}

# in-place variant; sort data, return sorted data
#sub sort_in_place_left_right_scalar_array_ref($data_scalar_array_ref, $i_left_const_int, $i_right_const_int)
sub sort_in_place_left_right_scalar_array_ref
{
	my scalar_array_ref $data = shift;
	my const_int $i_left = shift;
	my const_int $i_right = shift;
	print "in sort_in_place_left_right_scalar_array_ref(), have \$data = \n" . Dumper($data) . "\n" if $RPerl::DEBUG;
	
	my int $i_pivot;
	
	if ($i_left < $i_right)
	{
		$i_pivot = int($i_left + (($i_right - $i_left) / 2));  # pivot is middle element in partition; okay for large, already-sorted, or repetitive arrays
		$i_pivot = partition_int($data, $i_left, $i_right, $i_pivot);
		sort_in_place_left_right_scalar_array_ref($data, $i_left, $i_pivot - 1);  # ignore return values on recursive calls
		sort_in_place_left_right_scalar_array_ref($data, $i_pivot + 1, $i_right);
	}
	
	return $data;
}

# in-place variant; partition data, return store index
#sub partition_int($data_scalar_array_ref, $i_left_const_int, $i_right_const_int, $i_pivot_int) 
sub partition_int
{
	my scalar_array_ref $data = shift;
	my const_int $i_left = shift;	
	my const_int $i_right = shift;	
	my int $i_pivot = shift;	
	
	my scalar $swap;
	my int $i_store;
	my int $i;
	
	my scalar $pivot = $data->[$i_pivot];	
	print "in partition_int(), have \$pivot = $pivot\n" if $RPerl::DEBUG;
	
	# temporarily move pivot to the end of subarray to keep it out of the way
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
}