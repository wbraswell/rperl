#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPAPL02' >>>
# <<< PARSE_ERROR: 'Subroutine exported_ok redefined' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use RPerl::Test::Exporter::Class_B_Exporter_00_Good qw(exported_ok);

# [[[ SUBROUTINES ]]]

sub exported_ok {
    { my integer $RETURN_TYPE };
    ( my integer $arg ) = @ARG;
    print 'in main::exported_ok(), received $arg = ', $arg, "\n";
    return ($arg * 34);
}

# [[[ OPERATIONS ]]]

my integer $exported_ok_retval = exported_ok(17);
print 'after exported_ok(17), received $exported_ok_retval = ', $exported_ok_retval, "\n";

