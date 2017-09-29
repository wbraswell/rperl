#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< PARSE ERROR: 'ERROR ECOPAPL02' >>>
# <<< PARSE_ERROR: 'Subroutine exported redefined' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use RPerl::Test::Exporter::Package_C_Exporter_00_Good;

# [[[ SUBROUTINES ]]]

sub exported {
    { my integer $RETURN_TYPE };
    ( my integer $arg ) = @ARG;
    print 'in main::exported(), received $arg = ', $arg, "\n";
    return ($arg * 430);
}

# [[[ OPERATIONS ]]]

my integer $exported_retval = exported(17);
print 'after exported(17), received $exported_retval = ', $exported_retval, "\n";