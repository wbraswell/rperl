#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< GENERATE_ERROR: "72c, CODE GENERATOR, ABSTRACT SYNTAX TO" >>>
# <<< GENERATE_ERROR: "variable name '$foo__variable' must not include a double-underscore, forbidden by C++ specification as a reserved identifier" >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

use RPerl::Test::Reserved::Class_01_Good;

sub foo_subroutine_in_main {
    { my void $RETURN_TYPE };
    print 'Howdy from foo_subroutine_in_main()...', "\n";
    return;
}

# [[[ OPERATIONS ]]]
print 'Hello, World!', "\n";
foo_subroutine_in_main();

my string $foo__variable = 'if only you could see';
print $foo__variable, "\n";

