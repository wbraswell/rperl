#!/usr/bin/env perl

# [[[ HEADER ]]]
use strict;
use warnings;
our $VERSION = 0.003_000;

# [[[ INCLUDES ]]]
use Test::More;

# [[[ OPERATIONS ]]]

BEGIN {
    if ( $ENV{RPERL_VERBOSE} ) {
        Test::More::diag("[[[ Beginning Change Log Tests ]]]");
    }
}

eval 'use Test::CPAN::Changes';
plan skip_all => 'Test::CPAN::Changes required for this test' if $@;
changes_ok();