#ifndef __CPP__INCLUDED__rperlstandalone_h
#define __CPP__INCLUDED__rperlstandalone_h 0.001_000

// DEV NOTE, CORRELATION #rp024: sync include files in both RPerl/Inline.pm and rperlstandalone.h
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

// FROM Inline::CPP
#include <EXTERN.h>
#include <perl.h>
#include <XSUB.h>

// RPERL PROGRAM ADDITIONAL
#include <RPerl.cpp>  // -> RPerl.h -> (rperltypes_mode.h; rperloperations.h; rperltypes.h; HelperFunctions.cpp)
using std::cout;  using std::cerr;  using std::endl;

#endif
