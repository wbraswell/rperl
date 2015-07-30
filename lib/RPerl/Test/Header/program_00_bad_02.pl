#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECVPAPL02' >>>
# <<< PARSE_ERROR: "Can't locate arnings.pm in @INC" >>>

# [[[ HEADER ]]]
use strict;
use arnings;
use RPerl::AfterFilter;
our $VERSION = 0.001_000;

# [[[ OPERATIONS ]]]
my integer $i = 2 + 2;