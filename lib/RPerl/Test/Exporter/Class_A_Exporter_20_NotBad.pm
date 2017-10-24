# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::Exporter::Class_A_Exporter_20_NotBad;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);
use RPerl::CompileUnit::Module::Class;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitPackageVars)  # SYSTEM SPECIAL 15: allow package variables for exports tests

# [[[ EXPORTS ]]]
use RPerl::Exporter qw(import);
our @EXPORT_OK = qw(&exported_ok $exported_ok_scalar @exported_ok_array %exported_ok_hash *exported_ok_typeglob);

our integer $not_exported_scalar = 23;
our integer $exported_ok_scalar = 2_112;
our @exported_ok_array = (10, 20, 30, 40);
our %exported_ok_hash = (a => 15, b => 25, c => 35);
*exported_ok_typeglob = sub { return 'I am an anonymous subroutine inside an exported ok typeglob.'; };
&{*exported_ok_typeglob};  # AVOID ERROR: Name "RPerl::Test::Exporter::Class_A_Exporter_20_NotBad::exported_ok_typeglob" used only once: possible typo

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

sub not_exported {
    { my integer $RETURN_TYPE };
    ( my integer $arg ) = @ARG;
    print 'in Class_A_Exporter_20_NotBad::not_exported(), received $arg = ', $arg, "\n";
    return ($arg * 12);
}

sub exported_ok {
    { my integer $RETURN_TYPE };
    ( my integer $arg ) = @ARG;
    print 'in Class_A_Exporter_20_NotBad::exported_ok(), received $arg = ', $arg, "\n";
    return ($arg * 42);
}

1;    # end of class

