#!/usr/bin/perl
# [[[ TEST : 'ERROR ECVPARP00' ]]]
# [[[ TEST : "have invalid or unexpected token 'use warnings;'" ]]]
# [[[ HEADER ]]]
use warnings;
use strict;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic)

# [[[ OPERATIONS ]]]
my integer $i = 2 + 2;