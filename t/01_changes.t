#!/usr/bin/perl

# [[[ HEADER ]]]
use strict;
use warnings;
our $VERSION = 0.002_000;

# [[[ INCLUDES ]]]
use Test::More;

# [[[ OPERATIONS ]]]
eval 'use Test::CPAN::Changes';
plan skip_all => 'Test::CPAN::Changes required for this test' if $@;
changes_ok();