#!/usr/bin/perl
use lib '/home/wbraswell/austin_perl_mongers/compiler/RPerl/RPerl-latest/lib';  # RPerl system files  # NEED REMOVE hard-coded path
use strict;  use warnings;  use RPerl;  our @ISA = ('RPerl');

# NEED THESE TWO FOLLOWING LINES FOR Inline
use lib '/home/wbraswell/austin_perl_mongers/compiler/RPerl/RPerl-latest/lib/CPAN';  # RPerl's MyConfig.pm  # NEED REMOVE hard-coded path
use MyConfig;

#package RPerl::Algorithm::Sort;  # begin namespace hack, want to use ...Sort::Bubble->new(), not ...Sort::Bubble_cpp::Bubble->new()
#package main;  # same as no package declaration, needed for Airplane to occupy base Perl namespace

use Inline
(
        CPP => '/home/wbraswell/austin_perl_mongers/compiler/RPerl/RPerl-latest/lib/RPerl/Algorithm/Sort/PlaneTMP.cpp',
        CCFLAGS => '-Wno-deprecated',  # old-style-header warnings, suppress
        BUILD_NOISY => 1,
        CLEAN_AFTER_BUILD => 0,
        WARNINGS => 1,
);

#my $cessna = new PlaneTMP;
my $cessna = PlaneTMP->new();
$cessna->foo();
if ($cessna->isa("ObjectTMP")) { print "\$cessna $cessna is an ObjectTMP!\n"; }
if ($cessna->can("fly")) { $cessna->fly(); }
	else { print "This \$cessna sucks!\n"; }

my $whatzit = ObjectTMP->new();
$whatzit->foo(); 
if ($whatzit->isa("ObjectTMP")) { print "\$whatzit $whatzit is an ObjectTMP!\n"; }
	else { print "\$whatzit $whatzit is NOT an ObjectTMP!\n"; }
if ($whatzit->can("fly")) { $whatzit->fly(); }
	else { print "This \$whatzit sucks!\n"; }
