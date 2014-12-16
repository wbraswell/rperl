#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< COMPILE_ERROR: 'ERROR ECVPAPL02' >>>
# <<< COMPILE_ERROR: "Can't locate arnings.pm in @INC" >>>

# [[[ HEADER ]]]
use strict;
use arnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ OPERATIONS ]]]
my integer $i = 2 + 2;