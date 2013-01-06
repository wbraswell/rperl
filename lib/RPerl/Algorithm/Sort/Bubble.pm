package RPerl::Algorithm::Sort::Bubble;
use strict;  use warnings;
use Data::Dumper;

our @ISA = ('RPerl::Class');
use RPerl::Class;

our %properties =
(
	data_scalar_array_ref => undef
);

# call out to do sorting, return nothing
#sub sort_void($self_obj)
sub sort_void
{
	my $self_obj = shift;
	$self_obj->{data_scalar_array_ref} = sort_scalar_array_ref($self_obj->{data_scalar_array_ref});
}

# do sorting, return sorted data
#sub sort_scalar_array_ref($data_scalar_array_ref)
sub sort_scalar_array_ref
{
	my $data_scalar_array_ref = shift;
	my $is_sorted_bool = 0;
	my $i_int;
	my $i_max_const_int = (scalar @{$data_scalar_array_ref}) - 1;
	my $swap_scalar;
	
	print "in Bubble.pm, have \$i_max_const_int = $i_max_const_int\n" if $RPerl::DEBUG;

	while (not($is_sorted_bool))
	{
		print "in Bubble.pm, top of WHILE loop\n" if $RPerl::DEBUG;
		$is_sorted_bool = 1;
		for ($i_int = 0; $i_int < $i_max_const_int; $i_int++)
		{
			print "in Bubble.pm, inside for() loop, have \$i_int = $i_int\n" if $RPerl::DEBUG;
			print "in Bubble.pm, inside for() loop, have \$data_scalar_array_ref\n" . Dumper($data_scalar_array_ref) . "\n" if $RPerl::DEBUG;
			if ($data_scalar_array_ref->[$i_int] > $data_scalar_array_ref->[($i_int + 1)])
			{
				print "in Bubble.pm, inside for() loop, SWAPPED\n" if $RPerl::DEBUG;
				$is_sorted_bool = 0;
				$swap_scalar = $data_scalar_array_ref->[$i_int];
				$data_scalar_array_ref->[$i_int] = $data_scalar_array_ref->[($i_int + 1)];
				$data_scalar_array_ref->[($i_int + 1)] = $swap_scalar;
			}
		}
	}
	
	return $data_scalar_array_ref;
}