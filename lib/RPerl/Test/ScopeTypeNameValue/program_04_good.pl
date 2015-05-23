#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: "$VAR1 = {'object_arrayref' => [{'object' => {'__CLASS' => 'RPerl::Test::SimpleA','purd' => 'integer'}}]};" >>>
# <<< EXECUTE_SUCCESS: "$VAR1 = {'object_arrayref' => [{'object' => {'__CLASS' => 'RPerl::Test::SimpleA','purd' => 'integer'}},{'object' => {'__CLASS' => 'RPerl::Test::SimpleA','purd' => 'integer'}}]};" >>>
# <<< EXECUTE_SUCCESS: "$VAR1 = {'arrayref' => [{'object' => {'__CLASS' => 'RPerl::Test::SimpleA','purd' => 'integer'}},{'object' => {'__CLASS' => 'RPerl::Test::SimpleB','drup' => 'integer'}}]};" >>>
# <<< EXECUTE_SUCCESS: "$VAR1 = {'object_arrayref' => [{'object' => {'__CLASS' => 'RPerl::Test::SimpleA','purd' => 'integer'}},{'object' => {'__CLASS' => 'RPerl::Test::SimpleA','purd' => 'integer'}},{'object' => {'__CLASS' => 'RPerl::Test::SimpleA','purd' => 'integer'}},{'object' => {'__CLASS' => 'RPerl::Test::SimpleA','purd' => 'integer'}},{'object' => {'__CLASS' => 'RPerl::Test::SimpleA','purd' => 'integer'}}]};" >>>
# <<< EXECUTE_SUCCESS: "$VAR1 = {'arrayref' => [{'object' => {'__CLASS' => 'RPerl::Test::SimpleA','purd' => 'integer'}},{'object' => {'__CLASS' => 'RPerl::Test::SimpleA','purd' => 'integer'}},{'object' => {'__CLASS' => 'RPerl::Test::SimpleA','purd' => 'integer'}},{'object' => {'__CLASS' => 'RPerl::Test::SimpleB','drup' => 'integer'}},{'object' => {'__CLASS' => 'RPerl::Test::SimpleA','purd' => 'integer'}}]};" >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use RPerl::Test::SimpleA;
use RPerl::Test::SimpleB;

# [[[ OPERATIONS ]]]

$Data::Dumper::Indent = 0;
my arrayref $u = [ RPerl::Test::SimpleA->new() ];
print Dumper( types($u) ) . "\n";

$u = [ RPerl::Test::SimpleA->new(), RPerl::Test::SimpleA->new() ];
print Dumper( types($u) ) . "\n";
$u = [ RPerl::Test::SimpleA->new(), RPerl::Test::SimpleB->new() ];
print Dumper( types($u) ) . "\n";

$u = [
    RPerl::Test::SimpleA->new(), RPerl::Test::SimpleA->new(),
    RPerl::Test::SimpleA->new(), RPerl::Test::SimpleA->new(),
    RPerl::Test::SimpleA->new()
];
print Dumper( types($u) ) . "\n";

$u = [
    RPerl::Test::SimpleA->new(), RPerl::Test::SimpleA->new(),
    RPerl::Test::SimpleA->new(), RPerl::Test::SimpleB->new(),
    RPerl::Test::SimpleA->new()
];
print Dumper( types($u) ) . "\n";
