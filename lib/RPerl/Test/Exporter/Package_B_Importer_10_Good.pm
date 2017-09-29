# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::Exporter::Package_B_Importer_10_Good;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class RPerl::Exporter);
use           RPerl::CompileUnit::Module::Class;

# [[[ EXPORTS ]]]
use RPerl::Exporter;
our @EXPORT_OK = qw(exported_ok);

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use RPerl::Test::Exporter::Package_B_Exporter_00_Good qw(exported_ok);

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

sub not_exported {
    { my integer $RETURN_TYPE };
    ( my integer $arg ) = @ARG;
    print 'in Package_B_Importer_10_Good::not_exported(), received $arg = ', $arg, "\n";
    return ($arg * -21);
}

sub not_exported_ok {
    { my integer $RETURN_TYPE };
    ( my integer $arg ) = @ARG;
    print 'in Package_B_Importer_10_Good::not_exported_ok(), received $arg = ', $arg, "\n";
    return ($arg * -24);
}

1;    # end of class