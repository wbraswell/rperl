use strict; use warnings;
package RPerl::DataStructure::Array_cpp;
our $CPP_loaded = 0;
our $CPP_linked = 0;
our @ISA = ('RPerl::Class');
use RPerl::Class;  use RPerl;


package main;

BEGIN { print "[[[ BEGIN 'use Inline' STAGE for 'RPerl/DataStructure/Array.cpp' ]]]\n"x3; }

use Inline
(
#	CPP => 'RPerl/DataStructure/Array.cpp',
	CPP => '/tmp/RPerl-latest/lib/RPerl/DataStructure/Array.cpp',
	INC => '-I/usr/include/c++/4.5/ -I/usr/include/c++/4.5/i686-linux-gnu/',  # NEED FIX: remove hard-coded path
	CCFLAGS => '-Wno-deprecated',
	BUILD_NOISY => 1,
	CLEAN_AFTER_BUILD => 0,
	WARNINGS => 1,
	FILTERS => 'Preprocess',
);

print "[[[ END 'use Inline' STAGE for 'RPerl/DataStructure/Array.cpp' ]]]\n"x3;

$RPerl::DataStructure::Array_cpp::CPP_loaded = 1;


package RPerl::DataStructure::Array_cpp;
$CPP_linked = 1;
1;
#package RPerl::DataStructure::Array;
#our @ISA = ('main::CPP__RPerl__DataStructure__Array', 'RPerl::DataStructure');
#1;


#package RPerl::DataStructure::Array_cpp;
#1;