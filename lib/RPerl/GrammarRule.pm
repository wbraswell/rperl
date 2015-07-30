# [[[ HEADER ]]]
package RPerl::GrammarRule;
use strict;
use warnings;
use RPerl::AfterFilter;
our $VERSION = 0.000_002;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);
use RPerl::CompileUnit::Module::Class;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

1;  # end of class
