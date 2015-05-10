# [[[ HEADER ]]]
package RPerl::Test::Fu;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Test);
use RPerl::Test;
#use RPerl::Test qw(mode_tagline);
#use RPerl::Test qw(mode_tagline mode_description);
#use RPerl::Test qw(mode_tagline mode_description mode_enable);

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants

# [[[ INCLUDES ]]]
#use RPerl::Test::Foo qw(quux corge);
#use RPerl::Test::Bar;

# [[[ CONSTANTS ]]]
use constant PI  => my number $TYPED_PI  = 3.141_59;
use constant PIE => my string $TYPED_PIE = 'pecan';

# [[[ OO PROPERTIES ]]]
our hashref $properties = {
    plugh => my integer $TYPED_plugh           = 23,
#    xyzzy => my string $TYPED_xyzzy            = 'twenty-three',
#    thud  => my integer_arrayref $TYPED_thud = [ ],
#    thud  => my integer_arrayref $TYPED_thud = [ 2 ]#,
#    thud  => my integer_arrayref $TYPED_thud = [ 2, 4, 6, 8 ],
#    thud  => my integer_arrayref $TYPED_thud = [ qw(hi howdy hello) ],
#    yyz => my number_hashref $TYPED_yyz = { }
#    yyz => my number_hashref $TYPED_yyz = { a => 3.1 }
#    yyz => my number_hashref $TYPED_yyz = { a => 3.1, b => 6.2, c => 9.3 },
#    pals => my string_hashref $TYPED_pals = { a => 'howdy', b => 'buffalo', c => 'clarabell' }
    pals => my string_hashref $TYPED_pals = { a21 => 'howdy', 21 => 'buffalo', 21.3 => 'clarabell', '21.3' => 'bozo' }
};

1;    # end of class
