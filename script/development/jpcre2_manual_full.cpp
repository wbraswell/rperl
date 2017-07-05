// NEW CODE
#include "jpcre2.hpp"
#include <iostream>

typedef jpcre2::select<char> jp;

int main() {



// SAMPLE CODE

//Check if string matches the pattern
/*
 * The following uses a temporary Regex object.
 */

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



    size_t count;

/*
 * Modifiers passed to the Regex constructor or with compile() function are compile modifiers
 * Modifiers passed with the match() or replace() functions are action modifiers
 */

// Substrings/Captured groups:

/*
 * *** Getting captured groups/substring ***
 *
 * captured groups or substrings are stored in maps/vectors for each match,
 * and each match is stored in a vector.
 * Thus captured groups are in a vector of maps/vectors.
 *
 * PCRE2 provides two types of substrings:
 *  1. numbered (indexed) substring
 *  2. named substring
 *
 * For the above two, we have two vectors respectively:
 *  1. jp::VecNum (Corresponding vector: jp::NumSub)
 *  2. jp::VecNas (Corresponding map: jp::MapNas)
 *
 * Another additional vector is available to get the substring position/number
 * for a particular captured group by name. It's a vector of name to number maps
 *  * jp::VecNtN (Corresponding map: jp:MapNtN)
 */

// ***** Get numbered substring ***** ///
jp::VecNum vec_num;
jp::RegexMatch rm;
jp::Regex re("(\\w+)\\s*(\\d+)","m");
count =
jp::RegexMatch(&re).setSubject("I am 23, I am digits 10")
                   .setModifier("g")
                   .setNumberedSubstringVector(&vec_num)
                   .match();
/*
* count (the return value) is guaranteed to give you the correct number of matches,
* while vec_num.size() may give you wrong result if any match result
* was failed to be inserted in the vector. This should not happen
* i.e count and vec_num.size() should always be equal.
*/
std::cout<<"\nNumber of matches: "<<count/* or vec_num.size()*/;

//Now vec_num is populated with numbered substrings for each match
//The size of vec_num is the total match count
//vec_num[0] is the first match
//The type of vec_num[0] is jp::NumSub
std::cout<<"\nTotal match of first match: "<<vec_num[0][0];
std::cout<<"\nCaptured group 1 of first match: "<<vec_num[0][1];
std::cout<<"\nCaptured group 2 of first match: "<<vec_num[0][2];

//captured group 3 doesn't exist, (with operator [] it's a segfault)
//std::cout<<"\nCaptured group 3 of first match: "<<vec_num[0][3];

//Using at() will throw std::out_of_range exception
//~ try {
    //~ std::cout<<"\nCaptured group 3 of first match: "<<vec_num[0].at(3);
//~ } catch (const std::out_of_range& e) {
    //~ std::cerr<<"\n"<<e.what();
//~ }


//There were two matches found (vec_num.size() == 2) in the above example
std::cout<<"\nTotal match of second match: "<<vec_num[1][0];      //Total match (group 0) from second match
std::cout<<"\nCaptured group 1 of second match: "<<vec_num[1][1]; //captured group 1 from second match
std::cout<<"\nCaptured group 2 of second match: "<<vec_num[1][2]; //captured group 2 from second match


// ***** Get named substring ***** //

jp::VecNas vec_nas;
jp::VecNtN vec_ntn; // We will get name to number map vector too
re.compile("(?<word>\\w+)\\s*(?<digit>\\d+)","m");
count =
jp::RegexMatch(&re).setSubject("I am 23, I am digits 10")
                   .setModifier("g")
                   //.setNumberedSubstringVector(vec_num) // We don't need it in this example
                   .setNamedSubstringVector(&vec_nas)
                   .setNameToNumberMapVector(&vec_ntn) // Additional (name to number maps)
                   .match();
std::cout<<"\nNumber of matches: "<<vec_nas.size()/* or count */;
//Now vec_nas is populated with named substrings for each match
//The size of vec_nas is the total match count
//vec_nas[0] is the first match
//The type of vec_nas[0] is jp::MapNas
std::cout<<"\nCaptured group (word) of first match: "<<vec_nas[0]["word"];
std::cout<<"\nCaptured group (digit) of first match: "<<vec_nas[0]["digit"];

//Trying to access a non-existence named substirng with [] operator will give you empty string
//If the existence of a substring is important, use the std::map::find() or std::map::at() 
//(>=C++11) function to access map elements.
/* //>=C++11
try{
    ///This will throw exception because the substring name 'name' doesn't exist
    std::cout<<"\nCaptured group (name) of first match: "<<vec_nas[0].at("name");
} catch(const std::logic_error& e){
    std::cerr<<"\nCaptured group (name) doesn't exist";
}*/

//There were two matches found (vec_nas.size() == 2) in the above example
std::cout<<"\nCaptured group (word) of second match: "<<vec_nas[1]["word"];
std::cout<<"\nCaptured group (digit) of second match: "<<vec_nas[1]["digit"];

//Get the position (number) of a captured group name (that was found in match)
std::cout<<"\nPosition of captured group (word) in first match: "<<vec_ntn[0]["word"];
std::cout<<"\nPosition of captured group (digit) in first match: "<<vec_ntn[0]["digit"];

/*
 * Replacement Examples
 * Replace pattern in a string with a replacement string
 *
 * The Regex::replace() function can take a subject and replacement string as argument.
 * 
 * You can also pass the subject with setSubject() function in method chain,
 * replacement string with setReplaceWith() function in method chain, etc ...
 * A call to RegexReplace::replace() in the method chain will return the resultant string
 */

std::cout<<"\n"<<
//replace first occurrence of a digit with @
jp::Regex("\\d").replace("I am the subject string 44", "@");

std::cout<<"\n"<<
//replace all occurrences of a digit with @
jp::Regex("\\d").replace("I am the subject string 44", "@", "g");

//swap two parts of a string
std::cout<<"\n"<<
jp::Regex("^([^\t]+)\t([^\t]+)$")
    .replace("I am the subject\tTo be swapped according to tab", "$2 $1");
    
//Doing the above with method chain:
re.compile("^([^\t]+)\t([^\t]+)$");
jp::RegexReplace(&re).setSubject("I am the subject\tTo be swapped according to tab")
                     .setReplaceWith("$2 $1")
                     .replace();



// NEW CODE
}
