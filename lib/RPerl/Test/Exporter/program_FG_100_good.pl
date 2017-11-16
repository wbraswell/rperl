#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'no errors' >>>
# <<< EXECUTE_SUCCESS: 'have RPerl::Test::Exporter::Package_FG_Exporter_Importer_00_Good::multiply_return_FG(11, 22) = 242' >>>
# <<< EXECUTE_SUCCESS: 'have EXPORTED RPerl::Test::Exporter::Package_F_Exporter_Importer_00_Good::multiply_return_FG(11, 22) = 242' >>>
# <<< EXECUTE_SUCCESS: 'have RPerl::Test::Exporter::Package_F_Exporter_Importer_00_Good::multiply_return_F(-11, 22) = -242' >>>
# <<< EXECUTE_SUCCESS: 'have EXPORTED RPerl::Test::Exporter::Package_G_Importer_00_Good::multiply_return_FG(11, 22) = 242' >>>
# <<< EXECUTE_SUCCESS: 'have EXPORTED RPerl::Test::Exporter::Package_G_Importer_00_Good::multiply_return_F(-11, 22) = -242' >>>
# <<< EXECUTE_SUCCESS: 'have RPerl::Test::Exporter::Package_G_Importer_00_Good::multiply_return_G(-11, 33) = -363' >>>
# <<< EXECUTE_SUCCESS: 'still no errors' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use RPerl::Test::Exporter::Package_FG_Exporter_Importer_00_Good;

# [[[ OPERATIONS ]]]

print 'no errors', "\n";

# subroutine tests

print 'have RPerl::Test::Exporter::Package_FG_Exporter_Importer_00_Good::multiply_return_FG(11, 22) = ', RPerl::Test::Exporter::Package_FG_Exporter_Importer_00_Good::multiply_return_FG(11, 22), "\n";

print 'have EXPORTED RPerl::Test::Exporter::Package_F_Exporter_Importer_00_Good::multiply_return_FG(11, 22) = ', RPerl::Test::Exporter::Package_F_Exporter_Importer_00_Good::multiply_return_FG(11, 22), "\n";  # ERROR HERE, MOVE TO EXPORTER EXAMPLE

print 'have RPerl::Test::Exporter::Package_F_Exporter_Importer_00_Good::multiply_return_F(-11, 22) = ', RPerl::Test::Exporter::Package_F_Exporter_Importer_00_Good::multiply_return_F(-11, 22), "\n";

print 'have EXPORTED RPerl::Test::Exporter::Package_G_Importer_00_Good::multiply_return_FG(11, 22) = ', RPerl::Test::Exporter::Package_G_Importer_00_Good::multiply_return_FG(11, 22), "\n";  # ERROR HERE, MOVE TO EXPORTER EXAMPLE

print 'have EXPORTED RPerl::Test::Exporter::Package_G_Importer_00_Good::multiply_return_F(-11, 22) = ', RPerl::Test::Exporter::Package_G_Importer_00_Good::multiply_return_F(-11, 22), "\n";  # ERROR HERE, MOVE TO EXPORTER EXAMPLE

print 'have RPerl::Test::Exporter::Package_G_Importer_00_Good::multiply_return_G(-11, 33) = ', RPerl::Test::Exporter::Package_G_Importer_00_Good::multiply_return_G(-11, 33), "\n";

print 'still no errors', "\n";
