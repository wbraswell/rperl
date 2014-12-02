# [[[ HEADER ]]]
package RPerl::Test::DataTypeString::String_SingleQ_05_Good;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub { q{'foo'\ t"bar"\ n}; };

1;                  # end of class
