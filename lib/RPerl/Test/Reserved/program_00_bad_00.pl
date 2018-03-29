#!/usr/bin/perl

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

use RPerl::Test::Reserved::Class_00_Good;

sub _foo_subroutine_in_main {
    { my void $RETURN_TYPE };
    print 'Howdy from _foo_subroutine_in_main()...', "\n";
    return;
}

# [[[ OPERATIONS ]]]
print 'Hello, World!', "\n";
_foo_subroutine_in_main();
