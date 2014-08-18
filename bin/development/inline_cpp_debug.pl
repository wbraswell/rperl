#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;

# START HERE: remove unused Inline ARGS below, move C++ code to __DATA__, boil to one-liner
# START HERE: remove unused Inline ARGS below, move C++ code to __DATA__, boil to one-liner
# START HERE: remove unused Inline ARGS below, move C++ code to __DATA__, boil to one-liner

use Inline (CPP => "blib/lib/RPerl/Test/Inline_CPP_Debug.cpp", typemaps => "blib/lib/typemap.rperl",

    ccflagsex =>
        '-DNO_XSLOCKS -Wno-deprecated -std=c++0x -Wno-reserved-user-defined-literal -Wno-literal-suffix',
    inc               => "-Iblib/lib",
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
    classes => sub { @_ = split( '__', shift ); ( pop, join( '::', @_ ) ); });

#print STDERR q{in inline_cpp_debug.pl, have \%main:: symbol table = '} . Dumper(\%main::) . "'\n" or croak();
print STDERR q{in inline_cpp_debug.pl, have \%main:: symbol table entry for my_function() = '} . (\%main::)->{'my_function'} . "'\n" or croak();

my $my_object = RPerl::Test::Inline_CPP_Debug->new();
print STDERR "in inline_cpp_debug.pl have \$my_object->my_method() = '" . $my_object->my_method() . "'\n" or croak();  # OO INTERFACE

print STDERR q{in inline_cpp_debug.pl, have my_function() = '} . my_function() . "'\n" or croak();
#print STDERR q{in inline_cpp_debug.pl, have my_function() = '} . RPerl::Test::Inline_CPP_Debug::my_function() . "'\n" or croak();