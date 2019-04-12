#ifndef __CPP__INCLUDED__rperloperations_h
#define __CPP__INCLUDED__rperloperations_h 0.004_000

#include <rperltypes_mode.h>
#include <RPerl/HelperFunctions.cpp>  // -> HelperFunctions.h

# ifdef __PERL__TYPES

// NEED ADD CODE

# elif defined __CPP__TYPES

// [[[ EXPRESSIONS ]]]

// DEV NOTE, CORRELATION #rp020: upon adding new named op file lib/RPerl/Operation/Expression/Operator/Named*/* also add in Named*.pm and rperloperations.*
#define abs std::abs  // DEV NOTE, CORRELATION #rp110: C++ std::abs is the most versatile choice of C++ operator, and is equivalent to Perl abs
#define sin std::sin
#define cos std::cos
#define exp std::exp
#define log std::log
#define sqrt std::sqrt
#define atan2 std::atan2

// DEV NOTE, CORRELATION #rp070: "logical and" && operator behaves differently in Perl vs C++, accepts strings so must use double-negation trick to convert to boolean, returns operand on right if operator evaluates to true; use ANDl instead of && in C++
#define ANDl(x,y) (!!x) ? ((!!y) ? y : 0): 0

// [[[ STATEMENTS ]]]

#define print cout <<  // DEV NOTE, CORRELATION #rp100: C++ cout w/ double-less-than << input list separators is equivalent to Perl print w/ comma separators
#define prerr cerr <<  // DEV NOTE, CORRELATION #rp101: C++ cerr w/ double-less-than << input list separators is equivalent to Perl print {*STDERR} w/ comma separators

// BEGIN die OPERATOR
// DEV NOTE: prefer #rp102a solution because the generated C++ looks closer to the original Perl input; commas instead of double-less-thans, no inline exit()
// DEV NOTE, CORRELATION #rp102: renamed from Perl die to C++ Die to avoid error redefining Perl's embed.h die
// DEV NOTE, CORRELATION #rp102a: C++ cerr w/ recursive variadic template and exit() is equivalent to Perl die, DISABLED
void Die(){};
template<typename First, typename ...Rest>
void Die(First && first, Rest && ...rest) {
    cerr << std::forward<First>(first);
    Die(std::forward<Rest>(rest)...);  // ERROR all-lowercase die(): this recursive call causes an unknown SIGSEGV segfault in libperl.so
    exit(1);
}
// DEV NOTE, CORRELATION #rp102b: C++ cerr w/ inlined exit() is equivalent to Perl die
//#define die cerr <<  // ERROR all-lowercase die(): warning: "die" redefined    /usr/lib/perl/5.XX/CORE/embed.h    # define die Perl_die_nocontext
//#define Die cerr <<
// END die OPERATOR

# endif

#endif
