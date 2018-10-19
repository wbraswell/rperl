#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPAPL02' >>>
# <<< PARSE_ERROR: 'Global symbol "$bax" requires explicit package name' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

#my string $foo = 'howdy';
#print $foo, "\n";
#print scope_type_name_value($foo), "\n";
#print name($foo), "\n\n";

#$::bar = 'dowdy';
#print $::bar, "\n";
#print scope_type_name_value($::bar), "\n";
#print name($::bar), "\n\n";

$bax = 'dowdy';
print $bax, "\n";
print scope_type_name_value($bax), "\n";
print name($bax), "\n\n";

#our $baz = 'dowdy';
#print $baz, "\n";
#print scope_type_name_value($baz), "\n";
#print name($baz), "\n\n";


