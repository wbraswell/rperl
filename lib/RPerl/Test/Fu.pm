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

# START HERE: flesh out all Operator::Named (cos/sin/push etc) tests below (or in another file) and then implement
# START HERE: flesh out all Operator::Named (cos/sin/push etc) tests below (or in another file) and then implement
# START HERE: flesh out all Operator::Named (cos/sin/push etc) tests below (or in another file) and then implement

our unknown $quux_croak = sub {
    #    croak;        # GOOD OperatorVoid_114; program_00*
    #    croak();      # GOOD OperatorVoid_115, parens as args; program_01_good.pl
    #    croak ();     # BAD  OperatorVoid_116, parser, empty parens as subexpression; program_01_bad_01.pl
    #    croak 0;      # GOOD OperatorVoid_116; program_02*
    #    croak 1;      # GOOD OperatorVoid_116; program_03*
    #    croak 23;     # GOOD OperatorVoid_116; program_04*
    #    croak -1;     # GOOD OperatorVoid_116; program_05*
    #    croak -234_567.890_12;    # GOOD OperatorVoid_116; program_06*
    #    croak 'ahoy';             # GOOD OperatorVoid_116; program_07*
    #    croak(2);                 # GOOD OperatorVoid_115, parens as args; program_10*
    #    croak((2));               # GOOD OperatorVoid_115, outer parens as args, inner parens as subexpressions; program_11*
    #    croak(((2)));             # GOOD OperatorVoid_115, outer parens as args, inner parens as subexpressions; program_12*
    #    croak((((2))));           # GOOD OperatorVoid_115, outer parens as args, inner parens as subexpressions; program_13*
    #    croak (2);                # GOOD OperatorVoid_116, parens as subexpression; program_14*
    #    croak ((2));              # GOOD OperatorVoid_116, parens as subexpressions; program_15*
    #    croak (((2)));            # GOOD OperatorVoid_116, parens as subexpressions; program_16*
    #    croak ((((2))));          # GOOD OperatorVoid_116, parens as subexpressions; program_17*
    #    croak [];                 # GOOD OperatorVoid_116; program_20*
    #    croak [2];                # GOOD OperatorVoid_116; program_21*
    #    croak [2, 3];             # GOOD OperatorVoid_116; program_22*
    #    croak [2, 3, 5, 7];       # GOOD OperatorVoid_116; program_23*
    #    croak(@{[2]});            # GOOD OperatorVoid_115, parens as args; program_24_good.pl
    #    croak((@{[2]}));          # GOOD OperatorVoid_115, outer parens as args, inner parens as subexpression; program_25_good.pl
    #    croak @{[2]};             # GOOD OperatorVoid_116; program_26_good.pl
    #    croak (@{[2]});           # GOOD OperatorVoid_116, parens as subexpression; program_27_good.pl
    #    croak(@{[2, 3, 5, 7]});   # GOOD OperatorVoid_115, parens as args; program_28_good.pl
    #    croak((@{[2, 3, 5, 7]})); # GOOD OperatorVoid_115, outer parens as args, inner parens as subexpression; program_29_good.pl
    #    croak @{[2, 3, 5, 7]};    # GOOD OperatorVoid_116; program_30_good.pl
    #    croak (@{[2, 3, 5, 7]});  # GOOD OperatorVoid_116, parens as subexpression; program_31_good.pl
    #    croak 2, 3;               # GOOD OperatorVoid_116; program_32*
    #    croak 2, 3, 5, 7;         # GOOD OperatorVoid_116; program_33*
    #    croak(2, 3);              # GOOD OperatorVoid_115, parens as args; program_34*
    #    croak(2, 3, 5, 7);        # GOOD OperatorVoid_115, parens as args; program_35*
    #    croak (2, 3);             # BAD  OperatorVoid_116, parser, parens as subexpression cannot be list with commas; program_36_bad_00.pl
    #    croak (2, 3, 5, 7);       # BAD  OperatorVoid_116, parser, parens as subexpression cannot be list with commas; program_37_bad_00.pl
    #    croak {};                                 # GOOD OperatorVoid_116; program_40*
    #    croak {a => 2};                           # GOOD OperatorVoid_116; program_41*
    #    croak {a => 2, b => 3};                   # GOOD OperatorVoid_116; program_42*
    #    croak {a => 2, b => 3, c => 5, d => 7};   # GOOD OperatorVoid_116; program_43*
    #    croak(%{{a => 2}});                       # GOOD OperatorVoid_115, parens as args; program_44_good.pl
    #    croak((%{{a => 2}}));                     # GOOD OperatorVoid_115, outer parens as args, inner parens as subexpression; program_45_good.pl
    #    croak %{{a => 2}};                        # GOOD OperatorVoid_116; program_46_good.pl
    #    croak (%{{a => 2}});                      # GOOD OperatorVoid_116, parens as subexpression; program_47_good.pl
    #    croak(%{{a => 2, b => 3, c => 5, d => 7}});    # GOOD OperatorVoid_115, parens as args; program_48_good.pl
    #    croak((%{{a => 2, b => 3, c => 5, d => 7}}));  # GOOD OperatorVoid_115, outer parens as args, inner parens as subexpression; program_49_good.pl
    #    croak %{{a => 2, b => 3, c => 5, d => 7}};     # GOOD OperatorVoid_116; program_50_good.pl
    #    croak (%{{a => 2, b => 3, c => 5, d => 7}});   # GOOD OperatorVoid_116, parens as subexpression; program_51_good.pl
};

