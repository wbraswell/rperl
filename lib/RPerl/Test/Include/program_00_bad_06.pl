#!/usr/bin/perl
# [[[ TEST : 'ERROR ECVPARP00' ]]]
# [[[ TEST : 'Unexpected token:  use' ]]]
# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl::Test::Foo;
use RPerl;
our $VERSION = 0.001_000;

# [[[ INCLUDES ]]]
use RPerl::Test::Bar;

# [[[ OPERATIONS ]]]
my integer $i = 2 + 2;