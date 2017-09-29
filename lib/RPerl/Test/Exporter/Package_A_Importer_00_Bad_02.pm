# [[[ PREPROCESSOR ]]]
# <<< PARSE ERROR: 'ERROR ESUXP02' >>>
# <<< PARSE_ERROR: 'Failed to export requested subroutine not_exported()' >>>
# <<< PARSE_ERROR: 'subroutine not found in exporting package's @EXPORT or @EXPORT_OK' >>>

# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::Exporter::Package_A_Importer_00_Bad_02;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);
use RPerl::CompileUnit::Module::Class;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use RPerl::Test::Exporter::Package_A_Exporter_00_Good qw(not_exported);

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

sub not_exported {
    { my integer $RETURN_TYPE };
    ( my integer $arg ) = @ARG;
    print 'in Package_A_Importer_00_Bad_02::not_exported(), received $arg = ', $arg, "\n";
    return ($arg * -12);
}

sub exported_ok {
    { my integer $RETURN_TYPE };
    ( my integer $arg ) = @ARG;
    print 'in Package_A_Importer_00_Bad_02::exported_ok(), received $arg = ', $arg, "\n";
    return ($arg * -42);
}

1;    # end of class