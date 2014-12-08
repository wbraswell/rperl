#!/usr/bin/perl
# <<< COMPILE_ERROR: 'ERROR ECVPAPL02' >>>
# <<< COMPILE_ERROR: 'Unquoted string "foo" may clash with future reserved word' >>>
# [[[ HEADER ]]]
foo
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ OPERATIONS ]]]
my integer $i = 2 + 2;