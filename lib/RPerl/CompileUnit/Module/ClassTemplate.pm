# [[[ HEADER ]]]
# <<< CHANGE ME: replace with real class name >>>
package RPerl::CompileUnit::Module::ClassTemplate;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.000_023;

# [[[ OO INHERITANCE ]]]
# <<< CHANGE ME: leave as base class for no inheritance, or replace with real parent package name >>>
use parent qw(RPerl::CompileUnit::Module::Class);
use RPerl::CompileUnit::Module::Class;

# START HERE: continue sorting through all critics
# START HERE: continue sorting through all critics
# START HERE: continue sorting through all critics

# [[[ CRITICS ]]]
# <<< CHANGE ME: delete unused critics >>>
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values and print operator

## no critic qw(ProhibitUnreachableCode RequirePodSections RequirePodAtEnd PodSpelling) # DEVELOPER DEFAULT 1: allow unreachable & POD-commented code
## no critic qw(ProhibitStringySplit ProhibitInterpolationOfLiterals)  ## DEVELOPER DEFAULT 2: allow string test values

## no critic qw(ProhibitStringyEval RequireCheckingReturnValueOfEval ProhibitPunctuationVars) # SYSTEM DEFAULT 1: allow eval() for Inline::CPP
## no critic qw(RequireInterpolationOfMetachars)  ## SYSTEM DEFAULT 2: allow single-quoted control characters, sigils, and regexes

# INSERT ALL CRITICS
# INSERT ALL CRITICS
# INSERT ALL CRITICS

# [[[ INCLUDES ]]]
# <<< CHANGE ME: delete for no includes, or replace with real include package name(s) >>>
use RPerl::Test::Foo;
use RPerl::Test::Bar;

# [[[ CONSTANTS ]]]
# <<< CHANGE ME: delete for no constants, or replace with real constant name(s) & data >>>
use constant PI => my number $TYPED_PI = 3.14159;
use constant DAYS => my string__array_ref $TYPED_DAYS
    = [ 'Sun', 'Mon', 'Tues', 'Weds', 'Thurs', 'Fri', 'Sat' ];
use constant HYDROGEN => my scalar__array_ref $TYPED_HYDROGEN = [
    my integer $TYPED_number = 1,
    my number $TYPED_weight  = 1.00794,
    my string $TYPED_symbol  = 'H'
];
use constant TRANSCENDENTALS => my number__hash_ref $TYPED_TRANSCENDENTALS
    = { pi => 3.14159, e => 2.71828, c => 299_792_458 };
use constant EINSTEIN => my scalar__hash_ref $TYPED_EINSTEIN = {
    name       => my string $TYPED_name        = 'Albert Einstein',
    birth_year => my integer $TYPED_birth_year = 1879,
    death_year => my integer $TYPED_death_year = 1955
};

# [[[ OO PROPERTIES ]]]
# <<< CHANGE ME: replace with real property name(s) & data >>>
our %properties = ( ## no critic qw(ProhibitPackageVars)  # USER DEFAULT 2: allow OO properties
    plugh => my integer $TYPED_plugh            = 23,
    xyzzy => my string $TYPED_xyzzy             = 'twenty-three',
    thud => my integer__array_ref $TYPED_thud = [ 2, 4, 6, 8 ],
    yyz => my number__hash_ref $TYPED_yyz   = { a => 3.1, b => 6.2, c => 9.3 }
);

# [[[ OO METHODS ]]]

# <<< CHANGE ME: delete for no methods, or replace with real method(s) >>>
our void__method $quux = sub {
    ( my object $self) = @_;
    $self->{plugh} = $self->{plugh} * 2;
};

our string__method $corge = sub {
    ( my object $self) = @_;
    return $self->{xyzzy} x 3;
};

1, 1;    # CODE SEPARATOR: methods above, subroutines below

# [[[ SUBROUTINES ]]]

# <<< CHANGE ME: delete for no subroutines, or replace with real subroutine(s) >>>
our void $grault = sub {
    ( my integer $grault_input ) = @_;
    print '$grault_input ** 2 = ' . ( $grault_input**2 ) . "\n";
};

our number__array_ref $garply = sub {
    ( my integer $garply_input ) = @_;
    my number__array_ref $garply_output
        = [ $garply_input * 1.1, $garply_input * 2.2, $garply_input * 3.3 ];
    return $garply_output;
};

# NEED DETERMINE: auto-generate ops & types reporting below???
# NEED DETERMINE: auto-generate ops & types reporting below???
# NEED DETERMINE: auto-generate ops & types reporting below???

# <<< OPERATIONS & DATA TYPES REPORTING >>>
our integer $RPerl__CompileUnit__Module__ClassTemplate__OPS_TYPES_ID
    = sub { return 0; };    # PERLOPS_PERLTYPES is 0
our string $RPerl__CompileUnit__Module__ClassTemplate__ops
    = sub { return 'PERL'; };
our string $RPerl__CompileUnit__Module__ClassTemplate__types
    = sub { return 'PERL'; };

1, 1;                       # CODE SEPARATOR: end of class
