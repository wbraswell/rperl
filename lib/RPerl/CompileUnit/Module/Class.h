// [[[ HEADER ]]]
using std::cout;  using std::cerr;

#ifndef __CPP__INCLUDED__RPerl__CompileUnit__Module__Class__CPP_h
#define __CPP__INCLUDED__RPerl__CompileUnit__Module__Class__CPP_h 0.001_000

// [[[ INCLUDES ]]]
// BASE CLASS DOES NOT INCLUDE RPerl.cpp OR HelperFunctions.cpp
#include <rperltypes_mode.h>  // for definitions of __PERL__TYPES or __CPP__TYPES
#include <rperltypes.h>  // for data types and structures

# ifdef __PERL__TYPES

// [[[<<< BEGIN PERL TYPES >>>]]]
// [[[<<< BEGIN PERL TYPES >>>]]]
// [[[<<< BEGIN PERL TYPES >>>]]]

// [[[ OO INHERITANCE ]]]
// BASE CLASS HAS NO INHERITANCE
class RPerl__CompileUnit__Module__Class__CPP
{
public:
// [[[ OO METHODS ]]]
    // <<< OO PROPERTIES, ACCESSORS & MUTATORS >>>
    // BASE CLASS HAS NO PROPERTIES

    // <<< CONSTRUCTOR & DESTRUCTOR >>>
    RPerl__CompileUnit__Module__Class__CPP() {}
    ~RPerl__CompileUnit__Module__Class__CPP() {}

    // <<< CLASS NAME REPORTER >>>
    virtual SV* myclassname() { return newSVpv("RPerl::CompileUnit::Module::Class", 0); }

//private:
// [[[ OO PROPERTIES ]]]
// BASE CLASS HAS NO PROPERTIES
};

// [[[ SUBROUTINES ]]]

// DEV NOTE: this is inherited by all RPerl C++ classes, which allows us to call C++ classname(object) as generated from RPerl class($object)
SV* classname(RPerl__CompileUnit__Module__Class__CPP* my_object) { return my_object->myclassname(); }

// [[[<<< END PERL TYPES >>>]]]
// [[[<<< END PERL TYPES >>>]]]
// [[[<<< END PERL TYPES >>>]]]

# elif defined __CPP__TYPES

// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]

// [[[ OO INHERITANCE ]]]
// BASE CLASS HAS NO INHERITANCE
class RPerl__CompileUnit__Module__Class__CPP
{
public:
// [[[ OO METHODS ]]]
    // <<< OO PROPERTIES, ACCESSORS & MUTATORS >>>
    // BASE CLASS HAS NO PROPERTIES

    // <<< CONSTRUCTOR & DESTRUCTOR >>>
    RPerl__CompileUnit__Module__Class__CPP() {}
    ~RPerl__CompileUnit__Module__Class__CPP() {}

    // <<< CLASS NAME REPORTER >>>
    virtual string myclassname() { return (const string) "RPerl::CompileUnit::Module::Class"; }

//private:
// [[[ OO PROPERTIES ]]]
// BASE CLASS HAS NO PROPERTIES
};

// [[[ SUBROUTINES ]]]

// DEV NOTE: this is inherited by all RPerl C++ classes, which allows us to call C++ classname(object) as generated from RPerl class($object)
string classname(RPerl__CompileUnit__Module__Class__CPP* my_object) { return my_object->myclassname(); }

// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]

# else

Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!

# endif

#endif
