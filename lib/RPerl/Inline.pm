# [[[ HEADER ]]]
package RPerl::Inline;
use strict;
use warnings;
our $VERSION = 0.006_000;

#use RPerl;  # ERROR: Too late to run INIT block at ...
#use Config;
use RPerl::Config;  # for $RPerl::DEBUG
use Alien::PCRE2;   # for regex support
use Alien::JPCRE2;  # for regex support
use File::Spec;  # for splitpath() and catpath()

# for regex support, look up include & lib dirs
my $pcre2_dir = Alien::PCRE2->dist_dir();
my $jpcre2_dir = Alien::JPCRE2->dist_dir();
#print {*STDERR} "\n\n", q{<<< DEBUG >>> in RPerl::Inline, have $pcre2_dir = '}, $pcre2_dir, q{'}, "\n\n";
#print {*STDERR} "\n\n", q{<<< DEBUG >>> in RPerl::Inline, have $jpcre2_dir = '}, $jpcre2_dir, q{'}, "\n\n";

# two 'our' vars below utilized from Compiler.pm
our $pcre2_include_dir = File::Spec->catpath(q{}, $pcre2_dir, q{include});
our $jpcre2_include_dir = File::Spec->catpath(q{}, $jpcre2_dir, q{include});
my $pcre2_lib_dir = File::Spec->catpath(q{}, $pcre2_dir, q{lib});
#my $jpcre2_lib_dir = File::Spec->catpath(q{}, $jpcre2_dir, q{lib});  # NOT USED
#print {*STDERR} "\n\n", q{<<< DEBUG >>> in RPerl::Inline, have $pcre2_include_dir = '}, $pcre2_include_dir, q{'}, "\n\n";
#print {*STDERR} "\n\n", q{<<< DEBUG >>> in RPerl::Inline, have $jpcre2_include_dir = '}, $jpcre2_include_dir, q{'}, "\n\n";

# long form
#use Inline CPP => config => classes =>
#sub {
#    my $class = shift;
#    my @class_split = split('__', $class);
#    my $class_join = join('::', @class_split);
#    return($class_join);
#};

# short form
#use Inline CPP => config => classes => sub { join('::', split('__', shift)); };

# DEV NOTE, CORRELATION #rp011: replace -std=c++0x w/ -std=c++11 for std::string::pop_back()
# DEV NOTE: move ccflags outside %ARGS, make individual modules compose ccflags with possible cppflags right before calling Inline
#our $CCFLAGSEX = '-DNO_XSLOCKS -Wno-deprecated -std=c++0x -Wno-reserved-user-defined-literal -Wno-literal-suffix';
#our $CCFLAGSEX = '-DNO_XSLOCKS -Wno-deprecated -std=c++11 -Wno-reserved-user-defined-literal -Wno-literal-suffix';
# DEV NOTE: add -Wno-unused-variable to suppress warnings in GCC v4.9
my $is_msvc_compiler = ($Config::Config{cc} =~ /cl/);

our $CCFLAGSEX = $is_msvc_compiler ? '-DNO_XSLOCKS'
    : '-Wno-unused-variable -DNO_XSLOCKS -Wno-deprecated -std=c++11 -Wno-reserved-user-defined-literal -Wno-literal-suffix';

# for regex support
$CCFLAGSEX .= ' -L"' . $pcre2_lib_dir . '"';

our %ARGS = (
    typemaps => "$RPerl::INCLUDE_PATH/typemap.rperl",
     # disable default '-O2 -g' (or similar) from Perl core & Makemaker
    ($is_msvc_compiler
        ? ()
        : (optimize => '-O3 -fomit-frame-pointer -march=native -g')
    ),

# NEED UPGRADE: strip C++ incompat CFLAGS
#  ccflags => $Config{ccflags} . ' -DNO_XSLOCKS -Wno-deprecated -std=c++0x -Wno-reserved-user-defined-literal -Wno-literal-suffix',
#    force_build => 1,  # debug use only
    inc               => '-I' . $RPerl::INCLUDE_PATH . ' -Ilib -I' . $pcre2_include_dir . ' -I' . $jpcre2_include_dir,
    build_noisy       => ( $ENV{RPERL_DEBUG} or $RPerl::DEBUG ),  # suppress or display actual g++ compiler commands
    clean_after_build => 0, # used by Inline::C(PP) to cache build, also used by Inline::Filters to save Filters*.c files for use in gdb debugging
    warnings          => (((not defined $ENV{RPERL_WARNINGS}) or $ENV{RPERL_WARNINGS}) and $RPerl::WARNINGS),  # suppress or display Inline warnings
    filters           => 'Preprocess',
    auto_include => # DEV NOTE: include non-RPerl files using AUTO_INCLUDE so they are not parsed by the 'Preprocess' filter
    [
        # DEV NOTE, CORRELATION #rp024: sync include files & other preprocessor directives in both RPerl/Inline.pm and rperlstandalone.h
        '#include <memory>',  # smart pointers for memory management
        '#include <iostream>',
        '#include <string>',
        '#include <sstream>',
        '#include <limits>',
        '#undef seed',  # fix conflict between Perl's source/internal.h & libstdc++-dev's algorithm.h; 'error: macro "seed" passed 1 arguments, but takes just 0'
        '#include <algorithm>',
        '#include <vector>',
        '#include <math.h>',
        '#include <unordered_map>', # DEV NOTE: unordered_map may require '-std=c++0x' in CCFLAGS above

        # for regex support
        # DEV NOTE, CORRELATION #rp024: sync include files & other preprocessor directives in both RPerl/Inline.pm and rperlstandalone.h
        '#undef do_open',         # fix conflict between jpcre2.hpp subdep locale_facets_nonio.h & other uknown file, 'error: macro "do_open" requires 7 arguments, but only 2 given'
        '#undef do_close',        # fix conflict between jpcre2.hpp subdep locale_facets_nonio.h & other uknown file, 'error: macro "do_close" requires 2 arguments, but only 1 given'
        '#include "jpcre2.hpp"',
        # DEV NOTE, CORRELATION #rp300: must link against all bit width libs to allow automatic selection
        'typedef jpcre2::select<char>::Regex regex;',  # automatically selects correct character bit width based on system, 8 or 16 or 32
        'typedef jpcre2::SIZE_T regexsize;',  # used by substitution (replace) count type
    ],
    classes => sub { join('::', split('__', shift)); }
);

1;
