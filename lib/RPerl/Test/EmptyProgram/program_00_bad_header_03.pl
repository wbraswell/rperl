#!/usr/bin/perl
# [[[ TEST : 'ERROR ECVPAPL02' ]]]
# [[[ TEST : '"use" not allowed in expression' ]]]
# [[[ HEADER ]]]
use strict;
use warnings
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic)

# [[[ OPERATIONS ]]]
my integer $i = 2 + 2;