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
    #    croak 2, 3;               # GOOD OperatorVoid_116, generator; program_24*
    #    croak 2, 3, 5, 7;         # GOOD OperatorVoid_116, generator; program_25*
    #    croak (2, 3);             # BAD  OperatorVoid_116, parser, parens as subexpression cannot be list with commas; program_24_bad_05.pl
    #    croak (2, 3, 5, 7);       # BAD  OperatorVoid_116, parser, parens as subexpression cannot be list with commas; program_24_bad_06.pl
    #    croak(2, 3);              # GOOD OperatorVoid_115, generator, parens as args; program_26*
    #    croak(2, 3, 5, 7);        # GOOD OperatorVoid_115, generator, parens as args; program_27*
    #    croak {};                                 # GOOD OperatorVoid_116; program_30*
    #    croak {a => 2};                           # GOOD OperatorVoid_116; program_31*
    #    croak {a => 2, b => 3};                   # GOOD OperatorVoid_116; program_32*
    #    croak {a => 2, b => 3, c => 5, d => 7};   # GOOD OperatorVoid_116; program_33*
    #    croak(%{{a => 2}});                       # BAD  OperatorVoid_115, generator, parens as args; program_31_bad_01.pl
    #    croak((%{{a => 2}}));                     # BAD  OperatorVoid_115, generator, outer parens as args, inner parens as subexpression; program_31_bad_02.pl
    #    croak(((%{{a => 2}})));                   # BAD  OperatorVoid_115, generator, outer parens as args, inner parens as subexpressions; program_31_bad_03.pl
    #    croak((((%{{a => 2}}))));                 # BAD  OperatorVoid_115, generator, outer parens as args, inner parens as subexpressions; program_31_bad_04.pl 
    #    croak %{{a => 2}};                        # BAD  OperatorVoid_116, generator; program_31_bad_05.pl
    #    croak (%{{a => 2}});                      # BAD  OperatorVoid_116, generator, parens as subexpression; program_31_bad_06.pl
    #    croak ((%{{a => 2}}));                    # BAD  OperatorVoid_116, generator, parens as subexpressions; program_31_bad_07.pl
    #    croak (((%{{a => 2}})));                  # BAD  OperatorVoid_116, generator, parens as subexpressions; program_31_bad_08.pl
};

