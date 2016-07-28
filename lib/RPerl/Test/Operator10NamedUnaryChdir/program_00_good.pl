#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'have $foo = ' >>>
# <<< EXECUTE_SUCCESS: 'have $bar = 0' >>>
# <<< EXECUTE_SUCCESS: 'have $bat = 1' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

# DEV NOTE: in Windows (and possibly other operating systems) it is common not to have the $ENV{HOME} or $ENV{LOGDIR}
# environmental variables set, which causes chdir to die when called w/out any options;
# thus, allow $foo to be either 0 in Windows or 1 elsewhere, by simply removing the hard-coded value for $foo in EXECUTE_SUCCESS above
my integer $foo = chdir;
my integer $bar = chdir 'INVALID__DIRECTORY__NAME';
my integer $bat = chdir q{/};

print 'have $foo = ', $foo, "\n";
print 'have $bar = ', $bar, "\n";
print 'have $bat = ', $bat, "\n";
