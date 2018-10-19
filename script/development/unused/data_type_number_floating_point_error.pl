#!/usr/bin/env perl
use RPerl;
use strict;
use warnings;

my number $foo = 0.105 / 1_000;
my number $faa = 0.105 / 1_000;
my number $bar = 0.000_105;
my number $bat = 0.000_105;
print '$foo = ' . $foo . "\n";
print '$bar = ' . $bar . "\n";
     if (0.000_105 == 0.000_105)             { print 'true' . "\n"; } else { print 'false' . "\n"; }  #   EXPECTED BEHAVIOR: true
     if ((0.105 / 1_000) == (0.105 / 1_000)) { print 'true' . "\n"; } else { print 'false' . "\n"; }  #   EXPECTED BEHAVIOR: true
     if ($bar == $bat)                       { print 'true' . "\n"; } else { print 'false' . "\n"; }  #   EXPECTED BEHAVIOR: true
     if ($foo == $faa)                       { print 'true' . "\n"; } else { print 'false' . "\n"; }  #   EXPECTED BEHAVIOR: true
     if ($foo == $bar)                       { print 'true' . "\n"; } else { print 'false' . "\n"; }  # UNEXPECTED BEHAVIOR: false
if (abs ($foo -  $bar) < RPerl::EPSILON())   { print 'true' . "\n"; } else { print 'false' . "\n"; }  #   EXPECTED BEHAVIOR: true
