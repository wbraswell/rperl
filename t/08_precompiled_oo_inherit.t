#!/usr/bin/perl

# suppress 'WEXRP00: Found multiple rperl executables' due to blib/ & pre-existing installation(s),
# also 'WARNING WCVCODE00, COMPILER, FIND DEPENDENCIES: Failed to eval-use package' due to RPerl/Test/*/*Bad*.pm & RPerl/Test/*/*bad*.pl
BEGIN { $ENV{RPERL_WARNINGS} = 0; }

use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.005_000;

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(RequireCheckingReturnValueOfEval)  ## SYSTEM DEFAULT 4: allow eval() test code blocks

use Test::More tests => 250;
use Test::Exception;
use RPerl::Test;
use File::Copy;
use Module::Refresh;

#use File::Path qw(remove_tree);

BEGIN {
    if ( $ENV{RPERL_VERBOSE} ) {
        diag('[[[ Beginning Object-Oriented Inheritance Pre-Test Loading, RPerl Type System ]]]');
    }
    lives_and( sub { use_ok('RPerl::AfterSubclass'); }, q{use_ok('RPerl::AfterSubclass') lives} );

    # NEED FIX: duplicate code, is it redundant to do this here and also at the top of the main for() loop?
    my string $bubble_cpp_filename = $RPerl::INCLUDE_PATH . '/RPerl/Algorithm/Sort/Bubble.cpp';
    my string $bubble_h_filename   = $RPerl::INCLUDE_PATH . '/RPerl/Algorithm/Sort/Bubble.h';
    my string $bubble_pmc_filename = $RPerl::INCLUDE_PATH . '/RPerl/Algorithm/Sort/Bubble.pmc';

    my string $sort_cpp_filename = $RPerl::INCLUDE_PATH . '/RPerl/Algorithm/Sort.cpp';
    my string $sort_h_filename   = $RPerl::INCLUDE_PATH . '/RPerl/Algorithm/Sort.h';
    my string $sort_pmc_filename = $RPerl::INCLUDE_PATH . '/RPerl/Algorithm/Sort.pmc';

    my string $inefficient_cpp_filename = $RPerl::INCLUDE_PATH . '/RPerl/Algorithm/Inefficient.cpp';
    my string $inefficient_h_filename   = $RPerl::INCLUDE_PATH . '/RPerl/Algorithm/Inefficient.h';
    my string $inefficient_pmc_filename = $RPerl::INCLUDE_PATH . '/RPerl/Algorithm/Inefficient.pmc';

    my string $algorithm_cpp_filename = $RPerl::INCLUDE_PATH . '/RPerl/Algorithm.cpp';
    my string $algorithm_h_filename   = $RPerl::INCLUDE_PATH . '/RPerl/Algorithm.h';
    my string $algorithm_pmc_filename = $RPerl::INCLUDE_PATH . '/RPerl/Algorithm.pmc';

    #    RPerl::diag('in 08_precompiled_oo_inherit.t, have $bubble_pmc_filename = ' . $bubble_pmc_filename . "\n");

    # NEED FIX: triplicate code, is it redundant to do this here and also at the top of the main for() loop?
    # delete CPP, H, and PMC files if they exist;
    # for PERLOPS_PERLTYPES we need none of these files; for CPPOPS_xTYPES we need the proper manually-compiled files, not some other files
    foreach my string $filename (
        @{  [   $bubble_cpp_filename,      $bubble_h_filename,      $bubble_pmc_filename,      $sort_cpp_filename,
                $sort_h_filename,          $sort_pmc_filename,      $inefficient_cpp_filename, $inefficient_h_filename,
                $inefficient_pmc_filename, $algorithm_cpp_filename, $algorithm_h_filename,     $algorithm_pmc_filename
            ]
        }
        )
    {
        if ( -e $filename ) {
            my integer $unlink_success = unlink $filename;
            if ($unlink_success) {
                ok( 1, 'Unlink (delete) existing file ' . $filename );
            }
            else {
                ok( 0, 'Unlink (delete) existing file ' . $filename . q{ ... } . $OS_ERROR );

                # skip all tests in this mode if we cannot remove the PMC file (and presumably the other 2 modes, as well)
                next;
            }
        }
        else {
            ok( 1, 'No need to unlink (delete) existing file ' . $filename );
        }
    }

    # DEV NOTE, CORRELATION #rp15: suppress 'Too late to run INIT block' at run-time loading via require or eval
    lives_and( sub { require_ok('RPerl::Algorithm::Sort::Bubble'); }, q{require_ok('RPerl::Algorithm::Sort::Bubble') lives} );
    lives_and( sub { require_ok('RPerl::Algorithm::Inefficient'); },  q{require_ok('RPerl::Algorithm::Inefficient') lives} );
}

