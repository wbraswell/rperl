#!/usr/bin/perl
use strict;
use warnings;
our $VERSION = 0.000_001;
use Carp;

# [[[ SETUP ]]]

# RPERL DRIVER BOILERPLATE
#BEGIN { package main;  our $RPERL_INCLUDE_PATH = 'lib'; }  # NEED REMOVE hard-coded path
#BEGIN { use RPerl; use parent ('RPerl'); $RPerl::INCLUDE_PATH = $main::RPERL_INCLUDE_PATH; }    # RPerl system files
#BEGIN { use Data::Dumper;  our $AUTOLOAD;  sub AUTOLOAD { croak("AUTOLOAD purposefully disabled for debugging, have \$AUTOLOAD = '$AUTOLOAD' and \@_ = \n" . Dumper(\@_) . ', croaking'); } }  ## no critic qw(ProhibitAutoloading RequireArgUnpacking)  ## RPERL SYSTEM allow autoload  ## RPERL SYSTEM allow read-only @_

use RPerl;
#use parent ('RPerl');


# sort number data, return sorted data
our integer $integer__square = sub {
    ( my integer $integer__data) = @_;
#    ::integer__CHECK($integer__data);
    ::integer__CHECKTRACE( $integer__data, '$integer__data', 'integer__square()' );
    my integer $integer__squared = $integer__data * $integer__data;

    print STDERR "in PERLOPS_PERLTYPES integer__square(), received \$integer__data = $integer__data\n" or croak();
    print STDERR "in PERLOPS_PERLTYPES integer__square(), have \$integer__squared = $integer__squared\n" or croak();

    return $integer__squared;
};