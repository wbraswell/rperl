use strict; use warnings;
package RPerl::Algorithm::Sort_cpp;
our @ISA = ('RPerl::Class');
use RPerl::Class;  use RPerl;

our void__method $cpp_load = sub {
;	
	print "in Sort_cpp::cpp_load(), have defined(\$RPerl::Algorithm::Sort::CPP_loaded) = " . defined($RPerl::Algorithm::Sort::CPP_loaded) . "\n";
	if (not(defined($RPerl::Algorithm::Sort::CPP_loaded)))
	{
		my $eval_string = <<'EOF';
use RPerl::HelperFunctions_cpp;
RPerl::HelperFunctions_cpp::cpp_load();
package main;
use Inline
(
#	CPP => './Sort.cpp',
#	CPP => 'RPerl/Algorithm/Sort.cpp',
	CPP => '/home/wbraswell/austin_perl_mongers/compiler/RPerl/RPerl-latest/lib/RPerl/Algorithm/Sort.cpp',
	CCFLAGS => '-Wno-deprecated',  # old-style-header warnings, suppress
	BUILD_NOISY => 1,
	CLEAN_AFTER_BUILD => 0,
	WARNINGS => 1,
);
RPerl::HelperFunctions_cpp::cpp_link();
$RPerl::Algorithm::Sort::CPP_loaded = 1;
1;
EOF
		print "in Sort_cpp::cpp_load(), CPP not yet loaded, about to call eval() on \$eval_string =\n<<< BEGIN EVAL STRING>>>\n" . $eval_string . "<<< END EVAL STRING >>>\n";

		eval($eval_string);  ## no critic
		die(@_) if (@_);
	}
	else { print "in Sort_cpp::cpp_load(), CPP already loaded, DOING NOTHING\n"; }
};

our void__method $cpp_link = sub {
;
	print "in Sort_cpp::cpp_link(), have defined(\$RPerl::Algorithm::Sort::CPP_linked) = " . defined($RPerl::Algorithm::Sort::CPP_linked) . "\n";
	if (not(defined($RPerl::Algorithm::Sort::CPP_linked)))
	{
		my $eval_string = <<'EOF';
package RPerl::Algorithm::Sort;
our @ISA = ('CPP__RPerl__Algorithm__Sort', 'RPerl::Algorithm');
our $CPP_linked = 1;
1;
EOF
		print "in Sort_cpp::cpp_link(), CPP not yet linked, about to call eval() on \$eval_string =\n<<< BEGIN EVAL STRING>>>\n" . $eval_string . "<<< END EVAL STRING >>>\n";

		eval($eval_string);  ## no critic
		die(@_) if (@_);
	}
	else { print "in Sort_cpp::cpp_link(), CPP already linked, DOING NOTHING\n"; }
};

package RPerl::Algorithm::Sort_cpp;
1;