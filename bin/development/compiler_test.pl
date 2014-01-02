#!/usr/bin/perl
use strict;
use warnings;
our $VERSION = 0.001_010;
use Carp;
use RPerl;

# [[[ SETUP ]]]
## no critic qw(ProhibitAutoloading RequireArgUnpacking)  ## RPERL SYSTEM allow autoload  ## RPERL SYSTEM allow read-only @_
# RPERL DRIVER BOILERPLATE
BEGIN { package main; our $RPERL_INCLUDE_PATH = 'lib'; } # NEED REMOVE hard-coded path

BEGIN {
    #    use RPerl;   # NEED FIX: moved into proper RPerl header above
    use parent ('RPerl');
    $RPerl::INCLUDE_PATH = $main::RPERL_INCLUDE_PATH;
}                                                        # RPerl system files

BEGIN {
    use Data::Dumper;
    our $AUTOLOAD;

    sub AUTOLOAD {
        croak(
            "AUTOLOAD purposefully disabled for debugging, have \$AUTOLOAD = '$AUTOLOAD' and \@_ = \n"
                . Dumper( \@_ )
                . ', croaking' );
    }
}

use RPerl::Parser;    # includes PPI, Perl::Critic
use RPerl::Translator;
use RPerl::Generator;
use RPerl::Compiler;    # includes Inline

# move output away from initial Inline compiler output
print {*STDERR} "\n\n" or croak();

# NEED REMOVE HARD-CODED SOURCE FILE NAME
my string $rperl_source__file_name = 'lib/RPerl_test_00.pm';

# [[[ PARSE PERL TO PPI ]]]
# [[[ PARSE PERL TO PPI ]]]
# [[[ PARSE PERL TO PPI ]]]

my object $ppi_doctree = perl_to_ppi__parse($rperl_source__file_name);

# [[[ TRANSLATE PPI TO RPERL ]]]
# [[[ TRANSLATE PPI TO RPERL ]]]
# [[[ TRANSLATE PPI TO RPERL ]]]

my object $rperl_ast = ppi_to_rperl__translate($ppi_doctree);

# [[[ GENERATE RPERL TO C++ ]]]
# [[[ GENERATE RPERL TO C++ ]]]
# [[[ GENERATE RPERL TO C++ ]]]

my $mode = {

    #    types => 'PERL',  # CHOOSE WHICH TYPES TO OUTPUT
    types => 'CPP',
};

my string $cpp_source = rperl_to_cpp__generate( $rperl_ast, $mode );

# [[[ COMPILE C++ TO XS & BINARY ]]]
# [[[ COMPILE C++ TO XS & BINARY ]]]
# [[[ COMPILE C++ TO XS & BINARY ]]]

my string $cpp_file_name = $RPerl::INCLUDE_PATH . '/RPerl_test_00.cpp';
cpp_to_xsbinary__compile( $cpp_source, $cpp_file_name );
