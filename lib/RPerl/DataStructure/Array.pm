package RPerl::DataStructure::Array;
use strict;
use warnings;
use version; our $VERSION = qv('0.3.4');
use Carp;

use parent ('RPerl::DataStructure');
use RPerl::DataStructure;

# for type checking via SvIOKp(), SvNOKp(), and SvPOKp(); inside INIT to delay until after 'use MyConfig'
INIT { print "in Array.pm, loading C++ helper functions for type checking...\n"; }
INIT { use RPerl::HelperFunctions_cpp;  RPerl::HelperFunctions_cpp::cpp_load();  RPerl::HelperFunctions_cpp::cpp_link(); }

# [[[ DATA TYPES ]]]
use RPerl::DataType::Void;
use RPerl::DataType::Integer;
use RPerl::DataType::Float;
use RPerl::DataType::Number;
use RPerl::DataType::Character;
use RPerl::DataType::String;
use RPerl::DataType::Scalar;
use RPerl::DataType::Unknown;

# [[[ DATA STRUCTURES ]]]
use RPerl::DataStructure::Hash;

# [[[ DATA TYPES & OPERATIONS ]]]
our string $types_array = sub { return('PERL'); };
our string $ops_array = sub { return('PERL'); };

# [[[ ARRAYS ]]]

# an array is a 1-dimensional list/vector/sequence/set of data types
package array;
our @ISA = ('ARRAY', 'RPerl::DataStructure::Array');

# array with const size
package const_array;
our @ISA = ('array', 'const');

# ref to array
package array_ref;
our @ISA = ('ref');

# ref to (array with const size)
package const_array_ref;
our @ISA = ('ref');


# [[[ INT ARRAYS ]]]

# array of integers
package integer__array;
our @ISA = ('array');

# array of (integers with const values)
package const_integer__array;
our @ISA = ('array');

# array of (refs to integers)
package integer_ref__array;
our @ISA = ('array');

# array of (refs to (integers with const values))
package const_integer_ref__array;
our @ISA = ('array');

# (array with const size) of integers
package integer__const_array;
our @ISA = ('const_array');

# (array with const size) of (integers with const values)
package const_integer__const_array;
our @ISA = ('const_array');

# (array with const size) of (refs to integers)
package integer_ref__const_array;
our @ISA = ('const_array');

# (array with const size) of (refs to (integers with const values))
package const_integer_ref__const_array;
our @ISA = ('const_array');

# (ref to array) of integers
package integer__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (integers with const values)
package const_integer__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (refs to integers)
package integer_ref__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (refs to (integers with const values))
package const_integer_ref__array_ref;
our @ISA = ('array_ref');

# (ref to (array with const size)) of integers
package integer__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (integers with const values)
package const_integer__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (refs to integers)
package integer_ref__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (refs to (integers with const values))
package const_integer_ref__const_array_ref;
our @ISA = ('const_array_ref');


# [[[ FLOAT ARRAYS ]]]

# array of floats
package float__array;
our @ISA = ('array');

# array of (floats with const values)
package const_float__array;
our @ISA = ('array');

# array of (refs to floats)
package float_ref__array;
our @ISA = ('array');

# array of (refs to (floats with const values))
package const_float_ref__array;
our @ISA = ('array');

# (array with const size) of floats
package float__const_array;
our @ISA = ('const_array');

# (array with const size) of (floats with const values)
package const_float__const_array;
our @ISA = ('const_array');

# (array with const size) of (refs to floats)
package float_ref__const_array;
our @ISA = ('const_array');

# (array with const size) of (refs to (floats with const values))
package const_float_ref__const_array;
our @ISA = ('const_array');

# (ref to array) of floats
package float__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (floats with const values)
package const_float__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (refs to floats)
package float_ref__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (refs to (floats with const values))
package const_float_ref__array_ref;
our @ISA = ('array_ref');

# (ref to (array with const size)) of floats
package float__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (floats with const values)
package const_float__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (refs to floats)
package float_ref__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (refs to (floats with const values))
package const_float_ref__const_array_ref;
our @ISA = ('const_array_ref');


# [[[ NUMBER ARRAYS ]]]

# array of numbers
package number__array;
our @ISA = ('array');

