#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPAPL02' >>>
# <<< PARSE_ERROR: 'No such class RPerl::Test::Subclass::MySubclasserA_Good_hashrefd' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

# [[[ INCLUDES ]]]
use RPerl::Test::Subclass::MySubclasserA_Good;

# [[[ SUBROUTINES ]]]
our RPerl::Test::Subclass::MySubclasserA_Good_arrayref $tardies = sub {
    my RPerl::Test::Subclass::MySubclasserA_Good_arrayref $retval
        = [ RPerl::Test::Subclass::MySubclasserA_Good->new(), RPerl::Test::Subclass::MySubclasserA_Good->new() ];
    $retval->[0]->{preschool} = 'Howdy Preschool';
    $retval->[1]->{preschool} = 'Doody Preschool';
    return $retval;
};

our RPerl::Test::Subclass::MySubclasserA_Good_hashrefd $earlies = sub {
    my RPerl::Test::Subclass::MySubclasserA_Good_hashref $retval = {
        'susie'  => RPerl::Test::Subclass::MySubclasserA_Good->new(),
        'calvin' => RPerl::Test::Subclass::MySubclasserA_Good->new()
    };
    return $retval;
};

# [[[ OPERATIONS ]]]
my RPerl::Test::Subclass::MySubclasserA_Good_arrayref $some_kids = tardies();
print $some_kids->[1]->{preschool} . "\n";

my RPerl::Test::Subclass::MySubclasserA_Good_hashref $more_kids = earlies();
print( ( join ',', ( sort keys %{$more_kids} ) ) . "\n" );

my RPerl::Test::Subclass::MySubclasserA_Good $new_kid = $some_kids->[0]->building_blocks();
print $some_kids->[0]->{preschool} . "\n";

my RPerl::Test::Subclass::MySubclasserA_Good_arrayref $friends = $new_kid->finger_paints();
print $new_kid->{preschool} . "\n";

my RPerl::Test::Subclass::MySubclasserA_Good_hashref $classmates = $friends->[1]->sand_box();
print $friends->[1]->{preschool} . "\n";
print( ( join ',', ( sort keys %{$classmates} ) ) . "\n" );

my RPerl::Test::Subclass::MySubclasserA_Good_arrayref $others = swings();
print $others->[0]->{preschool} . "\n";

my RPerl::Test::Subclass::MySubclasserA_Good_hashref $peers = tinker_toys();
print( ( join ',', ( sort keys %{$peers} ) ) . "\n" );
