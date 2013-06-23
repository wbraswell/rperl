use strict;  use warnings;
package RPerl::Object;

# an object is an individual instance of a class; it could be a blessed hash ref in Perl or a C++ class
package object;
our @ISA = ('RPerl::Object');

# object with const (list of properties and methods)
package const_object;
our @ISA = ('object', 'const');

# ref to object
package object_ref;
our @ISA = ('ref');

# ref to (object with const (list of properties and methods))
package const_object_ref;
our @ISA = ('ref');

# RPerl Object, no inheritance from RPerl or RPerl::Class
1;
