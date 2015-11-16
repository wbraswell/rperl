# [[[ HEADER ]]]
package RPerl::DataType::Character;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.002_100;

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

# [[[ SWITCH CONTEXT BACK TO PRIMARY PACKAGE ]]]
package RPerl::DataType::Character;
use strict;
use warnings;

# [[[ BOOLIFY ]]]
our bool $char_to_bool = sub {
    (my char $input_char) = @_;
    if (($input_char * 1) == 0) { return 0; }
    else { return 1; }
};

# [[[ INTEGERIFY ]]]
our integer $char_to_integer = sub {
    (my char $input_char) = @_;
    return floor ($input_char * 1);
};

# [[[ NUMBERIFY ]]]
our number $char_to_number = sub {
    (my char $input_char) = @_;
    return $input_char * 1.0;
};

# [[[ STRINGIFY ]]]
our string $char_to_string = sub {
    (my char $input_char) = @_;
    return $input_char;
};

1;  # end of class
