#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPAPL02' >>>
# <<< PARSE_ERROR: 'No such class RPerl::Test::Subclass::MySubclasserB_Good_arrayrefd' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

# [[[ INCLUDES ]]]
use RPerl::Test::Subclass::MySubclasserB_Good;

# [[[ SUBROUTINES ]]]
our RPerl::Test::Subclass::MySubclasserB_Good_arrayref $tardies = sub {
    my RPerl::Test::Subclass::MySubclasserB_Good_arrayref $retval
        = [ RPerl::Test::Subclass::MySubclasserB_Good->new(), RPerl::Test::Subclass::MySubclasserB_Good->new() ];
    $retval->[0]->{kindergarten} = 'Buffalo Kindergarten';
    $retval->[1]->{kindergarten} = 'Bob Kindergarten';
    return $retval;
};

our RPerl::Test::Subclass::MySubclasserB_Good_hashref $earlies = sub {
    my RPerl::Test::Subclass::MySubclasserB_Good_hashref $retval = {
        'susie'  => RPerl::Test::Subclass::MySubclasserB_Good->new(),
        'calvin' => RPerl::Test::Subclass::MySubclasserB_Good->new()
    };
    return $retval;
};

# [[[ OPERATIONS ]]]
my RPerl::Test::Subclass::MySubclasserB_Good_arrayref $some_kids = tardies();
print $some_kids->[1]->{preschool} . "\n";

my RPerl::Test::Subclass::MySubclasserB_Good_hashref $more_kids = earlies();
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


my RPerl::Test::Subclass::MySubclasserB_Good $another_new_kid = $some_kids->[0]->alphabet();
print $some_kids->[0]->{kindergarten} . "\n";

my RPerl::Test::Subclass::MySubclasserB_Good_arrayref $more_friends = $another_new_kid->brush_paints();
print $another_new_kid->{kindergarten} . "\n";

my RPerl::Test::Subclass::MySubclasserB_Good_hashref $more_classmates = $more_friends->[1]->clay();
print $more_friends->[1]->{kindergarten} . "\n";
print( ( join ',', ( sort keys %{$more_classmates} ) ) . "\n" );

my RPerl::Test::Subclass::MySubclasserB_Good_arrayrefd $more_others = seesaw();
print $more_others->[0]->{kindergarten} . "\n";

my RPerl::Test::Subclass::MySubclasserB_Good_hashref $more_peers = erector_set();
print( ( join ',', ( sort keys %{$more_peers} ) ) . "\n" );
