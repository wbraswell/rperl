# [[[ HEADER ]]]
package RPerl::Test::Fu;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Test);
#use RPerl::Test;
#use RPerl::Test qw(mode_tagline);
#use RPerl::Test qw(mode_tagline mode_description);
use RPerl::Test qw(mode_tagline mode_description mode_enable);

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hash_ref $properties = {
#    plugh => my integer $TYPED_plugh           = 23,
#    xyzzy => my string $TYPED_xyzzy            = 'twenty-three',
    thud  => my integer__array_ref $TYPED_thud = [ 2, 4, 6, 8 ]#,
#    yyz => my number__hash_ref $TYPED_yyz = { a => 3.1, b => 6.2, c => 9.3 }
};

1;    # end of class
