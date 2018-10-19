#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< GENERATE_ERROR: "P181c, CODE GENERATOR, ABSTRACT SYNTAX TO" >>>
# <<< GENERATE_ERROR: "subroutine name 'foo__subroutine_in_main()' must not include a double-underscore, forbidden by C++ specification as a reserved identifier" >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

# [[[ INCLUDES ]]]
use RPerl::Test::Reserved::Class_01_Good;

# [[[ SUBROUTINES ]]]
sub foo__subroutine_in_main {
    { my void $RETURN_TYPE };
    print 'Howdy from foo__subroutine_in_main()...', "\n";
    return;
}

# [[[ OPERATIONS ]]]
print 'Hello, World!', "\n";
foo__subroutine_in_main();
