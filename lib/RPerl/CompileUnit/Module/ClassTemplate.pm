# [[[ HEADER ]]]
# <<< CHANGE ME: replace with real class name >>>
package RPerl::CompileUnit::Module::ClassTemplate;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.000_010;

# [[[ OO INHERITANCE ]]]
# <<< CHANGE ME: leave as base class for no inheritance, or replace with real parent package name >>>
use parent qw(RPerl::CompileUnit::Module::Class);
use RPerl::CompileUnit::Module::Class;

# [[[ CRITICS ]]]
# <<< CHANGE ME: delete unused critics >>>
# USER DEFAULT 1: allow numeric values and print operator
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)

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

# INSERT 00 PROPERTIES
# INSERT 00 PROPERTIES
# INSERT 00 PROPERTIES

# [[[ OO METHODS ]]]

# INSERT OO METHOD
# INSERT OO METHOD
# INSERT OO METHOD

1, 1;    # CODE SEPARATOR: methods above, subroutines below

# [[[ SUBROUTINES ]]]

# INSERT SUBROUTINE
# INSERT SUBROUTINE
# INSERT SUBROUTINE

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
