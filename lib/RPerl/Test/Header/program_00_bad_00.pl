#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPAPL02' >>>
# <<< PARSE_ERROR: '"use" not allowed in expression' >>>
# <<< PARSE_ERROR: 'syntax error' >>>
# <<< PARSE_ERROR: 'near "foo' >>>

# [[[ HEADER ]]]
foo
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OPERATIONS ]]]
my integer $i = 2 + 2;
