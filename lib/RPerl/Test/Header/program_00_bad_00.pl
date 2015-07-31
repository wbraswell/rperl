#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECVPAPL02' >>>
# <<< PARSE_ERROR: 'Unquoted string "foo" may clash with future reserved word' >>>

# [[[ HEADER ]]]
foo
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OPERATIONS ]]]
my integer $i = 2 + 2;