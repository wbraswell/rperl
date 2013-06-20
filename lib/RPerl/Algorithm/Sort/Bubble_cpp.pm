use strict; use warnings;
package RPerl::Algorithm::Sort::Bubble_cpp;
our @ISA = ('RPerl::Class');
use RPerl::Class;  use RPerl;

our void__method $cpp_load = sub {
;	
	print "in Bubble_cpp::cpp_load(), have defined(\$RPerl::Algorithm::Sort::Bubble::CPP_loaded) = " . defined($RPerl::Algorithm::Sort::Bubble::CPP_loaded) . "\n";
	if (not(defined($RPerl::Algorithm::Sort::Bubble::CPP_loaded)))
	{
		my $eval_string = <<'EOF';
use RPerl::HelperFunctions_cpp;
#RPerl::HelperFunctions_cpp::cpp_load();
$RPerl::HelperFunctions::cpp_loaded = 1;  # HelperFunctions.cpp loaded by C++ #include in Bubble.cpp 

# NEED FIX: Bubble.cpp should not load HelperFunctions.cpp, only HelperFunctions.h?  where then would we load HelperFunctions.cpp?

####use RPerl::Algorithm::Sort;
use RPerl::Algorithm::Sort_cpp;
#RPerl::Algorithm::Sort_cpp::cpp_load();
$RPerl::Algorithm::Sort::cpp_loaded = 1;  # Sort.cpp loaded by C++ #include in Bubble.cpp 

package main;
use Inline
(
#        CPP => './Bubble.cpp',
#        CPP => 'RPerl/Algorithm/Sort/Bubble.cpp',
        CPP => '/home/wbraswell/austin_perl_mongers/compiler/RPerl/RPerl-latest/lib/RPerl/Algorithm/Sort/Bubble.cpp',
        CCFLAGS => '-Wno-deprecated',  # old-style-header warnings, suppress
        BUILD_NOISY => 1,
        CLEAN_AFTER_BUILD => 0,
        WARNINGS => 1,
);
RPerl::Algorithm::Sort_cpp::cpp_link();
RPerl::HelperFunctions_cpp::cpp_link();
$RPerl::Algorithm::Sort::Bubble::CPP_loaded = 1;
1;
EOF

		print "in Bubble_cpp::cpp_load(), CPP not yet loaded, about to call eval() on \$eval_string =\n<<< BEGIN EVAL STRING>>>\n" . $eval_string . "<<< END EVAL STRING >>>\n";

		eval($eval_string);  ## no critic
		die(@_) if (@_);
		
		
		# START HERE: should we be linking above or below?  FIX LINKING!
		
	
#		RPerl::Algorithm::Sort::cpp_link();
#		RPerl::HelperFunctions::cpp_link();
#		$RPerl::Algorithm::Sort::Bubble::CPP_loaded = 1;
	}
	else { print "in Bubble_cpp::cpp_load(), CPP already loaded, DOING NOTHING\n"; }
};

our void__method $cpp_link = sub {
;
	print "in Bubble_cpp::cpp_link(), have defined(\$RPerl::Algorithm::Sort::Bubble::CPP_linked) = " . defined($RPerl::Algorithm::Sort::Bubble::CPP_linked) . "\n";
	if (not(defined($RPerl::Algorithm::Sort::Bubble::CPP_linked)))
	{
		my $eval_string = <<'EOF';
package RPerl::Algorithm::Sort::Bubble;
our @ISA = ('CPP__RPerl__Algorithm__Sort__Bubble', 'RPerl::Algorithm::Sort');
our $CPP_linked = 1;
1;
EOF
		print "in Bubble_cpp::cpp_link(), CPP not yet linked, about to call eval() on \$eval_string =\n<<< BEGIN EVAL STRING>>>\n" . $eval_string . "<<< END EVAL STRING >>>\n";

		eval($eval_string);  ## no critic
		die(@_) if (@_);
	}
	else { print "in Bubble_cpp::cpp_link(), CPP already linked, DOING NOTHING\n"; }
};

=DEBUG
use Data::Dumper;
#print "in Bubble_cpp.pm, after use Inline(...), have \%INC =\n" . Dumper(\%INC) . "\n";
no strict;
foreach my $entry ( keys %main:: )
{
	if (defined(${$entry})) { print "in Bubble_cpp.pm, after use Inline(...), symtab entry '$entry' is defined scalar\n"; }
    elsif (defined(@{$entry})) { print "in Bubble_cpp.pm, after use Inline(...), symtab entry '$entry' is defined array\n"; }
    elsif (defined(%{$entry})) { print "in Bubble_cpp.pm, after use Inline(...), symtab entry '$entry' is defined hash\n"; }
    elsif (defined(&{$entry})) { print "in Bubble_cpp.pm, after use Inline(...), symtab entry '$entry' is defined sub\n"; }
    else { print "in Bubble_cpp.pm, after use Inline(...), symtab entry '$entry' is SOMETHING ELSE\n"; }
}
=cut

package RPerl::Algorithm::Sort::Bubble_cpp;
1;