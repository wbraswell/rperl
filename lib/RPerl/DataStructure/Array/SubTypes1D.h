////use strict;  use warnings;
using std::cout;  using std::cerr;  using std::endl;

#ifndef __CPP__INCLUDED__RPerl__DataStructure__Array__SubTypes1D_h
#define __CPP__INCLUDED__RPerl__DataStructure__Array__SubTypes1D_h 0.020_000

#include <rperltypes_mode.h> // for definitions of __PERL__TYPES or __CPP__TYPES

// for type-checking subroutines & macros
#include <RPerl/HelperFunctions.cpp>  // -> HelperFunctions.h

// [[[ DATA TYPES ]]]
#include <RPerl/DataType/Integer.cpp>
#include <RPerl/DataType/Number.cpp>
#include <RPerl/DataType/String.cpp>

// [[[ TYPEDEFS ]]]
typedef std::vector<integer> integer_arrayref;
typedef std::vector<integer>::iterator integer_arrayref_iterator;
typedef std::vector<integer>::const_iterator integer_arrayref_const_iterator;
typedef std::vector<number> number_arrayref;
typedef std::vector<number>::iterator number_arrayref_iterator;
typedef std::vector<number>::const_iterator number_arrayref_const_iterator;
typedef std::vector<string> string_arrayref;
typedef std::vector<string>::iterator string_arrayref_iterator;
typedef std::vector<string>::const_iterator string_arrayref_const_iterator;

// [[[ TYPE-CHECKING SUBROUTINES ]]]
void integer_arrayref_CHECK(SV* possible_integer_arrayref);
void integer_arrayref_CHECKTRACE(SV* possible_integer_arrayref, const char* variable_name, const char* subroutine_name);
void number_arrayref_CHECK(SV* possible_number_arrayref);
void number_arrayref_CHECKTRACE(SV* possible_number_arrayref, const char* variable_name, const char* subroutine_name);
void string_arrayref_CHECK(SV* possible_string_arrayref);
void string_arrayref_CHECKTRACE(SV* possible_string_arrayref, const char* variable_name, const char* subroutine_name);

// [[[ OPERATIONS & DATA TYPES REPORTER ]]]
# ifdef __PERL__TYPES
SV* RPerl__DataStructure__Array__SubTypes1D__MODE_ID() { return(newSViv(1)); }  // CPPOPS_PERLTYPES is 1
# elif defined __CPP__TYPES
integer RPerl__DataStructure__Array__SubTypes1D__MODE_ID() { return 2; }  // CPPOPS_CPPTYPES is 2
# else
Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!
# endif

// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
# ifdef __CPP__TYPES
integer_arrayref XS_unpack_integer_arrayref(SV* input_avref);
void XS_pack_integer_arrayref(SV* output_avref, integer_arrayref input_vector);
number_arrayref XS_unpack_number_arrayref(SV* input_avref);
void XS_pack_number_arrayref(SV* output_avref, number_arrayref input_vector);
string_arrayref XS_unpack_string_arrayref(SV* input_avref);
void XS_pack_string_arrayref(SV* output_avref, string_arrayref input_vector);
# endif

// [[[ STRINGIFY ]]]
# ifdef __PERL__TYPES
SV* integer_arrayref_to_string_compact(SV* input_avref);
SV* integer_arrayref_to_string(SV* input_avref);
SV* integer_arrayref_to_string_pretty(SV* input_avref);
SV* integer_arrayref_to_string_extend(SV* input_avref);
SV* integer_arrayref_to_string_format(SV* input_avref, SV* format_level, SV* indent_level);
SV* number_arrayref_to_string_compact(SV* input_avref);
SV* number_arrayref_to_string(SV* input_avref);
SV* number_arrayref_to_string_pretty(SV* input_avref);
SV* number_arrayref_to_string_extend(SV* input_avref);
SV* number_arrayref_to_string_format(SV* input_avref, SV* format_level, SV* indent_level);
SV* string_arrayref_to_string_compact(SV* input_avref);
SV* string_arrayref_to_string(SV* input_avref);
SV* string_arrayref_to_string_pretty(SV* input_avref);
SV* string_arrayref_to_string_extend(SV* input_avref);
SV* string_arrayref_to_string_format(SV* input_avref, SV* format_level, SV* indent_level);
# elif defined __CPP__TYPES
string integer_arrayref_to_string_compact(integer_arrayref input_vector);
string integer_arrayref_to_string(integer_arrayref input_vector);
string integer_arrayref_to_string_pretty(integer_arrayref input_vector);
string integer_arrayref_to_string_extend(integer_arrayref input_vector);
string integer_arrayref_to_string_format(integer_arrayref input_vector, integer format_level, integer indent_level);
string number_arrayref_to_string_compact(number_arrayref input_vector);
string number_arrayref_to_string(number_arrayref input_vector);
string number_arrayref_to_string_pretty(number_arrayref input_vector);
string number_arrayref_to_string_extend(number_arrayref input_vector);
string number_arrayref_to_string_format(number_arrayref input_vector, integer format_level, integer indent_level);
string string_arrayref_to_string_compact(string_arrayref input_vector);
string string_arrayref_to_string(string_arrayref input_vector);
string string_arrayref_to_string_pretty(string_arrayref input_vector);
string string_arrayref_to_string_extend(string_arrayref input_vector);
string string_arrayref_to_string_format(string_arrayref input_vector, integer format_level, integer indent_level);

template <class CLASSNAME>
string arrayref_to_string_compact(CLASSNAME input_vector);
template <class CLASSNAME>
string arrayref_to_string(CLASSNAME input_vector);
template <class CLASSNAME>
string arrayref_to_string_pretty(CLASSNAME input_vector);
template <class CLASSNAME>
string arrayref_to_string_extend(CLASSNAME input_vector);
template <class CLASSNAME>
string arrayref_to_string_format(CLASSNAME input_vector, integer format_level, integer indent_level);

# endif

// [[[ TYPE TESTING ]]]
# ifdef __PERL__TYPES
SV* integer_arrayref_typetest0(SV* lucky_integers);
SV* integer_arrayref_typetest1(SV* my_size);
SV* number_arrayref_typetest0(SV* lucky_numbers);
SV* number_arrayref_typetest1(SV* my_size);
SV* string_arrayref_typetest0(SV* people);
SV* string_arrayref_typetest1(SV* my_size);
# elif defined __CPP__TYPES
string integer_arrayref_typetest0(integer_arrayref lucky_integers);
integer_arrayref integer_arrayref_typetest1(integer my_size);
string number_arrayref_typetest0(number_arrayref lucky_numbers);
number_arrayref number_arrayref_typetest1(integer my_size);
string string_arrayref_typetest0(string_arrayref people);
string_arrayref string_arrayref_typetest1(integer my_size);
# endif

// DEV NOTE, CORRELATION #rp310: separate declaration & implementation of templates
#include <RPerl/DataStructure/Array/SubTypes1D.tpp>  // -> ??? (relies on <vector> being included via Inline::CPP's AUTO_INCLUDE config option in RPerl/Inline.pm ???)

#endif
