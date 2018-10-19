use RPerl::Test::Foo;
#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPAPC02' >>>
# <<< PARSE_ERROR: 'Perl::Critic::Policy::Modules::RequireEndWithOne' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ INCLUDES ]]]
use RPerl::Test::Bar;

# [[[ OPERATIONS ]]]
my integer $i = 2 + 2;
