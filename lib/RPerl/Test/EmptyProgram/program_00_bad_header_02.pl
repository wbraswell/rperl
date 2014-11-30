#!/usr/bin/perl
# [[[ TEST : 'ERROR ECVPAPL02' ]]]
# [[[ TEST : "Can't locate arnings.pm in @INC" ]]]
# [[[ HEADER ]]]
use strict;
use arnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic)

# [[[ OPERATIONS ]]]
my integer $i = 2 + 2;