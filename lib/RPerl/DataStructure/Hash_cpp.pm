use strict; use warnings;
package RPerl::DataStructure::Hash_cpp;
our $CPP_LOADED = 0;
our $CPP_LINKED = 0;
our @ISA = ('RPerl::Class');
use RPerl::Class;  use RPerl;

our void__method $cpp_load = sub {
;	
	if (defined($RPerl::DataStructure::Hash_cpp::CPP_LOADED)) { print "in Hash_cpp::cpp_load(), have \$RPerl::DataStructure::Hash_cpp::CPP_LOADED = '" . $RPerl::DataStructure::Hash_cpp::CPP_LOADED . "'\n"; }
		else { print "in Hash_cpp::cpp_load(), have \$RPerl::DataStructure::Hash_cpp::CPP_LOADED = 'UNDEF'\n"; }
	if (not(defined($RPerl::DataStructure::Hash_cpp::CPP_LOADED)) or not($RPerl::DataStructure::Hash_cpp::CPP_LOADED))
	{
		my $eval_string = <<"EOF";
package main;
BEGIN { print "[[[ BEGIN 'use Inline' STAGE for 'RPerl/DataStructure/Hash.cpp' ]]]\n"x3; }
use Inline
(
	CPP => '$RPerl::INCLUDE_PATH/RPerl/DataStructure/Hash.cpp',
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
		'#include <sstream>',
		'#include <limits>',
		'#include <vector>',
		'#include <unordered_map>',  # DEV NOTE: unordered_map may require '-std=c++0x' in CCFLAGS above
	],
);
print "[[[ END 'use Inline' STAGE for 'RPerl/DataStructure/Hash.cpp' ]]]\n"x3;
1;
EOF
		print "in Hash_cpp::cpp_load(), CPP not yet loaded, about to call eval() on \$eval_string =\n<<< BEGIN EVAL STRING>>>\n" . $eval_string . "<<< END EVAL STRING >>>\n";

		eval($eval_string);  ## no critic
		die($@) if ($@);
		
		$RPerl::DataStructure::Hash_cpp::CPP_LOADED = 1;
	}
	else { print "in Hash_cpp::cpp_load(), CPP already loaded, DOING NOTHING\n"; }
};

our void__method $cpp_link = sub {
;
#	if (defined($RPerl::DataStructure::Hash_cpp::CPP_LINKED)) { print "in Hash_cpp::cpp_link(), have \$RPerl::DataStructure::Hash_cpp::CPP_LINKED = '" . $RPerl::DataStructure::Hash_cpp::CPP_LINKED . "'\n"; }
#		else { print "in Hash_cpp::cpp_link(), have \$RPerl::DataStructure::Hash_cpp::CPP_LINKED = 'UNDEF'\n"; }
	if (not(defined($RPerl::DataStructure::Hash_cpp::CPP_LINKED)) or not($RPerl::DataStructure::Hash_cpp::CPP_LINKED))
	{
		my $eval_string = <<'EOF';
package RPerl::DataStructure::Hash_cpp;
$CPP_LINKED = 1;
1;
#package RPerl::DataStructure::Hash;
#our @ISA = ('main::CPP__RPerl__DataStructure__Hash', 'RPerl::DataStructure');
1;
EOF
#		print "in Hash_cpp::cpp_link(), CPP not yet linked, about to call eval() on \$eval_string =\n<<< BEGIN EVAL STRING>>>\n" . $eval_string . "<<< END EVAL STRING >>>\n";

		eval($eval_string);  ## no critic
		die($@) if ($@);
	}
#	else { print "in Hash_cpp::cpp_link(), CPP already linked, DOING NOTHING\n"; }
};

package RPerl::DataStructure::Hash_cpp;
1;
