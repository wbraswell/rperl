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
    #    thud => my integer_arrayref $TYPED_thud = []    #,

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

our integer $fong = sub {
    ( my integer $fong_in ) = @_;
    return $fong_in;
};

#our unknown_method $quux = sub {

    #    ( my object $self) = @_;
    #    ( my object $self, my integer $howdy, my string_hashref $doody) = @_;

    #    $self->{plugh} = $self->{plugh} * 2;

    #    foreach my scalartype $foooo (@{[0, 2, 5, 7]}) { print 'howdy'; }

    #    return;    # GOOD; program_00* Class_00*
    #    return();  # GOOD, parens as args; program_01_good.pl
    #    return ();  # BAD, empty parens as subexpression; program_01_bad_00.pl
    #    return 0;  # GOOD; program_02*
    #    return 1;  # GOOD; program_03*
    #    return 23;  # GOOD; program_04*
    #    return -1;  # GOOD; program_05*
    #    return -234_567.890_12;  # GOOD; program_06*
    #    return 'ahoy';  # GOOD; program_07*
    #    return(2);  # GOOD, parens as args; program_08*
    #    return (2);  # GOOD, parens as subexpression; program_09*
    #    return [];  # GOOD; program_10*
    #    return [2];  # GOOD; program_11*
    #    return [2, 3];  # GOOD; program_12*
    #    return [2, 3, 5, 7];  # GOOD; program_13*
    #    return @{[2]};  # BAD, generator; program_11_bad_01.pl
    #    return (@{[2]});  # BAD, generator, parens as subexpression; program_11_bad_02.pl
    #    return ((@{[2]}));  # BAD, generator, parens as subexpressions; program_11_bad_03.pl
    #    return (((@{[2]})));  # BAD, generator, parens as subexpressions; program_11_bad_04.pl
    #    return(@{[2]});  # BAD, generator, parens as args; program_11_bad_05.pl
    #    return((@{[2]}));  # BAD, generator, outer parens as args, inner parens as subexpression; program_11_bad_06.pl
    #    return(((@{[2]})));  # BAD, generator, outer parens as args, inner parens as subexpressions; program_11_bad_07.pl
    #    return((((@{[2]}))));  # BAD, generator, outer parens as args, inner parens as subexpressions; program_11_bad_08.pl
    #    return 2, 3;  # BAD, generator; program_12_bad_01.pl
    #    return 2, 3, 5, 7;  # BAD, generator; program_12_bad_02.pl
    #    return (2, 3);  # BAD, parser, parens as subexpression cannot be list with commas; program_12_bad_03.pl
    #    return (2, 3, 5, 7);  # BAD, parser, parens as subexpression cannot be list with commas; program_12_bad_04.pl
    #    return {};  # GOOD; program_14*
    #    return {a => 2};  # GOOD; program_15*
    #    return {a => 2, b => 3};  # GOOD; program_16*
    #    return {a => 2, b => 3, c => 5, d => 7};  # GOOD; program_17*
    #    return %{{a => 2}};  # BAD, generator; program_15_bad_01.pl
    #    return (%{{a => 2}});  # BAD, generator, parens as subexpression; program_15_bad_02.pl
    #    return ((%{{a => 2}}));  # BAD, generator, parens as subexpressions; program_15_bad_03.pl
    #    return (((%{{a => 2}})));  # BAD, generator, parens as subexpressions; program_15_bad_04.pl
    #    return(%{{a => 2}});  # BAD, generator, parens as args; program_15_bad_05.pl
    #    return((%{{a => 2}}));  # BAD, generator, outer parens as args, inner parens as subexpression; program_15_bad_06.pl
    #    return(((%{{a => 2}})));  # BAD, generator, outer parens as args, inner parens as subexpressions; program_15_bad_07.pl
    #    return((((%{{a => 2}}))));  # BAD, generator, outer parens as args, inner parens as subexpressions; program_15_bad_08.pl
    
# START HERE: flesh out all OperatorVoid::Named (exit/die/croak) & Operator::Named (cos/sin/push etc) tests in Fu.pm
# START HERE: flesh out all OperatorVoid::Named (exit/die/croak) & Operator::Named (cos/sin/push etc) tests in Fu.pm
# START HERE: flesh out all OperatorVoid::Named (exit/die/croak) & Operator::Named (cos/sin/push etc) tests in Fu.pm

#};

1;    # end of class
