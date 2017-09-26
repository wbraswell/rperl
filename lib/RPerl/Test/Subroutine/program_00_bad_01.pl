#!/usr/bin/perl

# Learning RPerl, Section 4.2.1: Parentheses Suffix & Ampersand Prefix

# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPAPL02' >>>
# <<< PARSE_ERROR: 'Bareword "hello_world" not allowed while "strict subs" in use' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ SUBROUTINES ]]]

sub hello_world { { my void $RETURN_TYPE }; print 'Hello, World!', "\n"; return; }
sub Hello_World { { my void $RETURN_TYPE }; print 'Hello, World, again!', "\n"; return; }
sub HELLO_world { { my void $RETURN_TYPE }; print 'Hello, World, yet again!', "\n"; return; }

# [[[ OPERATIONS ]]]

hello_world;
Hello_World();
HELLO_world();
