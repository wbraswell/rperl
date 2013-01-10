package RPerl::Algorithm::Sort::Merge;
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
#	$self->{data} = mergesort($self->{data});  # original top-down algorithm
	$self->{data} = mergesort_bottom_up($self->{data});  # bottom-up algorithm
};

# top-down algorithm: O(n log n) average time, O(n) worst-case extra space 
# sort data, return sorted data
our scalar_array_ref $mergesort = sub {(my scalar_array_ref $data) = @_;
;
	my const_int $data_length = scalar(@{$data});
	
	print "in mergesort(), have \$data = \n" . RPerl::DUMPER($data) . "\n" if $RPerl::DEBUG;
	print "in mergesort(), have \$data_length = $data_length\n" if $RPerl::DEBUG;
	return $data if ($data_length <= 1);
	
	my const_int $i_middle = int($data_length / 2);
	my scalar_array_ref $left = [@$data[0 .. ($i_middle - 1)]];
	my scalar_array_ref $right = [@$data[$i_middle .. ($data_length - 1)]];
	
	$left = mergesort($left);
	$right = mergesort($right);
	$data = merge($left, $right);

	return $data;
};

# top-down algorithm; merge sublists data, return merged data
our scalar_array_ref $merge = sub {(my scalar_array_ref $left, my scalar_array_ref $right) = @_;
;
	my int $left_length = scalar(@{$left});
	my int $right_length = scalar(@{$right});
	my @merged_scalar_array = ();	
	
	while (($left_length > 0) || ($right_length > 0))
	{
		if (($left_length > 0) && ($right_length > 0))
		{
			if ($left->[0] <= $right->[0]) { push(@merged_scalar_array, shift(@{$left}));  $left_length--; }
			else { push(@merged_scalar_array, shift(@{$right}));  $right_length--; }
		}
		elsif ($left_length > 0) { @merged_scalar_array = (@merged_scalar_array, @{$left});  $left_length = 0; }
		elsif ($right_length > 0) { @merged_scalar_array = (@merged_scalar_array, @{$right});  $right_length = 0; }
	}
	
	return \@merged_scalar_array;
};

# bottom-up algorithm: O(n log n) average time, O(n) worst-case extra space
# sort data, return sorted data
our scalar_array_ref $mergesort_bottom_up = sub {(my scalar_array_ref $data) = @_;
;
	my const_int $data_length = scalar(@{$data});
	my scalar_array_ref $tmp_data = [];
	my int $width;	
	my int $i;
	
	print "in mergesort_bottom_up(), have \$data = \n" . RPerl::DUMPER($data) . "\n" if $RPerl::DEBUG;
	print "in mergesort_bottom_up(), have \$data_length = $data_length\n" if $RPerl::DEBUG;
	
	for ($width = 1; $width < $data_length; $width = $width * 2)
	{
		print "in mergesort_bottom_up(), top of outer for() loop, have \$width = $width\n" if $RPerl::DEBUG;
		for ($i = 0; $i < $data_length; $i = $i + ($width * 2))
		{
			print "in mergesort_bottom_up(), top of inner for() loop, have \$i = $i\n" if $RPerl::DEBUG;
			merge_bottom_up($data, $tmp_data, $i, min(($i + $width), $data_length), min(($i + ($width * 2)), $data_length));
		}
		$data = [@$tmp_data];
	}
	
	return $data;
};

# bottom-up algorithm; merge sublists, return nothing
our void $merge_bottom_up = sub {(my scalar_array_ref $data, my scalar_array_ref $tmp_data, my const_int $i_left, my const_int $i_right, my const_int $i_end) = @_;
;
	my int $i0 = $i_left;
	my int $i1 = $i_right;
	my int $j;
	
	print "in merge_bottom_up(), have \$data = \n" . RPerl::DUMPER($data) . "\n" if $RPerl::DEBUG;
	print "in merge_bottom_up(), have \$tmp_data = \n" . RPerl::DUMPER($tmp_data) . "\n" if $RPerl::DEBUG;
	print "in merge_bottom_up(), have \$i_left = $i_left\n" if $RPerl::DEBUG;
	print "in merge_bottom_up(), have \$i_right = $i_right\n" if $RPerl::DEBUG;
	print "in merge_bottom_up(), have \$i_end = $i_end\n" if $RPerl::DEBUG;
		
	for ($j = $i_left; $j < $i_end; $j++)
	{
		print "in merge_bottom_up(), top of for() loop, have \$j = $j\n" if $RPerl::DEBUG;
		if (($i0 < $i_right) && (($i1 >= $i_end) || ($data->[$i0] <= $data->[$i1])))
		{
			print "in merge_bottom_up(), setting \$tmp_data->[$j] = \$data->[\$i0] = \$data->[$i0] = " . $data->[$i0] . "\n" if $RPerl::DEBUG;
			$tmp_data->[$j] = $data->[$i0];
			$i0++;
		}
		else
		{
			print "in merge_bottom_up(), setting \$tmp_data->[$j] = \$data->[\$i1] = \$data->[$i1] = " . $data->[$i1] . "\n" if $RPerl::DEBUG;
			$tmp_data->[$j] = $data->[$i1];
			$i1++;
		}
	}
};

# bottom-up algorithm; return smaller of 2 scalars
our scalar $min = sub {(my const_scalar $a, my const_scalar $b) = @_; if ($a < $b) {return $a;} else {return $b;}};