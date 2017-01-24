# [[[ HEADER ]]]
package RPerl::DataType;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.002_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);
use RPerl::CompileUnit::Module::Class;

# [[[ INCLUDES ]]]
# include modifiers here to be utilized by individual data types
use RPerl::DataType::Modifier::Reference;

1;  # end of package
