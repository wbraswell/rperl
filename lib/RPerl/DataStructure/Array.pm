package RPerl::DataStructure::Array;
use strict;
use warnings;
our $VERSION = 0.003_006;
use parent ('RPerl::DataStructure');
use RPerl::DataStructure;
use Carp;

# [[[ SUB-TYPES BEFORE SETUP ]]]
use RPerl::DataStructure::Array::SubTypes;

# [[[ SETUP ]]]
# [[[ SETUP ]]]
# [[[ SETUP ]]]

# for type-checking via SvIOKp(), SvNOKp(), and SvPOKp(); inside INIT to delay until after 'use MyConfig'
#INIT { RPerl::diag "in Array.pm, loading C++ helper functions for type-checking...\n"; }
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

# [[[ OPERATIONS & DATA TYPES REPORTING ]]]
# [[[ OPERATIONS & DATA TYPES REPORTING ]]]
# [[[ OPERATIONS & DATA TYPES REPORTING ]]]

our integer $OPS_TYPES_ID = 0;                        # PERLOPS_PERLTYPES is 0
our string $array__ops    = sub { return ('PERL'); };
our string $array__types  = sub { return ('PERL'); };

1;