our unknown $quux_die = sub {
    #    die;        # GOOD OperatorVoid_114; program_00* Class_00*
 
    # MAKE BAD
    #    die();      # GOOD OperatorVoid_115, parens as args; program_01_good.pl
 
    #    die ();     # BAD  OperatorVoid_116, parser, empty parens as subexpression; program_01_bad_00.pl
    #    die 0;      # GOOD OperatorVoid_116; program_02*
    #    die 1;      # GOOD OperatorVoid_116; program_03*
    #    die 23;     # GOOD OperatorVoid_116; program_04*
    #    die -1;     # GOOD OperatorVoid_116; program_05*
    #    die -234_567.890_12;    # GOOD OperatorVoid_116; program_06*
    #    die 'ahoy';             # GOOD OperatorVoid_116; program_07*
 
    # MAKE BAD
    #    die(2);                 # GOOD OperatorVoid_115, parens as args; program_08*
    #    die((2));               # GOOD OperatorVoid_115, outer parens as args, inner parens as subexpressions; program_09*
    #    die(((2)));             # GOOD OperatorVoid_115, outer parens as args, inner parens as subexpressions; program_10*
    #    die((((2))));           # GOOD OperatorVoid_115, outer parens as args, inner parens as subexpressions; program_11*
 
    #    die (2);                # GOOD OperatorVoid_116, parens as subexpression; program_12*
    #    die ((2));              # GOOD OperatorVoid_116, parens as subexpressions; program_13*
    #    die (((2)));            # GOOD OperatorVoid_116, parens as subexpressions; program_14*
    #    die ((((2))));          # GOOD OperatorVoid_116, parens as subexpressions; program_15*
    #    die [];                 # GOOD OperatorVoid_116; program_20*
    #    die [2];                # GOOD OperatorVoid_116; program_21*
    #    die [2, 3];             # GOOD OperatorVoid_116; program_22*
    #    die [2, 3, 5, 7];       # GOOD OperatorVoid_116; program_23*
 
    # MAKE BAD
    #    die(@{[2]});            # BAD  OperatorVoid_115, generator, parens as args; program_21_bad_01.pl
    #    die((@{[2]}));          # BAD  OperatorVoid_115, generator, outer parens as args, inner parens as subexpression; program_21_bad_02.pl
    #    die(((@{[2]})));        # BAD  OperatorVoid_115, generator, outer parens as args, inner parens as subexpressions; program_21_bad_03.pl
    #    die((((@{[2]}))));      # BAD  OperatorVoid_115, generator, outer parens as args, inner parens as subexpressions; program_21_bad_04.pl
 
    #    die @{[2]};             # BAD  OperatorVoid_116, generator; program_21_bad_05.pl
    #    die (@{[2]});           # BAD  OperatorVoid_116, generator, parens as subexpression; program_21_bad_06.pl
    #    die ((@{[2]}));         # BAD  OperatorVoid_116, generator, parens as subexpressions; program_21_bad_07.pl
    #    die (((@{[2]})));       # BAD  OperatorVoid_116, generator, parens as subexpressions; program_21_bad_08.pl
    #    die 2, 3;               # GOOD OperatorVoid_116, generator; program_24*
    #    die 2, 3, 5, 7;         # GOOD OperatorVoid_116, generator; program_25*
    #    die (2, 3);             # BAD  OperatorVoid_116, parser, parens as subexpression cannot be list with commas; program_24_bad_05.pl
    #    die (2, 3, 5, 7);       # BAD  OperatorVoid_116, parser, parens as subexpression cannot be list with commas; program_24_bad_06.pl
 
    # MAKE BAD
    #    die(2, 3);              # GOOD OperatorVoid_115, generator, parens as args; program_26*
    #    die(2, 3, 5, 7);        # GOOD OperatorVoid_115, generator, parens as args; program_27*
 
    #    die {};                                 # GOOD OperatorVoid_116; program_30*
    #    die {a => 2};                           # GOOD OperatorVoid_116; program_31*
    #    die {a => 2, b => 3};                   # GOOD OperatorVoid_116; program_32*
    #    die {a => 2, b => 3, c => 5, d => 7};   # GOOD OperatorVoid_116; program_33*
 
    # MAKE BAD
    #    die(%{{a => 2}});                       # BAD  OperatorVoid_115, generator, parens as args; program_31_bad_01.pl
    #    die((%{{a => 2}}));                     # BAD  OperatorVoid_115, generator, outer parens as args, inner parens as subexpression; program_31_bad_02.pl
    #    die(((%{{a => 2}})));                   # BAD  OperatorVoid_115, generator, outer parens as args, inner parens as subexpressions; program_31_bad_03.pl
    #    die((((%{{a => 2}}))));                 # BAD  OperatorVoid_115, generator, outer parens as args, inner parens as subexpressions; program_31_bad_04.pl 
 
    #    die %{{a => 2}};                        # BAD  OperatorVoid_116, generator; program_31_bad_05.pl
    #    die (%{{a => 2}});                      # BAD  OperatorVoid_116, generator, parens as subexpression; program_31_bad_06.pl
    #    die ((%{{a => 2}}));                    # BAD  OperatorVoid_116, generator, parens as subexpressions; program_31_bad_07.pl
    #    die (((%{{a => 2}})));                  # BAD  OperatorVoid_116, generator, parens as subexpressions; program_31_bad_08.pl
};

