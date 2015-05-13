#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< RUN_SUCCESS: 'my integer $foo = 234_567_889;' >>>
# <<< RUN_SUCCESS: 'our number $bar = -4.245_677_8;' >>>
# <<< RUN_SUCCESS: "$qui::bat = my string $TYPED_qui__bat = 'hal';" >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names
## no critic qw(ProhibitPackageVars)  # SYSTEM SPECIAL 4d: allow $rperlnamespaces::*

# [[[ OPERATIONS ]]]

$Data::Dumper::Indent = 0;

my $foo = 234_567_889;
our $bar = -4.245_677_8;

package qui; $qui::bat = 'hal'; package main; print scope_type_name_value($foo) . "\n" . scope_type_name_value($bar) . "\n"; package qui; print main::scope_type_name_value($qui::bat) . "\n";