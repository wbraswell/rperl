# [[[ HEADER ]]]
package RPerl::Object;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.002_000;

# NEED FIX?: RPerl Object, no inheritance from RPerl or RPerl::CompileUnit::Module::Class

# [[[ OO INHERITANCE ]]]
#use parent ('RPerl::CompileUnit::Module::Class');
#use RPerl::CompileUnit::Module::Class;

# [[[ SUB-TYPES ]]]
# an object is an individual instance of a class; it could be a blessed hash ref in Perl or a C++ class
package  # hide from PAUSE indexing
    object;
use strict;
use warnings;
use RPerl;
use parent ('RPerl::Object');

1;  # end of class
