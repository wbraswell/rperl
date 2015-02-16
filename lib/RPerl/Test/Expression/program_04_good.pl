#!/usr/bin/perl
# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use RPerl::Test::Foo;

# [[[ OPERATIONS ]]]
#RPerl::Test::Foo::grault(17);
grault(17);

# IS THERE REALLY ANY DIFFERENCE BETWEEN A SUBROUTINE AND A CLASS METHOD?
# DELETE CLASS METHODS YET AGAIN???

# START HERE 2: flesh Foo from ClassTemplate, implement class method tests (will be "static" method in C++) & object method tests
# START HERE 2: flesh Foo from ClassTemplate, implement class method tests (will be "static" method in C++) & object method tests
# START HERE 2: flesh Foo from ClassTemplate, implement class method tests (will be "static" method in C++) & object method tests