package RPerl::Algorithm::Sort::Merge;
use strict;  use warnings;

our @ISA = ('RPerl::Algorithm::Sort');
use RPerl::Algorithm::Sort;

our %properties =
(
	variant => my string $TYPED_mode = 'topdown',  # default to top-down variant
	data => my unknown $TYPED_data,  # TODO: create nonscalar_ref data type?
);

# call out to sort data, return nothing
our void__method $sort = sub {(my object $self) = @_;
;
	if ((ref($self->{data}) eq 'ARRAY') or ($self->{data}->isa('array_ref')))
	{
		if ($self->{variant} eq 'topdown') { $self->{data} = mergesort_array_topdown($self->{data}); }
		elsif ($self->{variant} eq 'bottomup') { $self->{data} = mergesort_array_bottomup($self->{data}); }
		else { die("Unsupported variant '" . $self->{variant} . "' detected for array_ref data type (topdown or bottomup supported), dying"); }
	}
	elsif ($self->{data}->isa('scalar_linkedlist_ref'))
	{
		if ($self->{variant} eq 'topdown') { $self->{data}->{head} = mergesort_linkedlist_topdown($self->{data}->{head}); }
		else { die("Unsupported variant '" . $self->{variant} . "' detected for linkedlist_ref data type (only topdown supported), dying"); }
	}
	else { die("Unsupported data structure '" . ref($self->{data}) . "' detected (array_ref or linkedlist_ref supported), dying"); }
};

# top-down variant: comparison-based and stable and online [O(n log n) average total time, O(n) worst-case total extra space]
# sort data, return sorted data
our scalar__array_ref $mergesort_array_topdown = sub {(my scalar__array_ref $data) = @_;
;
	my const_int $data_length = scalar(@{$data});
	
#	RPerl::diag "in mergesort_array_topdown(), have \$data = \n" . RPerl::DUMPER($data) . "\n";
#	RPerl::diag "in mergesort_array_topdown(), have \$data_length = $data_length\n";

	# singleton or empty sublists are sorted
	return $data if ($data_length <= 1);
	
	# split data in half at midpoint
	my const_int $i_middle = int($data_length / 2);
	my scalar__array_ref $left = [@$data[0 .. ($i_middle - 1)]];
	my scalar__array_ref $right = [@$data[$i_middle .. ($data_length - 1)]];
	
	# recursively call this function on the sublists [O(log n) time], then merge the lengths-add-to-n sublists [O(n) time]
	$left = mergesort_array_topdown($left);
	$right = mergesort_array_topdown($right);
	$data = merge_array_topdown($left, $right);

	# data is now sorted [O(n log n) total time, O(n) total extra space] 
	# via iteration during merging [O(n) time, O(n) extra space] and recursion [O(log n) time, O(1) extra space? why not O(log n) extra space for call stack like in-place quicksort?]
	return $data;
};

# top-down variant; merge sublists data, return merged data [O(n) time, O(n) total extra space]
our scalar__array_ref $merge_array_topdown = sub {(my scalar__array_ref $left, my scalar__array_ref $right) = @_;
;
	my int $left_length = scalar(@{$left});
	my int $right_length = scalar(@{$right});
	
	# merged sublists [O(n) total extra space]
	my @merged_scalar__array = ();
	
	# iteratively merge elements of lengths-add-to-n sublists [O(n) time, O(n) total extra space for merged sublists]
	while (($left_length > 0) || ($right_length > 0))
	{
		if (($left_length > 0) && ($right_length > 0))
		{
			# compare elements and merge in smaller element, this is the core sort comparison
			if ($left->[0] <= $right->[0]) { push(@merged_scalar__array, shift(@{$left}));  $left_length--; }
			else { push(@merged_scalar__array, shift(@{$right}));  $right_length--; }
		}
		elsif ($left_length > 0) { @merged_scalar__array = (@merged_scalar__array, @{$left});  $left_length = 0; }
		elsif ($right_length > 0) { @merged_scalar__array = (@merged_scalar__array, @{$right});  $right_length = 0; }
	}
	
	return \@merged_scalar__array;
};