# array of (numbers with const values)
package const_number__array;
our @ISA = ('array');

# array of (refs to numbers)
package number_ref__array;
our @ISA = ('array');

# array of (refs to (numbers with const values))
package const_number_ref__array;
our @ISA = ('array');

# (array with const size) of numbers
package number__const_array;
our @ISA = ('const_array');

# (array with const size) of (numbers with const values)
package const_number__const_array;
our @ISA = ('const_array');

# (array with const size) of (refs to numbers)
package number_ref__const_array;
our @ISA = ('const_array');

# (array with const size) of (refs to (numbers with const values))
package const_number_ref__const_array;
our @ISA = ('const_array');

# (ref to array) of numbers
package number__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (numbers with const values)
package const_number__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (refs to numbers)
package number_ref__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (refs to (numbers with const values))
package const_number_ref__array_ref;
our @ISA = ('array_ref');

# (ref to (array with const size)) of numbers
package number__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (numbers with const values)
package const_number__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (refs to numbers)
package number_ref__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (refs to (numbers with const values))
package const_number_ref__const_array_ref;
our @ISA = ('const_array_ref');


# [[[ CHAR ARRAYS ]]]

# array of chars
package char__array;
our @ISA = ('array');

# array of (chars with const values)
package const_char__array;
our @ISA = ('array');

# array of (refs to chars)
package char_ref__array;
our @ISA = ('array');

# array of (refs to (chars with const values))
package const_char_ref__array;
our @ISA = ('array');

# (array with const size) of chars
package char__const_array;
our @ISA = ('const_array');

# (array with const size) of (chars with const values)
package const_char__const_array;
our @ISA = ('const_array');

# (array with const size) of (refs to chars)
package char_ref__const_array;
our @ISA = ('const_array');

# (array with const size) of (refs to (chars with const values))
package const_char_ref__const_array;
our @ISA = ('const_array');

# (ref to array) of chars
package char__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (chars with const values)
package const_char__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (refs to chars)
package char_ref__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (refs to (chars with const values))
package const_char_ref__array_ref;
our @ISA = ('array_ref');

# (ref to (array with const size)) of chars
package char__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (chars with const values)
package const_char__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (refs to chars)
package char_ref__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (refs to (chars with const values))
package const_char_ref__const_array_ref;
our @ISA = ('const_array_ref');


# [[[ STRING ARRAYS ]]]

# array of strings
package string__array;
our @ISA = ('array');

# array of (strings with const values)
package const_string__array;
our @ISA = ('array');

# array of (refs to strings)
package string_ref__array;
our @ISA = ('array');

# array of (refs to (strings with const values))
package const_string_ref__array;
our @ISA = ('array');

# (array with const size) of strings
package string__const_array;
our @ISA = ('const_array');

# (array with const size) of (strings with const values)
package const_string__const_array;
our @ISA = ('const_array');

# (array with const size) of (refs to strings)
package string_ref__const_array;
our @ISA = ('const_array');

# (array with const size) of (refs to (strings with const values))
package const_string_ref__const_array;
our @ISA = ('const_array');

# (ref to array) of strings
package string__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (strings with const values)
package const_string__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (refs to strings)
package string_ref__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (refs to (strings with const values))
package const_string_ref__array_ref;
our @ISA = ('array_ref');

# (ref to (array with const size)) of strings
package string__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (strings with const values)
package const_string__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (refs to strings)
package string_ref__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (refs to (strings with const values))
package const_string_ref__const_array_ref;
our @ISA = ('const_array_ref');


# [[[ SCALAR ARRAYS ]]]

# array of scalars
package scalar__array;
our @ISA = ('array');

# array of (scalars with const values)
package const_scalar__array;
our @ISA = ('array');

# array of (refs to scalars)
package scalar_ref__array;
our @ISA = ('array');

# array of (refs to (scalars with const values))
package const_scalar_ref__array;
our @ISA = ('array');

# (array with const size) of scalars
package scalar__const_array;
our @ISA = ('const_array');

# (array with const size) of (scalars with const values)
package const_scalar__const_array;
our @ISA = ('const_array');

# (array with const size) of (refs to scalars)
package scalar_ref__const_array;
our @ISA = ('const_array');

