# [[[ HEADER ]]]
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names
package  # hide from PAUSE indexing
    rperltypesconv;
use strict;
use warnings;
our $VERSION = 0.001_100;

# [[[ DATA TYPES ]]]
use RPerl::DataType::Boolean;
use RPerl::DataType::UnsignedInteger;
use RPerl::DataType::Integer;
use RPerl::DataType::Number;
use RPerl::DataType::Character;
use RPerl::DataType::String;

# DEV NOTE, CORRELATION #rp008: use Exporter here instead of rperltypes.pm

# [[[ EXPORTS ]]]
use Exporter 'import';

# DEV NOTE: don't include generic type conversion subroutines such as to_number() & to_string() in @EXPORT below, causes error:
# Subroutine main::to_number redefined at /usr/share/perl/5.18/Exporter.pm
our @EXPORT = qw(
    boolean_to_unsigned_integer boolean_to_integer boolean_to_number boolean_to_character boolean_to_string
    unsigned_integer_to_boolean unsigned_integer_to_integer unsigned_integer_to_number unsigned_integer_to_character unsigned_integer_to_string
    integer_to_boolean integer_to_unsigned_integer integer_to_number integer_to_character integer_to_string
    number_to_boolean number_to_unsigned_integer number_to_integer number_to_character number_to_string
    character_to_boolean character_to_unsigned_integer character_to_integer character_to_number character_to_string
    string_to_boolean string_to_unsigned_integer string_to_integer string_to_number string_to_character string_to_string
);