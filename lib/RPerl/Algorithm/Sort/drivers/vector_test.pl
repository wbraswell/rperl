#!/usr/bin/perl
use strict;  use warnings;

use lib '/tmp/RPerl-latest/lib/CPAN';  # RPerl's MyConfig.pm  # NEED REMOVE hard-coded path
use MyConfig;

package main;
use Inline
(
	CPP => '/tmp/RPerl-latest/lib/RPerl/Algorithm/Sort/drivers/vector_test.cpp',
	INC => '-I/usr/include/c++/4.5/ -I/usr/include/c++/4.5/i686-linux-gnu/',  # NEED FIX: remove hard-coded path
#    TYPEMAPS => '/tmp/RPerl-latest/lib/RPerl/Algorithm/Sort/drivers/vector_test.typemap',
	CCFLAGS => '-Wno-deprecated',
	BUILD_NOISY => 1,
	CLEAN_AFTER_BUILD => 0,
	WARNINGS => 1,
#	FILTERS => 'Preprocess',
);

main::int_AV_to_int_vector([5, 4, 3, 2, 1, 0]);
#main::int_AV_to_int_vector([0..9]);
#main::string_AV_to_string_vector([qw(foo bar baz)]);
