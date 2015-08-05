#!/usr/bin/perl
use strict;
use warnings;
our $VERSION = 0.001_000;

use Test::More;
eval 'use Test::CPAN::Changes';
plan skip_all => 'Test::CPAN::Changes required for this test' if $@;
changes_ok();