# bottom-up variant: comparison-based and stable and online [O(n log n) average total time, O(n) worst-case total extra space]
# sort data, return sorted data
our scalar__array_ref $mergesort_array_bottomup = sub {(my scalar__array_ref $data) = @_;
;
	my const_int $data_length = scalar(@{$data});
	my int $width;	
	my int $i;
	
	# temporary storage for partially sorted data [O(n) total extra space; counted for this function, not the merge_array_bottomup() function]
	my scalar__array_ref $tmp_data = [];
	
#	RPerl::diag "in mergesort_array_bottomup(), have \$data = \n" . RPerl::DUMPER($data) . "\n";
#	RPerl::diag "in mergesort_array_bottomup(), have \$data_length = $data_length\n";
	
	# iterate through the length-n list with logarithmic iterator growth [O(log n) time]
	for ($width = 1; $width < $data_length; $width = $width * 2)
	{
#		RPerl::diag "in mergesort_array_bottomup(), top of outer for() loop, have \$width = $width\n";
		for ($i = 0; $i < $data_length; $i = $i + ($width * 2))
		{
#			RPerl::diag "in mergesort_array_bottomup(), top of inner for() loop, have \$i = $i\n";
			merge_array_bottomup($data, $tmp_data, $i, min(($i + $width), $data_length), min(($i + ($width * 2)), $data_length));
		}
		$data = [@$tmp_data];
	}
	
	# data is now sorted [O(n log n) total time, O(n) total extra space] 
	# via iteration during merging [O(n) time, O(1) extra space] and top-level nested iteration [O(log n) time, O(n) extra space]
	return $data;
};

# bottom-up variant; merge sublists, return nothing [O(n) time, O(1) extra space]
our void $merge_array_bottomup = sub {(my scalar__array_ref $data, my scalar__array_ref $tmp_data, my const_int $i_left, my const_int $i_right, my const_int $i_end) = @_;
;
	my int $i0 = $i_left;
	my int $i1 = $i_right;
	my int $j;
	
#	RPerl::diag "in merge_array_bottomup(), have \$data = \n" . RPerl::DUMPER($data) . "\n";
#	RPerl::diag "in merge_array_bottomup(), have \$tmp_data = \n" . RPerl::DUMPER($tmp_data) . "\n";
#	RPerl::diag "in merge_array_bottomup(), have \$i_left = $i_left\n";
#	RPerl::diag "in merge_array_bottomup(), have \$i_right = $i_right\n";
#	RPerl::diag "in merge_array_bottomup(), have \$i_end = $i_end\n";
		
	# iteratively merge elements of lengths-add-to-n sublists [O(n) time, O(1) extra space]
	for ($j = $i_left; $j < $i_end; $j++)
	{
#		RPerl::diag "in merge_array_bottomup(), top of for() loop, have \$j = $j\n";

		# compare elements and merge in smaller element, this is the core sort comparison
		if (($i0 < $i_right) && (($i1 >= $i_end) || ($data->[$i0] <= $data->[$i1])))
		{
#			RPerl::diag "in merge_array_bottomup(), setting \$tmp_data->[$j] = \$data->[\$i0] = \$data->[$i0] = " . $data->[$i0] . "\n";
			$tmp_data->[$j] = $data->[$i0];
			$i0++;
		}
		else
		{
#			RPerl::diag "in merge_array_bottomup(), setting \$tmp_data->[$j] = \$data->[\$i1] = \$data->[$i1] = " . $data->[$i1] . "\n";
			$tmp_data->[$j] = $data->[$i1];
			$i1++;
		}
	}
};

# bottom-up variant; return smaller of 2 scalars [O(1) time, O(1) extra space]
our scalar $min = sub {(my const_scalar $a, my const_scalar $b) = @_; if ($a < $b) {return $a;} else {return $b;}};

