# [[[ HEADER ]]]
package RPerl::DataType::Character;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.004_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::DataType::String);
use RPerl::DataType::String;

# [[[ SUB-TYPES ]]]
# a character is a string of length 0 or 1, meaning a single letter, digit, or other ASCII (Unicode???) symbol
package  # hide from PAUSE indexing
    char;
use strict;
use warnings;
use parent qw(RPerl::DataType::Integer);

# [[[ PRE-DECLARED TYPES ]]]
package    # hide from PAUSE indexing
    bool;
package    # hide from PAUSE indexing
    unsigned_integer;
package     # hide from PAUSE indexing
    integer;
package    # hide from PAUSE indexing
    gmp_integer;
package    # hide from PAUSE indexing
    number;
package    # hide from PAUSE indexing
    string;

# [[[ SWITCH CONTEXT BACK TO PRIMARY PACKAGE ]]]
package RPerl::DataType::Character;
use strict;
use warnings;

# [[[ EXPORTS ]]]
use Exporter 'import';
our @EXPORT = qw(char_to_bool char_to_unsigned_integer char_to_integer char_to_number char_to_string);

# [[[ BOOLIFY ]]]
#our bool $char_to_bool = sub {
sub char_to_bool {
    (my char $input_char) = @_;
    if (($input_char * 1) == 0) { return 0; }
    else { return 1; }
}

# [[[ UNSIGNED INTEGERIFY ]]]
#our unsigned_integer $char_to_unsigned_integer = sub {
sub char_to_unsigned_integer {
    (my char $input_char) = @_;
    return floor abs ($input_char * 1);
}

# [[[ INTEGERIFY ]]]
#our integer $char_to_integer = sub {
sub char_to_integer {
    (my char $input_char) = @_;
    return floor ($input_char * 1);
}

# [[[ NUMBERIFY ]]]
#our number $char_to_number = sub {
sub char_to_number {
    (my char $input_char) = @_;
    return $input_char * 1.0;
}

# [[[ STRINGIFY ]]]
#our string $char_to_string = sub {
sub char_to_string {
    (my char $input_char) = @_;
    return $input_char;
}

1;  # end of class
