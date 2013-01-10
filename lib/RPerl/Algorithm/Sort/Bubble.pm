package RPerl::Algorithm::Sort::Bubble;
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
	$self->{data} = bubblesort($self->{data});
};

# original algorithm: O(n**2) average time, O(1) worst-case extra space 
# sort data, return sorted data
our scalar_array_ref $bubblesort = sub {(my scalar_array_ref $data) = @_;
;
	my int $is_sorted = 0;
	my int $i;
	my const_int $data_length = scalar(@{$data});
	my scalar $swap;
	
	print "in bubblesort(), have \$data_length = $data_length\n" if $RPerl::DEBUG;

	while (not($is_sorted))
	{
		print "in bubblesort(), top of WHILE loop\n" if $RPerl::DEBUG;
		$is_sorted = 1;
		for ($i = 0; $i < ($data_length - 1); $i++)
		{
			print "in bubblesort(), inside for() loop, have \$i = $i\n" if $RPerl::DEBUG;
			print "in bubblesort(), inside for() loop, have \$data\n" . RPerl::DUMPER($data) . "\n" if $RPerl::DEBUG;
			if ($data->[$i] > $data->[($i + 1)])
			{
				print "in bubblesort(), inside for() loop, SWAPPED\n" if $RPerl::DEBUG;
				$is_sorted = 0;
				$swap = $data->[$i];
				$data->[$i] = $data->[($i + 1)];
				$data->[($i + 1)] = $swap;
			}
		}
	}
	
	return $data;
};