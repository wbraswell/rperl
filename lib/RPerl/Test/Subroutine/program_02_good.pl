#!/usr/bin/env perl

# Learning RPerl, Section 4.2.1: Parentheses Suffix & Ampersand Prefix

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

sub hello_world_1 { { my void $RETURN_TYPE }; print 'Hello, World!',            "\n"; return; }  # this comment is a test of script/development/find_replace_old_subroutine_headers.sh
sub hello_world_2 { { my void $RETURN_TYPE }; print 'Hello, World, again!',     "\n"; return; }
sub hello_world_3 { { my void $RETURN_TYPE }; print 'Hello, World, yet again!', "\n"; return; }  # this comment is a test of script/development/find_replace_old_subroutine_headers.sh

# [[[ OPERATIONS ]]]

hello_world_1 ();
hello_world_2  ();
hello_world_3    ();
