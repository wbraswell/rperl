#ifndef __CPP__INCLUDED__RPerl__DataStructure__Array_h

// CODE FROM: Dean Roehrich's Perl API Cookbook A
// LICENSE: none???
// http://search.cpan.org/~dmr/CookBookA-19960430/
// http://cpansearch.perl.org/src/DMR/CookBookA-19960430/Ex8/Av_CharPtrPtr.c
// ALL CODE COPIED VERBATIM EXCEPT WHERE NOTED

// [[[ BEGIN ORIGINAL CODE droehrich ]]]
// [[[ BEGIN ORIGINAL CODE droehrich ]]]
// [[[ BEGIN ORIGINAL CODE droehrich ]]]

char **XS_unpack_charPtrPtr ( SV *rv );
//void XS_pack_charPtrPtr ( SV *st, char **s );  // ORIGINAL CODE droehrich
//void XS_pack_charPtrPtr ( SV *st, char **s, int count_charPtrPtr );  // MODIFIED CODE
void XS_pack_charPtrPtr ( SV *st, char **s );  // MODIFIED CODE
//static void XS_pack_charPtrPtr(SV *st, char **s, UV count_charPtrPtr);  // MODIFIED CODE
// [[[ END ORIGINAL CODE droehrich ]]]
// [[[ END ORIGINAL CODE droehrich ]]]
// [[[ END ORIGINAL CODE droehrich ]]]

#endif
#define __CPP__INCLUDED__RPerl__DataStructure__Array_h 1
