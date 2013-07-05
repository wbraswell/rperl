use strict; use warnings;
package RPerl::Algorithm_cpp;
our $CPP_loaded = 0;
our $CPP_linked = 0;
our @ISA = ('RPerl::Class');
use RPerl::Class;  use RPerl;

use RPerl::HelperFunctions_cpp;

our void__method $cpp_load = sub {
;	
	if (defined($RPerl::Algorithm_cpp::CPP_loaded)) { print "in Algorithm_cpp::cpp_load(), have \$RPerl::Algorithm_cpp::CPP_loaded = '" . $RPerl::Algorithm_cpp::CPP_loaded . "'\n"; }
		else { print "in Algorithm_cpp::cpp_load(), have \$RPerl::Algorithm_cpp::CPP_loaded = 'UNDEF'\n"; }
	if (not(defined($RPerl::Algorithm_cpp::CPP_loaded)) or not($RPerl::Algorithm_cpp::CPP_loaded))
	{
		$RPerl::HelperFunctions_cpp::CPP_loaded = 1;  # HelperFunctions.c loaded by C++ #include in Algorithm.h 
		
		my $eval_string = <<'EOF';
package main;
BEGIN { print "[[[ BEGIN 'use Inline' STAGE for 'RPerl/Algorithm.cpp' ]]]\n"x3; }
use Inline
(
	CPP => '$RPerl::INCLUDE_PATH/RPerl/Algorithm.cpp',
	TYPEMAPS => '$RPerl::INCLUDE_PATH/typemap.rperl',
	CCFLAGS => '-Wno-deprecated -std=c++0x',
	INC => '-I$RPerl::INCLUDE_PATH',
	BUILD_NOISY => 1,
	CLEAN_AFTER_BUILD => 0,
	WARNINGS => 1,
	FILTERS => 'Preprocess',
	AUTO_INCLUDE => # DEV NOTE: include non-RPerl files using AUTO_INCLUDE so they are not parsed by the 'Preprocess' filter
	[
		'#include <iostream>',
		'#include <string>',
		'#include <vector>',
		'#include <unordered_map>',  # DEV NOTE: unordered_map may require '-std=c++0x' in CCFLAGS above
	],
);
print "[[[ END 'use Inline' STAGE for 'RPerl/Algorithm.cpp' ]]]\n"x3;
1;
EOF
		print "in Algorithm_cpp::cpp_load(), CPP not yet loaded, about to call eval() on \$eval_string =\n<<< BEGIN EVAL STRING>>>\n" . $eval_string . "<<< END EVAL STRING >>>\n";

		eval($eval_string);  ## no critic
		die(@_) if (@_);
		
		RPerl::HelperFunctions_cpp::cpp_link();
		$RPerl::Algorithm_cpp::CPP_loaded = 1;
	}
	else { print "in Algorithm_cpp::cpp_load(), CPP already loaded, DOING NOTHING\n"; }
};

our void__method $cpp_link = sub {
;
#	if (defined($RPerl::Algorithm_cpp::CPP_linked)) { print "in Algorithm_cpp::cpp_link(), have \$RPerl::Algorithm_cpp::CPP_linked = '" . $RPerl::Algorithm_cpp::CPP_linked . "'\n"; }
#		else { print "in Algorithm_cpp::cpp_link(), have \$RPerl::Algorithm_cpp::CPP_linked = 'UNDEF'\n"; }
	if (not(defined($RPerl::Algorithm_cpp::CPP_linked)) or not($RPerl::Algorithm_cpp::CPP_linked))
	{
		my $eval_string = <<'EOF';
package RPerl::Algorithm_cpp;
$CPP_linked = 1;
1;
package RPerl::Algorithm;
our @ISA = ('main::CPP__RPerl__Algorithm', 'RPerl::Class');
1;
EOF
#		print "in Algorithm_cpp::cpp_link(), CPP not yet linked, about to call eval() on \$eval_string =\n<<< BEGIN EVAL STRING>>>\n" . $eval_string . "<<< END EVAL STRING >>>\n";

		eval($eval_string);  ## no critic
		die(@_) if (@_);
	}
#	else { print "in Algorithm_cpp::cpp_link(), CPP already linked, DOING NOTHING\n"; }
};

package RPerl::Algorithm_cpp;
1;