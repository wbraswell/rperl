#!/usr/bin/perl  ## no critic qw(ProhibitUselessNoCritic PodSpelling ProhibitExcessMainComplexity   # DEVELOPER DEFAULT 1a: allow unreachable & POD-commented code; SYSTEM SPECIAL 5: allow complex code outside subroutines, must be on line 1
# [[[ TEST : 'ERROR ECVPARP00' ]]]
# [[[ TEST : 'Unexpected token:  use strict;' ]]]
# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic)

# [[[ OPERATIONS ]]]
my integer $i = 2 + 2;