#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_ERROR: 'ERROR EIV01, TYPE-CHECKING MISMATCH' >>>
# <<< EXECUTE_ERROR: 'integer value expected but non-integer value found' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use RPerl::Test::TypeCheckingOn::AllTypes;

# [[[ OPERATIONS ]]]

my RPerl::Test::TypeCheckingOn::AllTypes $alltypes_object = RPerl::Test::TypeCheckingOn::AllTypes->new(); 
$alltypes_object->check_class_integer(23.1);