# (array with const size) of (refs to (scalars with const values))
package const_scalar_ref__const_array;
our @ISA = ('const_array');

# (ref to array) of scalars
package scalar__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (scalars with const values)
package const_scalar__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (refs to scalars)
package scalar_ref__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (refs to (scalars with const values))
package const_scalar_ref__array_ref;
our @ISA = ('array_ref');

# (ref to (array with const size)) of scalars
package scalar__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (scalars with const values)
package const_scalar__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (refs to scalars)
package scalar_ref__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (refs to (scalars with const values))
package const_scalar_ref__const_array_ref;
our @ISA = ('const_array_ref');


# [[[ UNKNOWN ARRAYS ]]]

# array of unknowns
package unknown__array;
our @ISA = ('array');

# array of (unknowns with const values)
package const_unknown__array;
our @ISA = ('array');

# array of (refs to unknowns)
package unknown_ref__array;
our @ISA = ('array');

# array of (refs to (unknowns with const values))
package const_unknown_ref__array;
our @ISA = ('array');

# (array with const size) of unknowns
package unknown__const_array;
our @ISA = ('const_array');

# (array with const size) of (unknowns with const values)
package const_unknown__const_array;
our @ISA = ('const_array');

# (array with const size) of (refs to unknowns)
package unknown_ref__const_array;
our @ISA = ('const_array');

# (array with const size) of (refs to (unknowns with const values))
package const_unknown_ref__const_array;
our @ISA = ('const_array');

# (ref to array) of unknowns
package unknown__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (unknowns with const values)
package const_unknown__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (refs to unknowns)
package unknown_ref__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (refs to (unknowns with const values))
package const_unknown_ref__array_ref;
our @ISA = ('array_ref');

# (ref to (array with const size)) of unknowns
package unknown__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (unknowns with const values)
package const_unknown__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (refs to unknowns)
package unknown_ref__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (refs to (unknowns with const values))
package const_unknown_ref__const_array_ref;
our @ISA = ('const_array_ref');


# [[[ ARRAY ARRAYS (2-dimensional) ]]]

# array of arrays
package array__array;
our @ISA = ('array');

# array of (arrays with const sizes)
package const_array__array;
our @ISA = ('array');

# array of (refs to arrays)
package array_ref__array;
our @ISA = ('array');

# array of (refs to (arrays with const sizes))
package const_array_ref__array;
our @ISA = ('array');

# (array with const size) of arrays
package array__const_array;
our @ISA = ('const_array');

# (array with const size) of (arrays with const sizes)
package const_array__const_array;
our @ISA = ('const_array');

# (array with const size) of (refs to arrays)
package array_ref__const_array;
our @ISA = ('const_array');

# (array with const size) of (refs to (arrays with const sizes))
package const_array_ref__const_array;
our @ISA = ('const_array');

# (ref to array) of arrays
package array__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (arrays with const sizes)
package const_array__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (refs to arrays)
package array_ref__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (refs to (arrays with const sizes))
package const_array_ref__array_ref;
our @ISA = ('array_ref');

# (ref to (array with const size)) of arrays
package array__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (arrays with const sizes)
package const_array__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (refs to arrays)
package array_ref__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (refs to (arrays with const sizes))
package const_array_ref__const_array_ref;
our @ISA = ('const_array_ref');


# [[[ HASH ARRAYS (2-dimesional) ]]]

# array of hashs
package hash__array;
our @ISA = ('array');

# array of (hashs with const sizes)
package const_hash__array;
our @ISA = ('array');

# array of (refs to hashs)
package hash_ref__array;
our @ISA = ('array');

# array of (refs to (hashs with const sizes))
package const_hash_ref__array;
our @ISA = ('array');

# (array with const size) of hashs
package hash__const_array;
our @ISA = ('const_array');

# (array with const size) of (hashs with const sizes)
package const_hash__const_array;
our @ISA = ('const_array');

# (array with const size) of (refs to hashs)
package hash_ref__const_array;
our @ISA = ('const_array');

# (array with const size) of (refs to (hashs with const sizes))
package const_hash_ref__const_array;
our @ISA = ('const_array');

