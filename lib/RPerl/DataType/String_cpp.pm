use strict; use warnings;
package RPerl::DataType::String_cpp;
our $CPP_LOADED = 0;
our @ISA = ('RPerl::CompileUnit::Module::Class');
use RPerl::CompileUnit::Module::Class;  use RPerl;

our void__method $cpp_load = sub {
;	
	if (defined($RPerl::DataType::String_cpp::CPP_LOADED)) { RPerl::diag "in String_cpp::cpp_load(), have \$RPerl::DataType::String_cpp::CPP_LOADED = '" . $RPerl::DataType::String_cpp::CPP_LOADED . "'\n"; }
		else { RPerl::diag "in String_cpp::cpp_load(), have \$RPerl::DataType::String_cpp::CPP_LOADED = 'UNDEF'\n"; }
	if (not(defined($RPerl::DataType::String_cpp::CPP_LOADED)) or not($RPerl::DataType::String_cpp::CPP_LOADED))
	{
		my $eval_string = <<"EOF";
package main;
BEGIN { RPerl::diag "[[[ BEGIN 'use Inline' STAGE for 'RPerl/DataType/String.cpp' ]]]\n"x3; }
use RPerl::Inline;
use Inline (CPP => "$RPerl::INCLUDE_PATH/RPerl/DataType/String.cpp", \@RPerl::Inline::ARGS);
RPerl::diag "[[[ END 'use Inline' STAGE for 'RPerl/DataType/String.cpp' ]]]\n"x3;
1;
EOF
		RPerl::diag "in String_cpp::cpp_load(), CPP not yet loaded, about to call eval() on \$eval_string =\n<<< BEGIN EVAL STRING>>>\n" . $eval_string . "<<< END EVAL STRING >>>\n";

		eval($eval_string);  ## no critic
		die($@) if ($@);
		
		$RPerl::DataType::String_cpp::CPP_LOADED = 1;
	}
	else { RPerl::diag "in String_cpp::cpp_load(), CPP already loaded, DOING NOTHING\n"; }
};

1;
