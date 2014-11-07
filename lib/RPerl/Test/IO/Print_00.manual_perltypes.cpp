// namespace RPerl::Test::IO::Print_00;  // NEED UPGRADE: Perl vs C++ namespace compatibility
using std::cout;
using std::cerr;
// VERSION 0.001_003
#include <rperltypes.h>  // for data types and structures
#include <RPerl/HelperFunctions.cpp>		// -> HelperFunctions.h

// [[[ PROCEDURAL SUBROUTINE DECLARATION(S) ]]]
void greet_planet(SV* arg0);
//void greet_planet(SV* arg0, SV* arg1);
//void greet_planet(SV* arg0, SV* arg1, SV* arg2);

// [[[ PROCEDURAL SUBROUTINE DEFINITION(S) ]]]
void greet_planet(SV* arg0) {
//void greet_planet(SV* arg0, SV* arg1) {
//void greet_planet(SV* arg0, SV* arg1, SV* arg2) {
    // [[[ TYPE-CHECK ARGUMENT(S) ]]]
    //integer__CHECK(arg0);
    integer__CHECKTRACE(arg0, "arg0", "greet_planet()");
    //string__CHECK(arg1);
    //string__CHECKTRACE(arg1, "arg1", "greet_planet()");
    //number__array_ref__CHECK(arg2);
    //number__array_ref__CHECKTRACE(arg2, "arg2", "greet_planet()");

    // [[[ PRINT ARGUMENT(S) ]]]
    cout << "Hello, world! " << SvIV(arg0) << '\n'; // single-quote newline works
    //cout << "Hello, world! " << SvIV(arg0) << "\n";  // double-quote newline works
    //cout << "Hello, world! " << SvIV(arg0) << " " << SvPV_nolen(arg1) << '\n';
    //cout << "Hello, world! " << SvIV(arg0) << " " << SvPV_nolen(arg1) << " " << SvPV_nolen(number__array_ref__stringify(arg2)) << '\n';

    cout << "Goodbye from CPPOPS_PERLTYPES\n";
}

// [[[ OPERATIONS & DATA TYPES REPORTING ]]]
SV* RPerl__Test__IO__Print_00__ops() {
    return (newSVpv("CPP", 3));
}
SV* RPerl__Test__IO__Print_00__types() {
    return (newSVpv("PERL", 4));
}
