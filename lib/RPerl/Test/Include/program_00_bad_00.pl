#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< COMPILE_ERROR: 'ERROR ECVPARP00' >>>
# <<< COMPILE_ERROR: 'Unexpected Token:  RPerl::Test::Foo' >>>

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