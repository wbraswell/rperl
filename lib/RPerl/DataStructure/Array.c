#include "/tmp/RPerl-latest/lib/RPerl/DataStructure/Array.h"		// -> ???
//	#include <RPerl/DataStructure/Array.h>


/*
 * NEED FIX, CORRELATION #02: bug, possibly in Inline, causing inability to declare 3rd count_FOO argument to T_PACKEDARRAY;
 * temporarily fixed by changing typemap to set char** to T_PACKED;
 * may need Inline to add declaration of count_FOO to PREINIT section of auto-generated XS code
 *
 * eval_469_2d18.c: In function ‘void XS_main_XS_unpack_charPtrPtr(PerlInterpreter*, CV*)’:
 * eval_469_2d18.c:1322:36: error: ‘count_charPtrPtr’ was not declared in this scope
 */

#ifndef __CPP__INCLUDED__RPerl__DataStructure__Array_c

// CODE FROM: Dean Roehrich's Perl API Cookbook A
// LICENSE: none???
// http://search.cpan.org/~dmr/CookBookA-19960430/
// http://cpansearch.perl.org/src/DMR/CookBookA-19960430/Ex8/Av_CharPtrPtr.c
// ALL CODE COPIED VERBATIM EXCEPT WHERE NOTED

// [[[ BEGIN ORIGINAL CODE droehrich ]]]
// [[[ BEGIN ORIGINAL CODE droehrich ]]]
// [[[ BEGIN ORIGINAL CODE droehrich ]]]

/* Used by the INPUT typemap for char**.
 * Will convert a Perl AV* (containing strings) to a C char**.
 */
//char ** XS_unpack_charPtrPtr( rv ) SV *rv;  // ORIGINAL CODE droehrich
char **XS_unpack_charPtrPtr(SV *rv)  // MODIFIED CODE
{
	AV *av;
	SV **ssv;
	char **s;
	int avlen;
	int x;

	if( SvROK( rv ) && (SvTYPE(SvRV(rv)) == SVt_PVAV) )
		av = (AV*)SvRV(rv);
	else {
		warn("XS_unpack_charPtrPtr: rv was not an AV ref");
		return( (char**)NULL );
	}

	/* is it empty? */
	avlen = av_len(av);
	if( avlen < 0 ){
		warn("XS_unpack_charPtrPtr: array was empty");
		return( (char**)NULL );
	}

	/* av_len+2 == number of strings, plus 1 for an end-of-array sentinel.
	 */
	s = (char **)safemalloc( sizeof(char*) * (avlen + 2) );
	if( s == NULL ){
		warn("XS_unpack_charPtrPtr: unable to malloc char**");
		return( (char**)NULL );
	}
	for( x = 0; x <= avlen; ++x ){
		ssv = av_fetch( av, x, 0 );
		if( ssv != NULL ){
			if( SvPOK( *ssv ) ){
				s[x] = (char *)safemalloc( SvCUR(*ssv) + 1 );
				if( s[x] == NULL )
					warn("XS_unpack_charPtrPtr: unable to malloc char*");
				else
//					strcpy( s[x], SvPV( *ssv, na ) );  // ORIGINAL CODE droehrich
					strcpy( s[x], SvPV( *ssv, PL_na ) );  // MODIFIED CODE
			}
			else
				warn("XS_unpack_charPtrPtr: array elem %d was not a string.", x );
		}
		else
			s[x] = (char*)NULL;
	}
	s[x] = (char*)NULL; /* sentinel */
	return( s );
}

// [[[ END ORIGINAL CODE droehrich ]]]
// [[[ END ORIGINAL CODE droehrich ]]]
// [[[ END ORIGINAL CODE droehrich ]]]


// CODE FROM: Foswiki
// LICENSE: GPL
// http://foswiki.org/
// ALL CODE COPIED VERBATIM EXCEPT WHERE NOTED

// [[[ BEGIN ORIGINAL CODE foswiki ]]]
// [[[ BEGIN ORIGINAL CODE foswiki ]]]
// [[[ BEGIN ORIGINAL CODE foswiki ]]]

/* * Convert a char** to a Perl AV*, freeing the char** and the strings
 * stored in it.  The function name is dictated by the mapping in the
 * default typemap i.e. (char** -> T_PACKEDARRAY -> XS_pack_charPtrPtr */
//void XS_pack_charPtrPtr(SV* st, char **s, int n)  // ORIGINAL CODE foswiki
//void XS_pack_charPtrPtr(SV* st, char **s, int count_charPtrPtr)  // MODIFIED CODE
void XS_pack_charPtrPtr(SV* st, char **s)  // MODIFIED CODE
//static void XS_pack_charPtrPtr(st, s, count_charPtrPtr) SV *st;  char **s;  UV count_charPtrPtr;  // MODIFIED CODE
//static void XS_pack_charPtrPtr(SV *st, char **s, UV count_charPtrPtr)  // MODIFIED CODE
{
	AV *av = newAV();
//	UV count_charPtrPtr = 99;  // MODIFIED CODE

    if (s) {
    	char **c;
    	for (c = s; *c; c++) {
    		SV * sv = newSVpv(*c, 0);
    		av_push(av, sv);
            free(*c);
    	}
        free(s);
    }

	SV * sv = newSVrv(st, NULL);	  /* upgrade stack SV to an RV */
	SvREFCNT_dec(sv);         /* discard */
	SvRV(st) = (SV*)av;       /* make stack RV point at our AV */
}

// [[[ END ORIGINAL CODE foswiki ]]]
// [[[ END ORIGINAL CODE foswiki ]]]
// [[[ END ORIGINAL CODE foswiki ]]]

#endif
#define __CPP__INCLUDED__RPerl__DataStructure__Array_c 1
