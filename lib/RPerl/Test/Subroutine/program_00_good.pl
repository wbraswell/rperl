#!/usr/bin/perl

# Learning RPerl, Section 4.1: Subroutine Definitions

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'Hello, World!' >>>
# <<< EXECUTE_SUCCESS: 'Hello, World, again!' >>>
# <<< EXECUTE_SUCCESS: 'Hello, World, yet again!' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ SUBROUTINES ]]]

our void $hello_world_1 = sub { print 'Hello, World!',            "\n"; };  # this comment is a test of script/development/find_replace_old_subroutine_headers.sh
our void $hello_world_2 = sub { print 'Hello, World, again!',     "\n"; };
our void $hello_world_3 = sub { print 'Hello, World, yet again!', "\n"; };

# [[[ OPERATIONS ]]]

hello_world_1();
hello_world_2();
hello_world_3();
