# [[[ HEADER ]]]
package RPerl::Inline;
use strict;
use warnings;
our $VERSION = 0.001_070;

#use RPerl;  # ERROR: Too late to run INIT block at ...
use Config;
use RPerl::Config;  # for $RPerl::DEBUG

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

# DEV NOTE, CORRELATION #rp11: replace -std=c++0x w/ -std=c++11 for std::string::pop_back()
# DEV NOTE: move ccflags outside %ARGS, make individual modules compose ccflags with possible cppflags right before calling Inline
#our $CCFLAGSEX = '-DNO_XSLOCKS -Wno-deprecated -std=c++0x -Wno-reserved-user-defined-literal -Wno-literal-suffix';
#our $CCFLAGSEX = '-DNO_XSLOCKS -Wno-deprecated -std=c++11 -Wno-reserved-user-defined-literal -Wno-literal-suffix';
# DEV NOTE: add -Wno-unused-variable to suppress warnings in GCC v4.9
our $CCFLAGSEX = '-Wno-unused-variable -DNO_XSLOCKS -Wno-deprecated -std=c++11 -Wno-reserved-user-defined-literal -Wno-literal-suffix';

our %ARGS = (
    typemaps => "$RPerl::INCLUDE_PATH/typemap.rperl",
    optimize => '-O3 -fomit-frame-pointer -march=native -g',  # disable default '-O2 -g' (or similar) from Perl core & Makemaker

# NEED UPGRADE: strip C++ incompat CFLAGS
#  ccflags => $Config{ccflags} . ' -DNO_XSLOCKS -Wno-deprecated -std=c++0x -Wno-reserved-user-defined-literal -Wno-literal-suffix',
#    force_build => 1,  # debug use only
    inc               => "-I$RPerl::INCLUDE_PATH -Ilib",
    build_noisy       => ( $ENV{RPERL_DEBUG} or $RPerl::DEBUG ),  # suppress or display actual g++ compiler commands
    clean_after_build => 0,                          # cache it
    warnings          => (((not defined $ENV{RPERL_WARNINGS}) or $ENV{RPERL_WARNINGS}) and $RPerl::WARNINGS),  # suppress or display Inline warnings
    filters           => 'Preprocess',
    auto_include => # DEV NOTE: include non-RPerl files using AUTO_INCLUDE so they are not parsed by the 'Preprocess' filter
        [
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
        ],
    classes => sub { join('::', split('__', shift)); }
);

if ($Config{archname} !~ /^arm/) {
    unshift @{$ARGS{auto_include}}, '#include <immintrin.h>';  # SSE for high-speed math
    $ARGS{optimize} .= ' -mfpmath=sse -msse3';
}

1;
