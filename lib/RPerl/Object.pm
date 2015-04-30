use strict;  use warnings;
package RPerl::Object;

# an object is an individual instance of a class; it could be a blessed hash ref in Perl or a C++ class
package object;
our @ISA = ('RPerl::Object');

# RPerl Object, no inheritance from RPerl or RPerl::CompileUnit::Module::Class
1;
