package RPerl::Translator;
use strict;
use warnings;
our $VERSION = 0.000_010;
use Carp;
use RPerl;

# [[[ SETUP ]]]

use rperlrules;    # we also would've accepted "rperlrocks"
use Data::Dumper;

# [[[ PROCEDURAL SUBROUTINES ]]]

# Translate from PPI DocTree to RPerl AST
# SOURCE_CODE RULE
our string $ppi_to_rperl__translate = sub {
    ( my object $ppi_doctree ) = @_;

#    RPerl::diag "in ppi_to_rperl__translate(), received \$ppi_doctree =\n" . Dumper($ppi_doctree) . "\n" or croak();

    # NEED UPGRADE: skipping PROGRAM & PACKAGE rules

    # SOURCE_CODE rule, PACKAGE production
    return (
        RPerl::CompileUnit::Module::Package->ppi_to_rperl__translate( # class method call
            $ppi_doctree)
    );
};

1;
