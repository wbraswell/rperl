use strict; use warnings;
package RPerl::Algorithm::Sort::Bubble_cpp;
our $CPP_loaded = 0;
our $CPP_linked = 0;
our @ISA = ('RPerl::Class');
use RPerl::Class;  use RPerl;

use RPerl::HelperFunctions_cpp;
use RPerl::Algorithm::Sort_cpp;

our void__method $cpp_load = sub {
;	
#	if (defined($RPerl::Algorithm::Sort::Bubble_cpp::CPP_loaded)) { print "in Bubble_cpp::cpp_load(), have \$RPerl::Algorithm::Sort::Bubble_cpp::CPP_loaded = '" . $RPerl::Algorithm::Sort::Bubble_cpp::CPP_loaded . "'\n"; }
#		else { print "in Bubble_cpp::cpp_load(), have \$RPerl::Algorithm::Sort::Bubble_cpp::CPP_loaded = 'UNDEF'\n"; }
	if (not(defined($RPerl::Algorithm::Sort::Bubble_cpp::CPP_loaded)) or not($RPerl::Algorithm::Sort::Bubble_cpp::CPP_loaded))
	{
		$RPerl::HelperFunctions_cpp::CPP_loaded = 1;  # HelperFunctions.cpp loaded by C++ #include in Bubble.cpp 

# NEED FIX: Bubble.cpp should not load HelperFunctions.cpp, only HelperFunctions.h?  where then would we load HelperFunctions.cpp?

		####use RPerl::Algorithm::Sort;
		$RPerl::Algorithm::Sort_cpp::CPP_loaded = 1;  # Sort.cpp loaded by C++ #include in Bubble.cpp 

		my $eval_string = <<'EOF';
package main;
BEGIN { print "[[[ BEGIN 'use Inline' STAGE for 'RPerl/Algorithm/Sort/Bubble.cpp' ]]]\n"x3; }
use Inline
(
#	CPP => 'RPerl/Algorithm/Sort/Bubble.cpp',
	CPP => '/tmp/RPerl-latest/lib/RPerl/Algorithm/Sort/Bubble.cpp',
	CCFLAGS => '-Wno-deprecated',
	BUILD_NOISY => 1,
	CLEAN_AFTER_BUILD => 0,
	WARNINGS => 1,
	FILTERS => 'Preprocess',
#	'AUTO_INCLUDE' =>
#	[
#	    '#include "/tmp/RPerl-latest/lib/RPerl/HelperFunctions.c"',
#	],
);
print "[[[ END 'use Inline' STAGE for 'RPerl/Algorithm/Sort/Bubble.cpp' ]]]\n"x3;
1;
EOF

#		print "in Bubble_cpp::cpp_load(), CPP not yet loaded, about to call eval() on \$eval_string =\n<<< BEGIN EVAL STRING>>>\n" . $eval_string . "<<< END EVAL STRING >>>\n";

		eval($eval_string);  ## no critic
		die(@_) if (@_);
		
		RPerl::HelperFunctions_cpp::cpp_link();
		RPerl::Algorithm::Sort_cpp::cpp_link();
		$RPerl::Algorithm::Sort::Bubble_cpp::CPP_loaded = 1;
	}
#	else { print "in Bubble_cpp::cpp_load(), CPP already loaded, DOING NOTHING\n"; }
};

our void__method $cpp_link = sub {
;
#	if (defined($RPerl::Algorithm::Sort::Bubble_cpp::CPP_linked)) { print "in Bubble_cpp::cpp_link(), have \$RPerl::Algorithm::Sort::Bubble_cpp::CPP_linked = '" . $RPerl::Algorithm::Sort::Bubble_cpp::CPP_linked . "'\n"; }
#		else { print "in Bubble_cpp::cpp_link(), have \$RPerl::Algorithm::Sort::Bubble_cpp::CPP_linked = 'UNDEF'\n"; }
	if (not(defined($RPerl::Algorithm::Sort::Bubble_cpp::CPP_linked)) or not($RPerl::Algorithm::Sort::Bubble_cpp::CPP_linked))
	{
		my $eval_string = <<'EOF';
package RPerl::Algorithm::Sort::Bubble_cpp;
$CPP_linked = 1;
1;
package RPerl::Algorithm::Sort::Bubble;
our @ISA = ('main::CPP__RPerl__Algorithm__Sort__Bubble', 'RPerl::Algorithm::Sort');
1;
EOF
#		print "in Bubble_cpp::cpp_link(), CPP not yet linked, about to call eval() on \$eval_string =\n<<< BEGIN EVAL STRING>>>\n" . $eval_string . "<<< END EVAL STRING >>>\n";

		eval($eval_string);  ## no critic
		die(@_) if (@_);
	}
#	else { print "in Bubble_cpp::cpp_link(), CPP already linked, DOING NOTHING\n"; }
};


=DEBUG
use Data::Dumper;
#print "in Bubble_cpp->cpp_link(), after use Inline(...), have \%INC =\n" . Dumper(\%INC) . "\n";
no strict;
foreach my $entry ( keys %main:: )
{
	if (defined(${$entry})) { print "in Bubble_cpp->cpp_link(), after use Inline(...), symtab entry '$entry' is defined scalar\n"; }
    elsif (defined(@{$entry})) { print "in Bubble_cpp->cpp_link(), after use Inline(...), symtab entry '$entry' is defined array\n"; }
    elsif (defined(%{$entry})) { print "in Bubble_cpp->cpp_link(), after use Inline(...), symtab entry '$entry' is defined hash\n"; }
    elsif (defined(&{$entry})) { print "in Bubble_cpp->cpp_link(), after use Inline(...), symtab entry '$entry' is defined sub\n"; }
    else { print "in Bubble_cpp->cpp_link(), after use Inline(...), symtab entry '$entry' is SOMETHING ELSE\n"; }
}
=cut


package RPerl::Algorithm::Sort::Bubble_cpp;
1;