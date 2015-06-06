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

# START HERE: flesh out all OperatorVoid::Named (exit/die/croak) & Operator::Named (cos/sin/push etc) tests in Fu.pm
# START HERE: flesh out all OperatorVoid::Named (exit/die/croak) & Operator::Named (cos/sin/push etc) tests in Fu.pm
# START HERE: flesh out all OperatorVoid::Named (exit/die/croak) & Operator::Named (cos/sin/push etc) tests in Fu.pm

our unknown $quux_return = sub {
    #    return;        # GOOD OperatorVoid_114; program_00* Class_00*
    #    return();      # GOOD OperatorVoid_115, parens as args; program_01_good.pl
    #    return ();     # BAD  OperatorVoid_116, parser, empty parens as subexpression; program_01_bad_00.pl
    #    return 0;      # GOOD OperatorVoid_116; program_02*
    #    return 1;      # GOOD OperatorVoid_116; program_03*
    #    return 23;     # GOOD OperatorVoid_116; program_04*
    #    return -1;     # GOOD OperatorVoid_116; program_05*
    #    return -234_567.890_12;    # GOOD OperatorVoid_116; program_06*
    #    return 'ahoy';             # GOOD OperatorVoid_116; program_07*
    #    return(2);                 # GOOD OperatorVoid_115, parens as args; program_08*
    #    return((2));               # GOOD OperatorVoid_115, outer parens as args, inner parens as subexpressions; program_09*
    #    return(((2)));             # GOOD OperatorVoid_115, outer parens as args, inner parens as subexpressions; program_10*
    #    return((((2))));           # GOOD OperatorVoid_115, outer parens as args, inner parens as subexpressions; program_11*
    #    return (2);                # GOOD OperatorVoid_116, parens as subexpression; program_12*
    #    return ((2));              # GOOD OperatorVoid_116, parens as subexpressions; program_13*
    #    return (((2)));            # GOOD OperatorVoid_116, parens as subexpressions; program_14*
    #    return ((((2))));          # GOOD OperatorVoid_116, parens as subexpressions; program_15*
    #    return [];                 # GOOD OperatorVoid_116; program_20*
    #    return [2];                # GOOD OperatorVoid_116; program_21*
    #    return [2, 3];             # GOOD OperatorVoid_116; program_22*
    #    return [2, 3, 5, 7];       # GOOD OperatorVoid_116; program_23*
    #    return(@{[2]});            # BAD  OperatorVoid_115, generator, parens as args; program_21_bad_01.pl
    #    return((@{[2]}));          # BAD  OperatorVoid_115, generator, outer parens as args, inner parens as subexpression; program_21_bad_02.pl
    #    return(((@{[2]})));        # BAD  OperatorVoid_115, generator, outer parens as args, inner parens as subexpressions; program_21_bad_03.pl
    #    return((((@{[2]}))));      # BAD  OperatorVoid_115, generator, outer parens as args, inner parens as subexpressions; program_21_bad_04.pl
    #    return @{[2]};             # BAD  OperatorVoid_116, generator; program_21_bad_05.pl
    #    return (@{[2]});           # BAD  OperatorVoid_116, generator, parens as subexpression; program_21_bad_06.pl
    #    return ((@{[2]}));         # BAD  OperatorVoid_116, generator, parens as subexpressions; program_21_bad_07.pl
    #    return (((@{[2]})));       # BAD  OperatorVoid_116, generator, parens as subexpressions; program_21_bad_08.pl
    #    return 2, 3;               # BAD  OperatorVoid_116, generator; program_22_bad_01.pl
    #    return 2, 3, 5, 7;         # BAD  OperatorVoid_116, generator; program_22_bad_02.pl
    #    return(2, 3);              # BAD  OperatorVoid_115, generator, parens as args; program_22_bad_03.pl
    #    return(2, 3, 5, 7);        # BAD  OperatorVoid_115, generator, parens as args; program_22_bad_04.pl
    #    return (2, 3);             # BAD  OperatorVoid_116, parser, parens as subexpression cannot be list with commas; program_22_bad_05.pl
    #    return (2, 3, 5, 7);       # BAD  OperatorVoid_116, parser, parens as subexpression cannot be list with commas; program_22_bad_06.pl
    #    return {};                                 # GOOD OperatorVoid_116; program_24*
    #    return {a => 2};                           # GOOD OperatorVoid_116; program_25*
    #    return {a => 2, b => 3};                   # GOOD OperatorVoid_116; program_26*
    #    return {a => 2, b => 3, c => 5, d => 7};   # GOOD OperatorVoid_116; program_27*
    #    return(%{{a => 2}});                       # BAD  OperatorVoid_115, generator, parens as args; program_25_bad_01.pl
    #    return((%{{a => 2}}));                     # BAD  OperatorVoid_115, generator, outer parens as args, inner parens as subexpression; program_25_bad_02.pl
    #    return(((%{{a => 2}})));                   # BAD  OperatorVoid_115, generator, outer parens as args, inner parens as subexpressions; program_25_bad_03.pl
    #    return((((%{{a => 2}}))));                 # BAD  OperatorVoid_115, generator, outer parens as args, inner parens as subexpressions; program_25_bad_04.pl 
    #    return %{{a => 2}};                        # BAD  OperatorVoid_116, generator; program_25_bad_05.pl
    #    return (%{{a => 2}});                      # BAD  OperatorVoid_116, generator, parens as subexpression; program_25_bad_06.pl
    #    return ((%{{a => 2}}));                    # BAD  OperatorVoid_116, generator, parens as subexpressions; program_25_bad_07.pl
    #    return (((%{{a => 2}})));                  # BAD  OperatorVoid_116, generator, parens as subexpressions; program_25_bad_08.pl
};

