//!/usr/bin/rperl
// [[[ HEADER ]]]
#include <rperlstandalone.h>
#ifndef __CPP__INCLUDED__RPerl__Test__HashReference__program_40_good_cpp
#define __CPP__INCLUDED__RPerl__Test__HashReference__program_40_good_cpp 0.001_000
# ifdef __CPP__TYPES





// [[[ SUBROUTINES ]]]
void pretty_print(integer_arrayref_hashref input) {
    integer i;
    integer j;
    print "{" << endl;
    string_arrayref input_keys = {// <<< RP::O::E::O::N::So __DUMMY_SOURCE_CODE CPPOPS_CPPTYPES >>>
    };
    integer input_keys_count = input_keys.size();
    for ( i = 0; i < input_keys_count; i++ ) {
        string input_key = input_keys[i];
        integer_arrayref input_value = input[input_key];
        integer input_value_count = input_value.size();
        if ( i > 0 ) {
            print "," << endl;
        }
        print "    " << input_key << " => ";
        print "[ ";
        for ( j = 0; j < input_value_count; j++ ) {
            if ( j > 0 ) {
                print ", ";
            }
            print input_value[j];
        }
        print " ]";
    }
    print "\n" << "}";
    return;
}

string pretty_return(integer_arrayref_hashref input) {
    integer i;
    integer j;
    string retval = (const string) "";
    retval .= (const string) "{" + (const string) "\n";
    string_arrayref input_keys = {// <<< RP::O::E::O::N::So __DUMMY_SOURCE_CODE CPPOPS_CPPTYPES >>>
    };
    integer input_keys_count = input_keys.size();
    for ( i = 0; i < input_keys_count; i++ ) {
        string input_key = input_keys[i];
        integer_arrayref input_value = input[input_key];
        integer input_value_count = input_value.size();
        if ( i > 0 ) {
            retval .= (const string) "," + (const string) "\n";
        }
        retval .= (const string) "    " + input_key + (const string) " => ";
        retval .= (const string) "[ ";
        for ( j = 0; j < input_value_count; j++ ) {
            if ( j > 0 ) {
                retval .= (const string) ", ";
            }
            retval .= input_value[j];
        }
        retval .= (const string) " ]";
    }
    retval .= (const string) "\n" + (const string) "}";
    return retval;
}

int main() {
    // [[[ OPERATIONS HEADER ]]]

// [[[ OPERATIONS ]]]
    integer_arrayref_hashref foo = { {"key_0", {0, 1, 2, 3, 4}}, {"key_1", {5, 6, 7, 8, 9}}, {"key_2", {0, -1, -2, -3, -4}}, {"key_3", {-5, -6, -7, -8, -9}} };
    print "have printed  $foo = ";
    pretty_print(foo);
    print endl;
    print "have returned $foo = " << pretty_return(foo) << endl;












































































    // [[[ OPERATIONS FOOTER ]]]
    return 0;
}

// [[[ FOOTER ]]]
# elif defined __PERL__TYPES
Purposefully_die_from_a_compile-time_error,_due_to____PERL__TYPES_being_defined.__We_need_to_define_only___CPP__TYPES_in_this_file!
# endif
#endif
