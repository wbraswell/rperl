#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: "$VAR1 = {'object_hashref' => {'a' => {'object' => {'__CLASS' => 'RPerl::Test::SimpleA','purd' => 'integer'}}}};" >>>
# <<< EXECUTE_SUCCESS: "$VAR1 = {'object_hashref' => {'a' => {'object' => {'__CLASS' => 'RPerl::Test::SimpleA','purd' => 'integer'}},'b' => {'object' => {'__CLASS' => 'RPerl::Test::SimpleA','purd' => 'integer'}}}};" >>>
# <<< EXECUTE_SUCCESS: "$VAR1 = {'hashref' => {'a' => {'object' => {'__CLASS' => 'RPerl::Test::SimpleA','purd' => 'integer'}},'b' => {'object' => {'__CLASS' => 'RPerl::Test::SimpleB','drup' => 'integer'}}}};" >>>
# <<< EXECUTE_SUCCESS: "$VAR1 = {'object_hashref' => {'a' => {'object' => {'__CLASS' => 'RPerl::Test::SimpleA','purd' => 'integer'}},'b' => {'object' => {'__CLASS' => 'RPerl::Test::SimpleA','purd' => 'integer'}},'c' => {'object' => {'__CLASS' => 'RPerl::Test::SimpleA','purd' => 'integer'}},'d' => {'object' => {'__CLASS' => 'RPerl::Test::SimpleA','purd' => 'integer'}},'e' => {'object' => {'__CLASS' => 'RPerl::Test::SimpleA','purd' => 'integer'}}}};" >>>
# <<< EXECUTE_SUCCESS: "$VAR1 = {'hashref' => {'a' => {'object' => {'__CLASS' => 'RPerl::Test::SimpleA','purd' => 'integer'}},'b' => {'object' => {'__CLASS' => 'RPerl::Test::SimpleA','purd' => 'integer'}},'c' => {'object' => {'__CLASS' => 'RPerl::Test::SimpleA','purd' => 'integer'}},'d' => {'object' => {'__CLASS' => 'RPerl::Test::SimpleB','drup' => 'integer'}},'e' => {'object' => {'__CLASS' => 'RPerl::Test::SimpleA','purd' => 'integer'}}}};" >>>

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
my hashref $u = { a => RPerl::Test::SimpleA->new() };
print Dumper( types($u) ) . "\n";

$u = { a => RPerl::Test::SimpleA->new(), b => RPerl::Test::SimpleA->new() };
print Dumper( types($u) ) . "\n";

$u = { a => RPerl::Test::SimpleA->new(), b => RPerl::Test::SimpleB->new() };
print Dumper( types($u) ) . "\n";

$u = {
    a => RPerl::Test::SimpleA->new(),
    b => RPerl::Test::SimpleA->new(),
    c => RPerl::Test::SimpleA->new(),
    d => RPerl::Test::SimpleA->new(),
    e => RPerl::Test::SimpleA->new()
};
print Dumper( types($u) ) . "\n";

$u = {
    a => RPerl::Test::SimpleA->new(),
    b => RPerl::Test::SimpleA->new(),
    c => RPerl::Test::SimpleA->new(),
    d => RPerl::Test::SimpleB->new(),
    e => RPerl::Test::SimpleA->new()
};
print Dumper( types($u) ) . "\n";
