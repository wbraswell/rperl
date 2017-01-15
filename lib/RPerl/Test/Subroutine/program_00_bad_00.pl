#!/usr/bin/perl

# Learning RPerl, Section 4.1: Subroutine Definitions

# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPARP00' >>>
# <<< PARSE_ERROR: 'Unexpected Token:  $HELLO_WORLD' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ SUBROUTINES ]]]

our void $HELLO_WORLD = sub { print 'Hello, World!', "\n"; };
our void $Hello_World = sub { print 'Hello, World, again!', "\n"; };
our void $HELLO_world = sub { print 'Hello, World, yet again!', "\n"; };

# [[[ OPERATIONS ]]]

HELLO_WORLD();
Hello_World();
HELLO_world();