our unknown $quux_croak = sub {
    #    croak;        # GOOD OperatorVoid_114; program_00* Class_00*
    #    croak();      # GOOD OperatorVoid_115, parens as args; program_01_good.pl
    #    croak ();     # BAD  OperatorVoid_116, parser, empty parens as subexpression; program_01_bad_00.pl
    #    croak 0;      # GOOD OperatorVoid_116; program_02*
    #    croak 1;      # GOOD OperatorVoid_116; program_03*
    #    croak 23;     # GOOD OperatorVoid_116; program_04*
    #    croak -1;     # GOOD OperatorVoid_116; program_05*
    #    croak -234_567.890_12;    # GOOD OperatorVoid_116; program_06*
    #    croak 'ahoy';             # GOOD OperatorVoid_116; program_07*
    #    croak(2);                 # GOOD OperatorVoid_115, parens as args; program_08*
    #    croak((2));               # GOOD OperatorVoid_115, outer parens as args, inner parens as subexpressions; program_09*
    #    croak(((2)));             # GOOD OperatorVoid_115, outer parens as args, inner parens as subexpressions; program_10*
    #    croak((((2))));           # GOOD OperatorVoid_115, outer parens as args, inner parens as subexpressions; program_11*
    #    croak (2);                # GOOD OperatorVoid_116, parens as subexpression; program_12*
    #    croak ((2));              # GOOD OperatorVoid_116, parens as subexpressions; program_13*
    #    croak (((2)));            # GOOD OperatorVoid_116, parens as subexpressions; program_14*
    #    croak ((((2))));          # GOOD OperatorVoid_116, parens as subexpressions; program_15*
    #    croak [];                 # GOOD OperatorVoid_116; program_20*
    #    croak [2];                # GOOD OperatorVoid_116; program_21*
    #    croak [2, 3];             # GOOD OperatorVoid_116; program_22*
    #    croak [2, 3, 5, 7];       # GOOD OperatorVoid_116; program_23*
    #    croak(@{[2]});            # BAD  OperatorVoid_115, generator, parens as args; program_21_bad_01.pl
    #    croak((@{[2]}));          # BAD  OperatorVoid_115, generator, outer parens as args, inner parens as subexpression; program_21_bad_02.pl
    #    croak(((@{[2]})));        # BAD  OperatorVoid_115, generator, outer parens as args, inner parens as subexpressions; program_21_bad_03.pl
    #    croak((((@{[2]}))));      # BAD  OperatorVoid_115, generator, outer parens as args, inner parens as subexpressions; program_21_bad_04.pl
    #    croak @{[2]};             # BAD  OperatorVoid_116, generator; program_21_bad_05.pl
    #    croak (@{[2]});           # BAD  OperatorVoid_116, generator, parens as subexpression; program_21_bad_06.pl
    #    croak ((@{[2]}));         # BAD  OperatorVoid_116, generator, parens as subexpressions; program_21_bad_07.pl
    #    croak (((@{[2]})));       # BAD  OperatorVoid_116, generator, parens as subexpressions; program_21_bad_08.pl

# START HERE: switch below from BAD to GOOD
# START HERE: switch below from BAD to GOOD
# START HERE: switch below from BAD to GOOD

    #    croak 2, 3;               # BAD  OperatorVoid_116, generator; program_22_bad_01.pl
    #    croak 2, 3, 5, 7;         # BAD  OperatorVoid_116, generator; program_22_bad_02.pl
    #    croak(2, 3);              # BAD  OperatorVoid_115, generator, parens as args; program_22_bad_03.pl
    #    croak(2, 3, 5, 7);        # BAD  OperatorVoid_115, generator, parens as args; program_22_bad_04.pl
    #    croak (2, 3);             # BAD  OperatorVoid_116, parser, parens as subexpression cannot be list with commas; program_22_bad_05.pl
    #    croak (2, 3, 5, 7);       # BAD  OperatorVoid_116, parser, parens as subexpression cannot be list with commas; program_22_bad_06.pl


    #    croak {};                                 # GOOD OperatorVoid_116; program_24*
    #    croak {a => 2};                           # GOOD OperatorVoid_116; program_25*
    #    croak {a => 2, b => 3};                   # GOOD OperatorVoid_116; program_26*
    #    croak {a => 2, b => 3, c => 5, d => 7};   # GOOD OperatorVoid_116; program_27*
    #    croak(%{{a => 2}});                       # BAD  OperatorVoid_115, generator, parens as args; program_25_bad_01.pl
    #    croak((%{{a => 2}}));                     # BAD  OperatorVoid_115, generator, outer parens as args, inner parens as subexpression; program_25_bad_02.pl
    #    croak(((%{{a => 2}})));                   # BAD  OperatorVoid_115, generator, outer parens as args, inner parens as subexpressions; program_25_bad_03.pl
    #    croak((((%{{a => 2}}))));                 # BAD  OperatorVoid_115, generator, outer parens as args, inner parens as subexpressions; program_25_bad_04.pl 
    #    croak %{{a => 2}};                        # BAD  OperatorVoid_116, generator; program_25_bad_05.pl
    #    croak (%{{a => 2}});                      # BAD  OperatorVoid_116, generator, parens as subexpression; program_25_bad_06.pl
    #    croak ((%{{a => 2}}));                    # BAD  OperatorVoid_116, generator, parens as subexpressions; program_25_bad_07.pl
    #    croak (((%{{a => 2}})));                  # BAD  OperatorVoid_116, generator, parens as subexpressions; program_25_bad_08.pl
};

1;    # end of class
