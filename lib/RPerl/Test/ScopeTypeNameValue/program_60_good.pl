#!/usr/bin/perl

# START HERE: set EXECUTE_SUCCESS in this file and also create *bad*.pl then set PARSE_ERRORS for 3 commented-out blocks below
# START HERE: set EXECUTE_SUCCESS in this file and also create *bad*.pl then set PARSE_ERRORS for 3 commented-out blocks below
# START HERE: set EXECUTE_SUCCESS in this file and also create *bad*.pl then set PARSE_ERRORS for 3 commented-out blocks below

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my string $foo = 'howdy';
print $foo, "\n";
print scope_type_name_value($foo), "\n";
print name($foo), "\n\n";

# dies at rperl critic ProhibitPackageVars

#$::bar = 'dowdy';
#print $::bar, "\n";
#print scope_type_name_value($::bar), "\n";
#print name($::bar), "\n\n";

# dies from strict/warnings

#$bax = 'dowdy';
#print $bax, "\n";
#print scope_type_name_value($bax), "\n";
#print name($bax), "\n\n";

#our $baz = 'dowdy';
#print $baz, "\n";
#print scope_type_name_value($baz), "\n";
#print name($baz), "\n\n";


