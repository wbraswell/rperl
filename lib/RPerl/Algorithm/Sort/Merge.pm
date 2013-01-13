package RPerl::Algorithm::Sort::Merge;
use strict;  use warnings;

our @ISA = ('RPerl::Algorithm::Sort');
use RPerl::Algorithm::Sort;

our %properties =
(
	# TODO: handle multiple data structures
##	data => my scalar_array_ref $KEY_data,
	data => my scalar_linkedlist_ref $KEY_data,
);

# call out to sort data, return nothing
our void $sort_method = sub {(my object $self) = @_;
;
	# TODO: handle multiple algorithm choices
##	$self->{data} = mergesort($self->{data});  # original top-down algorithm
##	$self->{data} = mergesort_bottom_up($self->{data});  # bottom-up algorithm
	$self->{data}->{head} = mergesort_linkedlist($self->{data}->{head});  # linked list algorithm
};

# top-down algorithm: comparison-based and stable and online [O(n log n) average total time, O(n) worst-case total extra space]
# sort data, return sorted data
our scalar_array_ref $mergesort = sub {(my scalar_array_ref $data) = @_;
;
	my const_int $data_length = scalar(@{$data});
	
#	print "in mergesort(), have \$data = \n" . RPerl::DUMPER($data) . "\n" if $RPerl::DEBUG;
#	print "in mergesort(), have \$data_length = $data_length\n" if $RPerl::DEBUG;

	# singleton or empty sublists are sorted
	return $data if ($data_length <= 1);
	
	my const_int $i_middle = int($data_length / 2);
	my scalar_array_ref $left = [@$data[0 .. ($i_middle - 1)]];
	my scalar_array_ref $right = [@$data[$i_middle .. ($data_length - 1)]];
	
	# recursively call this function on the sublists [O(log n) time], then merge the lengths-add-to-n sublists [O(n) time]
	$left = mergesort($left);
	$right = mergesort($right);
	$data = merge($left, $right);

	# data is now sorted [O(n log n) total time, O(n) total extra space] 
	# via iteration during merging [O(n) time, O(n) extra space] and recursion [O(log n) time, O(1) extra space? why not O(log n) extra space for call stack like in-place quicksort?]
	return $data;
};

# top-down algorithm; merge sublists data, return merged data [O(n) time, O(n) total extra space]
our scalar_array_ref $merge = sub {(my scalar_array_ref $left, my scalar_array_ref $right) = @_;
;
	my int $left_length = scalar(@{$left});
	my int $right_length = scalar(@{$right});
	
	# merged sublists [O(n) total extra space]
	my @merged_scalar_array = ();
	
	# iteratively merge elements of lengths-add-to-n sublists [O(n) time, O(n) total extra space for merged sublists]
	while (($left_length > 0) || ($right_length > 0))
	{
		if (($left_length > 0) && ($right_length > 0))
		{
			# compare elements and merge in smaller element, this is the core sort comparison
			if ($left->[0] <= $right->[0]) { push(@merged_scalar_array, shift(@{$left}));  $left_length--; }
			else { push(@merged_scalar_array, shift(@{$right}));  $right_length--; }
		}
		elsif ($left_length > 0) { @merged_scalar_array = (@merged_scalar_array, @{$left});  $left_length = 0; }
		elsif ($right_length > 0) { @merged_scalar_array = (@merged_scalar_array, @{$right});  $right_length = 0; }
	}
	
	return \@merged_scalar_array;
};

# bottom-up algorithm: comparison-based and stable and online [O(n log n) average total time, O(n) worst-case total extra space]
# sort data, return sorted data
our scalar_array_ref $mergesort_bottom_up = sub {(my scalar_array_ref $data) = @_;
;
	my const_int $data_length = scalar(@{$data});
	my int $width;	
	my int $i;
	
	# temporary storage for partially sorted data [O(n) total extra space; counted for this function, not the merge_bottom_up() function]
	my scalar_array_ref $tmp_data = [];
	
#	print "in mergesort_bottom_up(), have \$data = \n" . RPerl::DUMPER($data) . "\n" if $RPerl::DEBUG;
#	print "in mergesort_bottom_up(), have \$data_length = $data_length\n" if $RPerl::DEBUG;
	
	# iterate through the length-n list with logarithmic iterator growth [O(log n) time]
	for ($width = 1; $width < $data_length; $width = $width * 2)
	{
#		print "in mergesort_bottom_up(), top of outer for() loop, have \$width = $width\n" if $RPerl::DEBUG;
		for ($i = 0; $i < $data_length; $i = $i + ($width * 2))
		{
#			print "in mergesort_bottom_up(), top of inner for() loop, have \$i = $i\n" if $RPerl::DEBUG;
			merge_bottom_up($data, $tmp_data, $i, min(($i + $width), $data_length), min(($i + ($width * 2)), $data_length));
		}
		$data = [@$tmp_data];
	}
	
	# data is now sorted [O(n log n) total time, O(n) total extra space] 
	# via iteration during merging [O(n) time, O(1) extra space] and top-level nested iteration [O(log n) time, O(n) extra space]
	return $data;
};

