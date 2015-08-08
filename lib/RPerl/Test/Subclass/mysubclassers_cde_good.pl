#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'no errors' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

# [[[ INCLUDES ]]]
use RPerl::Test::Subclass::MySubclassersCDE_Good;

# [[[ OPERATIONS ]]]
my RPerl::Test::Subclass::MySubclassersCDE_Good_arrayref $foo_a = [];
my RPerl::Test::Subclass::MySubclassersCDE_Good_hashref $foo_h = {};
my RPerl::Test::Subclass::MySubclasserC_Good_arrayref $bar_a = [];
my RPerl::Test::Subclass::MySubclasserC_Good_hashref $bar_h = {};
my RPerl::Test::Subclass::MySubclasserD_Good_arrayref $bat_a = [];
my RPerl::Test::Subclass::MySubclasserD_Good_hashref $bat_h = {};
my RPerl::Test::Subclass::MySubclasserE_Good_arrayref $baz_a = [];
my RPerl::Test::Subclass::MySubclasserE_Good_hashref $baz_h = {};
print 'no errors' . "\n";
