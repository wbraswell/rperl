package RPerl::HelperFunctions_cpp;
use strict;
use warnings;
our $VERSION = 0.001_001;
use Carp;

our $CPP_LOADED = 0;
#our @ISA = ('RPerl::CompileUnit::Module::Class');  # DEV NOTE: need to use HelperFunctions in RPerl::DataStructure::Array for type checking SvIOKp() etc; remove dependency on RPerl void__method type so HelperFunctions can be loaded by RPerl type system
#use RPerl::CompileUnit::Module::Class;  use RPerl;  # DEV NOTE: remove dependency on RPerl

#our void__method $cpp_load = sub {  # DEV NOTE: remove dependency on RPerl
sub cpp_load {
;	
#    croak("in HelperFunctions_cpp::cpp_load(), croaking");
	if (defined($RPerl::HelperFunctions_cpp::CPP_LOADED)) { RPerl::diag "in HelperFunctions_cpp::cpp_load(), have \$RPerl::HelperFunctions_cpp::CPP_LOADED = '" . $RPerl::HelperFunctions_cpp::CPP_LOADED . "'\n"; }
		else { RPerl::diag "in HelperFunctions_cpp::cpp_load(), have \$RPerl::HelperFunctions_cpp::CPP_LOADED = 'UNDEF'\n"; }
	if (not(defined($RPerl::HelperFunctions_cpp::CPP_LOADED)) or not($RPerl::HelperFunctions_cpp::CPP_LOADED))
	{
#BEGIN { RPerl::diag "[[[ BEGIN 'use Inline' STAGE for 'RPerl/HelperFunctions.cpp' ]]]\n"x3; }
		my $eval_string = <<"EOF";
package main;
use RPerl::Inline;
use Inline (CPP => "$RPerl::INCLUDE_PATH/RPerl/HelperFunctions.cpp", \@RPerl::Inline::ARGS);
1;
EOF
#RPerl::diag "[[[ END 'use Inline' STAGE for 'RPerl/HelperFunctions.cpp' ]]]\n"x3;

#		RPerl::diag "in HelperFunctions_cpp::cpp_load(), CPP not yet loaded, about to call eval() on \$eval_string =\n<<< BEGIN EVAL STRING>>>\n" . $eval_string . "<<< END EVAL STRING >>>\n";

		eval($eval_string);  ## no critic
		croak($@) if ($@);
		
		$RPerl::HelperFunctions_cpp::CPP_LOADED = 1;
	}
	else { RPerl::diag "in HelperFunctions_cpp::cpp_load(), CPP already loaded, DOING NOTHING\n"; }
#};
}

1;
