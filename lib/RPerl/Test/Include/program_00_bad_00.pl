#!/usr/bin/perl
# [[[ TEST : 'ERROR ECVPARP00' ]]]
# [[[ TEST : 'unexpected token:  RPerl::Test::Foo' ]]]
# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ INCLUDES ]]]
ue RPerl::Test::Foo;
use RPerl::Test::Bar;

# [[[ OPERATIONS ]]]
my integer $i = 2 + 2;