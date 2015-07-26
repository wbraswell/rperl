# [[[ HEADER ]]]
package RPerl::DataType::Character;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.002_000;

# [[[ OO INHERITANCE ]]]
use parent ('RPerl::DataType::String');
use RPerl::DataType::String;

# [[[ SUB-TYPES ]]]
# a character is a string of length 0 or 1, meaning a single letter, digit, or other ASCII (Unicode???) symbol
package  # hide from PAUSE indexing
    char;
use strict;
use warnings;
use RPerl;
use parent ('RPerl::DataType::Integer');

1;  # end of class
