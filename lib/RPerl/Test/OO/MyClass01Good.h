// [[[ HEADER ]]]
using std::cout;  using std::cerr;  using std::endl;

#ifndef __CPP__INCLUDED__RPerl__Test__OO__MyClass01Good_h
#define __CPP__INCLUDED__RPerl__Test__OO__MyClass01Good_h 0.001_000

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
class RPerl__Test__OO__MyClass01Good : public RPerl__CompileUnit__Module__Class__CPP {
public:
    // [[[ OO PROPERTIES ]]]
    integer bar = 23;

    // [[[ OO METHODS ]]]

    // <<< OO PROPERTIES, ACCESSORS & MUTATORS >>>
    integer get_bar() { return bar; }
    void set_bar(integer bar_new) { bar = bar_new; }

    // <<< CONSTRUCTOR & DESTRUCTOR >>>
    RPerl__Test__OO__MyClass01Good() {}
    ~RPerl__Test__OO__MyClass01Good() {}

    // <<< CLASS NAME REPORTER >>>
    virtual string myclassname() { return (const string) "RPerl::Test::OO::MyClass01Good"; }

    // <<< USER-DEFINED METHODS >>>
    void double_bar_save();
    integer double_bar_return();
};  // end of class

// [[[ OO SUBCLASSES ]]]
#define RPerl__Test__OO__MyClass01Good_rawptr RPerl__Test__OO__MyClass01Good*
typedef std::unique_ptr<RPerl__Test__OO__MyClass01Good> RPerl__Test__OO__MyClass01Good_ptr;
typedef std::vector<RPerl__Test__OO__MyClass01Good_ptr> RPerl__Test__OO__MyClass01Good_arrayref;
typedef std::unordered_map<string, RPerl__Test__OO__MyClass01Good_ptr> RPerl__Test__OO__MyClass01Good_hashref;
typedef std::unordered_map<string, RPerl__Test__OO__MyClass01Good_ptr>::iterator RPerl__Test__OO__MyClass01Good_hashref_iterator;

// [[[ OO CONSTRUCTOR WRAPPER CLASS ]]]
class NEW_RPerl__Test__OO__MyClass01Good {
public:
    RPerl__Test__OO__MyClass01Good_ptr wrapped_object;
    NEW_RPerl__Test__OO__MyClass01Good() : wrapped_object{new RPerl__Test__OO__MyClass01Good()} {}
    RPerl__Test__OO__MyClass01Good_ptr&& NEW() { return std::move(wrapped_object); }

    // <<< OO PROPERTIES, INITIALIZERS >>>
    NEW_RPerl__Test__OO__MyClass01Good& bar(integer bar_init) { wrapped_object->bar = bar_init; return *this; }
};

// <<< OPERATIONS & DATA TYPES REPORTER >>>
integer RPerl__Test__OO__MyClass01Good__MODE_ID() { return 2; }  // CPPOPS_CPPTYPES is 2

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

#ifndef __CPP__INCLUDED__RPerl__Test__OO__MySubclass01Good_h
#define __CPP__INCLUDED__RPerl__Test__OO__MySubclass01Good_h 0.001_000

// [[[ INCLUDES & OO INHERITANCE INCLUDES ]]]
//#include "RPerl/Test/OO/MyClass01Good.cpp" // DISABLED: do not recursively load the same .cpp/.h file from within itself

# ifdef __PERL__TYPES

Purposefully_die_from_a_compile-time_error,_due_to____PERL__TYPES_being_defined.__We_need_to_define_only___CPP__TYPES_in_this_file!

# elif defined __CPP__TYPES

// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]

// [[[ OO INHERITANCE ]]]
class RPerl__Test__OO__MySubclass01Good : public RPerl__Test__OO__MyClass01Good {
public:
    // [[[ OO PROPERTIES ]]]
    integer bax = 123;

    // [[[ OO METHODS ]]]

    // <<< OO PROPERTIES, ACCESSORS & MUTATORS >>>
    integer get_bax() { return bax; }
    void set_bax(integer bax_new) { bax = bax_new; }
    integer get_bar() { return bar; }  // inherited from RPerl::Test::OO::MyClass01Good::
    void set_bar(integer bar_new) { bar = bar_new; }  // inherited from RPerl::Test::OO::MyClass01Good::

    // <<< CONSTRUCTOR & DESTRUCTOR >>>
    RPerl__Test__OO__MySubclass01Good() {}
    ~RPerl__Test__OO__MySubclass01Good() {}

    // <<< CLASS NAME REPORTER >>>
    virtual string myclassname() { return (const string) "RPerl::Test::OO::MySubclass01Good"; }

    // <<< USER-DEFINED METHODS >>>
    void triple_bax_save();
    integer triple_bax_return();
    integer add_bax_return(integer addend);
    integer subtract_bax_return(integer subtrahend);
    integer multiply_bax_return(integer multiplier);
    integer multiply_multiply_bax_return(integer multiplier, integer multiplier2);
};  // end of class

// [[[ OO SUBCLASSES ]]]
#define RPerl__Test__OO__MySubclass01Good_rawptr RPerl__Test__OO__MySubclass01Good*
typedef std::unique_ptr<RPerl__Test__OO__MySubclass01Good> RPerl__Test__OO__MySubclass01Good_ptr;
typedef std::vector<RPerl__Test__OO__MySubclass01Good_ptr> RPerl__Test__OO__MySubclass01Good_arrayref;
typedef std::unordered_map<string, RPerl__Test__OO__MySubclass01Good_ptr> RPerl__Test__OO__MySubclass01Good_hashref;
typedef std::unordered_map<string, RPerl__Test__OO__MySubclass01Good_ptr>::iterator RPerl__Test__OO__MySubclass01Good_hashref_iterator;

// [[[ OO CONSTRUCTOR WRAPPER CLASS ]]]
class NEW_RPerl__Test__OO__MySubclass01Good {
public:
    RPerl__Test__OO__MySubclass01Good_ptr wrapped_object;
    NEW_RPerl__Test__OO__MySubclass01Good() : wrapped_object{new RPerl__Test__OO__MySubclass01Good()} {}
    RPerl__Test__OO__MySubclass01Good_ptr&& NEW() { return std::move(wrapped_object); }

    // <<< OO PROPERTIES, INITIALIZERS >>>
    NEW_RPerl__Test__OO__MySubclass01Good& bax(integer bax_init) { wrapped_object->bax = bax_init; return *this; }
    NEW_RPerl__Test__OO__MySubclass01Good& bar(integer bar_init) { wrapped_object->bar = bar_init; return *this; }  // inherited from RPerl::Test::OO::MyClass01Good::
};

// <<< OPERATIONS & DATA TYPES REPORTER >>>
integer RPerl__Test__OO__MySubclass01Good__MODE_ID() { return 2; }  // CPPOPS_CPPTYPES is 2

// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]

# else

Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_only___CPP__TYPES_in_this_file!

# endif

#endif

// end of class
