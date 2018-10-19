#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: "'a' => 'twenty-threetwenty-threetwenty-threetwenty-threetwenty-threetwenty-threetwenty-three'" >>>
# <<< EXECUTE_SUCCESS: "'b' => 'howdy'" >>>
# <<< EXECUTE_SUCCESS: "'c' => '-23.42'" >>>
# <<< EXECUTE_SUCCESS: "'a' => 'guffawguffawguffawguffawguffawguffawguffawguffawguffawguffawguffaw'" >>>
# <<< EXECUTE_SUCCESS: "'b' => 'howdy'" >>>
# <<< EXECUTE_SUCCESS: "'c' => '-23.42'" >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use RPerl::Test::Foo;

# [[[ OPERATIONS ]]]
my RPerl::Test::Foo $my_foo = RPerl::Test::Foo->new();
print Dumper($my_foo->qorge(7)) . "\n";
$my_foo->{xyzzy} = 'guffaw';
print Dumper($my_foo->qorge(11)) . "\n";
