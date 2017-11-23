//!/usr/bin/rperl

// [[[ HEADER ]]]
#include <rperlstandalone.h>
#ifndef __CPP__INCLUDED__oo02_low_rperl_new_cpp
#define __CPP__INCLUDED__oo02_low_rperl_new_cpp 0.001_000
# ifdef __CPP__TYPES




// [[[ INCLUDES ]]]
#include "oo02_low_rperl_new.h"
int main() {
    // [[[ OPERATIONS HEADER ]]]

// [[[ OPERATIONS ]]]
    MyClass02LowRPerlNew_ptr my_object = NEW_MyClass02LowRPerlNew{}.bar(22).NEW();  // WBRASWELL
    print "have $my_object->get_bar() = " << my_object->get_bar() << endl;
    print "BEFORE double_bar_save()..." << endl;
    my_object->double_bar_save();
    print "AFTER double_bar_save()..." << endl;
    print "have $my_object->get_bar() = " << my_object->get_bar() << endl;
    print "have $my_object->double_bar_return() = " << my_object->double_bar_return() << endl;
    print "have $my_object->get_bar() = " << my_object->get_bar() << endl;

    MySubclass02LowRPerlNew_ptr my_object_subclass(new MySubclass02LowRPerlNew);  // NOT MODIFIED, NO NAMED PARAMS
    print "have $my_object_subclass->get_bar() = " << my_object_subclass->get_bar() << endl;
    print "have $my_object_subclass->get_bax() = " << my_object_subclass->get_bax() << endl;
    my_object_subclass->triple_bax_save();
    print "have $my_object_subclass->get_bax() = " << my_object_subclass->get_bax() << endl;
    print "have $my_object_subclass->triple_bax_return() = " << my_object_subclass->triple_bax_return() << endl;
    print "have $my_object_subclass->get_bax() = " << my_object_subclass->get_bax() << endl;
    print "have $my_object_subclass->multiply_bax_return(2) = " << my_object_subclass->multiply_bax_return(2) << endl;
    print "have $my_object_subclass->get_bax() = " << my_object_subclass->get_bax() << endl;
    print "have $my_object_subclass->multiply_bax_return(20) = " << my_object_subclass->multiply_bax_return(20) << endl;
    print "have $my_object_subclass->get_bax() = " << my_object_subclass->get_bax() << endl;

    MySubclass02LowRPerlNew_ptr my_object_subclass2 = NEW_MySubclass02LowRPerlNew{}.bar(33).bax(88).NEW();  // WBRASWELL
    print "have $my_object_subclass2->get_bar() = " << my_object_subclass2->get_bar() << endl;
    print "have $my_object_subclass2->get_bax() = " << my_object_subclass2->get_bax() << endl;
    my_object_subclass2->triple_bax_save();
    print "have $my_object_subclass2->get_bax() = " << my_object_subclass2->get_bax() << endl;
    print "have $my_object_subclass2->triple_bax_return() = " << my_object_subclass2->triple_bax_return() << endl;
    print "have $my_object_subclass2->get_bax() = " << my_object_subclass2->get_bax() << endl;
    print "have $my_object_subclass2->multiply_bax_return(2) = " << my_object_subclass2->multiply_bax_return(2) << endl;
    print "have $my_object_subclass2->get_bax() = " << my_object_subclass2->get_bax() << endl;
    print "have $my_object_subclass2->multiply_bax_return(20) = " << my_object_subclass2->multiply_bax_return(20) << endl;
    print "have $my_object_subclass2->get_bax() = " << my_object_subclass2->get_bax() << endl;

    // [[[ OPERATIONS FOOTER ]]]
    return 0;
}

// [[[ FOOTER ]]]
# elif defined __PERL__TYPES
Purposefully_die_from_a_compile-time_error,_due_to____PERL__TYPES_being_defined.__We_need_to_define_only___CPP__TYPES_in_this_file!
# endif
#endif