our unknown $quux_die = sub {
    #    die "\n";      # GOOD OperatorVoid_114; program_00*
    #    die("\n");     # BAD  OperatorVoid_115, parser, parens as args; program_01_bad_00.pl
    #    die ("\n");    # BAD  OperatorVoid_116, parser, empty parens as subexpression; program_01_bad_01.pl
    #    die 0, "\n";   # GOOD OperatorVoid_116; program_02*
    #    die 1, "\n";   # GOOD OperatorVoid_116; program_03*
    #    die 23, "\n";  # GOOD OperatorVoid_116; program_04*
    #    die -1, "\n";  # GOOD OperatorVoid_116; program_05*
    #    die -234_567.890_12, "\n"; # GOOD OperatorVoid_116; program_06*
    #    die 'ahoy', "\n";          # GOOD OperatorVoid_116; program_07*
    #    die(2, "\n");              # BAD  OperatorVoid_115, parser, parens as args; program_10*
    #    die((2, "\n"));            # BAD  OperatorVoid_115, parser, outer parens as args, inner parens as subexpressions; program_11*
    #    die(((2, "\n")));          # BAD  OperatorVoid_115, parser, outer parens as args, inner parens as subexpressions; program_12*
    #    die((((2, "\n"))));        # BAD  OperatorVoid_115, parser, outer parens as args, inner parens as subexpressions; program_13*
    #    die (2, "\n");             # BAD  OperatorVoid_116, parser, parens as Perl::Critic args; program_14*
    #    die ((2, "\n"));           # BAD  OperatorVoid_116, parser, parens as Perl::Critic args; program_15*
    #    die (((2, "\n")));         # BAD  OperatorVoid_116, parser, parens as Perl::Critic args; program_16*
    #    die ((((2, "\n"))));       # BAD  OperatorVoid_116, parser, parens as Perl::Critic args; program_17*
    #    die [], "\n";              # GOOD OperatorVoid_116; program_20*
    #    die [2], "\n";             # GOOD OperatorVoid_116; program_21*
    #    die [2, 3], "\n";          # GOOD OperatorVoid_116; program_22*
    #    die [2, 3, 5, 7], "\n";    # GOOD OperatorVoid_116; program_23*
    #    die(@{[2]}, "\n");         # BAD  OperatorVoid_115, parser, parens as args; program_24_bad_00.pl
    #    die((@{[2]}, "\n"));       # BAD  OperatorVoid_115, parser, outer parens as args, inner parens as subexpression; program_25_bad_00.pl
    #    die @{[2]}, "\n";          # GOOD OperatorVoid_116; program_26_good.pl
    #    die (@{[2]}), "\n";        # BAD  OperatorVoid_116, parser, parens as Perl::Critic args; program_27*
    #    die(@{[2, 3, 5, 7]});      # BAD  OperatorVoid_115, parser; program_28_bad_00.pl
    #    die((@{[2, 3, 5, 7]}));    # BAD  OperatorVoid_115, parser; program_29_bad_00.pl
    #    die @{[2, 3, 5, 7]};       # GOOD OperatorVoid_116; program_30_good.pl
    #    die (@{[2, 3, 5, 7]});     # BAD  OperatorVoid_116, parser, parens as Perl::Critic args; program_31_bad_00.pl
    #    die 2, 3, "\n";            # GOOD OperatorVoid_116; program_32*
    #    die 2, 3, 5, 7, "\n";      # GOOD OperatorVoid_116; program_33*
    #    die(2, 3, "\n");           # BAD  OperatorVoid_115, parser, parens as args; program_34*
    #    die(2, 3, 5, 7, "\n");     # BAD  OperatorVoid_115, parser, parens as args; program_35*
    #    die (2, 3, "\n");          # BAD  OperatorVoid_116, parser, parens as subexpression cannot be list with commas; program_36_bad_00.pl
    #    die (2, 3, 5, 7, "\n");    # BAD  OperatorVoid_116, parser, parens as subexpression cannot be list with commas; program_37_bad_00.pl
    #    die {}, "\n";                                # GOOD OperatorVoid_116; program_40*
    #    die {a => 2}, "\n";                          # GOOD OperatorVoid_116; program_41*
    #    die {a => 2, b => 3}, "\n";                  # GOOD OperatorVoid_116; program_42*
    #    die {a => 2, b => 3, c => 5, d => 7}, "\n";  # GOOD OperatorVoid_116; program_43*
    #    die(%{{a => 2}}, "\n");                      # BAD  OperatorVoid_115, parser, parens as args; program_44_bad_00.pl
    #    die((%{{a => 2}}, "\n"));                    # BAD  OperatorVoid_115, parser, outer parens as args, inner parens as subexpression; program_45_bad_00.pl
    #    die %{{a => 2}}, "\n";                       # GOOD OperatorVoid_116; program_46_good.pl
    #    die (%{{a => 2}}, "\n");                     # BAD  OperatorVoid_116, parser, parens as Perl::Critic args; program_47*
    #    die(%{{a => 2, b => 3, c => 5, d => 7}}, "\n");    # BAD  OperatorVoid_115, parser; program_48*
    #    die((%{{a => 2, b => 3, c => 5, d => 7}}), "\n");  # BAD  OperatorVoid_115, parser; program_49_good.pl
    #    die %{{a => 2, b => 3, c => 5, d => 7}}, "\n";     # GOOD OperatorVoid_116; program_50*
    #    die (%{{a => 2, b => 3, c => 5, d => 7}}, "\n");   # BAD  OperatorVoid_116, parser, parens as Perl::Critic args; program_51*
};

