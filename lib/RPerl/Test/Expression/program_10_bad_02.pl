#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< COMPILE_ERROR: 'ERROR ECVPAPL02' >>>
# <<< COMPILE_ERROR: 'near ")' >>>
# <<< COMPILE_ERROR: 'Global symbol "$my_foo" requires explicit package name' >>>

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
my object $my_foo = RPerl::Test::Foo->new();
$my_foo->quux()
print $my_foo->{plugh}, "\n";
$my_foo->{plugh} = 42;
$my_foo->quux();
print $my_foo->{plugh}, "\n";