# [[[ HEADER ]]]
package RPerl::Test;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.004_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);
use RPerl::CompileUnit::Module::Class;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

# OO INHERITANCE TESTING
sub empty_method {
    { my void::method $RETURN_TYPE };
    ( my object $self ) = @ARG;
    print 'Hello, World!', "\n";
    return;
}

1;                  # end of class
