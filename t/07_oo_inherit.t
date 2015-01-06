#!/usr/bin/perl
use strict;
use warnings;
our $VERSION = 0.001_010;

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

use Test::More tests => 101;
use Test::Exception;
use RPerl::Test;

BEGIN {
    if ( $ENV{TEST_VERBOSE} ) {
        diag(
            '[[[ Beginning Object-Oriented Inheritance Pre-Test Loading, RPerl Type System ]]]'
        );
    }
    lives_and( sub { use_ok('RPerl'); }, q{use_ok('RPerl') lives} );
    lives_and(
        sub { use_ok('RPerl::Algorithm::Sort::Bubble'); },
        q{use_ok('RPerl::Algorithm::Sort::Bubble') lives}
    );
    lives_and(
        sub { use_ok('RPerl::Algorithm::Sort::Bubble_cpp'); },
        q{use_ok('RPerl::Algorithm::Sort::Bubble_cpp') lives}
    );
}

# [[[ PRIMARY RUNLOOP ]]]
# [[[ PRIMARY RUNLOOP ]]]
# [[[ PRIMARY RUNLOOP ]]]

# loop 3 times, once for each mode: PERLOPS_PERLTYPES, PERLOPS_CPPTYPES, CPPOPS_CPPTYPES
foreach my integer $mode_id ( sort keys %{$RPerl::MODES} ) {

#for my $mode_id ( 1 .. 1 ) {  # TEMPORARY DEBUGGING CPPOPS_PERLTYPES ONLY
#    RPerl::diag "in 07_oo_inherit.t, top of for() loop, have \$mode_id = $mode_id\n";
    my scalartype__hash_ref $mode = $RPerl::MODES->{$mode_id};
    if ( $ENV{TEST_VERBOSE} ) {
        Test::More::diag( 
                  '[[[ Beginning RPerl Object-Oriented Inheritance Tests, '
                . RPerl::Test::mode_description($mode)
                . ' ]]]' );
    }

    # [[[ MODE SETUP ]]]
    # [[[ MODE SETUP ]]]
    # [[[ MODE SETUP ]]]
    my $ops                 = $mode->{ops};
    my $types               = $mode->{types};
    my string $mode_tagline = RPerl::Test::mode_tagline($mode);

    lives_ok( sub { RPerl::Test::mode_enable($mode) },
        q{mode '} . RPerl::Test::mode_description($mode) . q{' enabled} );

    if ( $ops eq 'PERL' ) {
        lives_and(
            sub { require_ok('RPerl::Algorithm::Sort::Bubble'); },
            q{require_ok('RPerl::Algorithm::Sort::Bubble') lives}
        );
    }
    else {
        if ( $types eq 'CPP' ) {

            # force reload
            delete $main::{'RPerl__Algorithm__Sort__Bubble__MODE_ID'};
        }

        # C++ use, load, link
        lives_and(
            sub { require_ok('RPerl::Algorithm::Sort::Bubble_cpp'); },
            q{require_ok('RPerl::Algorithm::Sort::Bubble_cpp') lives}
        );
        lives_ok(
            sub { RPerl::Algorithm::Sort::Bubble_cpp::cpp_load(); },
            q{RPerl::Algorithm::Sort::Bubble_cpp::cpp_load() lives}
        );
    }

    foreach my string $type (
        qw(integer number string array hash RPerl__Algorithm__Sort__Bubble))
    {
        lives_and(
            sub {
                is( __PACKAGE__->can( $type . '__MODE_ID' )->(),
                    $ops, $type . '__MODE_ID() returns ' . $ops );
            },
            $type . q{__MODE_ID() lives}
        );
    }

    # [[[ OO INHERITANCE TESTS ]]]
    # [[[ OO INHERITANCE TESTS ]]]
    # [[[ OO INHERITANCE TESTS ]]]

    can_ok( 'RPerl::Algorithm::Sort::Bubble', 'new' );
    my $sorter = new_ok('RPerl::Algorithm::Sort::Bubble');

    can_ok( 'RPerl::Algorithm::Sort::Bubble', 'inherited__Bubble' );
    lives_ok(    # TOOIN01
        sub { $sorter->inherited__Bubble('Frozen') },
        q{TOOIN01 inherited__Bubble('Frozen') lives}
    );

    can_ok( 'RPerl::Algorithm::Sort::Bubble', 'inherited__Sort' );
    lives_ok(    # TOOIN02
        sub { $sorter->inherited__Sort('Frozen') },
        q{TOOIN02 inherited__Sort('Frozen') lives}
    );

    can_ok( 'RPerl::Algorithm::Sort::Bubble', 'inherited__Algorithm' );
    lives_ok(    # TOOIN03
        sub { $sorter->inherited__Algorithm('Frozen') },
        q{TOOIN03 inherited__Algorithm('Frozen') lives}
    );

    can_ok( 'RPerl::Algorithm::Sort::Bubble', 'inherited' );
    lives_ok(    # TOOIN04
        sub { $sorter->inherited('Logan') },
        q{TOOIN04 inherited('Logan') lives}
    );

    can_ok( 'RPerl::Algorithm::Sort::Bubble', 'uninherited__Bubble' );
    lives_and(    # TOOIN05
        sub {
            is( uninherited__Bubble('Claws'),
                'Bubble::uninherited__Bubble() RULES! ' . $mode_tagline,
                q{TOOIN05 uninherited__Bubble('Claws') returns correct value}
            );
        },
        q{TOOIN05 uninherited__Bubble('Claws') lives}
    );

    can_ok( 'RPerl::Algorithm::Sort::Bubble', 'uninherited__Sort' );
    lives_and(    # TOOIN06
        sub {
            is( uninherited__Sort('Claws'),
                'Sort::uninherited__Sort() RULES! ' . $mode_tagline,
                q{TOOIN06 uninherited__Sort('Claws') returns correct value}
            );
        },
        q{TOOIN06 uninherited__Sort('Claws') lives}
    );

    can_ok( 'RPerl::Algorithm::Sort::Bubble', 'uninherited__Algorithm' );
    lives_and(    # TOOIN07
        sub {
            is( uninherited__Algorithm('Claws'),
                'Algorithm::uninherited__Algorithm() RULES! ' . $mode_tagline,
                q{TOOIN07 uninherited__Algorithm('Claws') returns correct value}
            );
        },
        q{TOOIN07 uninherited__Algorithm('Claws') lives}
    );

    can_ok( 'RPerl::Algorithm::Sort::Bubble', 'uninherited' );
    lives_and(    # TOOIN08
        sub {
            is( uninherited('Wolverine'),
                'Bubble::uninherited() ROCKS! ' . $mode_tagline,
                q{TOOIN08 uninherited('Wolverine') returns correct value}
            );
        },
        q{TOOIN08 uninherited('Wolverine') lives}
    );
}

done_testing();
