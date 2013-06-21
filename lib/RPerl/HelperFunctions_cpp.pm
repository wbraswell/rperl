use strict; use warnings;
package RPerl::HelperFunctions_cpp;
our $CPP_loaded = 0;
our $CPP_linked = 0;
our @ISA = ('RPerl::Class');
use RPerl::Class;  use RPerl;

our void__method $cpp_load = sub {
;	
	if (defined($RPerl::HelperFunctions_cpp::CPP_loaded)) { print "in HelperFunctions_cpp::cpp_load(), have \$RPerl::HelperFunctions_cpp::CPP_loaded = '" . $RPerl::HelperFunctions_cpp::CPP_loaded . "'\n"; }
		else { print "in HelperFunctions_cpp::cpp_load(), have \$RPerl::HelperFunctions_cpp::CPP_loaded = 'UNDEF'\n"; }
	if (not(defined($RPerl::HelperFunctions_cpp::CPP_loaded)) or not($RPerl::HelperFunctions_cpp::CPP_loaded))
	{
		my $eval_string = <<'EOF';
package main;
BEGIN { print "[[[ BEGIN 'use Inline' STAGE for 'RPerl/HelperFunctions.cpp' ]]]\n"x3; }
use Inline
(
#	CPP => 'RPerl/HelperFunctions.cpp',
	CPP => '/tmp/RPerl-latest/lib/RPerl/HelperFunctions.cpp',
	CCFLAGS => '-Wno-deprecated',
	BUILD_NOISY => 1,
	CLEAN_AFTER_BUILD => 0,
	WARNINGS => 1,
	FILTERS => 'Preprocess',
);
print "[[[ END 'use Inline' STAGE for 'RPerl/HelperFunctions.cpp' ]]]\n"x3;
1;
EOF
		print "in HelperFunctions_cpp::cpp_load(), CPP not yet loaded, about to call eval() on \$eval_string =\n<<< BEGIN EVAL STRING>>>\n" . $eval_string . "<<< END EVAL STRING >>>\n";

		eval($eval_string);  ## no critic
		die(@_) if (@_);
		
		$RPerl::HelperFunctions_cpp::CPP_loaded = 1;
	}
	else { print "in HelperFunctions_cpp::cpp_load(), CPP already loaded, DOING NOTHING\n"; }
};

our void__method $cpp_link = sub {
;
#	if (defined($RPerl::HelperFunctions_cpp::CPP_linked)) { print "in HelperFunctions_cpp::cpp_link(), have \$RPerl::HelperFunctions_cpp::CPP_linked = '" . $RPerl::HelperFunctions_cpp::CPP_linked . "'\n"; }
#		else { print "in HelperFunctions_cpp::cpp_link(), have \$RPerl::HelperFunctions_cpp::CPP_linked = 'UNDEF'\n"; }
	if (not(defined($RPerl::HelperFunctions_cpp::CPP_linked)) or not($RPerl::HelperFunctions_cpp::CPP_linked))
	{
		my $eval_string = <<'EOF';
package RPerl::HelperFunctions_cpp;
$CPP_linked = 1;
1;
package RPerl::HelperFunctions;
our @ISA = ('RPerl');  # HelperFunctions is not a class, so @ISA does not contain 'main::CPP__HelperFunctions' or 'RPerl::Class';  HelperFunctions_cpp is a class because it needs typed methods
1;
EOF
#		print "in HelperFunctions_cpp::cpp_link(), CPP not yet linked, about to call eval() on \$eval_string =\n<<< BEGIN EVAL STRING>>>\n" . $eval_string . "<<< END EVAL STRING >>>\n";

		eval($eval_string);  ## no critic
		die(@_) if (@_);
	}
#	else { print "in HelperFunctions_cpp::cpp_link(), CPP already linked, DOING NOTHING\n"; }
};

package RPerl::HelperFunctions_cpp;
1;