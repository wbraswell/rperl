use strict; use warnings;
package RPerl::DataType::String_cpp;
our $CPP_LOADED = 0;
our $CPP_LINKED = 0;
our @ISA = ('RPerl::CompileUnit::Module::Class');
use RPerl::CompileUnit::Module::Class;  use RPerl;

our void__method $cpp_load = sub {
;	
	if (defined($RPerl::DataType::String_cpp::CPP_LOADED)) { print STDERR "in String_cpp::cpp_load(), have \$RPerl::DataType::String_cpp::CPP_LOADED = '" . $RPerl::DataType::String_cpp::CPP_LOADED . "'\n"; }
		else { print STDERR "in String_cpp::cpp_load(), have \$RPerl::DataType::String_cpp::CPP_LOADED = 'UNDEF'\n"; }
	if (not(defined($RPerl::DataType::String_cpp::CPP_LOADED)) or not($RPerl::DataType::String_cpp::CPP_LOADED))
	{
		my $eval_string = <<"EOF";
package main;
BEGIN { print STDERR "[[[ BEGIN 'use Inline' STAGE for 'RPerl/DataType/String.cpp' ]]]\n"x3; }
use RPerl::Inline;
use Inline (CPP => "$RPerl::INCLUDE_PATH/RPerl/DataType/String.cpp", \@RPerl::Inline::ARGS);
print STDERR "[[[ END 'use Inline' STAGE for 'RPerl/DataType/String.cpp' ]]]\n"x3;
1;
EOF
		print STDERR "in String_cpp::cpp_load(), CPP not yet loaded, about to call eval() on \$eval_string =\n<<< BEGIN EVAL STRING>>>\n" . $eval_string . "<<< END EVAL STRING >>>\n";

		eval($eval_string);  ## no critic
		die($@) if ($@);
		
		$RPerl::DataType::String_cpp::CPP_LOADED = 1;
	}
	else { print STDERR "in String_cpp::cpp_load(), CPP already loaded, DOING NOTHING\n"; }
};

our void__method $cpp_link = sub {
;
#	if (defined($RPerl::DataType::String_cpp::CPP_LINKED)) { print STDERR "in String_cpp::cpp_link(), have \$RPerl::DataType::String_cpp::CPP_LINKED = '" . $RPerl::DataType::String_cpp::CPP_LINKED . "'\n"; }
#		else { print STDERR "in String_cpp::cpp_link(), have \$RPerl::DataType::String_cpp::CPP_LINKED = 'UNDEF'\n"; }
	if (not(defined($RPerl::DataType::String_cpp::CPP_LINKED)) or not($RPerl::DataType::String_cpp::CPP_LINKED))
	{
		my $eval_string = <<'EOF';
package RPerl::DataType::String_cpp;
$CPP_LINKED = 1;
1;
#package RPerl::DataType::String;
#our @ISA = ('main::CPP__RPerl__DataType__String', 'RPerl::DataType');
1;
EOF
#		print STDERR "in String_cpp::cpp_link(), CPP not yet linked, about to call eval() on \$eval_string =\n<<< BEGIN EVAL STRING>>>\n" . $eval_string . "<<< END EVAL STRING >>>\n";

		eval($eval_string);  ## no critic
		die($@) if ($@);
	}
#	else { print STDERR "in String_cpp::cpp_link(), CPP already linked, DOING NOTHING\n"; }
};

package RPerl::DataType::String_cpp;
1;
