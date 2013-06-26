#ifndef __CPP__INCLUDED__RPerl__DataStructure__Array_h

#include <vector>

// [[[ TYPEDEFS FOR RPERL-TYPES-IN-C ]]]
typedef char* string;
typedef char** string__array_ref;
typedef std::vector<int> int__array_ref;

// [[[ TYPEMAP PACK/UNPACK SUBROUTINE PROTOTYPE DECLARATIONS FOR RPERL-TYPES-IN-C ]]]
int__array_ref XS_unpack_int__array_ref(SV *input);
void XS_pack_int__array_ref(SV *output, int__array_ref input);

// CODE FROM: Dean Roehrich's Perl API Cookbook A
// LICENSE: none???
// http://search.cpan.org/~dmr/CookBookA-19960430/
// http://cpansearch.perl.org/src/DMR/CookBookA-19960430/Ex8/Av_CharPtrPtr.c
// ALL CODE COPIED VERBATIM EXCEPT WHERE NOTED

// [[[ BEGIN ORIGINAL CODE droehrich ]]]
// [[[ BEGIN ORIGINAL CODE droehrich ]]]
// [[[ BEGIN ORIGINAL CODE droehrich ]]]

//char **XS_unpack_charPtrPtr ( SV *rv );
string__array_ref XS_unpack_string__array_ref ( SV *rv );
//void XS_pack_charPtrPtr ( SV *st, char **s );  // ORIGINAL CODE droehrich
//void XS_pack_charPtrPtr ( SV *st, char **s, int count_charPtrPtr );  // MODIFIED CODE
//void XS_pack_charPtrPtr ( SV *st, char **s );  // MODIFIED CODE
void XS_pack_string__array_ref ( SV *st, string__array_ref s );  // MODIFIED CODE
//static void XS_pack_charPtrPtr(SV *st, char **s, UV count_charPtrPtr);  // MODIFIED CODE
// [[[ END ORIGINAL CODE droehrich ]]]
// [[[ END ORIGINAL CODE droehrich ]]]
// [[[ END ORIGINAL CODE droehrich ]]]



//# [[[ TYPE TESTING ]]]
//# [[[ TYPE TESTING ]]]
//# [[[ TYPE TESTING ]]]
void typetest___int__in___void__out(int fuzznum);  // CPP_TYPES
void typetest___string__in___void__out(char* fuzzword);  // CPP_TYPES
void typetest___int__array_ref__in___void__out(int__array_ref lucky_numbers);  // CPP_TYPES
void typetest___string__array_ref__in___void__out(string__array_ref people);  // CPP_TYPES
string__array_ref typetest___void__in___string__array_ref__out();  // CPP_TYPES



#endif
#define __CPP__INCLUDED__RPerl__DataStructure__Array_h 1