# linked list, top-down variant: comparison-based and stable and online [O(n log n) average total time, O(1) worst-case total extra space]
# sort data starting at head node, return new head node of sorted data
our linkedlistnode_ref $mergesort_linkedlist_topdown = sub {(my linkedlistnode_ref $head) = @_;
;
#	RPerl::diag "in mergesort_linkedlist_topdown(), received \$head = " . RPerl::DUMPER($head) . "\n";

	my linkedlistnode_ref $left;
	my linkedlistnode_ref $right;
	
	# singleton or empty sublists are sorted
	return $head if (not(defined($head)) or not(defined($head->{next})));
	
	($left, $right) = @{split_linkedlist($head)};
#	RPerl::diag "in mergesort_linkedlist_topdown(), after split_linkedlist() have \$left = " . RPerl::DUMPER($left) . "\n";
#	RPerl::diag "in mergesort_linkedlist_topdown(), after split_linkedlist() have \$right = " . RPerl::DUMPER($right) . "\n";

	$left = mergesort_linkedlist_topdown($left);
	$right = mergesort_linkedlist_topdown($right);
#	RPerl::diag "in mergesort_linkedlist_topdown(), after recursion to mergesort_linkedlist_topdown() have \$left = " . RPerl::DUMPER($left) . "\n";
#	RPerl::diag "in mergesort_linkedlist_topdown(), after recursion to mergesort_linkedlist_topdown() have \$right = " . RPerl::DUMPER($right) . "\n";
	
	$head = merge_linkedlist_topdown($left, $right);
#	RPerl::diag "in mergesort_linkedlist_topdown(), after merge_linkedlist_topdown(), about to return \$head = " . RPerl::DUMPER($head) . "\n";
	
	return $head;
};

# linked list, top-down variant; split into sublists, return sublists [O(n) time, O(1) extra space]
our array_ref $split_linkedlist = sub {(my scalar_linkedlist_ref $head) = @_;
;	
#	RPerl::diag "in split_linkedlist(), received \$head->{data} = " . $head->{data} . "\n";
	
	my linkedlistnode_ref $left;
	my linkedlistnode_ref $right;
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
		
		# split data in half at midpoint
		$left = $head;
		$right = $slow->{next};
		$slow->{next} = undef;
	}
	
#	RPerl::diag "in split_linkedlist(), have final \$left = " . RPerl::DUMPER($left) . "\n";
#	RPerl::diag "in split_linkedlist(), have final \$right = " . RPerl::DUMPER($right) . "\n";
	return [$left, $right];
};

# linked list, top-down variant; merge sublists, return sublists [O(n) time, O(1) extra space]
our linkedlistnode_ref $merge_linkedlist_topdown = sub {(my linkedlistnode_ref $left, my linkedlistnode_ref $right) = @_;
;
#	RPerl::diag "in merge_linkedlist_topdown(), received \$left = " . RPerl::DUMPER($left) . "\n";
#	RPerl::diag "in merge_linkedlist_topdown(), received \$right = " . RPerl::DUMPER($right) . "\n";

	my linkedlistnode_ref $merged;
	
	if (not(defined($left)))
	{
#		RPerl::diag "in merge_linkedlist_topdown(), have undefined \$left, returning only \$right\n";
		return $right;
	}
	elsif (not(defined($right)))
	{
#		RPerl::diag "in merge_linkedlist_topdown(), have undefined \$right, returning only \$left\n";
		return $left;
	}
	
	if ($left->{data} <= $right->{data})
	{
#		RPerl::diag "in merge_linkedlist_topdown(), have \$left->{data} <= \$right->{data} === " . $left->{data} . " <= " . $right->{data} . "\n";
		$merged = $left;
		$merged->{next} = merge_linkedlist_topdown($left->{next}, $right);
	}
	else
	{
#		RPerl::diag "in merge_linkedlist_topdown(), have \$left->{data} > \$right->{data} === " . $left->{data} . " > " . $right->{data} . "\n";
		$merged = $right;
		$merged->{next} = merge_linkedlist_topdown($left, $right->{next});
	}
	
#	RPerl::diag "in merge_linkedlist_topdown(), returning \$merged = " . RPerl::DUMPER($merged) . "\n";
	return $merged;
};
