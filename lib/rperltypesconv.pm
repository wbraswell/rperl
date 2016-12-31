# [[[ HEADER ]]]
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names
package  # hide from PAUSE indexing
    rperltypesconv;
use strict;
use warnings;
our $VERSION = 0.004_000;

# DEV NOTE, CORRELATION #rp012: type system includes, hard-copies in rperltypes.pm & rperltypesconv.pm & Class.pm

# [[[ DATA TYPES ]]]
#use RPerl::DataType::Void;
use RPerl::DataType::Boolean;
use RPerl::DataType::UnsignedInteger;
use RPerl::DataType::Integer;
use RPerl::DataType::Number;
use RPerl::DataType::Character;
use RPerl::DataType::String;
#use RPerl::DataType::Scalar;
#use RPerl::DataType::Unknown;
#use RPerl::DataType::FileHandle;

# [[[ DATA STRUCTURES ]]]
use RPerl::DataStructure::Array;
use RPerl::DataStructure::Array::SubTypes;
use RPerl::DataStructure::Array::Reference;
use RPerl::DataStructure::Hash;
use RPerl::DataStructure::Hash::SubTypes;
use RPerl::DataStructure::Hash::Reference;

# DEV NOTE, CORRELATION #rp008: use Exporter here instead of rperltypes.pm

# [[[ EXPORTS ]]]
use Exporter 'import';

# DEV NOTE: don't include generic type conversion subroutines such as to_number() & to_string() in @EXPORT below, causes error:
# Subroutine main::to_number redefined at /usr/share/perl/5.18/Exporter.pm
our @EXPORT = qw(
    boolean_CHECK boolean_CHECKTRACE boolean_to_unsigned_integer boolean_to_integer boolean_to_number boolean_to_character boolean_to_string
    unsigned_integer_CHECK unsigned_integer_CHECKTRACE unsigned_integer_to_boolean unsigned_integer_to_integer unsigned_integer_to_number unsigned_integer_to_character unsigned_integer_to_string
    integer_CHECK integer_CHECKTRACE integer_to_boolean integer_to_unsigned_integer integer_to_number integer_to_character integer_to_string
    number_CHECK number_CHECKTRACE number_to_boolean number_to_unsigned_integer number_to_integer number_to_character number_to_string
    character_CHECK character_CHECKTRACE character_to_boolean character_to_unsigned_integer character_to_integer character_to_number character_to_string
    string_CHECK string_CHECKTRACE string_to_boolean string_to_unsigned_integer string_to_integer string_to_number string_to_character string_to_string
    arrayref_CHECK arrayref_CHECKTRACE integer_arrayref_CHECK integer_arrayref_CHECKTRACE number_arrayref_CHECK number_arrayref_CHECKTRACE string_arrayref_CHECK string_arrayref_CHECKTRACE
    hashref_CHECK hashref_CHECKTRACE integer_hashref_CHECK integer_hashref_CHECKTRACE number_hashref_CHECK number_hashref_CHECKTRACE string_hashref_CHECK string_hashref_CHECKTRACE
);