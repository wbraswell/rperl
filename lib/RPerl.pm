# [[[ HEADER SPECIAL ]]]
package RPerl;
use strict;
use warnings;

our $VERSION = 1.000_003;    # ONE POINT OH BETA THREE!!!
#our $VERSION = 20150612;    # NON-RELEASE VERSION
#our $VERSION = 2015.163;    # NON-RELEASE VERSION, OFFICIAL STARDATE

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitExplicitStdin)  # USER DEFAULT 4: allow <STDIN> prompt
## no critic qw(ProhibitStringyEval)  # SYSTEM DEFAULT 1: allow eval()
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES SPECIAL ]]]
require RPerl::Config;

#no magic;  # require data types, full declarations, other non-magic
# DEV NOTE, CORRELATION #08: circular dependency causes "subroutine FOO redefined" errors, solved by replacing use with require below
#use rperltypes;
require rperltypes;
#require rperloperations;
#require rperlrules;
require rperlnames;
#require rperlnamespaces;

# NEED ADD: use/require HelperFunctions*.pm here (not just in rperltypes.pm) to match dependency path of C++ code?

1;    # end of class
