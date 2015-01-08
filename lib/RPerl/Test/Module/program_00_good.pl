#!/usr/bin/perl
# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitPackageVars)  # USER DEFAULT 3: allow OO properties

# [[[ INCLUDES ]]]
# <<< CHANGE_ME: delete for no includes, or replace with real include package name(s) >>>
use RPerl::Test::Module::Class_00_Good;

# [[[ OPERATIONS ]]]

# START HERE 1A: add grammar support for parsing 'RPerl::Test::Module::Class_00_Good->new()'
# START HERE 1A: add grammar support for parsing 'RPerl::Test::Module::Class_00_Good->new()'
# START HERE 1A: add grammar support for parsing 'RPerl::Test::Module::Class_00_Good->new()'

my object $foo = RPerl::Test::Module::Class_00_Good->new();
my object $bar = RPerl::Test::Module::Class_00_Good->new();

print 'have $foo->{empty_property} = ', $foo->{empty_property}, "\n";
print 'have $bar->{empty_property} = ', $bar->{empty_property}, "\n";
print
    'have $RPerl::Test::Module::Class_00_Good::class_properties->{empty_class_property} = ',
    $RPerl::Test::Module::Class_00_Good::class_properties
    ->{empty_class_property}, "\n";
print '...', "\n";

$foo->{empty_property} = 23;
$RPerl::Test::Module::Class_00_Good::class_properties->{empty_class_property}
    = 'ahoy';

print 'have $foo->{empty_property} = ', $foo->{empty_property}, "\n";
print 'have $bar->{empty_property} = ', $bar->{empty_property}, "\n";
print
    'have $RPerl::Test::Module::Class_00_Good::class_properties->{empty_class_property} = ',
    $RPerl::Test::Module::Class_00_Good::class_properties
    ->{empty_class_property}, "\n";
