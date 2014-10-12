# [[[ HEADER ]]]
package RPerl::Test;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE, INCLUDES ]]]
use parent qw(RPerl::CompileUnit::Module::Class); # no non-system inheritance, RPerl::CompileUnit::Module::Class is the base class of all RPerl classes
use RPerl::CompileUnit::Module::Class;

# [[[ OO METHODS ]]]

# OO INHERITANCE TESTING
our void__method $empty_method = sub {
    ( my object $self ) = @_;
    2;
};

1;
1;    # CODE SEPARATOR: end of class
