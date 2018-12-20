# [[[ HEADER ]]]
package RPerl::Inline;
use strict;
use warnings;
our $VERSION = 0.022_000;

#use RPerl;         # ERROR: Too late to run INIT block at ...
#use Config;
use English;        # for $OSNAME
use RPerl::Config;  # for $RPerl::DEBUG
use Alien::GMP;     # prerequisite for Math::BigInt::GMP
#use Alien::GSL;     # prerequisite for Math::GSL
use Alien::PCRE2;   # for regex support
use Alien::JPCRE2;  # for regex support
use File::Spec;     # for splitpath() and catpath()
use IPC::Cmd qw(can_run);
use IPC::Run3 qw(run3);

# DEV NOTE: all 'our' vars below utilized from Compiler.pm and/or generated *.pmc files



# MongoDB support
# NEED FIX: add Alien::PkgConfig & Alien::Mongo* dependencies; add error checking for missing pkg-config or bad return value

#our $mongodb_include_dir = File::Spec->catpath(q{}, q{FOO}, q{include});  # NOT USED, replaced by pkg-config at compile time as in Compiler.pm

my $pkgconfig_path = undef;
$pkgconfig_path = can_run('pkg-config');
 
# NEED ENABLE: uncomment when Alien::PkgConfig dependency is added
#if ( not defined $pkgconfig_path ) {
#    die 'ERROR xxxxxxx, yyy: Command `pkg-config` not found, dying' . "\n" );
#}

my $mongodb_pkgconfig_command = $pkgconfig_path . ' --libs-only-L libmongocxx';
my $mongodb_pkgconfig_command_stdout = q{};
my $mongodb_pkgconfig_command_stderr = q{};
run3( $mongodb_pkgconfig_command, \undef, \$mongodb_pkgconfig_command_stdout, \$mongodb_pkgconfig_command_stderr );  # disable STDIN w/ \undef
my $mongodb_pkgconfig_command_exit_status = $CHILD_ERROR >> 8;

#RPerl::diag( 'in RPerl::Inline, have $CHILD_ERROR = ' . $CHILD_ERROR . "\n" );
#RPerl::diag( 'in RPerl::Inline, have $mongodb_pkgconfig_command_exit_status = ' . $mongodb_pkgconfig_command_exit_status . "\n" );

# NEED ENABLE: uncomment when Alien::MongoDB* dependencies are added
#if ((defined $mongodb_pkgconfig_command_stderr) and ($mongodb_pkgconfig_command_stderr ne q{})) {
#    die 'ERROR xxxxxxx, yyy: Command `' . $mongodb_pkgconfig_command . '` generated the following STDERR output when none was expected' . "\n\n" . $mongodb_pkgconfig_command . "\n\n" . 'dying' . "\n" ;
#}
#elsif ((not defined $mongodb_pkgconfig_command_stdout) or ($mongodb_pkgconfig_command_stdout eq q{})) {
#    die 'ERROR xxxxxxx, yyy: Command `' . $mongodb_pkgconfig_command . '` generated no STDOUT output when the MongoDB C++ driver library path was expected, dying' . "\n" ;
#}

# Package libmongocxx was not found in the pkg-config search path.
# Perhaps you should add the directory containing `libmongocxx.pc' to the PKG_CONFIG_PATH environment variable
# No package 'libmongocxx' found
#our $mongodb_lib_dir = `pkg-config --libs-only-L libmongocxx`;  # WRONG: causes uncontrolled STDERR output above & numerous false errors
our $mongodb_lib_dir = $mongodb_pkgconfig_command_stdout;
substr $mongodb_lib_dir, 0, 2, q{};  # trim leading '-L'
chomp $mongodb_lib_dir;  # trim trailing newline




# GMP support
my $gmp_dir = Alien::GMP->dist_dir();
our $gmp_include_dir = File::Spec->catpath(q{}, $gmp_dir, q{include});
our $gmp_lib_dir = File::Spec->catpath(q{}, $gmp_dir, q{lib});
#print {*STDERR} "\n\n", q{<<< DEBUG >>> in RPerl::Inline, have $gmp_dir = '}, $gmp_dir, q{'}, "\n\n";

# GSL support
#my $gsl_dir = Alien::GSL->dist_dir();
#print {*STDERR} "\n\n", q{<<< DEBUG >>> in RPerl::Inline, have $gsl_dir = '}, $gsl_dir, q{'}, "\n\n";
#our $gsl_include_dir = File::Spec->catpath(q{}, $gsl_dir, q{include});
#our $gsl_lib_dir = File::Spec->catpath(q{}, $gsl_dir, q{lib});

# PCRE2 support
my $pcre2_dir = Alien::PCRE2->dist_dir();
#print {*STDERR} "\n\n", q{<<< DEBUG >>> in RPerl::Inline, have $pcre2_dir = '}, $pcre2_dir, q{'}, "\n\n";
our $pcre2_include_dir = File::Spec->catpath(q{}, $pcre2_dir, q{include});
my $pcre2_lib_dir = File::Spec->catpath(q{}, $pcre2_dir, q{lib});
#print {*STDERR} "\n\n", q{<<< DEBUG >>> in RPerl::Inline, have $pcre2_include_dir = '}, $pcre2_include_dir, q{'}, "\n\n";

# JPCRE2 support
my $jpcre2_dir = Alien::JPCRE2->dist_dir();
#print {*STDERR} "\n\n", q{<<< DEBUG >>> in RPerl::Inline, have $jpcre2_dir = '}, $jpcre2_dir, q{'}, "\n\n";
our $jpcre2_include_dir = File::Spec->catpath(q{}, $jpcre2_dir, q{include});
#my $jpcre2_lib_dir = File::Spec->catpath(q{}, $jpcre2_dir, q{lib});  # NOT USED
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

