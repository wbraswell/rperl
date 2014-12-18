# [[[ HEADER ]]]
package RPerl::Test::Operator01Named::Package_00_Good;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub {

    # NEED FIX: add all builtins
    #    my number $op_sin = sin 2;
    #    my number $op_cos = cos 2;
    return 2;
};

1;    # end of package
