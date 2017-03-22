# [[[ HEADER ]]]
use RPerl::AfterSubclass;
package Inline::RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);
use RPerl::CompileUnit::Module::Class;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use RPerl::Test::Foo;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {
    foo => my integer $TYPED_foo         = 23,
};

# [[[ SUBROUTINES & OO METHODS ]]]

# <<< CHANGE_ME: delete for no subroutines/methods, or replace with real subroutine(s)/method(s) >>>
our void $bar = sub {
    print 'in subroutine bar()...', "\n";
};

1;    # end of class
