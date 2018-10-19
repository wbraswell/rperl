#!/usr/bin/env perl

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

# [[[ INCLUDES ]]]
use RPerl::Test::Reserved::_Class_04_Good;

# [[[ SUBROUTINES ]]]
sub foo_subroutine_in_main {
    { my void $RETURN_TYPE };
    print 'Howdy from foo_subroutine_in_main()...', "\n";

    my string $_foo_variable = 'if only you could see';
    print $_foo_variable, "\n";

    return;
}

# [[[ OPERATIONS ]]]
print 'Hello, World!', "\n";
foo_subroutine_in_main();