my string $bubble_pm_filename      = 'RPerl/Algorithm/Sort/Bubble.pm';
my string $sort_pm_filename        = 'RPerl/Algorithm/Sort.pm';
my string $inefficient_pm_filename = 'RPerl/Algorithm/Inefficient.pm';
my string $algorithm_pm_filename   = 'RPerl/Algorithm.pm';
my object $refresher               = Module::Refresh->new();

# NEED FIX: duplicate code
my string $bubble_cpp_filename        = $RPerl::INCLUDE_PATH . '/RPerl/Algorithm/Sort/Bubble.cpp';
my string $bubble_cpp_filename_manual = $bubble_cpp_filename . '.CPPOPS_DUALTYPES';
my string $bubble_h_filename          = $RPerl::INCLUDE_PATH . '/RPerl/Algorithm/Sort/Bubble.h';
my string $bubble_h_filename_manual   = $bubble_h_filename . '.CPPOPS_DUALTYPES';
my string $bubble_pmc_filename        = $RPerl::INCLUDE_PATH . '/RPerl/Algorithm/Sort/Bubble.pmc';
my string $bubble_pmc_filename_manual = $bubble_pmc_filename . '.CPPOPS_DUALTYPES';

my string $sort_cpp_filename        = $RPerl::INCLUDE_PATH . '/RPerl/Algorithm/Sort.cpp';
my string $sort_cpp_filename_manual = $sort_cpp_filename . '.CPPOPS_DUALTYPES';
my string $sort_h_filename          = $RPerl::INCLUDE_PATH . '/RPerl/Algorithm/Sort.h';
my string $sort_h_filename_manual   = $sort_h_filename . '.CPPOPS_DUALTYPES';
my string $sort_pmc_filename        = $RPerl::INCLUDE_PATH . '/RPerl/Algorithm/Sort.pmc';
my string $sort_pmc_filename_manual = $sort_pmc_filename . '.CPPOPS_DUALTYPES';

my string $inefficient_cpp_filename        = $RPerl::INCLUDE_PATH . '/RPerl/Algorithm/Inefficient.cpp';
my string $inefficient_cpp_filename_manual = $inefficient_cpp_filename . '.CPPOPS_DUALTYPES';
my string $inefficient_h_filename          = $RPerl::INCLUDE_PATH . '/RPerl/Algorithm/Inefficient.h';
my string $inefficient_h_filename_manual   = $inefficient_h_filename . '.CPPOPS_DUALTYPES';
my string $inefficient_pmc_filename        = $RPerl::INCLUDE_PATH . '/RPerl/Algorithm/Inefficient.pmc';
my string $inefficient_pmc_filename_manual = $inefficient_pmc_filename . '.CPPOPS_DUALTYPES';

my string $algorithm_cpp_filename        = $RPerl::INCLUDE_PATH . '/RPerl/Algorithm.cpp';
my string $algorithm_cpp_filename_manual = $algorithm_cpp_filename . '.CPPOPS_DUALTYPES';
my string $algorithm_h_filename          = $RPerl::INCLUDE_PATH . '/RPerl/Algorithm.h';
my string $algorithm_h_filename_manual   = $algorithm_h_filename . '.CPPOPS_DUALTYPES';
my string $algorithm_pmc_filename        = $RPerl::INCLUDE_PATH . '/RPerl/Algorithm.pmc';
my string $algorithm_pmc_filename_manual = $algorithm_pmc_filename . '.CPPOPS_DUALTYPES';

#RPerl::diag('in 08_precompiled_oo_inherit.t, have $bubble_pmc_filename = ' . $bubble_pmc_filename . "\n");
#RPerl::diag('in 08_precompiled_oo_inherit.t, have $bubble_pmc_filename_manual = ' . $bubble_pmc_filename_manual . "\n");

# [[[ PRIMARY RUNLOOP ]]]
# [[[ PRIMARY RUNLOOP ]]]
# [[[ PRIMARY RUNLOOP ]]]

