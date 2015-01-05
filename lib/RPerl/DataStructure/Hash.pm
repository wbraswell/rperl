package RPerl::DataStructure::Hash;
use strict;
use warnings;
our $VERSION = 0.003_010;
use parent ('RPerl::DataStructure');
use RPerl::DataStructure;
use Carp;

# [[[ SUB-TYPES BEFORE SETUP ]]]
use RPerl::DataStructure::Hash::SubTypes;

# [[[ SETUP ]]]
# [[[ SETUP ]]]
# [[[ SETUP ]]]

# for type-checking via SvIOKp(), SvNOKp(), and SvPOKp(); inside INIT to delay until after 'use MyConfig'
#INIT { RPerl::diag "in Hash.pm, loading C++ helper functions for type-checking...\n"; }
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

1;
