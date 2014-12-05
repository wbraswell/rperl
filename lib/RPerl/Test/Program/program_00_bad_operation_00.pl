#!/usr/bin/perl
# [[[ TEST : 'ERROR ECVPAPL02' ]]]
# [[[ TEST : 'Global symbol "$i" requires explicit package name' ]]]
# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ OPERATIONS ]]]
integer $i = 2 + 2;