# bottom-up algorithm; merge sublists, return nothing [O(n) time, O(1) extra space]
our void $merge_bottom_up = sub {(my scalar_array_ref $data, my scalar_array_ref $tmp_data, my const_int $i_left, my const_int $i_right, my const_int $i_end) = @_;
;
	my int $i0 = $i_left;
	my int $i1 = $i_right;
	my int $j;
	
#	print "in merge_bottom_up(), have \$data = \n" . RPerl::DUMPER($data) . "\n" if $RPerl::DEBUG;
#	print "in merge_bottom_up(), have \$tmp_data = \n" . RPerl::DUMPER($tmp_data) . "\n" if $RPerl::DEBUG;
#	print "in merge_bottom_up(), have \$i_left = $i_left\n" if $RPerl::DEBUG;
#	print "in merge_bottom_up(), have \$i_right = $i_right\n" if $RPerl::DEBUG;
#	print "in merge_bottom_up(), have \$i_end = $i_end\n" if $RPerl::DEBUG;
		
	# iteratively merge elements of lengths-add-to-n sublists [O(n) time, O(1) extra space]
	for ($j = $i_left; $j < $i_end; $j++)
	{
#		print "in merge_bottom_up(), top of for() loop, have \$j = $j\n" if $RPerl::DEBUG;

		# compare elements and merge in smaller element, this is the core sort comparison
		if (($i0 < $i_right) && (($i1 >= $i_end) || ($data->[$i0] <= $data->[$i1])))
		{
#			print "in merge_bottom_up(), setting \$tmp_data->[$j] = \$data->[\$i0] = \$data->[$i0] = " . $data->[$i0] . "\n" if $RPerl::DEBUG;
			$tmp_data->[$j] = $data->[$i0];
			$i0++;
		}
		else
		{
#			print "in merge_bottom_up(), setting \$tmp_data->[$j] = \$data->[\$i1] = \$data->[$i1] = " . $data->[$i1] . "\n" if $RPerl::DEBUG;
			$tmp_data->[$j] = $data->[$i1];
			$i1++;
		}
	}
};

# bottom-up algorithm; return smaller of 2 scalars [O(1) time, O(1) extra space]
our scalar $min = sub {(my const_scalar $a, my const_scalar $b) = @_; if ($a < $b) {return $a;} else {return $b;}};


# START HERE: add debugging messages and debug!
our linkedlistnode_ref $mergesort_linkedlist = sub {(my linkedlistnode_ref $head) = @_;
;
	my linkedlistnode_ref $left;
	my linkedlistnode_ref $right;
	
	# singleton or empty sublists are sorted
	return $head if (not(defined($head)) or not(defined($head->{next})));
	
	unmerge_linkedlist($head, $left, $right);
	mergesort_linkedlist($left);
	mergesort_linkedlist($right);
	$head = merge_linkedlist($left, $right);
	
	return $head;
};

our void $unmerge_linkedlist = sub {(my scalar_linkedlist_ref $head, my linkedlistnode_ref $left, my linkedlistnode_ref $right) = @_;
;	
	my linkedlistnode_ref $slow;
	my linkedlistnode_ref $fast;
	
	# singleton or empty sublists
	if (not(defined($head)) or not(defined($head->{next})))
	{
		$left = $head;
		$right = undef;	
	}
	else
	{
		$slow = $head;
		$fast = $head->{next};
		
		# advance fast twice and slow once
		while (defined($fast))
		{
			$fast = $fast->{next};
			if (defined($fast))
			{
				$slow = $slow->{next};
				$fast = $fast->{next};
			}
		}
		
		# split list at midpoint
		$left = $head;
		$right = $slow->{next};
		$slow->{next} = undef;
	}
};

our linkedlistnode_ref $merge_linkedlist = sub {(my linkedlistnode_ref $left, my linkedlistnode_ref $right) = @_;
;
	my linkedlistnode_ref $merged;
	
	if (not(defined($left)))
	{
		return $right;
	}
	elsif (not(defined($right)))
	{
		return $left;
	}
	
	if ($left->{data} <= $right->{data})
	{
		$merged = $left;
		$merged->{next} = merge_linkedlist($left->{next}, $right);
	}
	else
	{
		$merged = $right;
		$merged->{next} = merge_linkedlist($left, $right->{next});
	}
	
	return $merged;
};