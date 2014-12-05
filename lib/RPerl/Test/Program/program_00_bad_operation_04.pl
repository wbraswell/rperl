#!/usr/bin/perl
# [[[ TEST : 'ERROR ECVPAPL02' ]]]
# [[[ TEST : 'Bareword "i" not allowed while "strict subs" in use' ]]]
# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ OPERATIONS ]]]
my integer $i = i + 2;