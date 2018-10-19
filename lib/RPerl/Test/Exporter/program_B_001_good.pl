#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'in Package_B_Exporter_00_Good::exported_ok(), received $arg = 17' >>>
# <<< EXECUTE_SUCCESS: 'after RPerl::Test::Exporter::Package_B_Importer_00_Good::exported_ok(17), received $exported_ok_retval = 408' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use RPerl::Test::Exporter::Package_B_Importer_00_Good;

# [[[ SUBROUTINES ]]]

sub not_exported {
    { my integer $RETURN_TYPE };
    ( my integer $arg ) = @ARG;
    print 'in main::not_exported(), received $arg = ', $arg, "\n";
    return ($arg * 34);
}

# [[[ OPERATIONS ]]]

my integer $exported_ok_retval = RPerl::Test::Exporter::Package_B_Importer_00_Good::exported_ok(17);
print 'after RPerl::Test::Exporter::Package_B_Importer_00_Good::exported_ok(17), received $exported_ok_retval = ', $exported_ok_retval, "\n";

