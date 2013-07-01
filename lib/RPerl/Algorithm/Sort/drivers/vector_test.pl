#!/usr/bin/perl
use strict;  use warnings;
use Data::Dumper;

 # NEED REMOVE hard-coded path
BEGIN { package main;  our $RPERL_INCLUDE_PATH = '/tmp/RPerl-latest/lib'; }

use lib $main::RPERL_INCLUDE_PATH . '/CPAN/';  # RPerl's MyConfig.pm 
use MyConfig;

package main;
use Inline
(
	CPP => "$main::RPERL_INCLUDE_PATH/RPerl/Algorithm/Sort/drivers/vector_test.cpp",
	CCFLAGS => '-Wno-deprecated -std=c++0x',
	INC => '-I$RPerl::INCLUDE_PATH',
	BUILD_NOISY => 1,
	CLEAN_AFTER_BUILD => 0,
	WARNINGS => 1,
	FILTERS => 'Preprocess',
	AUTO_INCLUDE => # DEV NOTE: include non-RPerl files using AUTO_INCLUDE so they are not parsed by the 'Preprocess' filter
	[
#		'#include <string>',
		'#include <vector>',
#		'#include <unordered_map>',  # DEV NOTE: unordered_map may require '-std=c++0x' in CCFLAGS above
	],
);

#XS_unpack_int__array_ref([5, 4, 3, 2, 1, 0]);
#XS_unpack_int__array_ref([0..9]);
print___int__array_ref([5, 4, 3, 2, 1, 0]);

my $retval = generate__int__array_ref(5);

print "have \$retval = \n" . Dumper($retval) . "\n";