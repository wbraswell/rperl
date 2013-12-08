////use strict;  use warnings;
using std::cout;  using std::endl;

#ifndef __CPP__INCLUDED__RPerl__DataType__String_h
#define __CPP__INCLUDED__RPerl__DataType__String_h 1

// [[[ TYPEDEFS FOR RPERL-TYPES-IN-C ]]]
typedef std::string string;
typedef std::ostringstream ostringstream;

#include <types.h> // for definitions of __PERL__TYPES or __CPP__TYPES

// [[[ TYPEMAP PACK/UNPACK SUBROUTINE PROTOTYPE DECLARATIONS FOR RPERL-TYPES-IN-C ]]]
string XS_unpack_string(SV* input_sv);
void XS_pack_string(SV* output_sv, string input_string);

// [[[ DATA TYPES & OPERATIONS ]]]
# ifdef __PERL__TYPES
SV* types_string() { return(newSVpv("PERL", 4)); }
SV* ops_string() { return(newSVpv("CPP", 3)); }
# elif defined __CPP__TYPES
string types_string() { string retval = "CPP";  return(retval); }
string ops_string() { string retval = "CPP";  return(retval); }
# else
Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!
# endif

//# [[[ TYPE TESTING ]]]
# ifdef __PERL__TYPES
SV* typetest___void__in___string__out();
SV* typetest___string__in___string__out(SV* fuzzword);
# elif defined __CPP__TYPES
string typetest___void__in___string__out();
string typetest___string__in___string__out(string fuzzword);
# endif

#endif
