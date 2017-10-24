# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPARP00' >>>
# <<< PARSE_ERROR: 'Unexpected Token:  our' >>>

# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::Exporter::Class_C_Exporter_20_Bad_00;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);
use RPerl::CompileUnit::Module::Class;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitAutomaticExportation)  # SYSTEM SPECIAL 14: allow global exports from Config.pm & elsewhere
## no critic qw(ProhibitPackageVars)  # SYSTEM SPECIAL 15: allow package variables for exports tests

# [[[ EXPORTS ]]]
use RPerl::Exporter qw(import);
our @EXPORT = qw(+exported $exported_scalar @exported_array %exported_hash *exported_typeglob);

our integer $exported_scalar = -2_112;
our @exported_array = (-10, -20, -30, -40);
our %exported_hash = (a => -15, b => -25, c => -35);
*exported_typeglob = sub { return 'I am an anonymous subroutine inside an exported typeglob.'; };
&{*exported_typeglob};  # AVOID ERROR: Name "RPerl::Test::Exporter::Class_C_Exporter_20_Bad_00::exported_typeglob" used only once: possible typo

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

sub exported {
    { my integer $RETURN_TYPE };
    ( my integer $arg ) = @ARG;
    print 'in Class_C_Exporter_20_Bad_00::exported(), received $arg = ', $arg, "\n";
    return ($arg * 120);
}

sub not_exported {
    { my integer $RETURN_TYPE };
    ( my integer $arg ) = @ARG;
    print 'in Class_C_Exporter_20_Bad_00::not_exported(), received $arg = ', $arg, "\n";
    return ($arg * 420);
}

1;    # end of class

