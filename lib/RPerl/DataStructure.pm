package RPerl::DataStructure;
use strict;  use warnings;

our @ISA = ('RPerl::Class');
use RPerl::Class;

# the base classes that directly call "use RPerl::Class;" also need to "use RPerl;" to get "use types;", etc.
use RPerl;