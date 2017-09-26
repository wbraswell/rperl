# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPAPC02' >>>
# <<< PARSE_ERROR: 'Perl::Critic::Policy::ValuesAndExpressions::ProhibitConstantPragma' >>>

# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::Constant::Package_00_Bad_05;
use strict;
use warnings;
use constant PI  => my number $TYPED_PI  = 3.141_59;
our $VERSION = 0.001_000;

# [[[ CONSTANTS ]]]
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants
use constant PIE => my string $TYPED_PIE = 'pecan';

# [[[ SUBROUTINES ]]]
sub empty_sub { { my void $RETURN_TYPE };
    return 2;
}

1;                  # end of package
