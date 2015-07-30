# DEV NOTE: this is a shortcut class to make RPerl application code cleaner

# [[[ HEADER ]]]
package RPerl::Class;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);
use RPerl::CompileUnit::Module::Class;

1;  # end of class