# (ref to array) of hashs
package hash__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (hashs with const sizes)
package const_hash__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (refs to hashs)
package hash_ref__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (refs to (hashs with const sizes))
package const_hash_ref__array_ref;
our @ISA = ('array_ref');

# (ref to (array with const size)) of hashs
package hash__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (hashs with const sizes)
package const_hash__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (refs to hashs)
package hash_ref__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (refs to (hashs with const sizes))
package const_hash_ref__const_array_ref;
our @ISA = ('const_array_ref');


# [[[ SWITCH CONTEXT BACK TO MAIN PACKAGE ]]]
package RPerl::DataStructure::Array;

# [[[ STRINGIFY ]]]
# [[[ STRINGIFY ]]]
# [[[ STRINGIFY ]]]

# convert from (Perl SV containing RV to (Perl AV of (Perl SVs containing IVs))) to Perl-parsable (Perl SV containing PV)
our string $stringify_integer__array_ref = sub { (my $input_av_ref) = @_;  
;
#	print "in PERLOPS_PERLTYPES stringify_integer__array_ref(), top of subroutine\n";

	# for type checking in stringify()'s, inside eval to delay until after 'use MyConfig', need move somewhere else???
	# replaced by RPerl_SvIOKp()
#	eval 'use Scalar::Util::Numeric qw(isinteger);';  ## no critic
#	eval 'use Scalar::Util qw(isdual);';  ## no critic

    my @input_av;
	my integer $input_av_length;
	my integer $i;
	my integer $input_av_element;
#	my string $temp_string = '';
#	my number $temp_num = 0;
#	my string $temp_string2 = '';
#	my number $temp_num2 = 0;
	my string $output_sv;
#	my bool $i_is_0 = 1;  # TODO: add bool RPerl type
	my integer $i_is_0 = 1;

	if (UNIVERSAL::isa($input_av_ref, 'ARRAY')) { @input_av = @{$input_av_ref}; }
	else { die("in PERLOPS_PERLTYPES stringify_integer__array_ref(), \$input_av_ref was not an AV ref, dying"); }  # croak says eval(), die says Array.pm, confess says Array.pm & stack trace
	
	$input_av_length = scalar @input_av;
#	print "in PERLOPS_PERLTYPES stringify_integer__array_ref(), have \$input_av_length = $input_av_length\n";

	$output_sv = '[';

	for ($i = 0;  $i < $input_av_length;  ++$i)
	{
		# utilizes i in element retrieval
		$input_av_element = $input_av[$i];

		if (defined($input_av_element))
		{
=SNIP Attempt at Pure-Perl equivalent to SvIOKp(), only works if $input_av_element not already dualvar status, which can be inadvertently caused by printing values for debugging, etc.
#			print "in PERLOPS_PERLTYPES stringify_integer__array_ref(), inside for() loop \$i = $i, have \$input_av_element = $input_av_element\n";  # DEV NOTE: causes integer-to-string dualvar status
#			print "in PERLOPS_PERLTYPES stringify_integer__array_ref(), inside for() loop \$i = $i, have \$input_av_element = " . $input_av_element . "\n";  # DEV NOTE: causes integer-to-string dualvar status
#			printf("in PERLOPS_PERLTYPES stringify_integer__array_ref(), inside for() loop \$i = $i, have \$input_av_element = %d\n", $input_av_element);  # DEV NOTE: causes string-to-integer dualvar status
			print "in PERLOPS_PERLTYPES stringify_integer__array_ref(), inside for() loop \$i = $i, have isdual(\$input_av_element) = " . isdual($input_av_element) . "\n";

			# DEV NOTE: evaluate copied scalar in numeric context;
			# forces $temp_string to dualvar status if $input_av_element is a number wrapped in a string,
			# without $input_av_element itself getting dualvar status, cool trick!
			# Scalar::Util::Numeric::isnum/isinteger are like SvNOK/SvIOK, and Scalar::Util::isdual plus this trick is like SvPOK
			$temp_string = $input_av_element;
			print "in PERLOPS_PERLTYPES stringify_integer__array_ref(), inside for() loop \$i = $i, have pre-numeric-op isdual(\$temp_string) = " . isdual($temp_string) . "\n";
			{ no warnings;  $temp_num = $temp_string + 0; }
			print "in PERLOPS_PERLTYPES stringify_integer__array_ref(), inside for() loop \$i = $i, have post-numeric-op isdual(\$temp_string) = " . isdual($temp_string) . "\n";  # DEV NOTE: solely true iff $input_av_element is non-dualvar number-wrapped-in-string
			print "in PERLOPS_PERLTYPES stringify_integer__array_ref(), inside for() loop \$i = $i, have post-numeric-op isdual(\$temp_num) = " . isdual($temp_num) . "\n";
			
			$temp_num2 = $input_av_element;
			print "in PERLOPS_PERLTYPES stringify_integer__array_ref(), inside for() loop \$i = $i, have pre-string-op isdual(\$temp_num2) = " . isdual($temp_num2) . "\n";
			{ no warnings;  $temp_string2 = $temp_num2 . ''; }
			print "in PERLOPS_PERLTYPES stringify_integer__array_ref(), inside for() loop \$i = $i, have post-string-op isdual(\$temp_num2) = " . isdual($temp_num2) . "\n";  # DEV NOTE: solely true iff $input_av_element is non-dualvar integer
			print "in PERLOPS_PERLTYPES stringify_integer__array_ref(), inside for() loop \$i = $i, have post-string-op isdual(\$temp_string2) = " . isdual($temp_string2) . "\n";
			
			# an integer is any scalar that:
			# 1. is defined
			# AND
			# 2. does not hold a reference
			# AND
			# 3. does not hold an integer wrapped in a string (dualvar eligibile)
			# AND
			# 4. does hold an integer (normal integer)
#			if ((ref($input_av_element) eq '') and not(isdual($input_av_element)) and isinteger($input_av_element))
#			if ((ref($input_av_element) eq '') and isdual($input_av_element) and isinteger($input_av_element))
			if ((ref($input_av_element) eq '') and not(isdual($temp_string)) and isinteger($input_av_element))  # works when $input_av_element not already dualvar
#			if ((ref($input_av_element) eq '') and not(isdual($temp_num)) and isinteger($input_av_element))
#			if ((ref($input_av_element) eq '') and isinteger($input_av_element))
#			if (isinteger($input_av_element))
=cut
			if (main::RPerl_SvIOKp($input_av_element))
			{
				if ($i_is_0)
				{
					$output_sv .= "$input_av_element";
					$i_is_0 = 0;
				}
				else
				{
					$output_sv .= ", $input_av_element";
				}
			}
			else { die("in PERLOPS_PERLTYPES stringify_integer__array_ref(), \$input_av_element at index $i was not an integer, dying"); }
		}
		else { die("in PERLOPS_PERLTYPES stringify_integer__array_ref(), \$input_av_element at index $i was undef and/or NULL, dying"); }
	}

	$output_sv .= ']';

#	print "in PERLOPS_PERLTYPES stringify_integer__array_ref(), after for() loop, have \$output_sv =\n$output_sv\n";
#	print "in PERLOPS_PERLTYPES stringify_integer__array_ref(), bottom of subroutine\n";

	return($output_sv);
};