our unknown $quux_exit = sub {
    #    exit;        # GOOD OperatorVoid_114; program_00* Class_00*
 
    # MAKE BAD
    #    exit();      # GOOD OperatorVoid_115, parens as args; program_01_good.pl
 
    #    exit ();     # BAD  OperatorVoid_116, parser, empty parens as subexpression; program_01_bad_00.pl
    #    exit 0;      # GOOD OperatorVoid_116; program_02*
    #    exit 1;      # GOOD OperatorVoid_116; program_03*
    #    exit 23;     # GOOD OperatorVoid_116; program_04*
    #    exit -1;     # GOOD OperatorVoid_116; program_05*
    #    exit -234_567.890_12;    # GOOD OperatorVoid_116; program_06*
    #    exit 'ahoy';             # GOOD OperatorVoid_116; program_07*
 
    # MAKE BAD
    #    exit(2);                 # GOOD OperatorVoid_115, parens as args; program_08*
    #    exit((2));               # GOOD OperatorVoid_115, outer parens as args, inner parens as subexpressions; program_09*
    #    exit(((2)));             # GOOD OperatorVoid_115, outer parens as args, inner parens as subexpressions; program_10*
    #    exit((((2))));           # GOOD OperatorVoid_115, outer parens as args, inner parens as subexpressions; program_11*

    #    exit (2);                # GOOD OperatorVoid_116, parens as subexpression; program_12*
    #    exit ((2));              # GOOD OperatorVoid_116, parens as subexpressions; program_13*
    #    exit (((2)));            # GOOD OperatorVoid_116, parens as subexpressions; program_14*
    #    exit ((((2))));          # GOOD OperatorVoid_116, parens as subexpressions; program_15*
    #    exit [];                 # GOOD OperatorVoid_116; program_20*
    #    exit [2];                # GOOD OperatorVoid_116; program_21*
    #    exit [2, 3];             # GOOD OperatorVoid_116; program_22*
    #    exit [2, 3, 5, 7];       # GOOD OperatorVoid_116; program_23*
 
    # MAKE BAD
    #    exit(@{[2]});            # BAD  OperatorVoid_115, generator, parens as args; program_21_bad_01.pl
    #    exit((@{[2]}));          # BAD  OperatorVoid_115, generator, outer parens as args, inner parens as subexpression; program_21_bad_02.pl
    #    exit(((@{[2]})));        # BAD  OperatorVoid_115, generator, outer parens as args, inner parens as subexpressions; program_21_bad_03.pl
    #    exit((((@{[2]}))));      # BAD  OperatorVoid_115, generator, outer parens as args, inner parens as subexpressions; program_21_bad_04.pl
 
    #    exit @{[2]};             # BAD  OperatorVoid_116, generator; program_21_bad_05.pl
    #    exit (@{[2]});           # BAD  OperatorVoid_116, generator, parens as subexpression; program_21_bad_06.pl
    #    exit ((@{[2]}));         # BAD  OperatorVoid_116, generator, parens as subexpressions; program_21_bad_07.pl
    #    exit (((@{[2]})));       # BAD  OperatorVoid_116, generator, parens as subexpressions; program_21_bad_08.pl
 
    # MAKE BAD
    #    exit 2, 3;               # GOOD OperatorVoid_116, generator; program_24*
    #    exit 2, 3, 5, 7;         # GOOD OperatorVoid_116, generator; program_25*
 
    #    exit (2, 3);             # BAD  OperatorVoid_116, parser, parens as subexpression cannot be list with commas; program_24_bad_05.pl
    #    exit (2, 3, 5, 7);       # BAD  OperatorVoid_116, parser, parens as subexpression cannot be list with commas; program_24_bad_06.pl
 
    # MAKE BAD
    #    exit(2, 3);              # GOOD OperatorVoid_115, generator, parens as args; program_26*
    #    exit(2, 3, 5, 7);        # GOOD OperatorVoid_115, generator, parens as args; program_27*
 
    #    exit {};                                 # GOOD OperatorVoid_116; program_30*
    #    exit {a => 2};                           # GOOD OperatorVoid_116; program_31*
    #    exit {a => 2, b => 3};                   # GOOD OperatorVoid_116; program_32*
    #    exit {a => 2, b => 3, c => 5, d => 7};   # GOOD OperatorVoid_116; program_33*
 
    # MAKE BAD
    #    exit(%{{a => 2}});                       # BAD  OperatorVoid_115, generator, parens as args; program_31_bad_01.pl
    #    exit((%{{a => 2}}));                     # BAD  OperatorVoid_115, generator, outer parens as args, inner parens as subexpression; program_31_bad_02.pl
    #    exit(((%{{a => 2}})));                   # BAD  OperatorVoid_115, generator, outer parens as args, inner parens as subexpressions; program_31_bad_03.pl
    #    exit((((%{{a => 2}}))));                 # BAD  OperatorVoid_115, generator, outer parens as args, inner parens as subexpressions; program_31_bad_04.pl 
 
    #    exit %{{a => 2}};                        # BAD  OperatorVoid_116, generator; program_31_bad_05.pl
    #    exit (%{{a => 2}});                      # BAD  OperatorVoid_116, generator, parens as subexpression; program_31_bad_06.pl
    #    exit ((%{{a => 2}}));                    # BAD  OperatorVoid_116, generator, parens as subexpressions; program_31_bad_07.pl
    #    exit (((%{{a => 2}})));                  # BAD  OperatorVoid_116, generator, parens as subexpressions; program_31_bad_08.pl
};

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
    #    return {};                                 # GOOD OperatorVoid_116; program_30*
    #    return {a => 2};                           # GOOD OperatorVoid_116; program_31*
    #    return {a => 2, b => 3};                   # GOOD OperatorVoid_116; program_32*
    #    return {a => 2, b => 3, c => 5, d => 7};   # GOOD OperatorVoid_116; program_33*
    #    return(%{{a => 2}});                       # BAD  OperatorVoid_115, generator, parens as args; program_31_bad_01.pl
    #    return((%{{a => 2}}));                     # BAD  OperatorVoid_115, generator, outer parens as args, inner parens as subexpression; program_31_bad_02.pl
    #    return(((%{{a => 2}})));                   # BAD  OperatorVoid_115, generator, outer parens as args, inner parens as subexpressions; program_31_bad_03.pl
    #    return((((%{{a => 2}}))));                 # BAD  OperatorVoid_115, generator, outer parens as args, inner parens as subexpressions; program_31_bad_04.pl 
    #    return %{{a => 2}};                        # BAD  OperatorVoid_116, generator; program_31_bad_05.pl
    #    return (%{{a => 2}});                      # BAD  OperatorVoid_116, generator, parens as subexpression; program_31_bad_06.pl
    #    return ((%{{a => 2}}));                    # BAD  OperatorVoid_116, generator, parens as subexpressions; program_31_bad_07.pl
    #    return (((%{{a => 2}})));                  # BAD  OperatorVoid_116, generator, parens as subexpressions; program_31_bad_08.pl
};

1;    # end of class
