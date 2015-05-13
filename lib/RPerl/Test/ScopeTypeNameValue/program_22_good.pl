#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< RUN_SUCCESS: 'my integer $foo = 234_567_889;' >>>
# <<< RUN_SUCCESS: 'our number $bar = -4.245_677_8;' >>>
# <<< RUN_SUCCESS: "$main::bat = my string $TYPED_main__bat = 'howdy!';" >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitPackageVars)  # SYSTEM SPECIAL 4d: allow $rperlnamespaces::*

# [[[ OPERATIONS ]]]

$Data::Dumper::Indent = 0;

my $foo = 234_567_889;
our $bar = -4.245_677_8;

$main::bat = 'hal'; $main::bat = my string $TYPED_bat = 'happy'; $main::bat = 'howdy!'; print scope_type_name_value($foo) . "\n" . scope_type_name_value($bar) . "\n" . scope_type_name_value($main::bat) . "\n";