our unknown $quux_exit = sub {
    #    exit;      # GOOD OperatorVoid_114; program_00*
    #    exit();    # BAD  OperatorVoid_115, parser, parens as args; program_01_bad_00.pl
    #    exit ();   # BAD  OperatorVoid_116, parser, empty parens as subexpression; program_01_bad_01.pl
    #    exit 0;    # GOOD OperatorVoid_116; program_02*
    #    exit 1;    # GOOD OperatorVoid_116; program_03*
    #    exit 23;   # GOOD OperatorVoid_116; program_04*
    #    exit -1;   # GOOD OperatorVoid_116; program_05*
    #    exit -234_567.890_12; # GOOD OperatorVoid_116; program_06*
    #    exit 'ahoy';          # GOOD OperatorVoid_116; program_07*
    #    exit(2);              # BAD  OperatorVoid_115, parser, parens as args; program_10*
    #    exit((2));            # BAD  OperatorVoid_115, parser, outer parens as args, inner parens as subexpressions; program_11*
    #    exit(((2)));          # BAD  OperatorVoid_115, parser, outer parens as args, inner parens as subexpressions; program_12*
    #    exit((((2))));        # BAD  OperatorVoid_115, parser, outer parens as args, inner parens as subexpressions; program_13*
    #    exit (2);             # BAD  OperatorVoid_116, parser, parens as Perl::Critic args; program_14*
    #    exit ((2));           # BAD  OperatorVoid_116, parser, parens as Perl::Critic args; program_15*
    #    exit (((2)));         # BAD  OperatorVoid_116, parser, parens as Perl::Critic args; program_16*
    #    exit ((((2))));       # BAD  OperatorVoid_116, parser, parens as Perl::Critic args; program_17*
    #    exit [];              # GOOD OperatorVoid_116; program_20*
    #    exit [2];             # GOOD OperatorVoid_116; program_21*
    #    exit [2, 3];          # GOOD OperatorVoid_116; program_22*
    #    exit [2, 3, 5, 7];    # GOOD OperatorVoid_116; program_23*
    #    exit(@{[2]});         # BAD  OperatorVoid_115, parser, parens as args; program_24_bad_00.pl
    #    exit((@{[2]}));       # BAD  OperatorVoid_115, parser, outer parens as args, inner parens as subexpression; program_25_bad_00.pl
    #    exit @{[2]};          # GOOD OperatorVoid_116; program_26_good.pl
    #    exit (@{[2]});        # BAD  OperatorVoid_116, parser, parens as Perl::Critic args; program_27*
    #    exit(@{[2, 3, 5, 7]});     # GOOD OperatorVoid_115; program_28_good.ol
    #    exit((@{[2, 3, 5, 7]}));   # GOOD OperatorVoid_115; program_29_good.pl
    #    exit @{[2, 3, 5, 7]};      # GOOD OperatorVoid_116; program_30_good.pl
    #    exit (@{[2, 3, 5, 7]});    # BAD  OperatorVoid_116, parser, parens as Perl::Critic args; program_31_bad_00.pl
    #    exit 2, 3;                 # BAD  OperatorVoid_116, parser; program_32*
    #    exit 2, 3, 5, 7;           # BAD  OperatorVoid_116, parser; program_33*
    #    exit(2, 3);                # BAD  OperatorVoid_115, parser, parens as args; program_34*
    #    exit(2, 3, 5, 7);          # BAD  OperatorVoid_115, parser, parens as args; program_35*
    #    exit (2, 3);               # BAD  OperatorVoid_116, parser, parens as subexpression cannot be list with commas; program_36_bad_00.pl
    #    exit (2, 3, 5, 7);         # BAD  OperatorVoid_116, parser, parens as subexpression cannot be list with commas; program_37_bad_00.pl
    #    exit {};                                  # GOOD OperatorVoid_116; program_40*
    #    exit {a => 2};                            # GOOD OperatorVoid_116; program_41*
    #    exit {a => 2, b => 3};                    # GOOD OperatorVoid_116; program_42*
    #    exit {a => 2, b => 3, c => 5, d => 7};    # GOOD OperatorVoid_116; program_43*
    #    exit(%{{a => 2}});                        # BAD  OperatorVoid_115, parser, parens as args; program_44_bad_00.pl
    #    exit((%{{a => 2}}));                      # BAD  OperatorVoid_115, parser, outer parens as args, inner parens as subexpression; program_45_bad_00.pl
    #    exit %{{a => 2}};                         # GOOD OperatorVoid_116; program_46_good.pl
    #    exit (%{{a => 2}});                       # BAD  OperatorVoid_116, parser, parens as Perl::Critic args; program_47*
    #    exit(%{{a => 2, b => 3, c => 5, d => 7}});    # BAD  OperatorVoid_115, parser; program_48*
    #    exit((%{{a => 2, b => 3, c => 5, d => 7}}));  # BAD  OperatorVoid_115, parser; program_49_good.pl
    #    exit %{{a => 2, b => 3, c => 5, d => 7}};     # GOOD OperatorVoid_116; program_50*
    #    exit (%{{a => 2, b => 3, c => 5, d => 7}});   # BAD  OperatorVoid_116, parser, parens as Perl::Critic args; program_51*
};

