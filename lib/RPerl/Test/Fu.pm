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
#use RPerl::Test::Foo qw(quux qorge);
#use RPerl::Test::Bar;

# [[[ CONSTANTS ]]]
#use constant PI  => my number $TYPED_PI  = 3.141_59;
#use constant PIE => my string $TYPED_PIE = 'pecan';

# [[[ OO PROPERTIES ]]]
our hashref $properties = {

    #    plugh => my integer $TYPED_plugh           = 23,
    #    xyzzy => my string $TYPED_xyzzy            = 'twenty-three',
    thud => my integer_arrayref $TYPED_thud = []    #,

#    thud  => my integer_arrayref $TYPED_thud = [ 2 ]#,
#    thud  => my integer_arrayref $TYPED_thud = [ 2, 4, 6, 8 ],
#    thud  => my integer_arrayref $TYPED_thud = [ qw(hi howdy hello) ],
#    yyz => my number_hashref $TYPED_yyz = { }
#    yyz => my number_hashref $TYPED_yyz = { a => 3.1 }
#    yyz => my number_hashref $TYPED_yyz = { a => 3.1, b => 6.2, c => 9.3 },
#    pals => my string_hashref $TYPED_pals = { a => 'howdy', b => 'buffalo', c => 'clarabell' }
#    pals => my string_hashref $TYPED_pals = { a21 => 'howdy', 21 => 'buffalo', 21.3 => 'clarabell', '21.3' => 'bozo' }
};

# [[[ OO METHODS & SUBROUTINES ]]]

our void_method $quux = sub {

    #    ( my object $self) = @_;
    ( my object $self, my integer $howdy, my string_hashref $doody) = @_;

    #    $self->{plugh} = $self->{plugh} * 2;

    # START HERE: continue with code generation for BAD? returns below
    # START HERE: continue with code generation for BAD? returns below
    # START HERE: continue with code generation for BAD? returns below

    foreach my scalartype $foooo (@{[0, 2, 5, 7]}) { print 'howdy'; }

    #    return;    # GOOD
    #    return();  # GOOD, parens as args list
    #    return ();  # BAD, empty parens as subexpression
    #    return 2;  # GOOD
    #    return(2);  # GOOD, parens as args list
    #    return (2);  # GOOD, parens as subexpression
    #    return -234_567.890_12;  # GOOD
    #    return 'howdy';  # GOOD
    #    return [];  # GOOD
    #    return [2];  # GOOD
    #    return [2, 3];  # GOOD
    #    return [2, 3, 5, 7];  # GOOD
        return @{[2]};  # BAD? generator, SubExpression_134
    #    return {};  # GOOD
    #    return {a => 2};  # GOOD
    #    return {a => 2, b => 3};  # GOOD
    #    return {a => 2, b => 3, c => 5};  # GOOD
    #    return 3, 4;  # BAD, generator
    #    return (3, 4);  # BAD, parser
    #    return 3, 4, 5, 6, 7;  # BAD, generator
    #    return (3, 4, 5, 6, 7);  # BAD, parser
};

1;    # end of class
