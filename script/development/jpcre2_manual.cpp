#include "jpcre2.hpp"
#include <iostream>

size_t count;
typedef jpcre2::select<char> jp;

//Check if string matches the pattern
/*
 * The following uses a temporary Regex object.
 */

int main() {

    std::cout << "\n\n" << "[[[ DEBUG ]]] BEFORE MATCH 1" << "\n\n";

    if(jp::Regex("(\\d)|(\\w)").match("I am the subject")) {
        std::cout << "\nmatched";
    }

    std::cout << "\n\n" << "[[[ DEBUG ]]] AFTER MATCH 1" << "\n\n";

/*
 * Using the modifier S (i.e jpcre2::JIT_COMPILE) with temporary object may or may not give you
 * any performance boost (depends on the complexity of the pattern). The more complex
 * the pattern gets, the more sense the S modifier makes.
 */

//If you want to match all and get the match count, use the action modifier 'g':
    std::cout << "\n\n" << "[[[ DEBUG ]]] BEFORE MATCH 2" << "\n\n";

    std::cout << "\n" << jp::Regex("(\\d)|(\\w)","m").match("I am the subject","g");

    std::cout << "\n\n" << "[[[ DEBUG ]]] AFTER MATCH 2" << "\n\n";
}
