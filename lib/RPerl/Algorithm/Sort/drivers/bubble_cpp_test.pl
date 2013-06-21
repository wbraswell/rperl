#!/usr/bin/perl
use lib '/tmp/RPerl-latest/lib';  # RPerl system files  # NEED REMOVE hard-coded path
use strict;  use warnings;  use RPerl;  our @ISA = ('RPerl');

use lib '/tmp/RPerl-latest/lib/CPAN';  # RPerl's MyConfig.pm
use MyConfig;

# test if @INC now gives us access to the Inline libraries
#use Parse::RecDescent;
#use Inline;
#use Inline::C;
#use Inline::CPP;

use RPerl::Algorithm::Sort::Bubble_cpp;

my object $sorter;

for (my $i = 0; $i < 1;  $i++)
{
	$sorter = RPerl::Algorithm::Sort::Bubble->new();
	print "in bubble_cpp_test.pl, have \$i = $i and \$sorter =\n" . RPerl::DUMPER($sorter) . "\n" if $RPerl::DEBUG;

	#$sorter->set_data([5, 4, 3, 2, 1, 0]);
	my @data_array = (0 ... 5);
	@data_array = reverse(@data_array);
	$sorter->set_data(\@data_array);
	print "in bubble_cpp_test.pl, have \$i = $i and unsorted \$sorter->get_data() =\n" . RPerl::DUMPER($sorter->get_data()) . "\n" if $RPerl::DEBUG;

	my $start_time = time();
	$sorter->sort_method();
	my $end_time = time();
	my $run_time = $end_time - $start_time;

	print "in bubble_cpp_test.pl, have \$i = $i and sorted \$sorter->get_data() =\n" . RPerl::DUMPER($sorter->get_data()) . "\n" if $RPerl::DEBUG;
	print "in bubble_cpp_test.pl, have \$i = $i and \$run_time = $run_time\n";
}
