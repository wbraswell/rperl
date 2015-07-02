# [[[ HEADER SPECIAL ]]]
package RPerl;
use strict;
use warnings;

# DEV NOTE, CORRELATION #16: RPerl's underscore-is-comma (not CPAN's underscore-is-beta) numbering scheme utilized here
our $VERSION = 1.000_000;    # ONE POINT OH BETA THREE!!!
#our $VERSION = 20150702;    # NON-RELEASE VERSION, OFFICIAL LONGDATE
#our $VERSION = 2015.183;    # NON-RELEASE VERSION, OFFICIAL STARDATE

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
