package RPerl::Algorithm::Sort::Bubble;
use strict;  use warnings;  use types;
use Data::Dumper;

our @ISA = ('RPerl::Algorithm::Sort');
use RPerl::Algorithm::Sort;

our %properties =
(
	data_scalar_array_ref => undef
);

# TODO: REMOVE sort_void() DUPLICATES BY MOVING INTO Sort.pm
# call out to sort data, return nothing
#sub sort_void($self_object)
sub sort_void
{
	my object $self = shift;
	$self->{data_scalar_array_ref} = sort_scalar_array_ref($self->{data_scalar_array_ref});
}

# original algorithm: O(n**2) time, O(1) extra space 
# sort data, return sorted data
#sub sort_scalar_array_ref($data_scalar_array_ref)
sub sort_scalar_array_ref
{
	my scalar_array_ref $data = shift;
	my int $is_sorted = 0;
	my int $i;
	my const_int $data_length = scalar @{$data};
	my scalar $swap;
	
	print "in sort_scalar_array_ref(), have \$data_length = $data_length\n" if $RPerl::DEBUG;

	while (not($is_sorted))
	{
		print "in sort_scalar_array_ref(), top of WHILE loop\n" if $RPerl::DEBUG;
		$is_sorted = 1;
		for ($i = 0; $i < ($data_length - 1); $i++)
		{
			print "in sort_scalar_array_ref(), inside for() loop, have \$i = $i\n" if $RPerl::DEBUG;
			print "in sort_scalar_array_ref(), inside for() loop, have \$data\n" . Dumper($data) . "\n" if $RPerl::DEBUG;
			if ($data->[$i] > $data->[($i + 1)])
			{
				print "in sort_scalar_array_ref(), inside for() loop, SWAPPED\n" if $RPerl::DEBUG;
				$is_sorted = 0;
				$swap = $data->[$i];
				$data->[$i] = $data->[($i + 1)];
				$data->[($i + 1)] = $swap;
			}
		}
	}
	
	return $data;
}