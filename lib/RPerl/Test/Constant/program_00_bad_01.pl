#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPAPC02' >>>
# <<< PARSE_ERROR: 'Perl::Critic::Policy::NamingConventions::Capitalization' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CONSTANTS ]]]
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants
use constant PI  => my number $TYPED_PI  = 3.141_59;
use constant  my string $TYPED_PIE = 'pecan';

# [[[ OPERATIONS ]]]
my integer $i = 2 + 2;

