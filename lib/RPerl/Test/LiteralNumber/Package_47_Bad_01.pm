# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPAPC02' >>>
# <<< PARSE_ERROR: 'Perl::Critic::Policy::ValuesAndExpressions::ProhibitMagicNumbers' >>>

# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::LiteralNumber::Package_47_Bad_01;
use strict;
use warnings;
our $VERSION = 0.001_000;

our number $empty_sub = sub {
    return -2333_456_789.234_56;
};

1;    # end of package
