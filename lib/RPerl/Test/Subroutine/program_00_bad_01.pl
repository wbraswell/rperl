#!/usr/bin/env perl

# Learning RPerl, Section 4.2.1: Parentheses Suffix & Ampersand Prefix

# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPAPC02' >>>
# <<< PARSE_ERROR: 'Perl::Critic::Policy::NamingConventions::Capitalization' >>>

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

