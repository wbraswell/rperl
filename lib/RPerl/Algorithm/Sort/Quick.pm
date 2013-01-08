package RPerl::Algorithm::Sort::Quick;
use strict;  use warnings;
use Data::Dumper;

our @ISA = ('RPerl::Algorithm::Sort');
use RPerl::Algorithm::Sort;

our %properties =
(
	data_scalar_array_ref => undef
);

# TODO: REMOVE sort_void() DUPLICATES BY MOVING INTO Sort.pm, HANDLE MULTIPLE VARIANTS
# call out to sort data, return nothing
#sub sort_void($self_obj)
sub sort_void
{
	my $self_obj = shift;
#	$self_obj->{data_scalar_array_ref} = sort_scalar_array_ref($self_obj->{data_scalar_array_ref});  # original algorithm
	$self_obj->{data_scalar_array_ref} = sort_in_place_scalar_array_ref($self_obj->{data_scalar_array_ref});  # in-place variant algorithm
}

# original algorithm: O(n log n) time, O(n) extra space 
# sort data, return sorted data
#sub sort_scalar_array_ref($data_scalar_array_ref)
sub sort_scalar_array_ref
{
	my $data_scalar_array_ref = shift;
	my $data_length_const_int = scalar @{$data_scalar_array_ref};
	
	print "in sort_scalar_array_ref(), have \$data_scalar_array_ref = \n" . Dumper($data_scalar_array_ref) . "\n" if $RPerl::DEBUG;
	print "in sort_scalar_array_ref(), have \$data_length_const_int = $data_length_const_int\n" if $RPerl::DEBUG;
	return $data_scalar_array_ref if ($data_length_const_int <= 1);
	
	my $i_int;
	my $element_scalar;
	my @less_scalar_array = ();
	my @greater_scalar_array = ();
	
#	my $i_pivot_const_int = $data_length_const_int - 1;  # pivot is last element in partition; okay for small, not-already-sorted arrays
	my $i_pivot_const_int = int($data_length_const_int / 2);  # pivot is middle element in partition; okay for large, already-sorted, or repetitive arrays
	print "in sort_scalar_array_ref(), have \$i_pivot_const_int = $i_pivot_const_int\n" if $RPerl::DEBUG;

	my $pivot_const_scalar = $data_scalar_array_ref->[$i_pivot_const_int];
	print "in sort_scalar_array_ref(), have \$pivot_const_scalar = $pivot_const_scalar\n" if $RPerl::DEBUG;

	for ($i_int = 0; $i_int < $data_length_const_int; $i_int++)
	{
		next if ($i_int == $i_pivot_const_int);  # do not compare pivot to itself, do not store in @less or @greater
		$element_scalar = $data_scalar_array_ref->[$i_int];
		print "in sort_scalar_array_ref(), have \$element_scalar = $element_scalar\n" if $RPerl::DEBUG;
		if ($element_scalar <= $pivot_const_scalar)
			{ push(@less_scalar_array, $element_scalar); }
		else
			{ push(@greater_scalar_array, $element_scalar); }
	}
	print "in sort_scalar_array_ref(), have \@less_scalar_array = \n" . Dumper(\@less_scalar_array) . "\n" if $RPerl::DEBUG;
	print "in sort_scalar_array_ref(), have \@greater_scalar_array = \n" . Dumper(\@greater_scalar_array) . "\n" if $RPerl::DEBUG;
	
	$data_scalar_array_ref = [@{sort_scalar_array_ref(\@less_scalar_array)}, $pivot_const_scalar, @{sort_scalar_array_ref(\@greater_scalar_array)}];
	return $data_scalar_array_ref;
}

# in-place variant: O(n log n) time, O(log n) extra space
# call out to sort data, return sorted data
#sub sort_in_place_scalar_array_ref($data_scalar_array_ref)
sub sort_in_place_scalar_array_ref
{
	my $data_scalar_array_ref = shift;
	$data_scalar_array_ref = sort_in_place_left_right_scalar_array_ref($data_scalar_array_ref, 0, (scalar @{$data_scalar_array_ref}) - 1);
}

# in-place variant; sort data, return sorted data
#sub sort_in_place_left_right_scalar_array_ref($data_scalar_array_ref, $i_left_const_int, $i_right_const_int)
sub sort_in_place_left_right_scalar_array_ref
{
	my $data_scalar_array_ref = shift;
	my $i_left_const_int = shift;
	my $i_right_const_int = shift;
	print "in sort_in_place_left_right_scalar_array_ref(), have \$data_scalar_array_ref = \n" . Dumper($data_scalar_array_ref) . "\n" if $RPerl::DEBUG;
	
	my $i_pivot_int;
	
	if ($i_left_const_int < $i_right_const_int)
	{
		$i_pivot_int = int($i_left_const_int + (($i_right_const_int - $i_left_const_int) / 2));  # pivot is middle element in partition; okay for large, already-sorted, or repetitive arrays
		$i_pivot_int = partition_int($data_scalar_array_ref, $i_left_const_int, $i_right_const_int, $i_pivot_int);
		sort_in_place_left_right_scalar_array_ref($data_scalar_array_ref, $i_left_const_int, $i_pivot_int - 1);  # ignore return values on recursive calls
		sort_in_place_left_right_scalar_array_ref($data_scalar_array_ref, $i_pivot_int + 1, $i_right_const_int);
	}
	
	return $data_scalar_array_ref;
}

# in-place variant; partition data, return store index
#sub partition_int($data_scalar_array_ref, $i_left_const_int, $i_right_const_int, $i_pivot_const_int) 
sub partition_int
{
	my $data_scalar_array_ref = shift;
	my $i_left_const_int = shift;	
	my $i_right_const_int = shift;	
	my $i_pivot_const_int = shift;	
	
	my $swap_scalar;
	my $i_store_int;
	my $i_int;
	
	my $pivot_const_scalar = $data_scalar_array_ref->[$i_pivot_const_int];	
	print "in partition_int(), have \$pivot_const_scalar = $pivot_const_scalar\n" if $RPerl::DEBUG;
	
	# temporarily move pivot to the end of subarray to keep it out of the way
	$data_scalar_array_ref->[$i_pivot_const_int] = $data_scalar_array_ref->[$i_right_const_int];
	$data_scalar_array_ref->[$i_right_const_int] = $pivot_const_scalar;
	
	$i_store_int = $i_left_const_int;
	
	for ($i_int = $i_left_const_int; $i_int < $i_right_const_int; $i_int++)
	{
		if ($data_scalar_array_ref->[$i_int] < $pivot_const_scalar)
		{
			$swap_scalar = $data_scalar_array_ref->[$i_int];
			$data_scalar_array_ref->[$i_int] = $data_scalar_array_ref->[$i_store_int];
			$data_scalar_array_ref->[$i_store_int] = $swap_scalar;
			$i_store_int++;
		}
	}

	# move pivot back to where it needs to be
	$swap_scalar = $data_scalar_array_ref->[$i_store_int];
	$data_scalar_array_ref->[$i_store_int] = $data_scalar_array_ref->[$i_right_const_int];
	$data_scalar_array_ref->[$i_right_const_int] = $swap_scalar;
	
	return $i_store_int;
}