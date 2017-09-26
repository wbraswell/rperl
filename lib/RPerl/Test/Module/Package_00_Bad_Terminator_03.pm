# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPAPC02' >>>
# <<< PARSE_ERROR: 'Perl::Critic::Policy::Modules::RequireEndWithOne' >>>

# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::Module::Package_00_Bad_Terminator_03;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
sub empty_sub { { my void $RETURN_TYPE };
    return 2;
}

1                  # end of package
