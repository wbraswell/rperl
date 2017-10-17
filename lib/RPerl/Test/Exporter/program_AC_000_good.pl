#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'in Package_AC_Exporter_00_Good::exported_ok(), received $arg = 17' >>>
# <<< EXECUTE_SUCCESS: 'after exported_ok(17), received $exported_ok_retval = 714' >>>
# <<< EXECUTE_SUCCESS: 'in Package_AC_Exporter_00_Good::exported(), received $arg = 17' >>>
# <<< EXECUTE_SUCCESS: 'after exported(17), received $exported_retval = 391' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use RPerl::Test::Exporter::Package_AC_Exporter_00_Good qw(exported_ok);

# [[[ SUBROUTINES ]]]

sub not_exported {
    { my integer $RETURN_TYPE };
    ( my integer $arg ) = @ARG;
    print 'in main::not_exported(), received $arg = ', $arg, "\n";
    return ($arg * 43);
}

# [[[ OPERATIONS ]]]

my integer $exported_ok_retval = exported_ok(17);
print 'after exported_ok(17), received $exported_ok_retval = ', $exported_ok_retval, "\n";

my integer $exported_retval = exported(17);
print 'after exported(17), received $exported_retval = ', $exported_retval, "\n";

