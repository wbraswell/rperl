# [[[ HEADER ]]]
package RPerl::DataStructure::Hash;
use strict;
use warnings;
our $VERSION = 0.004_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::DataStructure);
use RPerl::DataStructure;

use Carp;

# [[[ SUB-TYPES BEFORE INCLUDES ]]]
use RPerl::DataStructure::Hash::SubTypes;

# [[[ INCLUDES ]]]
# for type-checking via SvIOKp(), SvNOKp(), and SvPOKp(); inside INIT to delay until after 'use MyConfig'
#INIT { RPerl::diag("in Hash.pm, loading C++ helper functions for type-checking...\n"); }
INIT {
    use RPerl::HelperFunctions_cpp;
    RPerl::HelperFunctions_cpp::cpp_load();
}

use RPerl::DataType::Void;
use RPerl::DataType::Integer;
use RPerl::DataType::Float;
use RPerl::DataType::Number;
use RPerl::DataType::Character;
use RPerl::DataType::String;
use RPerl::DataType::Scalar;
use RPerl::DataType::Unknown;
use RPerl::DataStructure::Array;

# DEV NOTE, CORRELATION #rp18: RPerl::DataStructure::Array & Hash can not 'use RPerl;' so *__MODE_ID() subroutines are hard-coded here
package main;
use strict;
use warnings;
sub RPerl__DataStructure__Hash__MODE_ID { return 0; }

1;  # end of class