# loop 3 times, once for each mode: PERLOPS_PERLTYPES, PERLOPS_CPPTYPES, CPPOPS_CPPTYPES
foreach my integer $mode_id ( sort keys %{$RPerl::MODES} ) {

    #for my $mode_id ( 1 .. 2 ) {    # TEMPORARY DEBUGGING xOPS_xTYPES ONLY

    # [[[ MODE SETUP ]]]
    #    RPerl::diag("in 08_precompiled_oo_inherit.t, top of for() loop, have \$mode_id = $mode_id\n");
    my scalartype_hashref $mode = $RPerl::MODES->{$mode_id};
    my $ops                     = $mode->{ops};
    my $types                   = $mode->{types};
    my string $mode_tagline     = $ops . 'OPS_' . $types . 'TYPES';
    if ( $ENV{RPERL_VERBOSE} ) {
        Test::More::diag( '[[[ Beginning RPerl Pre-Compiled Sort Tests, ' . $ops . ' operations and ' . $types . ' data types' . ' ]]]' );
    }

    lives_ok( sub { rperltypes::types_enable($types) }, q{Mode '} . $ops . ' operations and ' . $types . ' data types' . q{' enabled in CPP header file(s)} );

    # NEED FIX: triplicate code
    # delete CPP, H, and PMC files if they exist;
    # for PERLOPS_PERLTYPES we need none of these files; for CPPOPS_xTYPES we need the proper manually-compiled files, not some other files
    foreach my string $filename (
        @{  [   $bubble_cpp_filename,      $bubble_h_filename,      $bubble_pmc_filename,      $sort_cpp_filename,
                $sort_h_filename,          $sort_pmc_filename,      $inefficient_cpp_filename, $inefficient_h_filename,
                $inefficient_pmc_filename, $algorithm_cpp_filename, $algorithm_h_filename,     $algorithm_pmc_filename
            ]
        }
        )
    {
        if ( -e $filename ) {
            my integer $unlink_success = unlink $filename;
            if ($unlink_success) {
                ok( 1, 'Unlink (delete) existing file ' . $filename );
            }
            else {
                ok( 0, 'Unlink (delete) existing file ' . $filename . q{ ... } . $OS_ERROR );

                # skip all tests in this mode if we cannot remove the PMC file (and presumably the other 2 modes, as well)
                next;
            }
        }
        else {
            ok( 1, 'No need to unlink (delete) existing file ' . $filename );
        }
    }

    if ( $ops eq 'PERL' ) {

#        RPerl::diag('in 08_precompiled_oo_inherit.t, have Bubble symtab entries:' . "\n" . RPerl::analyze_class_symtab_entries('RPerl::Algorithm::Sort::Bubble') . "\n\n");
    }
    else {    # $ops eq 'CPP'
        foreach my string_arrayref $filenames (
            @{  [   [ $bubble_cpp_filename, $bubble_cpp_filename_manual ],

                    [ $bubble_h_filename,   $bubble_h_filename_manual ],
                    [ $bubble_pmc_filename, $bubble_pmc_filename_manual ],
                    [ $sort_cpp_filename,   $sort_cpp_filename_manual ],
                    [ $sort_h_filename,     $sort_h_filename_manual ],
                    [ $sort_pmc_filename,   $sort_pmc_filename_manual ],

                    [ $inefficient_cpp_filename, $inefficient_cpp_filename_manual ],
                    [ $inefficient_h_filename,   $inefficient_h_filename_manual ],
                    [ $inefficient_pmc_filename, $inefficient_pmc_filename_manual ],

                    [ $algorithm_cpp_filename, $algorithm_cpp_filename_manual ],
                    [ $algorithm_h_filename,   $algorithm_h_filename_manual ],
                    [ $algorithm_pmc_filename, $algorithm_pmc_filename_manual ]
                ]
            }
            )
        {
            my string $filename              = $filenames->[0];
            my string $filename_manual       = $filenames->[1];
            my string $filename_short        = $filename;
            my string $filename_manual_short = $filename_manual;
            if ( ( length $filename_short ) > 55 )        { $filename_short        = '...' . substr $filename_short,        -55; }
            if ( ( length $filename_manual_short ) > 55 ) { $filename_manual_short = '...' . substr $filename_manual_short, -55; }
            if ( -e ($filename_manual) ) {
                my integer $copy_success = copy( $filename_manual, $filename );
                if ($copy_success) {
                    ok( 1, 'Copy manually-compiled file ' . $filename_manual_short . ' to ' . $filename_short );
                }
                else {
                    ok( 0, 'Copy manually-compiled file ' . $filename_manual_short . ' to ' . $filename_short . q{ ... } . $OS_ERROR );
                }
            }
            else {
                ok( 0, 'Copy manually-compiled file ' . $filename_manual_short . ' to ' . $filename_short . q{ ... } . 'File does not exist' );
            }
        }

        # C++ use, load, link
        # ALL 4 MODULES
        lives_ok( sub { $refresher->refresh_module($bubble_pm_filename) },      'Refresh previously-loaded module: ' . $bubble_pm_filename );
        lives_ok( sub { $refresher->refresh_module($sort_pm_filename) },        'Refresh previously-loaded module: ' . $sort_pm_filename );
        lives_ok( sub { $refresher->refresh_module($inefficient_pm_filename) }, 'Refresh previously-loaded module: ' . $inefficient_pm_filename );
        lives_ok( sub { $refresher->refresh_module($algorithm_pm_filename) },   'Refresh previously-loaded module: ' . $algorithm_pm_filename );

        # DEV NOTE, CORRELATION #rp15: suppress 'Too late to run INIT block' at run-time loading via require or eval
        # ONLY 2 MODULES
        lives_and( sub { require_ok('RPerl::Algorithm::Sort::Bubble'); }, q{require_ok('RPerl::Algorithm::Sort::Bubble') lives} );
        lives_and( sub { require_ok('RPerl::Algorithm::Inefficient'); },  q{require_ok('RPerl::Algorithm::Inefficient') lives} );

        # force reload
        # ONLY 2 MODULES
        delete $main::{'RPerl__Algorithm__Sort__Bubble__MODE_ID'};
        delete $main::{'RPerl__Algorithm__Inefficient__MODE_ID'};

        # DEV NOTE: must call long form of cpp_load() to bypass mysterious 'undefined subroutine' symtab weirdness
        # ONLY 2 MODULES
        #lives_ok( sub { RPerl::Algorithm::Sort::Bubble::cpp_load(); }, q{RPerl::Algorithm::Sort::Bubble::cpp_load() lives} );
        lives_ok( sub { &{ $RPerl::Algorithm::Sort::Bubble::{'cpp_load'} }(); }, q{RPerl::Algorithm::Sort::Bubble::cpp_load() lives} );    # long form
        lives_ok( sub { &{ $RPerl::Algorithm::Inefficient::{'cpp_load'} }(); },  q{RPerl::Algorithm::Inefficient::cpp_load() lives} );     # long form

#RPerl::diag('in 08_precompiled_oo_inherit.t, have post-re-use, post-re-cpp_load Bubble symtab entries:' . "\n" . RPerl::analyze_class_symtab_entries('RPerl::Algorithm::Sort::Bubble') . "\n\n");
    }

    foreach my string $type (
        qw(DataType__Integer DataType__Number DataType__String DataStructure__Array DataStructure__Hash Algorithm Algorithm__Sort Algorithm__Inefficient Algorithm__Sort__Bubble)
        )
    {
        lives_and(
            sub {
                is( $RPerl::MODES->{ main->can( 'RPerl__' . $type . '__MODE_ID' )->() }->{ops},
                    $ops, 'main::RPerl__' . $type . '__MODE_ID() ops returns ' . $ops );
            },
            'main::RPerl__' . $type . '__MODE_ID() lives'
        );
        lives_and(
            sub {
                is( $RPerl::MODES->{ main->can( 'RPerl__' . $type . '__MODE_ID' )->() }->{types},
                    $types, 'main::RPerl__' . $type . '__MODE_ID() types returns ' . $types );
            },
            'main::RPerl__' . $type . '__MODE_ID() lives'
        );
    }

    # [[[ OO INHERITANCE TESTS ]]]
    # [[[ OO INHERITANCE TESTS ]]]
    # [[[ OO INHERITANCE TESTS ]]]

    # TOOIN00
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
            is( RPerl::Algorithm::Sort::Bubble::uninherited__Bubble('Claws'),
                'Bubble::uninherited__Bubble() RULES! ' . $mode_tagline,
                q{TOOIN05 uninherited__Bubble('Claws') returns correct value}
            );
        },
        q{TOOIN05 uninherited__Bubble('Claws') lives}
    );

    can_ok( 'RPerl::Algorithm::Sort', 'uninherited__Sort' );
    lives_and(    # TOOIN06
        sub {
            is( RPerl::Algorithm::Sort::uninherited__Sort('Claws'),
                'Sort::uninherited__Sort() RULES! ' . $mode_tagline,
                q{TOOIN06 uninherited__Sort('Claws') returns correct value}
            );
        },
        q{TOOIN06 uninherited__Sort('Claws') lives}
    );

    can_ok( 'RPerl::Algorithm', 'uninherited__Algorithm' );
    lives_and(    # TOOIN07
        sub {
            is( RPerl::Algorithm::uninherited__Algorithm('Claws'),
                'Algorithm::uninherited__Algorithm() RULES! ' . $mode_tagline,
                q{TOOIN07 uninherited__Algorithm('Claws') returns correct value}
            );
        },
        q{TOOIN07 uninherited__Algorithm('Claws') lives}
    );

    can_ok( 'RPerl::Algorithm::Sort::Bubble', 'uninherited' );
    lives_and(    # TOOIN08
        sub {
            is( RPerl::Algorithm::Sort::Bubble::uninherited('Wolverine'),
                'Bubble::uninherited() ROCKS! ' . $mode_tagline,
                q{TOOIN08 uninherited('Wolverine') returns correct value}
            );
        },
        q{TOOIN08 uninherited('Wolverine') lives}
    );

    # TOOIN09
    can_ok( 'RPerl::Algorithm::Inefficient', 'new' );
    my $inefficient = new_ok('RPerl::Algorithm::Inefficient');

    can_ok( 'RPerl::Algorithm::Inefficient', 'inherited__Inefficient' );
    lives_ok(    # TOOIN10
        sub { $inefficient->inherited__Inefficient('Frozen') },
        q{TOOIN10 inherited__Inefficient('Frozen') lives}
    );

    can_ok( 'RPerl::Algorithm::Inefficient', 'inherited__Algorithm' );
    lives_ok(    # TOOIN11
        sub { $inefficient->inherited__Algorithm('Frozen') },
        q{TOOIN11 inherited__Algorithm('Frozen') lives}
    );

    can_ok( 'RPerl::Algorithm::Inefficient', 'inherited' );
    lives_ok(    # TOOIN12
        sub { $inefficient->inherited('Logan') },
        q{TOOIN12 inherited('Logan') lives}
    );

    can_ok( 'RPerl::Algorithm::Inefficient', 'uninherited__Inefficient' );
    lives_and(    # TOOIN13
        sub {
            is( RPerl::Algorithm::Inefficient::uninherited__Inefficient('Claws'),
                'Inefficient::uninherited__Inefficient() RULES! ' . $mode_tagline,
                q{TOOIN13 uninherited__Inefficient('Claws') returns correct value}
            );
        },
        q{TOOIN13 uninherited__Inefficient('Claws') lives}
    );

    can_ok( 'RPerl::Algorithm', 'uninherited__Algorithm' );
    lives_and(    # TOOIN14
        sub {
            is( RPerl::Algorithm::uninherited__Algorithm('Claws'),
                'Algorithm::uninherited__Algorithm() RULES! ' . $mode_tagline,
                q{TOOIN14 uninherited__Algorithm('Claws') returns correct value}
            );
        },
        q{TOOIN14 uninherited__Algorithm('Claws') lives}
    );

   # DEV NOTE, CORRELATION #rp04: inheritance testing, manually enable uninherited() in exactly one of Algorithm.*, Inefficient.*, Sort.*, or Bubble.*
   #    can_ok( 'RPerl::Algorithm::Inefficient', 'uninherited' );
   #    lives_and(    # TOOIN15
   #        sub {
   #            is( uninherited('Wolverine'), 'Inefficient::uninherited() ROCKS! ' . $mode_tagline, q{TOOIN15 uninherited('Wolverine') returns correct value} );
   #        },
   #        q{TOOIN15 uninherited('Wolverine') lives}
   #    );

}

# NEED FIX: triplicate code
# delete CPP, H, and PMC files if they exist;
# for PERLOPS_PERLTYPES we need none of these files; for CPPOPS_xTYPES we need the proper manually-compiled files, not some other files
foreach my string $filename (
    @{  [   $bubble_cpp_filename,      $bubble_h_filename,      $bubble_pmc_filename,      $sort_cpp_filename,
            $sort_h_filename,          $sort_pmc_filename,      $inefficient_cpp_filename, $inefficient_h_filename,
            $inefficient_pmc_filename, $algorithm_cpp_filename, $algorithm_h_filename,     $algorithm_pmc_filename
        ]
    }
    )
{
    {
        if ( -e $filename ) {
            my integer $unlink_success = unlink $filename;
            if ($unlink_success) {
                ok( 1, 'Unlink (delete) existing file ' . $filename );
            }
            else {
                ok( 0, 'Unlink (delete) existing file ' . $filename . q{ ... } . $OS_ERROR );

                # skip all tests in this mode if we cannot remove the PMC file (and presumably the other 2 modes, as well)
                next;
            }
        }
        else {
            ok( 1, 'No need to unlink (delete) existing file ' . $filename );
        }
    }
}

done_testing();
