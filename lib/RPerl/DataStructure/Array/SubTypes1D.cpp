using std::cout;  using std::cerr;  using std::endl;  using std::to_string;

#ifndef __CPP__INCLUDED__RPerl__DataStructure__Array__SubTypes1D_cpp
#define __CPP__INCLUDED__RPerl__DataStructure__Array__SubTypes1D_cpp 0.003_000

#include <RPerl/DataStructure/Array/SubTypes1D.h>		// -> ???

/*
* NEED FIX, CORRELATION #rp002: bug, possibly in Inline, causing inability to declare 3rd count_FOO argument to T_PACKEDARRAY;
* temporarily fixed by changing typemap to set char** to T_PACKED;
* may need Inline to add declaration of count_FOO to PREINIT section of auto-generated XS code
*
* eval_FOO.c: In function ‘void XS_main_XS_unpack_charPtrPtr(PerlInterpreter*, CV*)’:
* eval_FOO.c:1322:36: error: ‘count_charPtrPtr’ was not declared in this scope
*/

// [[[ TYPE-CHECKING ]]]
// [[[ TYPE-CHECKING ]]]
// [[[ TYPE-CHECKING ]]]

// DEV NOTE: for() loops are statements not expressions, so they can't be embedded in ternary operators, and thus this type-checking must be done with subroutines instead of macros
void integer_arrayref_CHECK(SV* possible_integer_arrayref)
{
   // DEV NOTE: the following two if() statements are functionally equivalent to the arrayref_CHECK() macro, but with integer-specific error codes
   if ( not( SvOK(possible_integer_arrayref) ) ) { croak( "\nERROR EIVAVRV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger_arrayref value expected but undefined/null value found,\ncroaking" ); }
   if ( not( SvAROKp(possible_integer_arrayref) ) ) { croak( "\nERROR EIVAVRV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger_arrayref value expected but non-arrayref value found,\ncroaking" ); }

   AV* possible_integer_array;
   integer possible_integer_array_length;
   integer i;
   SV** possible_integer_array_element;

   possible_integer_array = (AV*)SvRV(possible_integer_arrayref);
   possible_integer_array_length = av_len(possible_integer_array) + 1;

   for (i = 0;  i < possible_integer_array_length;  ++i)  // incrementing iteration
   {
       possible_integer_array_element = av_fetch(possible_integer_array, i, 0);

       // DEV NOTE: the following two if() statements are functionally equivalent to the integer_CHECK() macro & subroutine, but with array-specific error codes
       if (not(SvOK(*possible_integer_array_element))) { croak("\nERROR EIVAVRV02, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger_arrayref element value expected but undefined/null value found at index %"INTEGER",\ncroaking", i); }
       if (not(SvIOKp(*possible_integer_array_element))) { croak("\nERROR EIVAVRV03, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger_arrayref element value expected but non-integer value found at index %"INTEGER",\ncroaking", i); }
   }
}

