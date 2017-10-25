#!/usr/bin/perl

# Learning RPerl, Section 4.1: Subroutine Definitions

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

sub HELLO_WORLD { { my void $RETURN_TYPE }; print 'Hello, World!', "\n"; return; }
sub Hello_World { { my void $RETURN_TYPE }; print 'Hello, World, again!', "\n"; return; }
sub HELLO_world { { my void $RETURN_TYPE }; print 'Hello, World, yet again!', "\n"; return; }

# [[[ OPERATIONS ]]]

HELLO_WORLD();
Hello_World();
HELLO_world();

