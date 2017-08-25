#ifndef __CPP__INCLUDED__rperlstandalone_h
#define __CPP__INCLUDED__rperlstandalone_h 0.003_000

// DEV NOTE, CORRELATION #rp024: sync include files & other preprocessor directives in both RPerl/Inline.pm and rperlstandalone.h
#include <memory>
#include <iostream>
#include <string>
#include <sstream>
#include <limits>
#undef seed
#include <algorithm>
#include <vector>
#include <math.h>
#include <unordered_map>

// for regex support
// DEV NOTE, CORRELATION #rp024: sync include files & other preprocessor directives in both RPerl/Inline.pm and rperlstandalone.h
#undef do_open         // fix conflict between jpcre2.hpp subdep locale_facets_nonio.h & other uknown file, 'error: macro "do_open" requires 7 arguments, but only 2 given'
#undef do_close        // fix conflict between jpcre2.hpp subdep locale_facets_nonio.h & other uknown file, 'error: macro "do_close" requires 2 arguments, but only 1 given'
#include "jpcre2.hpp"
// DEV NOTE, CORRELATION #rp300: must link against all bit width libs to allow automatic selection
typedef jpcre2::select<char>::Regex regex;  // automatically selects correct character bit width based on system, 8 or 16 or 32
typedef jpcre2::SIZE_T regexsize;  // used by substitution (replace) count type

// FROM Inline::CPP
#include <EXTERN.h>
#include <perl.h>
#include <XSUB.h>

// RPERL PROGRAM ADDITIONAL
#include <RPerl.cpp>  // -> RPerl.h -> (rperltypes_mode.h; rperloperations.h; rperltypes.h; HelperFunctions.cpp)
using std::cout;  using std::cerr;  using std::endl;

#endif
