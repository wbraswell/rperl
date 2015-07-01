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
    //integer_CHECK(arg0);
    integer_CHECKTRACE(arg0, "arg0", "greet_planet()");
    //string_CHECK(arg1);
    //string_CHECKTRACE(arg1, "arg1", "greet_planet()");
    //number_arrayref_CHECK(arg2);
    //number_arrayref_CHECKTRACE(arg2, "arg2", "greet_planet()");

    // [[[ PRINT ARGUMENT(S) ]]]
    cout << "Hello, world! " << SvIV(arg0) << '\n'; // single-quote newline works
    //cout << "Hello, world! " << SvIV(arg0) << "\n";  // double-quote newline works
    //cout << "Hello, world! " << SvIV(arg0) << " " << SvPV_nolen(arg1) << '\n';
    //cout << "Hello, world! " << SvIV(arg0) << " " << SvPV_nolen(arg1) << " " << SvPV_nolen(number_arrayref_to_string(arg2)) << '\n';

    cout << "Goodbye from CPPOPS_PERLTYPES\n";
}

// [[[ OPERATIONS & DATA TYPES REPORTER ]]]
SV* RPerl__Test__IO__Print_00__MODE_ID() {
    return (newSViv(1));  // CPPOPS_PERLTYPES is 1
}
