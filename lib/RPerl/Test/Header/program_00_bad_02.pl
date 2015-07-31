#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECVPAPL02' >>>
# <<< PARSE_ERROR: "Can't locate arnings.pm in @INC" >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use arnings;
use RPerl::AfterSubclass;
our $VERSION = 0.001_000;

# [[[ OPERATIONS ]]]
my integer $i = 2 + 2;