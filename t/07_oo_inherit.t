#!/usr/bin/perl
use strict;
use warnings;
our $VERSION = 0.000_001;

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values and print operator

use Test::More;    # tests => xx;
use Test::Exception;
use Carp;

BEGIN {
    if ( $ENV{TEST_VERBOSE} ) {
        diag(
            '[[[ Beginning Object-Oriented Inheritance Pre-Test Loading, RPerl Type System ]]]'
        );
    }
    lives_and( sub { use_ok('RPerl'); }, q{use_ok('RPerl') lives} );
}

# [[[ TEST RUNLOOP ]]]
# [[[ TEST RUNLOOP ]]]
# [[[ TEST RUNLOOP ]]]

# loop 3 times, once for each mode: Pure-Perl, RPerl Perl-Data, and RPerl C-Data
for my $OPS_TYPES_ID ( 0 .. 2 ) {

    my $OPS_TYPES;

    # [[[ PERLOPS_PERLTYPES SETUP ]]]
    # [[[ PERLOPS_PERLTYPES SETUP ]]]
    # [[[ PERLOPS_PERLTYPES SETUP ]]]

    if ( $OPS_TYPES_ID == 0 ) {
        $OPS_TYPES = 'PERLOPS_PERLTYPES';
        if ( $ENV{TEST_VERBOSE} ) {
            diag(
                q{[[[ Beginning RPerl's Pure-Perl Object-Oriented Inheritance Tests, RPerl Type System Using Perl Data Types & Perl Operations ]]]}
            );
        }

        # Bubblesort: Perl use, load, link
        BEGIN {
            lives_and(
                sub { use_ok('RPerl::Algorithm::Sort::Bubble'); },
                q{use_ok('RPerl::Algorithm::Sort::Bubble') lives}
            );
        }
        lives_and(
            sub { require_ok('RPerl::Algorithm::Sort::Bubble'); },
            q{require_ok('RPerl::Algorithm::Sort::Bubble') lives}
        );
        lives_and(
            sub {
                is( integer__ops(), 'PERL',
                    q{integer__ops() returns 'PERL'} );
            },
            q{integer__ops() lives}
        );
        lives_and(
            sub {
                is( integer__types(), 'PERL',
                    q{integer__types() returns 'PERL'} );
            },
            q{integer__types() lives}
        );
        lives_and(
            sub {
                is( number__ops(), 'PERL', q{number__ops() returns 'PERL'} );
            },
            q{number__ops() lives}
        );
        lives_and(
            sub {
                is( number__types(), 'PERL',
                    q{number__types() returns 'PERL'} );
            },
            q{number__types() lives}
        );
        lives_and(
            sub {
                is( string__ops(), 'PERL', q{string__ops() returns 'PERL'} );
            },
            q{string__ops() lives}
        );
        lives_and(
            sub {
                is( string__types(), 'PERL',
                    q{string__types() returns 'PERL'} );
            },
            q{string__types() lives}
        );
        lives_and(
            sub { is( array__ops(), 'PERL', q{array__ops() returns 'PERL'} ) }
            ,
            q{array__ops() lives}
        );
        lives_and(
            sub {
                is( array__types(), 'PERL',
                    q{array__types() returns 'PERL'} );
            },
            q{array__types() lives}
        );
        lives_and(
            sub { is( hash__ops(), 'PERL', q{hash__ops() returns 'PERL'} ) },
            q{hash__ops() lives}
        );
        lives_and(
            sub {
                is( hash__types(), 'PERL', q{hash__types() returns 'PERL'} );
            },
            q{hash__types() lives}
        );
        lives_and(
            sub {
                is( RPerl__Algorithm__Sort__Bubble__ops(),
                    'PERL',
                    q{RPerl__Algorithm__Sort__Bubble__ops() returns 'PERL'} );
            },
            q{RPerl__Algorithm__Sort__Bubble__ops() lives}
        );
        lives_and(
            sub {
                is( RPerl__Algorithm__Sort__Bubble__types(), 'PERL',
                    q{RPerl__Algorithm__Sort__Bubble__types() returns 'PERL'}
                );
            },
            q{RPerl__Algorithm__Sort__Bubble__types() lives}
        );
    }

    # [[[ CPPOPS_PERLTYPES SETUP ]]]
    # [[[ CPPOPS_PERLTYPES SETUP ]]]
    # [[[ CPPOPS_PERLTYPES SETUP ]]]

    elsif ( $OPS_TYPES_ID == 1 ) {
        $OPS_TYPES = 'CPPOPS_PERLTYPES';
        if ( $ENV{TEST_VERBOSE} ) {
            diag(
                q{[[[ Beginning RPerl's Perl-Data Mode Object-Oriented Inheritance Tests, RPerl Type System Using Perl Data Types & C++ Operations ]]]}
            );
        }

        lives_ok(
            sub { rperltypes::types_enable('PERL') },
            q{rperltypes::types_enable('PERL') lives}
        );

        # Bubblesort: C++ use, load, link
        BEGIN {
            lives_and(
                sub { use_ok('RPerl::Algorithm::Sort::Bubble_cpp'); },
                q{use_ok('RPerl::Algorithm::Sort::Bubble_cpp') lives}
            );
        }
        lives_and(
            sub { require_ok('RPerl::Algorithm::Sort::Bubble_cpp'); },
            q{require_ok('RPerl::Algorithm::Sort::Bubble_cpp') lives}
        );
        lives_ok(
            sub { RPerl::Algorithm::Sort::Bubble_cpp::cpp_load(); },
            q{RPerl::Algorithm::Sort::Bubble_cpp::cpp_load() lives}
        );

        lives_and(
            sub {
                is( integer__ops(), 'CPP', q{integer__ops() returns 'CPP'} );
            },
            q{integer__ops() lives}
        );
        lives_and(
            sub {
                is( integer__types(), 'PERL',
                    q{integer__types() returns 'PERL'} );
            },
            q{integer__types() lives}
        );
        lives_and(
            sub { is( number__ops(), 'CPP', q{number__ops() returns 'CPP'} ) }
            ,
            q{number__ops() lives}
        );
        lives_and(
            sub {
                is( number__types(), 'PERL',
                    q{number__types() returns 'PERL'} );
            },
            q{number__types() lives}
        );
        lives_and(
            sub { is( string__ops(), 'CPP', q{string__ops() returns 'CPP'} ) }
            ,
            q{string__ops() lives}
        );
        lives_and(
            sub {
                is( string__types(), 'PERL',
                    q{string__types() returns 'PERL'} );
            },
            q{string__types() lives}
        );
        lives_and(
            sub { is( array__ops(), 'CPP', q{array__ops() returns 'CPP'} ) },
            q{array__ops() lives}
        );
        lives_and(
            sub {
                is( array__types(), 'PERL',
                    q{array__types() returns 'PERL'} );
            },
            q{array__types() lives}
        );
        lives_and(
            sub { is( hash__ops(), 'CPP', q{hash__ops() returns 'CPP'} ) },
            q{hash__ops() lives} );
        lives_and(
            sub {
                is( hash__types(), 'PERL', q{hash__types() returns 'PERL'} );
            },
            q{hash__types() lives}
        );
        lives_and(
            sub {
                is( RPerl__Algorithm__Sort__Bubble__ops(),
                    'CPP',
                    q{RPerl__Algorithm__Sort__Bubble__ops() returns 'CPP'} );
            },
            q{RPerl__Algorithm__Sort__Bubble__ops() lives}
        );
        lives_and(
            sub {
                is( RPerl__Algorithm__Sort__Bubble__types(), 'PERL',
                    q{RPerl__Algorithm__Sort__Bubble__types() returns 'PERL'}
                );
            },
            q{RPerl__Algorithm__Sort__Bubble__types() lives}
        );
    }

    # [[[ CPPOPS_CPPTYPES SETUP ]]]
    # [[[ CPPOPS_CPPTYPES SETUP ]]]
    # [[[ CPPOPS_CPPTYPES SETUP ]]]

    else {
        $OPS_TYPES = 'CPPOPS_CPPTYPES';
        if ( $ENV{TEST_VERBOSE} ) {
            diag(
                q{[[[ Beginning RPerl's C-Data Mode Object-Oriented Inheritance Tests, RPerl Type System Using C++ Data Types & C++ Operations ]]]}
            );
        }
        lives_ok(
            sub { rperltypes::types_enable('CPP') },
            q{rperltypes::types_enable('CPP') lives}
        );

        # force reload
        delete $main::{'RPerl__Algorithm__Sort__Bubble__ops'};

        # Bubblesort: C++ use, load, link
        lives_ok(
            sub { RPerl::Algorithm::Sort::Bubble_cpp::cpp_load(); },
            q{RPerl::Algorithm::Sort::Bubble_cpp::cpp_load() lives}
        );
        lives_and(
            sub {
                is( integer__ops(), 'CPP', q{integer__ops() returns 'CPP'} );
            },
            q{integer__ops() lives}
        );
        lives_and(
            sub {
                is( integer__types(), 'CPP',
                    q{integer__types() returns 'CPP'} );
            },
            q{integer__types() lives}
        );
        lives_and(
            sub { is( number__ops(), 'CPP', q{number__ops() returns 'CPP'} ) }
            ,
            q{number__ops() lives}
        );
        lives_and(
            sub {
                is( number__types(), 'CPP',
                    q{number__types() returns 'CPP'} );
            },
            q{number__types() lives}
        );
        lives_and(
            sub { is( string__ops(), 'CPP', q{string__ops() returns 'CPP'} ) }
            ,
            q{string__ops() lives}
        );
        lives_and(
            sub {
                is( string__types(), 'CPP',
                    q{string__types() returns 'CPP'} );
            },
            q{string__types() lives}
        );
        lives_and(
            sub { is( array__ops(), 'CPP', q{array__ops() returns 'CPP'} ) },
            q{array__ops() lives}
        );
        lives_and(
            sub {
                is( array__types(), 'CPP', q{array__types() returns 'CPP'} );
            },
            q{array__types() lives}
        );
        lives_and(
            sub { is( hash__ops(), 'CPP', q{hash__ops() returns 'CPP'} ) },
            q{hash__ops() lives} );
        lives_and(
            sub { is( hash__types(), 'CPP', q{hash__types() returns 'CPP'} ) }
            ,    ## PERLTIDY BUG comma on newline
            q{hash__types() lives}
        );
        lives_and(
            sub {
                is( RPerl__Algorithm__Sort__Bubble__ops(),
                    'CPP',
                    q{RPerl__Algorithm__Sort__Bubble__ops() returns 'CPP'} );
            },
            q{RPerl__Algorithm__Sort__Bubble__ops() lives}
        );
        lives_and(
            sub {
                is( RPerl__Algorithm__Sort__Bubble__types(), 'CPP',
                    q{RPerl__Algorithm__Sort__Bubble__types() returns 'CPP'}
                );
            },
            q{RPerl__Algorithm__Sort__Bubble__types() lives}
        );
    }

    # [[[ OO INHERITANCE TESTS ]]]
    # [[[ OO INHERITANCE TESTS ]]]
    # [[[ OO INHERITANCE TESTS ]]]
    
    can_ok('RPerl::Algorithm::Sort::Bubble', 'new');
    my $sorter = new_ok('RPerl::Algorithm::Sort::Bubble');

    can_ok('RPerl::Algorithm::Sort::Bubble', 'inherited__Bubble');
    lives_ok(     # NEEDTESTID
        sub { $sorter->inherited__Bubble('Frozen') },
        q{NEEDTESTID inherited__Bubble('Frozen') lives}
    );

    can_ok('RPerl::Algorithm::Sort::Bubble', 'inherited__Sort');
    lives_ok(     # NEEDTESTID
        sub { $sorter->inherited__Sort('Frozen') },
        q{NEEDTESTID inherited__Sort('Frozen') lives}
    );
 
    can_ok('RPerl::Algorithm::Sort::Bubble', 'inherited__Algorithm');
    lives_ok(     # NEEDTESTID
        sub { $sorter->inherited__Algorithm('Frozen') },
        q{NEEDTESTID inherited__Algorithm('Frozen') lives}
    );


    can_ok('RPerl::Algorithm::Sort::Bubble', 'inherited');
    lives_ok(     # NEEDTESTID
        sub { $sorter->inherited('Logan') },
        q{NEEDTESTID inherited('Logan') lives}
    );


    can_ok('RPerl::Algorithm::Sort::Bubble', 'uninherited__Bubble');
    lives_and(     # NEEDTESTID
        sub {
            is( uninherited__Bubble('Claws'),
                'Bubble::uninherited__Bubble() RULES! ' . $OPS_TYPES,
                q{NEEDTESTID uninherited__Bubble('Claws') returns correct value}
            );
        },
        q{NEEDTESTID uninherited__Bubble('Claws') lives}
    );
 
    can_ok('RPerl::Algorithm::Sort::Bubble', 'uninherited__Sort');
    lives_and(     # NEEDTESTID
        sub {
            is( uninherited__Sort('Claws'),
                'Sort::uninherited__Sort() RULES! ' . $OPS_TYPES,
                q{NEEDTESTID uninherited__Sort('Claws') returns correct value}
            );
        },
        q{NEEDTESTID uninherited__Sort('Claws') lives}
    );
 
    can_ok('RPerl::Algorithm::Sort::Bubble', 'uninherited__Algorithm');
    lives_and(     # NEEDTESTID
        sub {
            is( uninherited__Algorithm('Claws'),
                'Algorithm::uninherited__Algorithm() RULES! ' . $OPS_TYPES,
                q{NEEDTESTID uninherited__Algorithm('Claws') returns correct value}
            );
        },
        q{NEEDTESTID uninherited__Algorithm('Claws') lives}
    );


    can_ok('RPerl::Algorithm::Sort::Bubble', 'uninherited');
    lives_and(     # NEEDTESTID
        sub {
            is( uninherited('Wolverine'),
                'Bubble::uninherited() ROCKS! ' . $OPS_TYPES,
                q{NEEDTESTID uninherited('Wolverine') returns correct value}
            );
        },
        q{NEEDTESTID uninherited('Wolverine') lives}
    );
}

done_testing();