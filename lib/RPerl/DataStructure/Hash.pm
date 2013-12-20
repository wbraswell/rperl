package RPerl::DataStructure::Hash;
use strict;
use warnings;
use version; our $VERSION = 0.003000;
use Carp;

# [[[ SUB-TYPES BEFORE SETUP ]]]
use RPerl::DataStructure::Hash::SubTypes;

# [[[ SETUP ]]]
# [[[ SETUP ]]]
# [[[ SETUP ]]]

use parent ('RPerl::DataStructure');
use RPerl::DataStructure;

# for type-checking via SvIOKp(), SvNOKp(), and SvPOKp(); inside INIT to delay until after 'use MyConfig'
INIT {
    print "in Hash.pm, loading C++ helper functions for type-checking...\n"
        or croak();
}
INIT {
    use RPerl::HelperFunctions_cpp;
    RPerl::HelperFunctions_cpp::cpp_load();
    RPerl::HelperFunctions_cpp::cpp_link();
}

use RPerl::DataType::Void;
use RPerl::DataType::Integer;
use RPerl::DataType::Float;
use RPerl::DataType::Number;
use RPerl::DataType::Character;
use RPerl::DataType::String;
use RPerl::DataType::Scalar;

#use RPerl::DataType::Reference;
use RPerl::DataType::Unknown;

#use RPerl::DataStructure::Array;

# [[[ OPERATIONS & DATA TYPES REPORTING ]]]
# [[[ OPERATIONS & DATA TYPES REPORTING ]]]
# [[[ OPERATIONS & DATA TYPES REPORTING ]]]

our integer $OPS_TYPES_ID = 0;                        # PERLOPS_PERLTYPES is 0
our string $hash__ops     = sub { return ('PERL'); };
our string $hash__types   = sub { return ('PERL'); };

1;
