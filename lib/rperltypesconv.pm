# [[[ HEADER ]]]
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names
package  # hide from PAUSE indexing
    rperltypesconv;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ DATA TYPES ]]]
use RPerl::DataType::Boolean;
use RPerl::DataType::UnsignedInteger;
use RPerl::DataType::Integer;
use RPerl::DataType::Number;
use RPerl::DataType::Character;
use RPerl::DataType::String;

# DEV NOTE, CORRELATION #rp08: use Exporter here instead of rperltypes.pm

# [[[ EXPORTS ]]]
use Exporter 'import';

our @EXPORT = qw(
    bool_to_unsigned_integer bool_to_integer bool_to_number bool_to_char bool_to_string
    unsigned_integer_to_bool unsigned_integer_to_integer unsigned_integer_to_number unsigned_integer_to_char unsigned_integer_to_string
    integer_to_bool integer_to_unsigned_integer integer_to_number integer_to_char integer_to_string
    number_to_bool number_to_unsigned_integer number_to_integer number_to_char number_to_string
    char_to_bool char_to_unsigned_integer char_to_integer char_to_number char_to_string
    string_to_bool string_to_unsigned_integer string_to_integer string_to_number string_to_char string_to_string
);