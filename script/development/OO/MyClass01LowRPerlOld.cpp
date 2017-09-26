// [[[ HEADER ]]]
using std::cout;  using std::cerr;  using std::endl;

#ifndef __CPP__INCLUDED__MyClass01LowRPerlOld_cpp
#define __CPP__INCLUDED__MyClass01LowRPerlOld_cpp 0.001_000

// [[[ INCLUDES ]]]
#include "MyClass01LowRPerlOld.h"

# ifdef __PERL__TYPES

Purposefully_die_from_a_compile-time_error,_due_to____PERL__TYPES_being_defined.__We_need_to_define_only___CPP__TYPES_in_this_file!

# elif defined __CPP__TYPES

// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]

// [[[ SUBROUTINES & OO METHODS ]]]

void MyClass01LowRPerlOld::double_bar_save() {
    this->bar = this->bar * 2;
}

integer MyClass01LowRPerlOld::double_bar_return() {
    return this->bar * 2;
}

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

#ifndef __CPP__INCLUDED__MySubclass01LowRPerlOld_cpp
#define __CPP__INCLUDED__MySubclass01LowRPerlOld_cpp 0.001_000

// [[[ INCLUDES ]]]
#include "MyClass01LowRPerlOld.h"

# ifdef __PERL__TYPES

Purposefully_die_from_a_compile-time_error,_due_to____PERL__TYPES_being_defined.__We_need_to_define_only___CPP__TYPES_in_this_file!

# elif defined __CPP__TYPES

// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]

// [[[ SUBROUTINES & OO METHODS ]]]

void MySubclass01LowRPerlOld::triple_bax_save() {
    this->bax = this->bax * 3;
}

integer MySubclass01LowRPerlOld::triple_bax_return() {
    return this->bax * 3;
}

integer MySubclass01LowRPerlOld::multiply_bax_return(integer multiplier) {
    if ( multiplier < 10 ) {
        return this->bax * multiplier;
    }
    return this->bax * 3;
}

// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]

# else

Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_only___CPP__TYPES_in_this_file!

# endif

#endif

// end of class
