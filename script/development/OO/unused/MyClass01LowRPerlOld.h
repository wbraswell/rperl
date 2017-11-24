// [[[ HEADER ]]]
using std::cout;  using std::cerr;  using std::endl;

#ifndef __CPP__INCLUDED__MyClass01LowRPerlOld_h
#define __CPP__INCLUDED__MyClass01LowRPerlOld_h 0.001_000

// [[[ INCLUDES & OO INHERITANCE INCLUDES ]]]
#include <RPerl.cpp>  // -> RPerl.h -> (rperltypes_mode.h; rperloperations.h; rperltypes.h; HelperFunctions.cpp)
#include <RPerl/CompileUnit/Module/Class.cpp>

# ifdef __PERL__TYPES

Purposefully_die_from_a_compile-time_error,_due_to____PERL__TYPES_being_defined.__We_need_to_define_only___CPP__TYPES_in_this_file!

# elif defined __CPP__TYPES

// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]

// [[[ OO INHERITANCE ]]]
class MyClass01LowRPerlOld : public RPerl__CompileUnit__Module__Class__CPP {
public:
    // [[[ OO PROPERTIES ]]]
    integer bar = 23;

    // [[[ OO METHODS ]]]

    // <<< OO PROPERTIES, ACCESSORS & MUTATORS >>>
    integer get_bar() { return this->bar; }
    void set_bar(integer bar_new) { this->bar = bar_new; }

    // <<< CONSTRUCTOR & DESTRUCTOR >>>
    MyClass01LowRPerlOld() {}
    ~MyClass01LowRPerlOld() {}

    // <<< CLASS NAME REPORTER >>>
    virtual string myclassname() { return (const string) "MyClass01LowRPerlOld"; }

    // <<< USER-DEFINED METHODS >>>
    void double_bar_save();
    integer double_bar_return();
};  // end of class

// [[[ OO SUBCLASSES ]]]
#define MyClass01LowRPerlOld_rawptr MyClass01LowRPerlOld*
typedef std::unique_ptr<MyClass01LowRPerlOld> MyClass01LowRPerlOld_ptr;
typedef std::vector<MyClass01LowRPerlOld_ptr> MyClass01LowRPerlOld_arrayref;
typedef std::unordered_map<string, MyClass01LowRPerlOld_ptr> MyClass01LowRPerlOld_hashref;
typedef std::unordered_map<string, MyClass01LowRPerlOld_ptr>::iterator MyClass01LowRPerlOld_hashref_iterator;

// <<< OPERATIONS & DATA TYPES REPORTER >>>
integer MyClass01LowRPerlOld__MODE_ID() { return 2; }  // CPPOPS_CPPTYPES is 2

// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]

# else

Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_only___CPP__TYPES_in_this_file!

# endif

#endif

// end of class


// [[[ ADDITIONAL CLASSES ]]]

// [[[ HEADER ]]]
using std::cout;  using std::cerr;  using std::endl;

#ifndef __CPP__INCLUDED__MySubclass01LowRPerlOld_h
#define __CPP__INCLUDED__MySubclass01LowRPerlOld_h 0.001_000

// [[[ INCLUDES & OO INHERITANCE INCLUDES ]]]

# ifdef __PERL__TYPES

Purposefully_die_from_a_compile-time_error,_due_to____PERL__TYPES_being_defined.__We_need_to_define_only___CPP__TYPES_in_this_file!

# elif defined __CPP__TYPES

// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]

// [[[ OO INHERITANCE ]]]
class MySubclass01LowRPerlOld : public MyClass01LowRPerlOld {
public:
    // [[[ OO PROPERTIES ]]]
    integer bax = 123;

    // [[[ OO METHODS ]]]

    // <<< OO PROPERTIES, ACCESSORS & MUTATORS >>>
    integer get_bax() { return this->bax; }
    void set_bax(integer bax_new) { this->bax = bax_new; }
    integer get_bar() { return this->bar; }
    void set_bar(integer bar_new) { this->bar = bar_new; }

    // <<< CONSTRUCTOR & DESTRUCTOR >>>
    MySubclass01LowRPerlOld() {}
    ~MySubclass01LowRPerlOld() {}

    // <<< CLASS NAME REPORTER >>>
    virtual string myclassname() { return (const string) "MySubclass01LowRPerlOld"; }

    // <<< USER-DEFINED METHODS >>>
    void triple_bax_save();
    integer triple_bax_return();
    integer multiply_bax_return(integer multiplier);
};  // end of class

// [[[ OO SUBCLASSES ]]]
#define MySubclass01LowRPerlOld_rawptr MySubclass01LowRPerlOld*
typedef std::unique_ptr<MySubclass01LowRPerlOld> MySubclass01LowRPerlOld_ptr;
typedef std::vector<MySubclass01LowRPerlOld_ptr> MySubclass01LowRPerlOld_arrayref;
typedef std::unordered_map<string, MySubclass01LowRPerlOld_ptr> MySubclass01LowRPerlOld_hashref;
typedef std::unordered_map<string, MySubclass01LowRPerlOld_ptr>::iterator MySubclass01LowRPerlOld_hashref_iterator;

// <<< OPERATIONS & DATA TYPES REPORTER >>>
integer MySubclass01LowRPerlOld__MODE_ID() { return 2; }  // CPPOPS_CPPTYPES is 2

// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]

# else

Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_only___CPP__TYPES_in_this_file!

# endif

#endif

// end of class