void integer_arrayref_CHECKTRACE(SV* possible_integer_arrayref, const char* variable_name, const char* subroutine_name)
{
   if ( not( SvOK(possible_integer_arrayref) ) ) { croak( "\nERROR EIVAVRV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger_arrayref value expected but undefined/null value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name ); }
   if ( not( SvAROKp(possible_integer_arrayref) ) ) { croak( "\nERROR EIVAVRV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger_arrayref value expected but non-arrayref value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name ); }

   AV* possible_integer_array;
   integer possible_integer_array_length;
   integer i;
   SV** possible_integer_array_element;

   possible_integer_array = (AV*)SvRV(possible_integer_arrayref);
   possible_integer_array_length = av_len(possible_integer_array) + 1;

   for (i = 0;  i < possible_integer_array_length;  ++i)  // incrementing iteration
   {
       possible_integer_array_element = av_fetch(possible_integer_array, i, 0);

       if (not(SvOK(*possible_integer_array_element))) { croak("\nERROR EIVAVRV02, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger_arrayref element value expected but undefined/null value found at index %"INTEGER",\nin variable %s from subroutine %s,\ncroaking", i, variable_name, subroutine_name); }
       if (not(SvIOKp(*possible_integer_array_element))) { croak("\nERROR EIVAVRV03, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger_arrayref element value expected but non-integer value found at index %"INTEGER",\nin variable %s from subroutine %s,\ncroaking", i, variable_name, subroutine_name); }
   }
}

void number_arrayref_CHECK(SV* possible_number_arrayref)
{
   if ( not( SvOK(possible_number_arrayref) ) ) { croak( "\nERROR ENVAVRV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber_arrayref value expected but undefined/null value found,\ncroaking" ); }
   if ( not( SvAROKp(possible_number_arrayref) ) ) { croak( "\nERROR ENVAVRV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber_arrayref value expected but non-arrayref value found,\ncroaking" ); }

   AV* possible_number_array;
   integer possible_number_array_length;
   integer i;
   SV** possible_number_array_element;

   possible_number_array = (AV*)SvRV(possible_number_arrayref);
   possible_number_array_length = av_len(possible_number_array) + 1;

   for (i = 0;  i < possible_number_array_length;  ++i)  // incrementing iteration
   {
       possible_number_array_element = av_fetch(possible_number_array, i, 0);

       if (not(SvOK(*possible_number_array_element))) { croak("\nERROR ENVAVRV02, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber_arrayref element value expected but undefined/null value found at index %"INTEGER",\ncroaking", i); }
       if (not(SvNOKp(*possible_number_array_element) || SvIOKp(*possible_number_array_element))) { croak("\nERROR ENVAVRV03, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber_arrayref element value expected but non-number value found at index %"INTEGER",\ncroaking", i); }
   }
}

void number_arrayref_CHECKTRACE(SV* possible_number_arrayref, const char* variable_name, const char* subroutine_name)
{
   if ( not( SvOK(possible_number_arrayref) ) ) { croak( "\nERROR ENVAVRV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber_arrayref value expected but undefined/null value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name ); }
   if ( not( SvAROKp(possible_number_arrayref) ) ) { croak( "\nERROR ENVAVRV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber_arrayref value expected but non-arrayref value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name ); }

   AV* possible_number_array;
   integer possible_number_array_length;
   integer i;
   SV** possible_number_array_element;

   possible_number_array = (AV*)SvRV(possible_number_arrayref);
   possible_number_array_length = av_len(possible_number_array) + 1;

   for (i = 0;  i < possible_number_array_length;  ++i)  // incrementing iteration
   {
       possible_number_array_element = av_fetch(possible_number_array, i, 0);

       if (not(SvOK(*possible_number_array_element))) { croak("\nERROR ENVAVRV02, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber_arrayref element value expected but undefined/null value found at index %"INTEGER",\nin variable %s from subroutine %s,\ncroaking", i, variable_name, subroutine_name); }
       if (not(SvNOKp(*possible_number_array_element) || SvIOKp(*possible_number_array_element))) { croak("\nERROR ENVAVRV03, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber_arrayref element value expected but non-number value found at index %"INTEGER",\nin variable %s from subroutine %s,\ncroaking", i, variable_name, subroutine_name); }
   }
}

void string_arrayref_CHECK(SV* possible_string_arrayref)
{
   if ( not( SvOK(possible_string_arrayref) ) ) { croak( "\nERROR EPVAVRV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring_arrayref value expected but undefined/null value found,\ncroaking" ); }
   if ( not( SvAROKp(possible_string_arrayref) ) ) { croak( "\nERROR EPVAVRV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring_arrayref value expected but non-arrayref value found,\ncroaking" ); }

   AV* possible_string_array;
   integer possible_string_array_length;
   integer i;
   SV** possible_string_array_element;

   possible_string_array = (AV*)SvRV(possible_string_arrayref);
   possible_string_array_length = av_len(possible_string_array) + 1;

   for (i = 0;  i < possible_string_array_length;  ++i)  // incrementing iteration
   {
       possible_string_array_element = av_fetch(possible_string_array, i, 0);

       if (not(SvOK(*possible_string_array_element))) { croak("\nERROR EPVAVRV02, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring_arrayref element value expected but undefined/null value found at index %"INTEGER",\ncroaking", i); }
       if (not(SvPOKp(*possible_string_array_element))) { croak("\nERROR EPVAVRV03, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring_arrayref element value expected but non-string value found at index %"INTEGER",\ncroaking", i); }
   }
}

void string_arrayref_CHECKTRACE(SV* possible_string_arrayref, const char* variable_name, const char* subroutine_name)
{
   if ( not( SvOK(possible_string_arrayref) ) ) { croak( "\nERROR EPVAVRV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring_arrayref value expected but undefined/null value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name ); }
   if ( not( SvAROKp(possible_string_arrayref) ) ) { croak( "\nERROR EPVAVRV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring_arrayref value expected but non-arrayref value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name ); }

   AV* possible_string_array;
   integer possible_string_array_length;
   integer i;
   SV** possible_string_array_element;

   possible_string_array = (AV*)SvRV(possible_string_arrayref);
   possible_string_array_length = av_len(possible_string_array) + 1;

   for (i = 0;  i < possible_string_array_length;  ++i)  // incrementing iteration
   {
       possible_string_array_element = av_fetch(possible_string_array, i, 0);

       if (not(SvOK(*possible_string_array_element))) { croak("\nERROR EPVAVRV02, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring_arrayref element value expected but undefined/null value found at index %"INTEGER",\nin variable %s from subroutine %s,\ncroaking", i, variable_name, subroutine_name); }
       if (not(SvPOKp(*possible_string_array_element))) { croak("\nERROR EPVAVRV03, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring_arrayref element value expected but non-string value found at index %"INTEGER",\nin variable %s from subroutine %s,\ncroaking", i, variable_name, subroutine_name); }
   }
}

// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]

# ifdef __CPP__TYPES

// convert from (Perl SV containing RV to (Perl AV of (Perl SVs containing IVs))) to (C++ std::vector of integers)
integer_arrayref XS_unpack_integer_arrayref(SV* input_avref)
{
//  fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_integer_arrayref(), top of subroutine\n");
//  integer_arrayref_CHECK(input_avref);
   integer_arrayref_CHECKTRACE(input_avref, "input_avref", "XS_unpack_integer_arrayref()");

   AV* input_av;
   integer input_av_length;
   integer i;
   SV** input_av_element;
   integer_arrayref output_vector;

   input_av = (AV*)SvRV(input_avref);
   input_av_length = av_len(input_av) + 1;
//  fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_integer_arrayref(), have input_av_length = %"INTEGER"\n", input_av_length);

   // DEV NOTE: VECTOR ELEMENT ASSIGNMENT OPTION information is not specific to this subroutine or packing/unpacking

   // VECTOR ELEMENT ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: vector has programmer-provided const size or compiler-guessable size,
   // resize() ahead of time to allow l-value subscript notation
   output_vector.resize((size_t)input_av_length);

   // VECTOR ELEMENT ASSIGNMENT, OPTION C, PUSH, KNOWN SIZE: vector has programmer-provided const size or compiler-guessable size,
   // reserve() ahead of time to avoid memory reallocation(s) (aka change in vector capacity) during element copying in for() loop
//  output_vector.reserve((size_t)input_av_length);

   // VECTOR ELEMENT ASSIGNMENT, OPTION E, ITERATOR, KNOWN SIZE:
//  output_vector.reserve((size_t)input_av_length);  // if incrementing iteration
//  output_vector.resize((size_t)input_av_length);  // if decrementing iteration

   for (i = 0;  i < input_av_length;  ++i)  // incrementing iteration
//  for (i = (input_av_length - 1);  i >= 0;  --i)  // decrementing iteration
   {
       // utilizes i in element retrieval
       input_av_element = av_fetch(input_av, i, 0);
       // DEV NOTE: integer type-checking already done as part of integer_arrayref_CHECKTRACE()
//      integer_CHECK(*input_av_element);
//      integer_CHECKTRACE(*input_av_element, (char*)((string)"*input_av_element at index " + to_string(i)).c_str(), "XS_unpack_integer_hashref()");

       // VECTOR ELEMENT ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: l-value subscript notation with no further resize(); utilizes i in assignment
       output_vector[i] = SvIV(*input_av_element);

       // VECTOR ELEMENT ASSIGNMENT, OPTION B, SUBSCRIPT, UNKNOWN SIZE: unpredictable value of i and thus unpredictable vector size,
       // call resize() every time we use l-value subscript; utilizes i in assignment
//      VECTOR_RESIZE_NOSHRINK(output_vector, (i + 1));  output_vector[i] = SvIV(*input_av_element);

       // VECTOR ELEMENT ASSIGNMENT, OPTIONS C & D, PUSH, KNOWN & UNKNOWN SIZE: push_back() calls resize(); does not utilize i in assignment;
       // only works for incrementing iteration!!!  will reverse list order for decrementing iteration, there is no push_front() method
//      output_vector.push_back(SvIV(*input_av_element));

       // VECTOR ELEMENT ASSIGNMENT, OPTION E, ITERATOR, KNOWN SIZE: utilizes i in assignment
//      output_vector.insert((i + output_vector.begin()), SvIV(*input_av_element));  // if incrementing iteration
//      output_vector.erase(i + output_vector.begin());  output_vector.insert((i + output_vector.begin()), SvIV(*input_av_element));  // if decrementing iteration

       // VECTOR ELEMENT ASSIGNMENT, OPTION F, ITERATOR, UNKNOWN SIZE: unpredictable value of i and thus unpredictable vector size,
       // call resize() every time we use insert(); utilizes i in assignment
//      VECTOR_RESIZE_NOSHRINK(output_vector, (i + 1));  output_vector.erase(i + output_vector.begin());  output_vector.insert((i + output_vector.begin()), SvIV(*input_av_element));
   }

//  fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_integer_arrayref(), after for() loop, have output_vector.size() = %"INTEGER"\n", output_vector.size());
//  fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_integer_arrayref(), bottom of subroutine\n");

   return(output_vector);
}

// convert from (C++ std::vector of integers) to (Perl SV containing RV to (Perl AV of (Perl SVs containing IVs)))
void XS_pack_integer_arrayref(SV* output_avref, integer_arrayref input_vector)
{
//  fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_integer_arrayref(), top of subroutine\n");

   AV* output_av = newAV();  // initialize output array to empty
   integer input_vector_length = input_vector.size();
   integer i;
   SV* temp_sv_pointer;

//  fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_integer_arrayref(), have input_vector_length = %"INTEGER"\n", input_vector_length);

   if (input_vector_length > 0) { for (i = 0;  i < input_vector_length;  ++i) { av_push(output_av, newSViv(input_vector[i])); } }
//  else warn("in CPPOPS_CPPTYPES XS_pack_integer_arrayref(), array was empty, returning empty array via newAV()");

   temp_sv_pointer = newSVrv(output_avref, NULL);    // upgrade output stack SV to an RV
   SvREFCNT_dec(temp_sv_pointer);       // discard temporary pointer
   SvRV(output_avref) = (SV*)output_av;       // make output stack RV pointer at our output AV

//  fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_integer_arrayref(), bottom of subroutine\n");
}

// convert from (Perl SV containing RV to (Perl AV of (Perl SVs containing NVs))) to (C++ std::vector of numbers)
number_arrayref XS_unpack_number_arrayref(SV* input_avref)
{
//  fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_number_arrayref(), top of subroutine\n");
//  number_arrayref_CHECK(input_avref);
   number_arrayref_CHECKTRACE(input_avref, "input_avref", "XS_unpack_number_arrayref()");

   AV* input_av;
   integer input_av_length;
   integer i;
   SV** input_av_element;
   number_arrayref output_vector;

   input_av = (AV*)SvRV(input_avref);
   input_av_length = av_len(input_av) + 1;
//  fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_number_arrayref(), have input_av_length = %"INTEGER"\n", input_av_length);

   // VECTOR ELEMENT ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: vector has programmer-provided const size or compiler-guessable size,
   // resize() ahead of time to allow l-value subscript notation
   output_vector.resize((size_t)input_av_length);

   for (i = 0;  i < input_av_length;  ++i)  // incrementing iteration
   {
       // utilizes i in element retrieval
       input_av_element = av_fetch(input_av, i, 0);

       // VECTOR ELEMENT ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: l-value subscript notation with no further resize(); utilizes i in assignment
       output_vector[i] = SvNV(*input_av_element);
   }

//  fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_number_arrayref(), after for() loop, have output_vector.size() = %"INTEGER"\n", output_vector.size());
//  fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_number_arrayref(), bottom of subroutine\n");

   return(output_vector);
}

// convert from (C++ std::vector of numbers) to (Perl SV containing RV to (Perl AV of (Perl SVs containing NVs)))
void XS_pack_number_arrayref(SV* output_avref, number_arrayref input_vector)
{
//  fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_number_arrayref(), top of subroutine\n");

   AV* output_av = newAV();  // initialize output array to empty
   integer input_vector_length = input_vector.size();
   integer i;
   SV* temp_sv_pointer;

//  fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_number_arrayref(), have input_vector_length = %"INTEGER"\n", input_vector_length);

   if (input_vector_length > 0) { for (i = 0;  i < input_vector_length;  ++i) { av_push(output_av, newSVnv(input_vector[i])); } }
//  else warn("in CPPOPS_CPPTYPES XS_pack_number_arrayref(), array was empty, returning empty array via newAV()");

   temp_sv_pointer = newSVrv(output_avref, NULL);    // upgrade output stack SV to an RV
   SvREFCNT_dec(temp_sv_pointer);       // discard temporary pointer
   SvRV(output_avref) = (SV*)output_av;       // make output stack RV pointer at our output AV

//  fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_number_arrayref(), bottom of subroutine\n");
}

// convert from (Perl SV containing RV to (Perl AV of (Perl SVs containing PVs))) to (C++ std::vector of std::strings)
string_arrayref XS_unpack_string_arrayref(SV* input_avref)
{
//  fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_string_arrayref(), top of subroutine\n");
//  string_arrayref_CHECK(input_avref);
   string_arrayref_CHECKTRACE(input_avref, "input_avref", "XS_unpack_string_arrayref()");

   AV* input_av;
   integer input_av_length;
   integer i;
   SV** input_av_element;
   string_arrayref output_vector;

   input_av = (AV*)SvRV(input_avref);
   input_av_length = av_len(input_av) + 1;
//  fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_string_arrayref(), have input_av_length = %"INTEGER"\n", input_av_length);

   // VECTOR ELEMENT ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: vector has programmer-provided const size or compiler-guessable size,
   // resize() ahead of time to allow l-value subscript notation
   output_vector.resize((size_t)input_av_length);

   for (i = 0;  i < input_av_length;  ++i)  // incrementing iteration
   {
       // utilizes i in element retrieval
       input_av_element = av_fetch(input_av, i, 0);

       // VECTOR ELEMENT ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: l-value subscript notation with no further resize(); utilizes i in assignment
       output_vector[i] = SvPV_nolen(*input_av_element);
   }

//  fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_string_arrayref(), after for() loop, have output_vector.size() = %"INTEGER"\n", output_vector.size());
//  fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_string_arrayref(), bottom of subroutine\n");

   return(output_vector);
}

// convert from (C++ std::vector of std::strings) to (Perl SV containing RV to (Perl AV of (Perl SVs containing PVs)))
void XS_pack_string_arrayref(SV* output_avref, string_arrayref input_vector)
{
//  fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_string_arrayref(), top of subroutine\n");

   AV* output_av = newAV();  // initialize output array to empty
   integer input_vector_length = input_vector.size();
   integer i;
   SV* temp_sv_pointer;

//  fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_string_arrayref(), have input_vector_length = %"INTEGER"\n", input_vector_length);

   if (input_vector_length > 0) { for (i = 0;  i < input_vector_length;  ++i) { av_push(output_av, newSVpv(input_vector[i].data(), input_vector[i].size())); } }
//  else warn("in CPPOPS_CPPTYPES XS_pack_string_arrayref(), array was empty, returning empty array via newAV()");

   temp_sv_pointer = newSVrv(output_avref, NULL);    // upgrade output stack SV to an RV
   SvREFCNT_dec(temp_sv_pointer);       // discard temporary pointer
   SvRV(output_avref) = (SV*)output_av;       // make output stack RV pointer at our output AV

//  fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_string_arrayref(), bottom of subroutine\n");
}

# endif

// [[[ STRINGIFY ]]]
// [[[ STRINGIFY ]]]
// [[[ STRINGIFY ]]]


// START HERE: Failing Travis tests, upgrade *arrayref_to_string() below, add *_compact() etc variations, re-enable t/05 tests, write new tests?
// START HERE: Failing Travis tests, upgrade *arrayref_to_string() below, add *_compact() etc variations, re-enable t/05 tests, write new tests?
// START HERE: Failing Travis tests, upgrade *arrayref_to_string() below, add *_compact() etc variations, re-enable t/05 tests, write new tests?



# ifdef __PERL__TYPES

SV* integer_arrayref_to_string(SV* input_avref)
{


}

// DEV NOTE: direct manipulation of the Perl Stack shown in /* block comments */
// TODO: use Perl stack manipulation to enable support for variable number of arguments, multiple return values, not setting var to retval in Perl, etc.
// convert from (Perl SV containing RV to (Perl AV of (Perl SVs containing IVs))) to Perl-parsable (Perl SV containing PV)
//void integer_arrayref_to_string(SV* input_avref)
SV* integer_arrayref_to_string(SV* input_avref)
{
//  Inline_Stack_Vars;
//define Inline_Stack_Vars  dXSARGS  // from INLINE.h
//  dXSARGS;
//  define dXSARGS dSP; dAXMARK; dITEMS  // from XSUB.h
/*  dSP;
   dAXMARK; */
//  dITEMS;

//  fprintf(stderr, "in CPPOPS_PERLTYPES integer_arrayref_to_string(), top of subroutine\n");
//  integer_arrayref_CHECK(input_avref);
   integer_arrayref_CHECKTRACE(input_avref, "input_avref", "integer_arrayref_to_string()");

   AV* input_av;
   integer input_av_length;
   integer i;
   SV** input_av_element;
   SV* output_sv = newSV(0);
   boolean i_is_0 = 1;

   input_av = (AV*)SvRV(input_avref);
   input_av_length = av_len(input_av) + 1;
//  fprintf(stderr, "in CPPOPS_PERLTYPES integer_arrayref_to_string(), have input_av_length = %"INTEGER"\n", input_av_length);

   sv_setpvn(output_sv, "[", 1);

   for (i = 0;  i < input_av_length;  ++i)
   {
       // utilizes i in element retrieval
       input_av_element = av_fetch(input_av, i, 0);
       // DEV NOTE: integer type-checking already done as part of integer_arrayref_CHECKTRACE()
//      integer_CHECK(*input_av_element);
//      integer_CHECKTRACE(*input_av_element, (char*)((string)"*input_av_element at index " + to_string(i)).c_str(), "integer_hashref_to_string()");

       if (i_is_0) { i_is_0 = 0; } else { sv_catpvn(output_sv, ", ", 2); }
//      sv_catpvf(output_sv, "%"INTEGER"", (integer)SvIV(*input_av_element));  // NO UNDERSCORES
       sv_catsv(output_sv, integer_to_string(*input_av_element));  // YES UNDERSCORES
   }

   sv_catpvn(output_sv, "]", 1);

//  fprintf(stderr, "in CPPOPS_PERLTYPES integer_arrayref_to_string(), after for() loop, have output_sv =\n%s\n", SvPV_nolen(output_sv));
//  fprintf(stderr, "in CPPOPS_PERLTYPES integer_arrayref_to_string(), bottom of subroutine\n");

//  Inline_Stack_Reset;
//define Inline_Stack_Reset      sp = mark  // from INLINE.h
/*  sp = mark; */

//  Inline_Stack_Push(sv_2mortal(output_sv));
//define Inline_Stack_Push(x)   XPUSHs(x)  // from INLINE.h
/*  XPUSHs(sv_2mortal(output_sv));  // mortalize because we created output_sv with newSV() in this function */
   return(output_sv);

//  Inline_Stack_Done;
//define Inline_Stack_Done  PUTBACK  // from INLINE.h
//  PUTBACK;

//  Inline_Stack_Return(1);
//define Inline_Stack_Return(x) XSRETURN(x)  // from INLINE.h
//  XSRETURN(1);
}

// convert from (Perl SV containing RV to (Perl AV of (Perl SVs containing NVs))) to Perl-parsable (Perl SV containing PV)
SV* number_arrayref_to_string(SV* input_avref)
{
//  fprintf(stderr, "in CPPOPS_PERLTYPES number_arrayref_to_string(), top of subroutine\n");
//  number_arrayref_CHECK(input_avref);
   number_arrayref_CHECKTRACE(input_avref, "input_avref", "number_arrayref_to_string()");

   AV* input_av;
   integer input_av_length;
   integer i;
   SV** input_av_element;
   SV* output_sv = newSV(0);
   boolean i_is_0 = 1;
   ostringstream temp_stream;
   temp_stream.precision(std::numeric_limits<double>::digits10);

   input_av = (AV*)SvRV(input_avref);
   input_av_length = av_len(input_av) + 1;
//  fprintf(stderr, "in CPPOPS_PERLTYPES number_arrayref_to_string(), have input_av_length = %"INTEGER"\n", input_av_length);

   temp_stream << "[";
//  sv_setpvn(output_sv, "[", 1);

   for (i = 0;  i < input_av_length;  ++i)
   {
       // utilizes i in element retrieval
       input_av_element = av_fetch(input_av, i, 0);

       if (i_is_0) { i_is_0 = 0; } else { temp_stream << ", "; }
//      if (i_is_0) { i_is_0 = 0; } else { sv_catpvn(output_sv, ", ", 2); }
       temp_stream << (string)SvPV_nolen(number_to_string(*input_av_element));
//      sv_catpvf(output_sv, "%Lf", (number)SvNV(*input_av_element));  // NEED ANSWER: can we make fprintf(stderr, )-like "%Lf" act like ostringstream's precision?
   }

   temp_stream << "]";
   sv_setpv(output_sv, (char *)(temp_stream.str().c_str()));
//  sv_catpvn(output_sv, "]", 1);

//  fprintf(stderr, "in CPPOPS_PERLTYPES number_arrayref_to_string(), after for() loop, have output_sv =\n%s\n", SvPV_nolen(output_sv));
//  fprintf(stderr, "in CPPOPS_PERLTYPES number_arrayref_to_string(), bottom of subroutine\n");

   return(output_sv);
}

// convert from (Perl SV containing RV to (Perl AV of (Perl SVs containing PVs))) to Perl-parsable (Perl SV containing PV)
SV* string_arrayref_to_string(SV* input_avref)
{
//  fprintf(stderr, "in CPPOPS_PERLTYPES string_arrayref_to_string(), top of subroutine\n");
//  string_arrayref_CHECK(input_avref);
   string_arrayref_CHECKTRACE(input_avref, "input_avref", "string_arrayref_to_string()");

   AV* input_av;
   integer input_av_length;
   integer i;
   SV** input_av_element;
   string input_av_element_string;
   size_t input_av_element_string_pos;
   SV* output_sv = newSV(0);
   boolean i_is_0 = 1;
//  ostringstream temp_stream;

   input_av = (AV*)SvRV(input_avref);
   input_av_length = av_len(input_av) + 1;
//  fprintf(stderr, "in CPPOPS_PERLTYPES string_arrayref_to_string(), have input_av_length = %"INTEGER"\n", input_av_length);

//  temp_stream << "[";
   sv_setpvn(output_sv, "[", 1);

   for (i = 0;  i < input_av_length;  ++i)
   {
       // utilizes i in element retrieval
       input_av_element = av_fetch(input_av, i, 0);

//      if (i_is_0) { i_is_0 = 0; } else { temp_stream << ", "; }
       if (i_is_0) { i_is_0 = 0; } else { sv_catpvn(output_sv, ", ", 2); }

       // escape all back-slash \ and single-quote ' characters with a back-slash \ character
       input_av_element_string = string(SvPV_nolen(*input_av_element));
       input_av_element_string_pos = 0;
       while((input_av_element_string_pos = input_av_element_string.find("\\", input_av_element_string_pos)) != string::npos)
       {
           input_av_element_string.replace(input_av_element_string_pos, 1, "\\\\");
           input_av_element_string_pos += 2;
       }
       input_av_element_string_pos = 0;
       while((input_av_element_string_pos = input_av_element_string.find("'", input_av_element_string_pos)) != string::npos)
       {
           input_av_element_string.replace(input_av_element_string_pos, 1, "\\'");
           input_av_element_string_pos += 2;
       }

//      temp_stream << "'" << SvPV_nolen(*input_av_element) << "'";
//      sv_catpvf(output_sv, "'%s'", SvPV_nolen(*input_av_element));
       sv_catpvf(output_sv, "'%s'", input_av_element_string.c_str());
   }

//  temp_stream << "]";
//  sv_setpv(output_sv, (char *)(temp_stream.str().c_str()));
   sv_catpvn(output_sv, "]", 1);

//  fprintf(stderr, "in CPPOPS_PERLTYPES string_arrayref_to_string(), after for() loop, have output_sv =\n%s\n", SvPV_nolen(output_sv));
//  fprintf(stderr, "in CPPOPS_PERLTYPES string_arrayref_to_string(), bottom of subroutine\n");

   return(output_sv);
}

# elif defined __CPP__TYPES

// convert from (C++ std::vector of integers) to Perl-parsable (C++ std::string)
string integer_arrayref_to_string(integer_arrayref input_vector)
{
//  fprintf(stderr, "in CPPOPS_CPPTYPES integer_arrayref_to_string(), top of subroutine\n");

   ostringstream output_stream;
   integer input_vector_length = input_vector.size();
   integer i;
   integer input_vector_element;
   boolean i_is_0 = 1;

//  fprintf(stderr, "in CPPOPS_CPPTYPES integer_arrayref_to_string(), have input_vector_length = %"INTEGER"\n", input_vector_length);

   output_stream << '[';

   for (i = 0;  i < input_vector_length;  ++i)
   {
       // utilizes i in element retrieval
       input_vector_element = input_vector[i];
       if (i_is_0) { i_is_0 = 0; } else { output_stream << ", "; }
//      output_stream << input_vector_element;  // NO UNDERSCORES
       output_stream << integer_to_string(input_vector_element);  // YES UNDERSCORES
   }

   output_stream << ']';

//  fprintf(stderr, "in CPPOPS_CPPTYPES integer_arrayref_to_string(), after for() loop, have output_stream =\n%s\n", (char *)(output_stream.str().c_str()));
//  fprintf(stderr, "in CPPOPS_CPPTYPES integer_arrayref_to_string(), bottom of subroutine\n");

   return(output_stream.str());
}

// convert from (C++ std::vector of numbers) to Perl-parsable (C++ std::string)
string number_arrayref_to_string(number_arrayref input_vector)
{
//  fprintf(stderr, "in CPPOPS_CPPTYPES number_arrayref_to_string(), top of subroutine\n");

   ostringstream output_stream;
   integer input_vector_length = input_vector.size();
   integer i;
   number input_vector_element;
   boolean i_is_0 = 1;

//  fprintf(stderr, "in CPPOPS_CPPTYPES number_arrayref_to_string(), have input_vector_length = %"INTEGER"\n", input_vector_length);

   output_stream.precision(std::numeric_limits<double>::digits10);
   output_stream << '[';

   for (i = 0;  i < input_vector_length;  ++i)
   {
       // utilizes i in element retrieval
       input_vector_element = input_vector[i];
       if (i_is_0) { i_is_0 = 0; } else { output_stream << ", "; }
//      output_stream << input_vector_element;
       output_stream << number_to_string(input_vector_element);
   }

   output_stream << ']';

//  fprintf(stderr, "in CPPOPS_CPPTYPES number_arrayref_to_string(), after for() loop, have output_stream =\n%s\n", (char *)(output_stream.str().c_str()));
//  fprintf(stderr, "in CPPOPS_CPPTYPES number_arrayref_to_string(), bottom of subroutine\n");

   return(output_stream.str());
}

// convert from (C++ std::vector of std::strings) to Perl-parsable (C++ std::string)
string string_arrayref_to_string(string_arrayref input_vector)
{
//  fprintf(stderr, "in CPPOPS_CPPTYPES string_arrayref_to_string(), top of subroutine\n");

//  ostringstream output_stream;
   string output_string;
   integer input_vector_length = input_vector.size();
   integer i;
   string input_vector_element;
   size_t input_vector_element_pos;
   boolean i_is_0 = 1;

//  fprintf(stderr, "in CPPOPS_CPPTYPES string_arrayref_to_string(), have input_vector_length = %"INTEGER"\n", input_vector_length);

//  output_stream << '[';
   output_string = "[";

   for (i = 0;  i < input_vector_length;  ++i)
   {
       // utilizes i in element retrieval
       input_vector_element = input_vector[i];
       if (i_is_0) { i_is_0 = 0; } else { output_string += ", "; }

       // escape all back-slash \ and single-quote ' characters with a back-slash \ character
       input_vector_element_pos = 0;
       while((input_vector_element_pos = input_vector_element.find("\\", input_vector_element_pos)) != string::npos)
       {
           input_vector_element.replace(input_vector_element_pos, 1, "\\\\");
           input_vector_element_pos += 2;
       }
       input_vector_element_pos = 0;
       while((input_vector_element_pos = input_vector_element.find("'", input_vector_element_pos)) != string::npos)
       {
           input_vector_element.replace(input_vector_element_pos, 1, "\\'");
           input_vector_element_pos += 2;
       }

//      output_stream <<  "'" << input_vector_element << "'";
       output_string += "'" + input_vector_element + "'";
   }

//  output_stream << ']';
   output_string += "]";

//  fprintf(stderr, "in CPPOPS_CPPTYPES string_arrayref_to_string(), after for() loop, have output_stream =\n%s\n", (char *)(output_stream.str().c_str()));
//  fprintf(stderr, "in CPPOPS_CPPTYPES string_arrayref_to_string(), after for() loop, have output_string =\n%s\n", output_string.c_str());
//  fprintf(stderr, "in CPPOPS_CPPTYPES string_arrayref_to_string(), bottom of subroutine\n");

//  return(output_stream.str());
   return(output_string);
}

# else

Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!

# endif

// [[[ TYPE TESTING ]]]
// [[[ TYPE TESTING ]]]
// [[[ TYPE TESTING ]]]

# ifdef __PERL__TYPES

// DEV NOTE: direct manipulation of the Perl Stack shown in /* block comments */
/*void integer_arrayref_typetest0(SV* lucky_integers) */
SV* integer_arrayref_typetest0(SV* lucky_integers)
{
/*  dSP; */

/*  SV* output_sv; */
//  integer_arrayref_CHECK(lucky_integers);
   integer_arrayref_CHECKTRACE(lucky_integers, "lucky_integers", "integer_arrayref_typetest0()");
//  AV* lucky_integers_deref = (AV*)SvRV(lucky_integers);
//  integer how_lucky = av_len(lucky_integers_deref) + 1;
//  integer i;

//  for (i = 0;  i < how_lucky;  ++i)
//  {
//      fprintf(stderr, "in CPPOPS_PERLTYPES integer_arrayref_typetest0(), have lucky integer %"INTEGER"/%"INTEGER" = %"INTEGER", BARBAT\n", i, (how_lucky - 1), (integer)SvIV(*av_fetch(lucky_integers_deref, i, 0)));
//  }

//  ENTER;
//  SAVETMPS;
/*  integer_arrayref_to_string(lucky_integers); */
/*  output_sv = integer_arrayref_to_string(lucky_integers); */
//  SPAGAIN;

/*  output_sv = POPs; */
//  PUTBACK;

//  FREETMPS;
//  LEAVE;

/*  sv_catpv(output_sv, "BARBAT"); */
/*  fprintf(stderr, "in CPPOPS_PERLTYPES integer_arrayref_typetest0(), have output_sv = %s\n", SvPV_nolen(output_sv)); */

/*
//  SPAGAIN;
//  PUSHMARK(SP);
   XPUSHs(output_sv);  // do not mortalize because we receive value for output_sv from outside this function
//  PUTBACK;
*/
//  SvREFCNT_inc(output_sv);
/*  return(output_sv);  // do not mortalize because we receive value for output_sv from outside this function */
   return(newSVpvf("%s%s", SvPV_nolen(integer_arrayref_to_string(lucky_integers)), "CPPOPS_PERLTYPES"));
}

// DEV NOTE: direct manipulation of the Perl Stack shown in /* block comments */
/*void integer_arrayref_typetest1(integer my_size) */
SV* integer_arrayref_typetest1(SV* my_size)
{
/*  dSP;
   dAXMARK; */

//  integer_CHECK(my_size);
   integer_CHECKTRACE(my_size, "my_size", "integer_arrayref_typetest1()");
   AV* output_av = newAV();
   integer i;

   av_extend(output_av, (I32)(SvIV(my_size) - 1));

   for (i = 0;  i < SvIV(my_size);  ++i)
   {
       av_store(output_av, (I32)i, newSViv(i * 5));
//      fprintf(stderr, "in CPPOPS_PERLTYPES integer_arrayref_typetest1(), setting element %"INTEGER"/%"INTEGER" = %"INTEGER", BARBAT\n", i, (integer)(SvIV(my_size) - 1), (integer)SvIV(*av_fetch(output_av, (I32)i, 0)));
   }

/*
   sp = mark;
   XPUSHs(sv_2mortal(newRV_noinc((SV*) output_av)));  // do mortalize because we create output_av with newAV() in this function
*/
   return(newRV_noinc((SV*) output_av));
}

SV* number_arrayref_typetest0(SV* lucky_numbers)
{
//  number_arrayref_CHECK(lucky_numbers);
   number_arrayref_CHECKTRACE(lucky_numbers, "lucky_numbers", "number_arrayref_typetest0()");
//  AV* lucky_numbers_deref = (AV*)SvRV(lucky_numbers);
//  integer how_lucky = av_len(lucky_numbers_deref) + 1;
//  integer i;

//  for (i = 0;  i < how_lucky;  ++i)
//  {
//      number_CHECK(*av_fetch(lucky_numbers_deref, i, 0));
//      number_CHECKTRACE(*av_fetch(lucky_numbers_deref, i, 0), (char*)((string)"*av_fetch(lucky_numbers_deref, i, 0) at index " + to_string(i)).c_str(), "number_arrayref_typetest0()");
//      fprintf(stderr, "in CPPOPS_PERLTYPES number_arrayref_typetest0(), have lucky number %"INTEGER"/%"INTEGER" = %Lf, BARBAT\n", i, (how_lucky - 1), (number)SvNV(*av_fetch(lucky_numbers_deref, i, 0)));
//  }
   return(newSVpvf("%s%s", SvPV_nolen(number_arrayref_to_string(lucky_numbers)), "CPPOPS_PERLTYPES"));
}

SV* number_arrayref_typetest1(SV* my_size)
{
//  integer_CHECK(my_size);
   integer_CHECKTRACE(my_size, "my_size", "number_arrayref_typetest1()");
   AV* output_av = newAV();
   integer i;
   av_extend(output_av, (I32)(SvIV(my_size) - 1));
   for (i = 0;  i < SvIV(my_size);  ++i)
   {
       av_store(output_av, (I32)i, newSVnv(i * 5.123456789));
//      fprintf(stderr, "in CPPOPS_PERLTYPES number_arrayref_typetest1(), setting element %"INTEGER"/%"INTEGER" = %Lf, BARBAT\n", i, (integer)(SvIV(my_size) - 1), (number)SvNV(*av_fetch(output_av, (I32)i, 0)));
   }
   return(newRV_noinc((SV*) output_av));
}

SV* string_arrayref_typetest0(SV* people)
{
//  string_arrayref_CHECK(people);
   string_arrayref_CHECKTRACE(people, "people", "string_arrayref_typetest0()");
//  AV* people_deref = (AV*)SvRV(people);
//  integer i;
//  for (i = 0;  i < (av_len(people_deref) + 1);  ++i)
//  {
//      string_CHECK(*av_fetch(people_deref, i, 0));
//      string_CHECKTRACE(*av_fetch(people_deref, i, 0), (char*)((string)"*av_fetch(people_deref, i, 0) at index " + to_string(i)).c_str(), "string_arrayref_typetest0()");
//      fprintf(stderr, "in CPPOPS_PERLTYPES string_arrayref_typetest0(), have person %"INTEGER" = '%s', BARBAR\n", i, (char *)SvPV_nolen(*av_fetch(people_deref, i, 0)));
//  }
   return(newSVpvf("%s%s", SvPV_nolen(string_arrayref_to_string(people)), "CPPOPS_PERLTYPES"));
}

SV* string_arrayref_typetest1(SV* my_size)
{
//  integer_CHECK(my_size);
   integer_CHECKTRACE(my_size, "my_size", "string_arrayref_typetest1()");
   AV* people = newAV();
   integer i;
   av_extend(people, (I32)(SvIV(my_size) - 1));
   for (i = 0;  i < SvIV(my_size);  ++i)
   {
       av_store(people, (I32)i, newSVpvf("Jeffy Ten! %"INTEGER"/%"INTEGER" CPPOPS_PERLTYPES", i, (integer)(SvIV(my_size) - 1)));
//      fprintf(stderr, "in CPPOPS_PERLTYPES string_arrayref_typetest1(), bottom of for() loop, have i = %"INTEGER", (integer)(SvIV(my_size) - 1) = %"INTEGER", just set another Jeffy, BARBAR\n", i, (integer)(SvIV(my_size) - 1));
   }
   return(newRV_noinc((SV*) people));
}

# elif defined __CPP__TYPES

string integer_arrayref_typetest0(integer_arrayref lucky_integers)
{
   integer how_lucky = lucky_integers.size();
   integer i;
//  for (i = 0;  i < how_lucky;  ++i)
//  {
//      fprintf(stderr, "in CPPOPS_CPPTYPES integer_arrayref_typetest0(), have lucky number %"INTEGER"/%"INTEGER" = %"INTEGER", BARBAT\n", i, (how_lucky - 1), lucky_integers[i]);
//  }
   return(integer_arrayref_to_string(lucky_integers) + "CPPOPS_CPPTYPES");
}

integer_arrayref integer_arrayref_typetest1(integer my_size)
{
   integer_arrayref new_vec(my_size);
   integer i;
   for (i = 0;  i < my_size;  ++i) {
       new_vec[i] = i * 5;
//      fprintf(stderr, "in CPPOPS_CPPTYPES integer_arrayref_typetest1(), setting element %"INTEGER"/%"INTEGER" = %"INTEGER", BARBAT\n", i, (my_size - 1), new_vec[i]);
   }
   return(new_vec);
}

string number_arrayref_typetest0(number_arrayref lucky_numbers)
{
   integer how_lucky = lucky_numbers.size();
   integer i;
//  for (i = 0;  i < how_lucky;  ++i)
//  {
//      fprintf(stderr, "in CPPOPS_CPPTYPES number_arrayref_typetest0(), have lucky number %"INTEGER"/%"INTEGER" = %Lf, BARBAZ\n", i, (how_lucky - 1), lucky_numbers[i]);
//  }
   return(number_arrayref_to_string(lucky_numbers) + "CPPOPS_CPPTYPES");
}
number_arrayref number_arrayref_typetest1(integer my_size)
{
   number_arrayref new_vec(my_size);
   integer i;
   for (i = 0;  i < my_size;  ++i)
   {
       new_vec[i] = i * 5.123456789;
//      fprintf(stderr, "in CPPOPS_CPPTYPES typetest__number_in__number_arrayref_out(), setting element %"INTEGER"/%"INTEGER" = %Lf, BARBAZ\n", i, (my_size - 1), new_vec[i]);
   }
   return(new_vec);
}

//string string_arrayref_typetest0(string_arrayref people) { integer i;  for (i = 0;  i < people.size();  ++i) { fprintf(stderr, "in CPPOPS_CPPTYPES fprintf(stderr, ) string_arrayref_typetest0(), have person %"INTEGER" = '%s', BARBAR\n", i, people[i].c_str()); }  return(string_arrayref_to_string(people) + "BARBAR"); }
string string_arrayref_typetest0(string_arrayref people)
{
   integer i;
//  for (i = 0;  i < people.size();  ++i)
//  {
//      cout << "in CPPOPS_CPPTYPES string_arrayref_typetest0(), have person " << i << " = '" << people[i] << "', BARBAR\n";
//  }
   return(string_arrayref_to_string(people) + "CPPOPS_CPPTYPES");
}

string_arrayref string_arrayref_typetest1(integer my_size)
{
   string_arrayref people;
   integer i;
   people.resize((size_t)my_size);
   for (i = 0;  i < my_size;  ++i)
   {
       people[i] = "Jeffy Ten! " + std::to_string(i) + "/" + std::to_string(my_size - 1) + " CPPOPS_CPPTYPES";
//      fprintf(stderr, "in CPPOPS_CPPTYPES string_arrayref_typetest1(), bottom of for() loop, have i = %"INTEGER", (my_size - 1) = %"INTEGER", just set another Jeffy, BARBAR\n", i, (my_size - 1));
   }
   return(people);
}

# endif

#endif
