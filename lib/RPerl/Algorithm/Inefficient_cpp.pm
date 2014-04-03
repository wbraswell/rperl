use strict; use warnings;
package RPerl::Algorithm::Inefficient_cpp;
our $CPP_LOADED = 0;
our $CPP_LINKED = 0;
our @ISA = ('RPerl::CompileUnit::Module::Class');
use RPerl::CompileUnit::Module::Class;  use RPerl;

use RPerl::HelperFunctions_cpp;
use RPerl::Algorithm_cpp;

our void__method $cpp_load = sub {
;	
	if (defined($RPerl::Algorithm::Inefficient_cpp::CPP_LOADED)) { RPerl::diag "in Inefficient_cpp::cpp_load(), have \$RPerl::Algorithm::Inefficient_cpp::CPP_LOADED = '" . $RPerl::Algorithm::Inefficient_cpp::CPP_LOADED . "'\n"; }
		else { RPerl::diag "in Inefficient_cpp::cpp_load(), have \$RPerl::Algorithm::Inefficient_cpp::CPP_LOADED = 'UNDEF'\n"; }
	if (not(defined($RPerl::Algorithm::Inefficient_cpp::CPP_LOADED)) or not($RPerl::Algorithm::Inefficient_cpp::CPP_LOADED))
	{
		$RPerl::HelperFunctions_cpp::CPP_LOADED = 1;  # HelperFunctions.cpp loaded by C++ #include in Inefficient.h 

		####use RPerl::Algorithm;
		$RPerl::Algorithm_cpp::CPP_LOADED = 1;  # Algorithm.cpp loaded by C++ #include in Inefficient.h
	
		my $eval_string = <<"EOF";
package main;
use RPerl::Inline;
BEGIN { RPerl::diag "[[[ BEGIN 'use Inline' STAGE for 'RPerl/Algorithm/Inefficient.cpp' ]]]\n"x3; }
use Inline (CPP => "$RPerl::INCLUDE_PATH/RPerl/Algorithm/Inefficient.cpp", \@RPerl::Inline::InlineArgs);
RPerl::diag "[[[ END 'use Inline' STAGE for 'RPerl/Algorithm/Inefficient.cpp' ]]]\n"x3;
1;
EOF
		RPerl::diag "in Inefficient_cpp::cpp_load(), CPP not yet loaded, about to call eval() on \$eval_string =\n<<< BEGIN EVAL STRING>>>\n" . $eval_string . "<<< END EVAL STRING >>>\n";

		eval($eval_string);  ## no critic
		die($@) if ($@);
		
		RPerl::HelperFunctions_cpp::cpp_link();
		RPerl::Algorithm_cpp::cpp_link();
		$RPerl::Algorithm::Inefficient_cpp::CPP_LOADED = 1;
	}
	else { RPerl::diag "in Inefficient_cpp::cpp_load(), CPP already loaded, DOING NOTHING\n"; }
};

our void__method $cpp_link = sub {
;
#	if (defined($RPerl::Algorithm::Inefficient_cpp::CPP_LINKED)) { RPerl::diag "in Inefficient_cpp::cpp_link(), have \$RPerl::Algorithm::Inefficient_cpp::CPP_LINKED = '" . $RPerl::Algorithm::Inefficient_cpp::CPP_LINKED . "'\n"; }
#		else { RPerl::diag "in Inefficient_cpp::cpp_link(), have \$RPerl::Algorithm::Inefficient_cpp::CPP_LINKED = 'UNDEF'\n"; }
	if (not(defined($RPerl::Algorithm::Inefficient_cpp::CPP_LINKED)) or not($RPerl::Algorithm::Inefficient_cpp::CPP_LINKED))
	{
		my $eval_string = <<'EOF';
package RPerl::Algorithm::Inefficient_cpp;
$CPP_LINKED = 1;
1;
package RPerl::Algorithm::Inefficient;
our @ISA = ('main::CPP__RPerl__Algorithm__Inefficient', 'RPerl::Algorithm');
1;
EOF
#		RPerl::diag "in Inefficient_cpp::cpp_link(), CPP not yet linked, about to call eval() on \$eval_string =\n<<< BEGIN EVAL STRING>>>\n" . $eval_string . "<<< END EVAL STRING >>>\n";

		eval($eval_string);  ## no critic
		die($@) if ($@);
	}
#	else { RPerl::diag "in Inefficient_cpp::cpp_link(), CPP already linked, DOING NOTHING\n"; }
};

package RPerl::Algorithm::Inefficient_cpp;
1;