our unknown $quux_return = sub {
    #    return;        # GOOD OperatorVoid_114; program_00* Class_00*
    #    return();      # GOOD OperatorVoid_115, parens as args; program_01_good.pl
    #    return ();     # BAD  OperatorVoid_116, parser, empty parens as subexpression; program_01_bad_01.pl
    #    return 0;      # GOOD OperatorVoid_116; program_02*
    #    return 1;      # GOOD OperatorVoid_116; program_03*
    #    return 23;     # GOOD OperatorVoid_116; program_04*
    #    return -1;     # GOOD OperatorVoid_116; program_05*
    #    return -234_567.890_12;    # GOOD OperatorVoid_116; program_06*
    #    return 'ahoy';             # GOOD OperatorVoid_116; program_07*
    #    return(2);                 # GOOD OperatorVoid_115, parens as args; program_10*
    #    return((2));               # GOOD OperatorVoid_115, outer parens as args, inner parens as subexpressions; program_11*
    #    return(((2)));             # GOOD OperatorVoid_115, outer parens as args, inner parens as subexpressions; program_12*
    #    return((((2))));           # GOOD OperatorVoid_115, outer parens as args, inner parens as subexpressions; program_13*
    #    return (2);                # GOOD OperatorVoid_116, parens as subexpression; program_14*
    #    return ((2));              # GOOD OperatorVoid_116, parens as subexpressions; program_15*
    #    return (((2)));            # GOOD OperatorVoid_116, parens as subexpressions; program_16*
    #    return ((((2))));          # GOOD OperatorVoid_116, parens as subexpressions; program_17*
    #    return [];                 # GOOD OperatorVoid_116; program_20*
    #    return [2];                # GOOD OperatorVoid_116; program_21*
    #    return [2, 3];             # GOOD OperatorVoid_116; program_22*
    #    return [2, 3, 5, 7];       # GOOD OperatorVoid_116; program_23*
    #    return(@{[2]});            # BAD  OperatorVoid_115, generator, parens as args; program_24_bad_00.pl
    #    return((@{[2]}));          # BAD  OperatorVoid_115, generator, outer parens as args, inner parens as subexpression; program_25_bad_00.pl
    #    return(((@{[2]})));        # BAD  OperatorVoid_115, generator, outer parens as args, inner parens as subexpressions; program_25_bad_01.pl
    #    return((((@{[2]}))));      # BAD  OperatorVoid_115, generator, outer parens as args, inner parens as subexpressions; program_25_bad_02.pl
    #    return @{[2]};             # BAD  OperatorVoid_116, generator; program_26_bad_00.pl
    #    return (@{[2]});           # BAD  OperatorVoid_116, generator, parens as subexpression; program_27_bad_00.pl
    #    return ((@{[2]}));         # BAD  OperatorVoid_116, generator, parens as subexpressions; program_27_bad_01.pl
    #    return (((@{[2]})));       # BAD  OperatorVoid_116, generator, parens as subexpressions; program_27_bad_02.pl
    #    return 2, 3;               # BAD  OperatorVoid_116, generator; program_32_bad_00.pl
    #    return 2, 3, 5, 7;         # BAD  OperatorVoid_116, generator; program_33_bad_00.pl
    #    return(2, 3);              # BAD  OperatorVoid_115, generator, parens as args; program_34_bad_00.pl
    #    return(2, 3, 5, 7);        # BAD  OperatorVoid_115, generator, parens as args; program_35_bad_00.pl
    #    return (2, 3);             # BAD  OperatorVoid_116, parser, parens as subexpression cannot be list with commas; program_36_bad_00.pl
    #    return (2, 3, 5, 7);       # BAD  OperatorVoid_116, parser, parens as subexpression cannot be list with commas; program_37_bad_00.pl
    #    return {};                                 # GOOD OperatorVoid_116; program_40*
    #    return {a => 2};                           # GOOD OperatorVoid_116; program_41*
    #    return {a => 2, b => 3};                   # GOOD OperatorVoid_116; program_42*
    #    return {a => 2, b => 3, c => 5, d => 7};   # GOOD OperatorVoid_116; program_43*
    #    return(%{{a => 2}});                       # BAD  OperatorVoid_115, generator, parens as args; program_44_bad_01.pl
    #    return((%{{a => 2}}));                     # BAD  OperatorVoid_115, generator, outer parens as args, inner parens as subexpression; program_45_bad_00.pl
    #    return(((%{{a => 2}})));                   # BAD  OperatorVoid_115, generator, outer parens as args, inner parens as subexpressions; program_45_bad_01.pl
    #    return((((%{{a => 2}}))));                 # BAD  OperatorVoid_115, generator, outer parens as args, inner parens as subexpressions; program_45_bad_02.pl 
    #    return %{{a => 2}};                        # BAD  OperatorVoid_116, generator; program_46_bad_00.pl
    #    return (%{{a => 2}});                      # BAD  OperatorVoid_116, generator, parens as subexpression; program_47_bad_00.pl
    #    return ((%{{a => 2}}));                    # BAD  OperatorVoid_116, generator, parens as subexpressions; program_47_bad_01.pl
    #    return (((%{{a => 2}})));                  # BAD  OperatorVoid_116, generator, parens as subexpressions; program_47_bad_02.pl
};

1;    # end of class