# convert from (Perl SV containing RV to (Perl AV of (Perl SVs containing NVs))) to Perl-parsable (Perl SV containing PV)
our string $stringify_number__array_ref = sub { (my $input_av_ref) = @_;  
;
#	print "in PERLOPS_PERLTYPES stringify_number__array_ref(), top of subroutine\n";

	# for type checking in stringify()'s, inside eval to delay until after 'use MyConfig', need move somewhere else???
#	eval 'use Scalar::Util::Numeric qw(isnum);';  ## no critic

    my @input_av;
	my integer $input_av_length;
	my integer $i;
	my number $input_av_element;
	my string $output_sv;
#	my bool $i_is_0 = 1;  # NEED FIX: add bool RPerl type!
	my integer $i_is_0 = 1;

	if (UNIVERSAL::isa($input_av_ref, 'ARRAY')) { @input_av = @{$input_av_ref}; }
	else { die("in PERLOPS_PERLTYPES stringify_number__array_ref(), \$input_av_ref was not an AV ref, dying"); }
	
	$input_av_length = scalar @input_av;
#	print "in PERLOPS_PERLTYPES stringify_number__array_ref(), have \$input_av_length = $input_av_length\n";

	$output_sv = '[';

	for ($i = 0;  $i < $input_av_length;  ++$i)
	{
		# utilizes i in element retrieval
		$input_av_element = $input_av[$i];

		if (defined($input_av_element))
		{
			if (main::RPerl_SvNOKp($input_av_element) or main::RPerl_SvIOKp($input_av_element))
#			if (isnum($input_av_element))
			{
				if ($i_is_0)
				{
					$output_sv .= "$input_av_element";
					$i_is_0 = 0;
				}
				else
				{
					$output_sv .= ", $input_av_element";
				}
			}
			else { die("in PERLOPS_PERLTYPES stringify_number__array_ref(), \$input_av_element at index $i was not a number, dying"); }
		}
		else { die("in PERLOPS_PERLTYPES stringify_number__array_ref(), \$input_av_element at index $i was undef and/or NULL, dying"); }
	}

	$output_sv .= ']';

#	print "in PERLOPS_PERLTYPES stringify_number__array_ref(), after for() loop, have \$output_sv =\n$output_sv\n";
#	print "in PERLOPS_PERLTYPES stringify_number__array_ref(), bottom of subroutine\n";
	
	return($output_sv);
};

