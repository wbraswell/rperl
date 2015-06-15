#!/usr/bin/perl
use strict;
use warnings;
our $VERSION = 0.002_000;

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(RequireCheckingReturnValueOfEval)  ## SYSTEM DEFAULT 4: allow eval() test code blocks

# suppress 'WEXRP00: Found multiple rperl executables' due to blib/ & pre-existing installation(s)
BEGIN { $ENV{RPERL_WARNINGS} = 0; }

use Test::More tests => 104;
use Test::Exception;
use RPerl::Test;
use File::Copy;
use Module::Refresh;

BEGIN {
    if ( $ENV{RPERL_VERBOSE} ) {
        diag('[[[ Beginning Object-Oriented Inheritance Pre-Test Loading, RPerl Type System ]]]');
    }
    lives_and( sub { use_ok('RPerl'); }, q{use_ok('RPerl') lives} );

    # NEED FIX: duplicate code
    my string $bubble_pmc_filename        = $RPerl::INCLUDE_PATH . '/RPerl/Algorithm/Sort/Bubble.pmc';
#    RPerl::diag 'in 09_precompiled_sort.t, have $bubble_pmc_filename = ' . $bubble_pmc_filename . "\n";

    # delete PMC file if it exists;
    # for PERLOPS_PERLTYPES we need no PMC file; for CPPOPS_xTYPES we need the proper manually-compiled file, not some other file
    if ( -e $bubble_pmc_filename ) {
        my integer $unlink_success = unlink $bubble_pmc_filename;
        if ($unlink_success) {
            ok( 1, 'Unlink (delete) existing PMC file ' . $bubble_pmc_filename );
        }
        else {
            ok( 0, 'Unlink (delete) existing PMC file ' . $bubble_pmc_filename . q{ ... } . $OS_ERROR );

            # skip all tests in this mode if we cannot remove the PMC file (and presumably the other 2 modes, as well)
            next;
        }
    }

    lives_and( sub { require_ok('RPerl::Algorithm::Sort::Bubble'); }, q{require_ok('RPerl::Algorithm::Sort::Bubble') lives} );
}

my string $module_filenamename = 'RPerl/Algorithm/Sort/Bubble.pm';
my object $refresher       = Module::Refresh->new();

# NEED FIX: duplicate code
my string $bubble_pmc_filename        = $RPerl::INCLUDE_PATH . '/RPerl/Algorithm/Sort/Bubble.pmc';
my string $bubble_pmc_filename_manual = $bubble_pmc_filename . '.CPPOPS_DUALTYPES';
#RPerl::diag 'in 09_precompiled_sort.t, have $bubble_pmc_filename = ' . $bubble_pmc_filename . "\n";
#RPerl::diag 'in 09_precompiled_sort.t, have $bubble_pmc_filename_manual = ' . $bubble_pmc_filename_manual . "\n";

# [[[ PRIMARY RUNLOOP ]]]
# [[[ PRIMARY RUNLOOP ]]]
# [[[ PRIMARY RUNLOOP ]]]

