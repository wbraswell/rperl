#!/usr/bin/perl

# Learning RPerl, Section 4.4: Subroutine Arguments

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'inside foo_arg(), have $arg1 = 1_701' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ SUBROUTINES ]]]

# NEED UPGRADE, CORRELATION #rp035: allow multi-line subroutines & other code blocks, where they would be less than 160 chars if on a single line
#sub foo_arg {
#    { my void $RETURN_TYPE };
#    (my integer $arg1) = @ARG;
#    print 'inside foo_arg(), have $arg1 = ', integer_to_string($arg1), "\n";
#    return;
#}

# PERLTIDY BUG, failure to put a space between $arg3 and closing )
#sub foo_arg { { my void $RETURN_TYPE }; (my integer $arg1) = @ARG; print 'inside foo_arg(), have $arg1 = ', integer_to_string($arg1), "\n"; return; }
#sub foo_arg { { my void $RETURN_TYPE }; (my integer $arg1) = @ARG; print 'inside foo_arg(), have $arg1 = ', integer_to_string($arg1), "\n"; return; }  # this comment is a test of script/development/find_replace_old_subroutine_headers.sh
sub foo_arg { { my void $RETURN_TYPE }; ( my integer $arg1 ) = @ARG; print 'inside foo_arg(), have $arg1 = ', integer_to_string($arg1), "\n"; return; }

# [[[ OPERATIONS ]]]
foo_arg(1_701);
