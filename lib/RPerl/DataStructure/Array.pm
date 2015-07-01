package RPerl::DataStructure::Array;
use strict;
use warnings;
our $VERSION = 0.003_011;
use parent ('RPerl::DataStructure');
use RPerl::DataStructure;
use Carp;

# [[[ SUB-TYPES BEFORE INCLUDES ]]]
use RPerl::DataStructure::Array::SubTypes;

# [[[ INCLUDES ]]]
# for type-checking via SvIOKp(), SvNOKp(), and SvPOKp(); inside INIT to delay until after 'use MyConfig'
#INIT { RPerl::diag("in Array.pm, loading C++ helper functions for type-checking...\n"); }
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
use RPerl::DataStructure::Hash;

1;
