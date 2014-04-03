package RPerl::DataStructure::Array_cpp;
use strict;
use warnings;
our $VERSION = 0.003_000;

our $CPP_LOADED = 0;
our $CPP_LINKED = 0;
use parent ('RPerl::CompileUnit::Module::Class');
use RPerl::CompileUnit::Module::Class;  use RPerl;

our void__method $cpp_load = sub {
;
	if (defined($RPerl::DataStructure::Array_cpp::CPP_LOADED)) { RPerl::diag "in Array_cpp::cpp_load(), have \$RPerl::DataStructure::Array_cpp::CPP_LOADED = '" . $RPerl::DataStructure::Array_cpp::CPP_LOADED . "'\n"; }
		else { RPerl::diag "in Array_cpp::cpp_load(), have \$RPerl::DataStructure::Array_cpp::CPP_LOADED = 'UNDEF'\n"; }
	if (not(defined($RPerl::DataStructure::Array_cpp::CPP_LOADED)) or not($RPerl::DataStructure::Array_cpp::CPP_LOADED))
	{
		my $eval_string = <<"EOF";
package main;
BEGIN { RPerl::diag "[[[ BEGIN 'use Inline' STAGE for 'RPerl/DataStructure/Array.cpp' ]]]\n"x3; }
use RPerl::Inline;
use Inline (CPP => "$RPerl::INCLUDE_PATH/RPerl/DataStructure/Array.cpp", \@RPerl::Inline::ARGS);
RPerl::diag "[[[ END 'use Inline' STAGE for 'RPerl/DataStructure/Array.cpp' ]]]\n"x3;
1;
EOF
		RPerl::diag "in Array_cpp::cpp_load(), CPP not yet loaded, about to call eval() on \$eval_string =\n<<< BEGIN EVAL STRING>>>\n" . $eval_string . "<<< END EVAL STRING >>>\n";

		eval($eval_string);  ## no critic
		die($@) if ($@);
		
		$RPerl::DataStructure::Array_cpp::CPP_LOADED = 1;
	}
	else { RPerl::diag "in Array_cpp::cpp_load(), CPP already loaded, DOING NOTHING\n"; }
};

our void__method $cpp_link = sub {
;
#	if (defined($RPerl::DataStructure::Array_cpp::CPP_LINKED)) { RPerl::diag "in Array_cpp::cpp_link(), have \$RPerl::DataStructure::Array_cpp::CPP_LINKED = '" . $RPerl::DataStructure::Array_cpp::CPP_LINKED . "'\n"; }
#		else { RPerl::diag "in Array_cpp::cpp_link(), have \$RPerl::DataStructure::Array_cpp::CPP_LINKED = 'UNDEF'\n"; }
	if (not(defined($RPerl::DataStructure::Array_cpp::CPP_LINKED)) or not($RPerl::DataStructure::Array_cpp::CPP_LINKED))
	{
		my $eval_string = <<'EOF';
package RPerl::DataStructure::Array_cpp;
$CPP_LINKED = 1;
1;
#package RPerl::DataStructure::Array;
#our @ISA = ('main::CPP__RPerl__DataStructure__Array', 'RPerl::DataStructure');
1;
EOF
#		RPerl::diag "in Array_cpp::cpp_link(), CPP not yet linked, about to call eval() on \$eval_string =\n<<< BEGIN EVAL STRING>>>\n" . $eval_string . "<<< END EVAL STRING >>>\n";

		eval($eval_string);  ## no critic
		die($@) if ($@);
	}
#	else { RPerl::diag "in Array_cpp::cpp_link(), CPP already linked, DOING NOTHING\n"; }
};

package RPerl::DataStructure::Array_cpp;
1;
