## no critic qw(ProhibitUselessNoCritic PodSpelling ProhibitExcessMainComplexity)  # DEVELOPER DEFAULT 1a: allow unreachable & POD-commented code; SYSTEM SPECIAL 4: allow complex code outside subroutines, must be on line 1
#!/usr/bin/perl  

# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECVPAPC02' >>>
# <<< PARSE_ERROR: 'Perl::Critic::Policy::Modules::RequireExplicitPackage' >>>
# <<< PARSE_ERROR: 'Perl::Critic::Policy::Modules::RequireEndWithOne' >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic)

# [[[ OPERATIONS ]]]
my integer $i = 2 + 2;