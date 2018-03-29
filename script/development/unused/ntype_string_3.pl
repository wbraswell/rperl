#!/usr/bin/perl
use strict;  use warnings;

BEGIN { print "[[[ BEGIN 'use Inline' STAGE for 'DATA' ]]]\n"x3; }
use Inline (CPP => 'DATA',
  TYPEMAPS => "blib/lib/typemap.rperl",
  CCFLAGSEX => '-DNO_XSLOCKS -Wno-deprecated -std=c++0x -Wno-reserved-user-defined-literal -Wno-literal-suffix',
  BUILD_NOISY => 1,
  CLEAN_AFTER_BUILD => 0, # cache it
  WARNINGS => 1,
);
print "[[[ END   'use Inline' STAGE for 'DATA' ]]]\n"x3;

my $string_retval = string_typetest0();
RPerl::diag("in ntype_string_1a.pl have \$string_retval = '$string_retval'\n");

__DATA__
__CPP__

using std::cout;  using std::cerr;  using std::endl;
typedef std::string string;
typedef std::ostringstream ostringstream;

// convert from (Perl SV containing string) to (C++ std::string)
string XS_unpack_string(SV* input_sv)
{
	return((string)SvPV_nolen(input_sv));
}

// convert from (C++ std::string) to (Perl SV containing string)
void XS_pack_string(SV* output_sv, string input_string) {
	sv_setsv(output_sv, sv_2mortal(newSVpv(input_string.data(), input_string.size())));
}

string string_typetest0() {
	string retval = "Spice CPPOPS_CPPTYPES";
	return retval;
}
