#!/usr/bin/perl

use lib '/home/wbraswell/austin_perl_mongers/compiler/RPerl/RPerl-latest/lib';  # RPerl system files
use lib '/home/wbraswell/austin_perl_mongers/compiler/RPerl/RPerl-latest/lib/CPAN';  # RPerl's MyConfig.pm
use MyConfig;

# test if @INC now gives us access to the Inline libraries
#use Parse::RecDescent;
#use Inline;
#use Inline::C;
#use Inline::CPP;

use RPerl::Algorithm::Sort::Bubble_cpp;
