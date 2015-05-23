# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECVPAPC02' >>>
# <<< PARSE_ERROR: 'Perl::Critic::Policy::Modules::RequireExplicitPackage' >>>
# <<< PARSE_ERROR: 'Perl::Critic::Policy::TestingAndDebugging::RequireUseStrict' >>>
# <<< PARSE_ERROR: 'Perl::Critic::Policy::TestingAndDebugging::RequireUseWarnings' >>>

# [[[ HEADER ]]]
packaged RPerl::Test::Header::Package_00_Bad_00;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub { return 2; };

1;                  # end of package