# NEED FIX INLINE: must disable -Wdelete-non-virtual-dtor warnings until Inline::C (or is it Inline::CPP?) destructor issue can be solved
# eval_XXXX_XXXX.c: In function ‘void XS_RPerl__CompileUnit__Module__Class__CPP_DESTROY(CV*)’:
# eval_XXXX_XXXX.c:yyyy:z: warning: deleting object of polymorphic class type ‘RPerl__CompileUnit__Module__Class__CPP’ which has non-virtual destructor might cause undefined behaviour [-Wdelete-non-virtual-dtor]
#   delete THIS;
#          ^

our $CCFLAGSEX = $is_msvc_compiler ? '-DNO_XSLOCKS'
#    : '-Wno-unused-variable -DNO_XSLOCKS -Wno-deprecated -std=c++11 -Wno-literal-suffix';
    : '-Wno-unused-variable -DNO_XSLOCKS -Wno-deprecated -std=c++11 -Wno-literal-suffix -Wall -Wextra -Wno-delete-non-virtual-dtor';

# DEV NOTE: Perl v5.18 and older on Macintosh OS X requires -Wno-reserved-user-defined-literal to avoid error:
# "invalid suffix on literal; C++11 requires a space between literal and identifier"
#if (($OLD_PERL_VERSION <= 5.018000) and ($OSNAME eq 'darwin')) {  # $OLD_PERL_VERSION introduced in Perl v5.20, $] is the non-English equivalent
if (($] <= 5.018000) and ($OSNAME eq 'darwin')) {
    $CCFLAGSEX .= ' -Wno-reserved-user-defined-literal';
}

# DEV NOTE, POSSIBLE ALTERNATIVE STRATEGY:  '-L' . $Config{archlibexp} . '/CORE'
# for support of dynamic linking to libperl.so
if (defined $Config::Config{ccdlflags}) {
    my $ccdlflags = $Config::Config{ccdlflags};

# for testing paths containing space characters, for example somewhere in the '/home' directory, create a symlink '/ho\ me' which points to '/home', then use the debug code below
# ln -s /home /ho\ me
#$ccdlflags = '-Wl,-E -Wl,-rpath,/ho\ me/FOO/BAR/lib/perl5/5.22.1/x86_64-linux/CORE';  # TMP DEBUG
#print "\n\n", q{<<< DEBUG >>> in RPerl::Inline, have $ccdlflags = '}, $ccdlflags, q{'}, "\n\n";

    # subcompile dynamic linking flags, may include '-rpath' directory containing 'libperl.so'; if present, '-rpath' removes need for ldconfig; 
    # not enclosed by quotes, so leave backslash-escaped characters as-is
    $CCFLAGSEX .= ' ' . $ccdlflags;

    if ($ccdlflags =~ m/.*\-Wl,\-rpath,([\w\-\.\\\/](?:\\\ |[\w:\-\.\\\/])*)/gxms) {  # find -Wl,rpath,/DIR_CONTAINING_libperl.so; allow backslash-escaped spaces
#    if ($ccdlflags =~ m/.*\-Wl,\-rpath,([\w:\-\.\\\/]+)/gxms) {  # find -Wl,rpath,/DIR_CONTAINING_libperl.so
        my $libperl_lib_dir = $1;
        if ($libperl_lib_dir =~ m/\\\ /gxms) {
            $libperl_lib_dir =~ s/\\\ /\ /gxms;  # replace backslash-escaped space with just space, for compatibility with double-quote enclosing -L"..." below
        }
        $CCFLAGSEX .= ' -L"' . $libperl_lib_dir . '"';
#print "\n\n", q{<<< DEBUG >>> in RPerl::Inline, have $libperl_lib_dir = '}, $libperl_lib_dir, q{'}, "\n\n";
    }
}

# for regex support
$CCFLAGSEX .= ' -L"' . $pcre2_lib_dir . '"';

my $optimize;
if ($is_msvc_compiler) {
    $optimize = q{};
}
# NEED FIX: NetBSD does not support -march=native switch for some reason,
# must wait until NetBSD OS devs fix this then test $Config::Config{osvers} to see if NetBSD is new enough to include fix
# error: bad value (native) for -march= switch
elsif ($Config::Config{osname} eq 'netbsd') {
    $optimize = '-O3 -fomit-frame-pointer -g';
}
else {
    $optimize = '-O3 -fomit-frame-pointer -march=native -g';
}

our %ARGS = (
    typemaps => "$RPerl::INCLUDE_PATH/typemap.rperl",
     # disable default '-O2 -g' (or similar) from Perl core & Makemaker
    optimize => $optimize,

# NEED UPGRADE: strip C++ incompat CFLAGS
#  ccflags => $Config::Config{ccflags} . ' -DNO_XSLOCKS -Wno-deprecated -std=c++0x -Wno-reserved-user-defined-literal -Wno-literal-suffix',
#    force_build => 1,  # debug use only
    # put . (current dir) last to avoid finding coincidentally-named file './foo' instead of '/SYSTEM/PATH/foo.h' from '#include <foo>' 
    inc               => '-I' . $RPerl::INCLUDE_PATH . ' -Ilib -I' . $pcre2_include_dir . ' -I' . $jpcre2_include_dir . ' -I.',
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

        # NEED UPGRADE: only include when actually benchmarking
        # benchmarking, for std::chrono::high_resolution_clock::now
        '#include <ctime>',
        '#include <ratio>',
        '#include <chrono>',

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
