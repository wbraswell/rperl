#!/usr/bin/perl

# Bubble Sort, Program Source Code, Perl Implementation #1
# Sort A List Of Out-Of-Order Integers
# The Open Benchmarks Group
# http://openbenchmarks.org

# Contributed In Perl By Will Braswell

# $ ./script/demo/bubble_sort.pl 5000
# time total:   15.488 seconds
# $ rperl ./lib/RPerl/Algorithm/Sort/Bubble.pm
# $ ./script/demo/bubble_sort.pl 5000
# time total:   0.050 seconds

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

# [[[ INCLUDES ]]]
use RPerl::Algorithm::Sort::Bubble;
use Time::HiRes qw(time);
use rperltypesconv;

# [[[ OPERATIONS ]]]

#my integer $number_of_integers = 5_000;  # default
my integer $number_of_integers = 500;
if (defined $ARGV[0]) { $number_of_integers = string_to_integer($ARGV[0]); }  # user input, command-line argument

my $a = [reverse 0 .. $number_of_integers];
my number $time_start = time();

my $s = RPerl::Algorithm::Sort::Bubble::integer_bubblesort($a);

my number $time_total = time() - $time_start;
print Dumper($s);
print 'time total:   ' . $time_total . ' seconds' . "\n";
