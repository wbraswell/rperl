#ifndef __CPP__INCLUDED__RPerl_cpp
#define __CPP__INCLUDED__RPerl_cpp 0.003_000

#include <RPerl.h>  // -> (rperltypes_mode.h; rperltypes.h; HelperFunctions.cpp)

# ifdef __PERL__TYPES

// [[[<<< BEGIN PERL TYPES >>>]]]
// [[[<<< BEGIN PERL TYPES >>>]]]
// [[[<<< BEGIN PERL TYPES >>>]]]


// START HERE: test RPerl::diag() for CPPOPS_PERLTYPES; then implement RPerl::verbose() and RPerl::warning() for CPPOPS_PERLTYPES; decide what to do with RPerl::DUMPER() and native C++ RPerl::diag() below
// START HERE: test RPerl::diag() for CPPOPS_PERLTYPES; then implement RPerl::verbose() and RPerl::warning() for CPPOPS_PERLTYPES; decide what to do with RPerl::DUMPER() and native C++ RPerl::diag() below
// START HERE: test RPerl::diag() for CPPOPS_PERLTYPES; then implement RPerl::verbose() and RPerl::warning() for CPPOPS_PERLTYPES; decide what to do with RPerl::DUMPER() and native C++ RPerl::diag() below


int RPerl__diag(SV* message)
{
        dSP;
        int retcnt;
        int retval;

        ENTER;
        SAVETMPS;
        PUSHMARK(SP); XPUSHs(message); PUTBACK;
        retcnt = call_pv("RPerl::diag", G_SCALAR);
        SPAGAIN;
        if (retcnt != 1) { croak("RPerl::diag(message) return count is %"INTEGER", expected 1, croaking", retcnt); }
        retval = POPi; PUTBACK;
//        FREETMPS;
        LEAVE;

        return retval;
}

/*
#include <stdlib.h>  // for getenv()
#include <stdio.h>  // for ostream object type

ostringstream RPerl__diag;

ostream& operator<<(ostream& ostream_object, const char* char_star_input)
{
        if (getenv("RPERL_DEBUG") { cerr << char_star_input; }
        return ostream_object;
}

ostream& operator<<(ostream& ostream_object, std::string string_input)
{
        if (getenv("RPERL_DEBUG") { cerr << string_input; }
        return ostream_object;
}
*/

/*
char* RPerl::DUMPER(SV* dumpee)
{
        dSP;
        int retcnt;
        char* retval;

        ENTER;
        SAVETMPS;
        PUSHMARK(SP); XPUSHs(dumpee); PUTBACK;
        retcnt = call_pv("RPerl::DUMPER", G_SCALAR);
        SPAGAIN;
        if (retcnt != 1) { croak("RPerl::DUMPER(dumpee) return count is %"INTEGER", expected 1, croaking", retcnt); }
        retval = POPp; PUTBACK;
//        FREETMPS;
        LEAVE;

        return retval;
}
*/

// [[[<<< END PERL TYPES >>>]]]
// [[[<<< END PERL TYPES >>>]]]
// [[[<<< END PERL TYPES >>>]]]

# elif defined __CPP__TYPES

// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]

integer RPerl__diag(string message)
{
        dSP;
        int retcnt;
        int retval;

        ENTER;
        SAVETMPS;
        PUSHMARK(SP); XPUSHs(newSVpv(message.c_str(), 0)); PUTBACK;
        retcnt = call_pv("RPerl::diag", G_SCALAR);
        SPAGAIN;
        if (retcnt != 1) { croak("RPerl::diag(message) return count is %"INTEGER", expected 1, croaking", retcnt); }
        retval = POPi; PUTBACK;
//        FREETMPS;
        LEAVE;

        return retval;
}

integer RPerl__verbose(string message)
{
        dSP;
        int retcnt;
        int retval;

        ENTER;
        SAVETMPS;
        PUSHMARK(SP); XPUSHs(newSVpv(message.c_str(), 0)); PUTBACK;
        retcnt = call_pv("RPerl::verbose", G_SCALAR);
        SPAGAIN;
        if (retcnt != 1) { croak("RPerl::verbose(message) return count is %"INTEGER", expected 1, croaking", retcnt); }
        retval = POPi; PUTBACK;
//        FREETMPS;
        LEAVE;

        return retval;
}

integer RPerl__warning(string message)
{
        dSP;
        int retcnt;
        int retval;

        ENTER;
        SAVETMPS;
        PUSHMARK(SP); XPUSHs(newSVpv(message.c_str(), 0)); PUTBACK;
        retcnt = call_pv("RPerl::warning", G_SCALAR);
        SPAGAIN;
        if (retcnt != 1) { croak("RPerl::warning(message) return count is %"INTEGER", expected 1, croaking", retcnt); }
        retval = POPi; PUTBACK;
//        FREETMPS;
        LEAVE;

        return retval;
}

// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]

# else

Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!

# endif

#endif