# convert from (Perl SV containing RV to (Perl AV of (Perl SVs containing PVs))) to Perl-parsable (Perl SV containing PV)
our string $stringify_string__array_ref = sub { (my $input_av_ref) = @_;  
;
#	print "in PERLOPS_PERLTYPES stringify_string__array_ref(), top of subroutine\n";

	# for type checking in stringify()'s, inside eval to delay until after 'use MyConfig', need move somewhere else???
#	eval 'use Scalar::Util::Numeric qw(isnum);';  ## no critic
#	eval 'use Scalar::Util qw(isdual);';  ## no critic

    my @input_av;
	my integer $input_av_length;
	my integer $i;
	my string $input_av_element;
#	my string $temp_string;
#	my number $temp_num;
	my string $output_sv;
#	my bool $i_is_0 = 1;  # NEED FIX: add bool RPerl type!
	my integer $i_is_0 = 1;

	if (UNIVERSAL::isa($input_av_ref, 'ARRAY')) { @input_av = @{$input_av_ref}; }
	else { die("in PERLOPS_PERLTYPES stringify_string__array_ref(), \$input_av_ref was not an AV ref, dying"); }
	
	$input_av_length = scalar @input_av;
#	print "in PERLOPS_PERLTYPES stringify_string__array_ref(), have \$input_av_length = $input_av_length\n";

	$output_sv = '[';

	for ($i = 0;  $i < $input_av_length;  ++$i)
	{
		# utilizes i in element retrieval
		$input_av_element = $input_av[$i];

		if (defined($input_av_element))
		{
=SNIP Attempt at Pure-Perl equivalent to SvPOKp()
			# DEV NOTE: evaluate copied scalar in numeric context;
			# forces $temp_string to dualvar status if $input_av_element is a number wrapped in a string,
			# without $input_av_element itself getting dualvar status, cool trick!
			# Scalar::Util::Numeric::isnum/isinteger are like SvNOK/SvIOK, and Scalar::Util::isdual plus this trick is like SvPOK
			$temp_string = $input_av_element;
			{ no warnings;  $temp_num = $temp_string + 0; }
			
			# a string is any scalar that:
			# 1. is defined
			# AND
			# 2. does not hold a reference
			# AND
			# 3a. does not hold a number (normal string)
			# OR
			# 3b. does hold a number wrapped in a string (dualvar eligibile)
			if ((ref($input_av_element) eq '') and
				(
					not(isnum($input_av_element)) or
					isdual($temp_string)
				))
=cut
			if (main::RPerl_SvPOKp($input_av_element))
			{
				if ($i_is_0)
				{
				    # DEV NOTE: emulate Data::Dumper & follow PBP by using single quotes for strings
#					$output_sv .= '"' . $input_av_element . '"';
					$output_sv .= "\'$input_av_element\'";
					$i_is_0 = 0;
				}
				else
				{
#					$output_sv .= ', "' . $input_av_element . '"';
					$output_sv .= ", \'$input_av_element\'";
				}
			}
			else { die("in PERLOPS_PERLTYPES stringify_string__array_ref(), \$input_av_element at index $i was not a string, dying"); }
		}
		else { die("in PERLOPS_PERLTYPES stringify_string__array_ref(), \$input_av_element at index $i was undef and/or NULL, dying"); }
	}

	$output_sv .= ']';

#	print "in PERLOPS_PERLTYPES stringify_string__array_ref(), after for() loop, have \$output_sv =\n$output_sv\n";
#	print "in PERLOPS_PERLTYPES stringify_string__array_ref(), bottom of subroutine\n";
	
	return($output_sv);
};


