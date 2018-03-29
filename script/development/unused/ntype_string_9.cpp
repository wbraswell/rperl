////use strict;  use warnings;
using std::cout;  using std::cerr;  using std::endl;

// [[[ TYPEDEFS ]]]
typedef std::string string;
typedef std::ostringstream ostringstream;

// [[[ OPERATIONS & DATA TYPES REPORTER ]]]
integer RPerl__DataType__String__MODE_ID() { return 2; }  // CPPOPS_CPPTYPES is 2

// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
string XS_unpack_string(SV* input_sv);
void XS_pack_string(SV* output_sv, string input_string);

// [[[ STRINGIFY ]]]
string string_to_string(string input_string);

// [[[ TYPE TESTING ]]]
string string_typetest0();
string string_typetest1(string lucky_string);



// convert from (Perl SV containing string) to (C++ std::string)
string XS_unpack_string(SV* input_sv)
{
	return((string)SvPV_nolen(input_sv));
}

// convert from (C++ std::string) to (Perl SV containing string)
void XS_pack_string(SV* output_sv, string input_string) {
	sv_setsv(output_sv, sv_2mortal(newSVpv(input_string.data(), input_string.size())));
}

string string_to_string(string input_string)
{
    size_t input_string_pos;

	// escape all back-slash \ and single-quote ' characters with a back-slash \ character
	input_string_pos = 0;
	while((input_string_pos = input_string.find("\\", input_string_pos)) != string::npos)
	{
		input_string.replace(input_string_pos, 1, "\\\\");
		input_string_pos += 2;
	}
	input_string_pos = 0;
	while((input_string_pos = input_string.find("'", input_string_pos)) != string::npos)
	{
		input_string.replace(input_string_pos, 1, "\\'");
		input_string_pos += 2;
	}

	input_string = "'" + input_string + "'";

	return(input_string);
}

string string_typetest0() {
	string retval = "Spice CPPOPS_CPPTYPES";
	return retval;
}

string string_typetest1(string lucky_string) {
	return(string_to_string(lucky_string) + " CPPOPS_CPPTYPES");
}