# loop 3 times, once for each mode: PERLOPS_PERLTYPES, PERLOPS_CPPTYPES, CPPOPS_CPPTYPES
foreach my integer $mode_id ( sort keys %{$RPerl::MODES} ) {

    #for my $mode_id ( 1 .. 2 ) {    # TEMPORARY DEBUGGING xOPS_xTYPES ONLY
    #    RPerl::diag "in 09_precompiled_sort.t, top of for() loop, have \$mode_id = $mode_id\n";
    my scalartype_hashref $mode = $RPerl::MODES->{$mode_id};
    if ( $ENV{RPERL_VERBOSE} ) {
        Test::More::diag( '[[[ Beginning RPerl Pre-Compiled Sort Tests, ' . RPerl::Test::mode_description($mode) . ' ]]]' );
    }

    # [[[ MODE SETUP ]]]
    # [[[ MODE SETUP ]]]
    # [[[ MODE SETUP ]]]
    my $ops                 = $mode->{ops};
    my $types               = $mode->{types};
    my string $mode_tagline = RPerl::Test::mode_tagline($mode);

    lives_ok( sub { RPerl::Test::mode_enable($mode) }, q{Mode '} . RPerl::Test::mode_description($mode) . q{' enabled in CPP header file(s)} );

    # delete PMC file if it exists;
    # for PERLOPS_PERLTYPES we need no PMC file; for CPPOPS_xTYPES we need the proper manually-compiled file, not some other file
    if ( -e $bubble_pmc_filename ) {
        my integer $unlink_success = unlink $bubble_pmc_filename;
        if ($unlink_success) {
            ok( 1, 'Unlink (delete) existing PMC file ' . $bubble_pmc_filename );
        }
        else {
            ok( 0, 'Unlink (delete) existing PMC file ' . $bubble_pmc_filename . q{ ... } . $OS_ERROR );

            # skip all tests in this mode if we cannot remove the PMC file (and presumably the other 2 modes, as well)
            next;
        }
    }

    if ( $ops eq 'PERL' ) {
#        RPerl::diag 'in 09_precompiled_sort.t, have Bubble symtab entries:' . "\n" . RPerl::analyze_class_symtab_entries('RPerl::Algorithm::Sort::Bubble') . "\n\n";
    }
    else {    # $ops eq 'CPP'
        if ( -e ($bubble_pmc_filename_manual) ) {
            my integer $copy_success = copy( $bubble_pmc_filename_manual, $bubble_pmc_filename );
            if ($copy_success) {
                ok( 1, 'Copy manually-compiled PMC file ' . $bubble_pmc_filename_manual . ' to ' . $bubble_pmc_filename );
            }
            else {
                ok( 0, 'Copy manually-compiled PMC file ' . $bubble_pmc_filename_manual . ' to ' . $bubble_pmc_filename . q{ ... } . $OS_ERROR );
            }
        }
        else {
            ok( 0, 'Copy manually-compiled PMC file ' . $bubble_pmc_filename_manual . ' to ' . $bubble_pmc_filename . q{ ... } . 'File does not exist' );
        }
 
        # C++ use, load, link

    lives_ok( sub { $refresher->refresh_module($module_filenamename) }, 'Refresh previously-loaded module: ' . $module_filenamename );

        lives_and( sub { require_ok('RPerl::Algorithm::Sort::Bubble'); }, q{require_ok('RPerl::Algorithm::Sort::Bubble') lives} );
        
        # allow cpp_load() to actually (re-)compile
        $RPerl::Algorithm::Sort::Bubble::need_load_cpp = 1;  # duplicate lines to avoid 'used only once, possible typo' warning
        $RPerl::Algorithm::Sort::Bubble::need_load_cpp = 1;

# DEV NOTE: must call long form of cpp_load() to bypass mysterious 'undefined subroutine' symtab weirdness
#        lives_ok( sub { RPerl::Algorithm::Sort::Bubble::cpp_load(); }, q{RPerl::Algorithm::Sort::Bubble::cpp_load() lives} ); 
        lives_ok( sub { &{$RPerl::Algorithm::Sort::Bubble::{'cpp_load'}}(); }, q{RPerl::Algorithm::Sort::Bubble::cpp_load() lives} );  # long form
 
#        RPerl::diag 'in 09_precompiled_sort.t, have post-re-use, post-re-cpp_load Bubble symtab entries:' . "\n" . RPerl::analyze_class_symtab_entries('RPerl::Algorithm::Sort::Bubble') . "\n\n";
    }

    foreach my string $type (qw(DataType__Integer DataType__Number DataType__String DataStructure__Array DataStructure__Hash Algorithm__Sort__Bubble)) {
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
            is( uninherited__Sort('Claws'), 'Sort::uninherited__Sort() RULES! ' . $mode_tagline, q{TOOIN06 uninherited__Sort('Claws') returns correct value} );
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
            is( uninherited('Wolverine'), 'Bubble::uninherited() ROCKS! ' . $mode_tagline, q{TOOIN08 uninherited('Wolverine') returns correct value} );
        },
        q{TOOIN08 uninherited('Wolverine') lives}
    );
}

done_testing();