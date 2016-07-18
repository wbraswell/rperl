#ifndef __CPP__INCLUDED__rperloperations_h
#define __CPP__INCLUDED__rperloperations_h 0.001_000

#include <rperltypes_mode.h>
#include <RPerl/HelperFunctions.cpp>  // -> HelperFunctions.h

# ifdef __PERL__TYPES

// NEED ADD CODE

# elif defined __CPP__TYPES

// [[[ EXPRESSIONS ]]]

// DEV NOTE, CORRELATION #rp020: upon adding new named op file lib/RPerl/Operation/Expression/Operator/Named/* also add in Grammar.eyp, Named.pm, and rperloperations.*
#define abs std::abs  // DEV NOTE, CORRELATION #rp110: C++ std::abs is the most versatile choice of C++ operator, and is equivalent to Perl abs

// [[[ STATEMENTS ]]]

#define print cout <<  // DEV NOTE, CORRELATION #rp100: C++ cout w/ double-less-than << input list separators is equivalent to Perl print w/ comma separators
#define prerr cerr <<  // DEV NOTE, CORRELATION #rp101: C++ cerr w/ double-less-than << input list separators is equivalent to Perl print {*STDERR} w/ comma separators

# endif

#endif
