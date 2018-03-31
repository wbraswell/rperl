#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< GENERATE_ERROR: "ERROR ECOGEASRP72a, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: global variable name '$_Foo_variable' must not start with an underscore, forbidden by C++ specification as a reserved identifier" >>>

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

# NEED ANSWER: is it possible to actually trigger ERROR ECOGEASRP72b?  here it is over-ridden by ERROR ECOGEASRP72a
my string $_Foo_variable = 'if only you could see';
print $_Foo_variable, "\n";

