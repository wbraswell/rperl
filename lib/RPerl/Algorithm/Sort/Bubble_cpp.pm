package RPerl::Algorithm::Sort::Bubble_cpp;
use strict;
use warnings;
use Carp;
our $VERSION = 0.001_000;
our $CPP_LOADED = 0;
our $CPP_LINKED = 0;
use parent ('RPerl::CompileUnit::Module::Class');
use RPerl::CompileUnit::Module::Class;
use RPerl;
use RPerl::HelperFunctions_cpp;
use RPerl::Algorithm::Sort_cpp;
use RPerl::Algorithm::Inefficient_cpp;

our void__method $cpp_load = sub {

#	if (defined($RPerl::Algorithm::Sort::Bubble_cpp::CPP_LOADED)) { print STDERR "in Bubble_cpp::cpp_load(), have \$RPerl::Algorithm::Sort::Bubble_cpp::CPP_LOADED = '" . $RPerl::Algorithm::Sort::Bubble_cpp::CPP_LOADED . "'\n"; }
#		else { print STDERR "in Bubble_cpp::cpp_load(), have \$RPerl::Algorithm::Sort::Bubble_cpp::CPP_LOADED = 'UNDEF'\n"; }
    if (   not( defined $RPerl::Algorithm::Sort::Bubble_cpp::CPP_LOADED )
        or not($RPerl::Algorithm::Sort::Bubble_cpp::CPP_LOADED) )
    {
        $RPerl::HelperFunctions_cpp::CPP_LOADED = 1; # HelperFunctions.cpp loaded by C++ #include in Bubble.h

        ####use RPerl::Algorithm::Sort;
        $RPerl::Algorithm::Sort_cpp::CPP_LOADED = 1; # Sort.cpp loaded by C++ #include in Bubble.h

        ####use RPerl::Algorithm::Inefficient;
        $RPerl::Algorithm::Inefficient_cpp::CPP_LOADED = 1; # Inefficient.cpp loaded by C++ #include in Bubble.h

        my $eval_string = <<"EOF";
package main;
BEGIN { print STDERR "[[[ BEGIN 'use Inline' STAGE for 'RPerl/Algorithm/Sort/Bubble.cpp' ]]]\n"x3; }
use Inline
(
	CPP => '$RPerl::INCLUDE_PATH/RPerl/Algorithm/Sort/Bubble.cpp',
	TYPEMAPS => '$RPerl::INCLUDE_PATH/typemap.rperl',
	CCFLAGS => '-Wno-deprecated -std=c++0x -Wno-reserved-user-defined-literal',
	INC => '-I$RPerl::INCLUDE_PATH',
	BUILD_NOISY => 1,
	CLEAN_AFTER_BUILD => 0,
	WARNINGS => 1,
	FILTERS => 'Preprocess',
	AUTO_INCLUDE => # DEV NOTE: include non-RPerl files using AUTO_INCLUDE so they are not parsed by the 'Preprocess' filter
	[
		'#include <iostream>',
		'#include <string>',
		'#include <sstream>',
		'#include <limits>',
		'#include <vector>',
		'#include <unordered_map>',  # DEV NOTE: unordered_map may require '-std=c++0x' in CCFLAGS above
	],
);
print STDERR "[[[ END 'use Inline' STAGE for 'RPerl/Algorithm/Sort/Bubble.cpp' ]]]\n"x3;
1;
EOF

        print STDERR
            "in Bubble_cpp::cpp_load(), CPP not yet loaded, about to call eval() on \$eval_string =\n<<< BEGIN EVAL STRING>>>\n"
            . $eval_string
            . "<<< END EVAL STRING >>>\n"
            or croak();

        eval($eval_string);
        if ($@) {croak($@);}

        RPerl::HelperFunctions_cpp::cpp_link();
        RPerl::Algorithm::Sort_cpp::cpp_link();
        RPerl::Algorithm::Inefficient_cpp::cpp_link();
        $RPerl::Algorithm::Sort::Bubble_cpp::CPP_LOADED = 1;
    }

#	else { print STDERR "in Bubble_cpp::cpp_load(), CPP already loaded, DOING NOTHING\n"; }
};

our void__method $cpp_link = sub {
    ;

#	if (defined($RPerl::Algorithm::Sort::Bubble_cpp::CPP_LINKED)) { print STDERR "in Bubble_cpp::cpp_link(), have \$RPerl::Algorithm::Sort::Bubble_cpp::CPP_LINKED = '" . $RPerl::Algorithm::Sort::Bubble_cpp::CPP_LINKED . "'\n"; }
#		else { print STDERR "in Bubble_cpp::cpp_link(), have \$RPerl::Algorithm::Sort::Bubble_cpp::CPP_LINKED = 'UNDEF'\n"; }
    if (   not( defined $RPerl::Algorithm::Sort::Bubble_cpp::CPP_LINKED )
        or not($RPerl::Algorithm::Sort::Bubble_cpp::CPP_LINKED) )
    {
        my $eval_string = <<'EOF';
package RPerl::Algorithm::Sort::Bubble_cpp;
$CPP_LINKED = 1;
1;
package RPerl::Algorithm::Sort::Bubble;
# DEV NOTE, CORRELATION #01: multiple inheritance is enabled by _either_ Perl here or C++ at correlation in Bubble.h
#our @ISA = ('main::CPP__RPerl__Algorithm__Sort__Bubble', 'RPerl::Algorithm::Sort');  # SINGLE INHERITANCE (not counting main::CPP__*)
our @ISA = ('main::CPP__RPerl__Algorithm__Sort__Bubble', 'RPerl::Algorithm::Sort', 'RPerl::Algorithm::Inefficient');  # MULTIPLE INHERITANCE
1;
EOF

#		print STDERR "in Bubble_cpp::cpp_link(), CPP not yet linked, about to call eval() on \$eval_string =\n<<< BEGIN EVAL STRING>>>\n" . $eval_string . "<<< END EVAL STRING >>>\n";

        eval($eval_string);
        if ($@) {croak($@);}
    }

#	else { print STDERR "in Bubble_cpp::cpp_link(), CPP already linked, DOING NOTHING\n"; }
};

=DEBUG
use Data::Dumper;
#print STDERR "in Bubble_cpp->cpp_link(), after use Inline(...), have \%INC =\n" . Dumper(\%INC) . "\n";
no strict;
foreach my $entry ( keys %main:: )
{
	if (defined(${$entry})) { print STDERR "in Bubble_cpp->cpp_link(), after use Inline(...), symtab entry '$entry' is defined scalar\n"; }
    elsif (defined(@{$entry})) { print STDERR "in Bubble_cpp->cpp_link(), after use Inline(...), symtab entry '$entry' is defined array\n"; }
    elsif (defined(%{$entry})) { print STDERR "in Bubble_cpp->cpp_link(), after use Inline(...), symtab entry '$entry' is defined hash\n"; }
    elsif (defined(&{$entry})) { print STDERR "in Bubble_cpp->cpp_link(), after use Inline(...), symtab entry '$entry' is defined sub\n"; }
    else { print STDERR "in Bubble_cpp->cpp_link(), after use Inline(...), symtab entry '$entry' is SOMETHING ELSE\n"; }
}
=cut

package RPerl::Algorithm::Sort::Bubble_cpp;
1;
