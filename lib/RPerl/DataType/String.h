#ifndef __CPP__INCLUDED__RPerl__DataType__String_h

// [[[ TYPEDEFS FOR RPERL-TYPES-IN-C ]]]
typedef std::string string;
typedef std::ostringstream ostringstream;

// [[[ TYPEMAP PACK/UNPACK SUBROUTINE PROTOTYPE DECLARATIONS FOR RPERL-TYPES-IN-C ]]]
string XS_unpack_string(SV *input_sv);
void XS_pack_string(SV *output_sv, string input_string);


//# [[[ TYPE TESTING ]]]
//# [[[ TYPE TESTING ]]]
//# [[[ TYPE TESTING ]]]
string typetest___void__in___string__out();
string typetest___string__in___string__out(string fuzzword);

#endif
#define __CPP__INCLUDED__RPerl__DataType__String_h 1
