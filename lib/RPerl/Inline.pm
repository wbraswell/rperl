package RPerl::Inline;
use RPerl;

#use Config;

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

our @ARGS = (
    typemaps => "$RPerl::INCLUDE_PATH/typemap.rperl",

# TODO: strip C++ incompat CFLAGS
#  ccflags => $Config{ccflags} . ' -DNO_XSLOCKS -Wno-deprecated -std=c++0x -Wno-reserved-user-defined-literal -Wno-literal-suffix',
    ccflagsex =>
        '-DNO_XSLOCKS -Wno-deprecated -std=c++0x -Wno-reserved-user-defined-literal -Wno-literal-suffix',
    inc               => "-I$RPerl::INCLUDE_PATH",
    build_noisy       => $ENV{TEST_VERBOSE},
    clean_after_build => 0,                          # cache it
    warnings          => 1,
    filters           => 'Preprocess',
    auto_include => # DEV NOTE: include non-RPerl files using AUTO_INCLUDE so they are not parsed by the 'Preprocess' filter
        [
        '#include <iostream>',
        '#include <string>',
        '#include <sstream>',
        '#include <limits>',
        '#include <vector>',
        '#include <unordered_map>', # DEV NOTE: unordered_map may require '-std=c++0x' in CCFLAGS above
        ],
    classes => sub { join('::', split('__', shift)); }
);
1;
