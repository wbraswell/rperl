#!/usr/bin/perl
use strict;
use warnings;
our $VERSION = 0.001_000;

package Foo;
1;

for my Foo $i ( 0 .. 2 ) { 1; }
for my Foo $i ( 0 .. 2 ) { 1; }
