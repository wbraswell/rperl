use strict;  use warnings;
package RPerl::DataType::Character;

our @ISA = ('RPerl::DataType::String');
use RPerl::DataType::String;

# a character is a string of length 0 or 1, meaning a single letter, digit, or other ASCII (Unicode???) symbol
package char;
our @ISA = ('RPerl::DataType::Integer');

# char with const value
package const_char;
our @ISA = ('char', 'const');

# ref to char
package char_ref;
our @ISA = ('ref');

# ref to (char with const value)
package const_char_ref;
our @ISA = ('ref');