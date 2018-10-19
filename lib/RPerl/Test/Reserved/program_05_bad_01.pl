#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< GENERATE_ERROR: "P185c, CODE GENERATOR, ABSTRACT SYNTAX TO" >>>
# <<< GENERATE_ERROR: "included package or class name 'RPerl::Test::Reserved::Class_04__Bad_00' must not include a double-underscore, forbidden by C++ specification as a reserved identifier" >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

# [[[ INCLUDES ]]]
use RPerl::Test::Reserved::Class_04__Bad_00;

# [[[ SUBROUTINES ]]]
sub _foo_subroutine_in_main {
    { my void $RETURN_TYPE };
    print 'Howdy from _foo_subroutine_in_main()...', "\n";
    return;
}

# [[[ OPERATIONS ]]]
print 'Hello, World!', "\n";
_foo_subroutine_in_main();
