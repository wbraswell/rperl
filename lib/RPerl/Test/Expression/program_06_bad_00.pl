#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPAPL02' >>>
# <<< PARSE_ERROR_DISABLED_PERL_V5.10_V5.12: 'Use of inherited AUTOLOAD for non-method main::garply() is deprecated' >>>
# <<< PARSE_ERROR_DISABLED_PERL_V5.14_ONWARD: 'Undefined subroutine &main::garply called' >>>
# NEED ANSWER: why did Perl v5.10 and v5.12 all of a sudden start failing this test in the middle of June 2018???

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use RPerl::Test::Foo

# [[[ OPERATIONS ]]]
print Dumper( garply( 17, 23, 42 ) );
