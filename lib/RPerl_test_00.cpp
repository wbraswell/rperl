// namespace RPerl_test_00;  // NEED UPGRADE: Perl vs C++ namespace compatibility
using std::cout;
using std::cerr;
// VERSION 0.002_000
#include <rperltypes.h>  // for data types and structures
#include <RPerl/HelperFunctions.cpp>  // -> HelperFunctions.h

// [[[ PROCEDURAL SUBROUTINE DECLARATION(S) ]]]
void greet_planet(integer arg0);

// [[[ PROCEDURAL SUBROUTINE DEFINITION(S) ]]]
void greet_planet(integer arg0){
    cerr << "Hello, world! comma " << arg0 << " and " << 42 << "\n";
    cout << "Goodbye from CPPOPS_CPPTYPES\n";
}

// [[[ OPERATIONS & DATA TYPES REPORTING ]]]
string RPerl_test_00__ops() {
    string retval = "CPP";
    return (retval);
}
string RPerl_test_00__types() {
    string retval = "CPP";
    return (retval);
}
