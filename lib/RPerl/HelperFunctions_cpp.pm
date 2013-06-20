use strict; use warnings;
package RPerl::HelperFunctions_cpp;
our @ISA = ('RPerl::Class');
use RPerl::Class;  use RPerl;

our void__method $cpp_load = sub {
;	
	print "in HelperFunctions_cpp::cpp_load(), have defined(\$RPerl::HelperFunctions::CPP_loaded) = " . defined($RPerl::HelperFunctions::CPP_loaded) . "\n";
	if (not(defined($RPerl::HelperFunctions::CPP_loaded)))
	{
		my $eval_string = <<'EOF';
package main;
use Inline
(
#        CPP => './HelperFunctions.cpp',
#        CPP => 'RPerl/HelperFunctions.cpp',
        CPP => '/home/wbraswell/austin_perl_mongers/compiler/RPerl/RPerl-latest/lib/RPerl/HelperFunctions.cpp',
        CCFLAGS => '-Wno-deprecated',  # old-style-header warnings, suppress
        BUILD_NOISY => 1,
        CLEAN_AFTER_BUILD => 0,
        WARNINGS => 1,
);
$RPerl::HelperFunctions::CPP_loaded = 1;
1;
EOF
		print "in HelperFunctions_cpp::cpp_load(), CPP not yet loaded, about to call eval() on \$eval_string =\n<<< BEGIN EVAL STRING>>>\n" . $eval_string . "<<< END EVAL STRING >>>\n";

		eval($eval_string);  ## no critic
		die(@_) if (@_);
	}
	else { print "in HelperFunctions_cpp::cpp_load(), CPP already loaded, DOING NOTHING\n"; }
};

our void__method $cpp_link = sub {
;
	print "in HelperFunctions_cpp::cpp_link(), have defined(\$RPerl::HelperFunctions::CPP_linked) = " . defined($RPerl::HelperFunctions::CPP_linked) . "\n";
	if (not(defined($RPerl::HelperFunctions::CPP_linked)))
	{
		my $eval_string = <<'EOF';
package RPerl::HelperFunctions;
our @ISA = ('RPerl');  # HelperFunctions is not a class, so @ISA does not contain 'RPerl::Class';  HelperFunctions_cpp is a class because it needs typed methods
our $CPP_linked = 1;
1;
EOF
		print "in HelperFunctions_cpp::cpp_link(), CPP not yet linked, about to call eval() on \$eval_string =\n<<< BEGIN EVAL STRING>>>\n" . $eval_string . "<<< END EVAL STRING >>>\n";

		eval($eval_string);  ## no critic
		die(@_) if (@_);
	}
	else { print "in HelperFunctions_cpp::cpp_link(), CPP already linked, DOING NOTHING\n"; }
};

package RPerl::HelperFunctions_cpp;
1;