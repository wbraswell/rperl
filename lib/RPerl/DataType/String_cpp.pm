use strict; use warnings;
package RPerl::DataType::String_cpp;
our $CPP_loaded = 0;
our $CPP_linked = 0;
our @ISA = ('RPerl::Class');
use RPerl::Class;  use RPerl;

our void__method $cpp_load = sub {
;	
	if (defined($RPerl::DataType::String_cpp::CPP_loaded)) { print "in String_cpp::cpp_load(), have \$RPerl::DataType::String_cpp::CPP_loaded = '" . $RPerl::DataType::String_cpp::CPP_loaded . "'\n"; }
		else { print "in String_cpp::cpp_load(), have \$RPerl::DataType::String_cpp::CPP_loaded = 'UNDEF'\n"; }
	if (not(defined($RPerl::DataType::String_cpp::CPP_loaded)) or not($RPerl::DataType::String_cpp::CPP_loaded))
	{
		my $eval_string = <<"EOF";
package main;
BEGIN { print "[[[ BEGIN 'use Inline' STAGE for 'RPerl/DataType/String.cpp' ]]]\n"x3; }
use Inline
(
	CPP => '$RPerl::INCLUDE_PATH/RPerl/DataType/String.cpp',
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
print "[[[ END 'use Inline' STAGE for 'RPerl/DataType/String.cpp' ]]]\n"x3;
1;
EOF
		print "in String_cpp::cpp_load(), CPP not yet loaded, about to call eval() on \$eval_string =\n<<< BEGIN EVAL STRING>>>\n" . $eval_string . "<<< END EVAL STRING >>>\n";

		eval($eval_string);  ## no critic
		die(@_) if (@_);
		
		$RPerl::DataType::String_cpp::CPP_loaded = 1;
	}
	else { print "in String_cpp::cpp_load(), CPP already loaded, DOING NOTHING\n"; }
};

our void__method $cpp_link = sub {
;
#	if (defined($RPerl::DataType::String_cpp::CPP_linked)) { print "in String_cpp::cpp_link(), have \$RPerl::DataType::String_cpp::CPP_linked = '" . $RPerl::DataType::String_cpp::CPP_linked . "'\n"; }
#		else { print "in String_cpp::cpp_link(), have \$RPerl::DataType::String_cpp::CPP_linked = 'UNDEF'\n"; }
	if (not(defined($RPerl::DataType::String_cpp::CPP_linked)) or not($RPerl::DataType::String_cpp::CPP_linked))
	{
		my $eval_string = <<'EOF';
package RPerl::DataType::String_cpp;
$CPP_linked = 1;
1;
#package RPerl::DataType::String;
#our @ISA = ('main::CPP__RPerl__DataType__String', 'RPerl::DataType');
1;
EOF
#		print "in String_cpp::cpp_link(), CPP not yet linked, about to call eval() on \$eval_string =\n<<< BEGIN EVAL STRING>>>\n" . $eval_string . "<<< END EVAL STRING >>>\n";

		eval($eval_string);  ## no critic
		die(@_) if (@_);
	}
#	else { print "in String_cpp::cpp_link(), CPP already linked, DOING NOTHING\n"; }
};

package RPerl::DataType::String_cpp;
1;
