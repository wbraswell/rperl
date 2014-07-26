#!/usr/bin/perl
use strict;
use warnings;

BEGIN { print "[[[ BEGIN 'use Inline' STAGE for 'DATA' ]]]\n"x3; }
use Inline (CPP => 'DATA',
TYPEMAPS => "blib/lib/typemap.rperl",
  CCFLAGSEX => '-DNO_XSLOCKS -Wno-deprecated -std=c++0x -Wno-reserved-user-defined-literal -Wno-literal-suffix',
  BUILD_NOISY => 1,
  CLEAN_AFTER_BUILD => 0, # cache it
  WARNINGS => 1,
  FILTERS => 'Preprocess',
  );
print "[[[ END 'use Inline' STAGE for 'DATA' ]]]\n"x3;

#my $string_retval = string__typetest0();
my $string_retval = string__typetest1('howdy');
print STDERR "in ntype.pl have \$string_retval = '$string_retval'\n";



__DATA__
__CPP__

////use strict;  use warnings;
using std::cout;  using std::cerr;

// [[[ TYPEDEFS ]]]
typedef std::string string;
typedef std::ostringstream ostringstream;

// [[[ OPERATIONS & DATA TYPES REPORTING ]]]
string string__ops() { string retval = "CPP";  return(retval); }
string string__types() { string retval = "CPP";  return(retval); }

// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
string XS_unpack_string(SV* input_sv);
void XS_pack_string(SV* output_sv, string input_string);

// [[[ STRINGIFY ]]]
string string__stringify(string input_string);

// [[[ TYPE TESTING ]]]
string string__typetest0();
string string__typetest1(string lucky_string);



// convert from (Perl SV containing string) to (C++ std::string)
string XS_unpack_string(SV* input_sv)
{
	return((string)SvPV_nolen(input_sv));
}

// convert from (C++ std::string) to (Perl SV containing string)
void XS_pack_string(SV* output_sv, string input_string) {
	sv_setsv(output_sv, sv_2mortal(newSVpv(input_string.data(), input_string.size())));
}

string string__stringify(string input_string)
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

string string__typetest0() {
	string retval = "Spice CPPOPS_CPPTYPES";
	return(retval);
}

string string__typetest1(string lucky_string) {
	return(string__stringify(lucky_string) + " CPPOPS_CPPTYPES");
}
