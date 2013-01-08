package RPerl::Algorithm::Sort::Bubble;
use strict;  use warnings;
use Data::Dumper;

our @ISA = ('RPerl::Algorithm::Sort');
use RPerl::Algorithm::Sort;

our %properties =
(
	data_scalar_array_ref => undef
);

# TODO: REMOVE sort_void() DUPLICATES BY MOVING INTO Sort.pm
# call out to sort data, return nothing
#sub sort_void($self_obj)
sub sort_void
{
	my $self_obj = shift;
	$self_obj->{data_scalar_array_ref} = sort_scalar_array_ref($self_obj->{data_scalar_array_ref});
}

# original algorithm: O(n**2) time, O(1) extra space 
# sort data, return sorted data
#sub sort_scalar_array_ref($data_scalar_array_ref)
sub sort_scalar_array_ref
{
	my $data_scalar_array_ref = shift;
	my $is_sorted_bool = 0;
	my $i_int;
	my $data_length_const_int = scalar @{$data_scalar_array_ref};
	my $swap_scalar;
	
	print "in sort_scalar_array_ref(), have \$data_length_const_int = $data_length_const_int\n" if $RPerl::DEBUG;

	while (not($is_sorted_bool))
	{
		print "in sort_scalar_array_ref(), top of WHILE loop\n" if $RPerl::DEBUG;
		$is_sorted_bool = 1;
		for ($i_int = 0; $i_int < $data_length_const_int; $i_int++)
		{
			print "in sort_scalar_array_ref(), inside for() loop, have \$i_int = $i_int\n" if $RPerl::DEBUG;
			print "in sort_scalar_array_ref(), inside for() loop, have \$data_scalar_array_ref\n" . Dumper($data_scalar_array_ref) . "\n" if $RPerl::DEBUG;
			if ($data_scalar_array_ref->[$i_int] > $data_scalar_array_ref->[($i_int + 1)])
			{
				print "in sort_scalar_array_ref(), inside for() loop, SWAPPED\n" if $RPerl::DEBUG;
				$is_sorted_bool = 0;
				$swap_scalar = $data_scalar_array_ref->[$i_int];
				$data_scalar_array_ref->[$i_int] = $data_scalar_array_ref->[($i_int + 1)];
				$data_scalar_array_ref->[($i_int + 1)] = $swap_scalar;
			}
		}
	}
	
	return $data_scalar_array_ref;
}