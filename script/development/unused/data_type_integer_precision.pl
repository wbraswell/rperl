#!/usr/bin/env perl

use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

my unsigned_integer $uifoo = 5;
my unsigned_integer $uibar = ~($uifoo);
print '$uifoo   = ' . $uifoo . "\n";
print '$uibar   = ' . $uibar . "\n";

use integer;

my integer $ifoo = 5;
my integer $ibar = ~($ifoo);
print '$ifoo   = ' . $ifoo . "\n";
print '$ibar   = ' . $ibar . "\n";