# [[[ TYPE TESTING ]]]
# [[[ TYPE TESTING ]]]
# [[[ TYPE TESTING ]]]

our string $typetest___integer__array_ref__in___string__out = sub { (my integer__array_ref $lucky_numbers) = @_;  my integer $how_lucky = scalar @{$lucky_numbers};  my integer $i;  for ($i = 0;  $i < $how_lucky;  ++$i) { if (main::RPerl_SvIOKp($lucky_numbers->[$i])) { print "in PERLOPS_PERLTYPES Array::typetest___integer__array_ref__in___string__out(), have lucky number $i/" . ($how_lucky - 1) . " = " . $lucky_numbers->[$i] . ", BARBAT\n"; } }  return(stringify_integer__array_ref($lucky_numbers) . 'PERLOPS_PERLTYPES'); };
our integer__array_ref $typetest___integer__in___integer__array_ref__out = sub { (my integer $my_size) = @_;  my integer__array_ref $new_array = [];  my integer $i;  for ($i = 0;  $i < $my_size;  ++$i) { $new_array->[$i] = $i * 5;  print "in PERLOPS_PERLTYPES Array::typetest___integer__in___integer__array_ref__out(), setting element $i/" . ($my_size - 1) . " = " . $new_array->[$i] . ", BARBAT\n"; }  return($new_array); };

our string $typetest___number__array_ref__in___string__out = sub { (my number__array_ref $lucky_numbers) = @_;  my integer $how_lucky = scalar @{$lucky_numbers};  my integer $i;  for ($i = 0;  $i < $how_lucky;  ++$i) { if (main::RPerl_SvNOKp($lucky_numbers->[$i]) or main::RPerl_SvIOKp($lucky_numbers->[$i])) { print "in PERLOPS_PERLTYPES Array::typetest___number__array_ref__in___string__out(), have lucky number $i/" . ($how_lucky - 1) . " = " . $lucky_numbers->[$i] . ", BARBAZ\n"; } }  return(stringify_number__array_ref($lucky_numbers) . 'PERLOPS_PERLTYPES'); };
our number__array_ref $typetest___integer__in___number__array_ref__out = sub { (my integer $my_size) = @_;  my number__array_ref $new_array = [];  my integer $i;  for ($i = 0;  $i < $my_size;  ++$i) { $new_array->[$i] = $i * 5.123456789;  print "in PERLOPS_PERLTYPES Array::typetest___integer__in___number__array_ref__out(), setting element $i/" . ($my_size - 1) . " = " . $new_array->[$i] . ", BARBAZ\n"; }  return($new_array); };

our string $typetest___string__array_ref__in___string__out = sub { (my string__array_ref $people) = @_;  my integer $i;  for ($i = 0;  $i < scalar @{$people};  ++$i) { if (main::RPerl_SvPOKp($people->[$i])) { print "in PERLOPS_PERLTYPES Array::typetest___string__array_ref__in___string__out(), have person $i = '" . $people->[$i] . "', BARBAR\n"; } }  return(stringify_string__array_ref($people) . 'PERLOPS_PERLTYPES'); };
our string__array_ref $typetest___integer__in___string__array_ref__out = sub { (my integer $my_size) = @_;  my string__array_ref $people = [];  my integer $i;  for ($i = 0;  $i < $my_size;  ++$i) { $people->[$i] = "Jeffy Ten! $i/" . ($my_size - 1) . ' PERLOPS_PERLTYPES';  print "in PERLOPS_PERLTYPES Array::typetest___void__in___string__array_ref__out(), bottom of for() loop, have i = $i, just set another Jeffy, BARBAR\n"; }  return($people); };
