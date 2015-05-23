#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECVPAPL02' >>>
# <<< PARSE_ERROR: 'Can't locate RPerll/Test/Bar.pm' >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ INCLUDES ]]]
use RPerl::Test::Foo;
use RPerll::Test::Bar;

# [[[ OPERATIONS ]]]
my integer $i = 2 + 2;