// namespace RPerl::Test::IO::Print_00_Good;  // NEED UPGRADE: Perl vs C++ namespace compatibility
using std::cout;
using std::cerr;
// VERSION 0.003_003
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
string RPerl__Test__IO__Print_00_Good__ops() {
    string retval = "CPP";
    return (retval);
}
string RPerl__Test__IO__Print_00_Good__types() {
    string retval = "CPP";
    return (retval);
}
