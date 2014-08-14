#!/usr/bin/perl
use strict;
use warnings;
use Carp;

# START HERE: boil down to find why methods are binding but not functions
# START HERE: boil down to find why methods are binding but not functions
# START HERE: boil down to find why methods are binding but not functions

# RPERL DRIVER BOILERPLATE
BEGIN { package main;  our $RPERL_INCLUDE_PATH = 'blib/lib'; }  # NEED REMOVE hard-coded path
BEGIN { use RPerl; use parent ('RPerl'); $RPerl::INCLUDE_PATH = $main::RPERL_INCLUDE_PATH; }    # RPerl system files
BEGIN { use Data::Dumper;  our $AUTOLOAD;  sub AUTOLOAD { croak("AUTOLOAD purposefully disabled for debugging, have \$AUTOLOAD = '$AUTOLOAD' and \@_ = \n" . Dumper(\@_) . ', croaking'); } }  ## no critic qw(ProhibitAutoloading RequireArgUnpacking)  ## RPERL SYSTEM allow autoload  ## RPERL SYSTEM allow read-only @_

# UNCOMMENT TO ENABLE PERL TYPES FOR C++ OPS
rperltypes::types_enable('PERL');

# UNCOMMENT TO ENABLE C++ TYPES FOR C++ OPS
#rperltypes::types_enable('CPP');

# TOGGLE COMMENT TO ENABLE C++ OPS
#use RPerl::Algorithm::Sort::Bubble;  # choose ONE of this
use RPerl::Algorithm::Sort::Bubble_cpp;  RPerl::Algorithm::Sort::Bubble_cpp::cpp_load(); # OR this

print STDERR q{in inline_cpp_debug.pl, have integer__ops() = '} . integer__ops() . "'\n" or croak();
print STDERR q{in inline_cpp_debug.pl, have integer__types() = '} . integer__types() . "'\n" or croak();
print STDERR q{in inline_cpp_debug.pl, have number__ops() = '} . number__ops() . "'\n" or croak();
print STDERR q{in inline_cpp_debug.pl, have number__types() = '} . number__types() . "'\n" or croak();
print STDERR q{in inline_cpp_debug.pl, have string__ops() = '} . string__ops() . "'\n" or croak();
print STDERR q{in inline_cpp_debug.pl, have string__types() = '} . string__types() . "'\n" or croak();
print STDERR q{in inline_cpp_debug.pl, have array__ops() = '} . array__ops() . "'\n" or croak();
print STDERR q{in inline_cpp_debug.pl, have array__types() = '} . array__types() . "'\n" or croak();
print STDERR q{in inline_cpp_debug.pl, have hash__ops() = '} . hash__ops() . "'\n" or croak();
print STDERR q{in inline_cpp_debug.pl, have hash__types() = '} . hash__types() . "'\n" or croak();

my $sorter = RPerl::Algorithm::Sort::Bubble->new();
print STDERR "in inline_cpp_debug.pl have \$sorter->bubblesort__ops__oo() = '" . $sorter->bubblesort__ops__oo() . "'\n" or croak();  # OO INTERFACE

print STDERR q{in inline_cpp_debug.pl, have bubblesort__ops() = '} . bubblesort__ops() . "'\n" or croak();
#print STDERR q{in inline_cpp_debug.pl, have bubblesort__ops() = '} . RPerl::Algorithm::Sort::Bubble::bubblesort__ops() . "'\n" or croak();
#print STDERR q{in inline_cpp_debug.pl, have bubblesort__types() = '} . bubblesort__types() . "'\n" or croak();
