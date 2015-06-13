#!/usr/bin/perl
use strict;
use warnings;
our $VERSION = 0.002_000;

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(RequireCheckingReturnValueOfEval)  ## SYSTEM DEFAULT 4: allow eval() test code blocks

# suppress 'WEXRP00: Found multiple rperl executables' due to blib/ & pre-existing installation(s)
BEGIN { $ENV{RPERL_WARNINGS} = 0; }

use Test::More tests => 183;
use Test::Exception;
use RPerl::Test;
use File::Copy;
use Module::Refresh;
#use File::Path qw(remove_tree);

BEGIN {
    if ( $ENV{RPERL_VERBOSE} ) {
        diag('[[[ Beginning Pre-Compiled Sort Pre-Test Loading, RPerl Type System ]]]');
    }
    lives_and( sub { use_ok('RPerl'); }, q{use_ok('RPerl') lives} );

    # NEED FIX: duplicate code
    my string $bubble_pmc_file        = $RPerl::INCLUDE_PATH . '/RPerl/Algorithm/Sort/Bubble.pmc';
#    RPerl::diag 'in 09_precompiled_sort.t, have $bubble_pmc_file = ' . $bubble_pmc_file . "\n";

    # delete PMC file if it exists;
    # for PERLOPS_PERLTYPES we need no PMC file; for CPPOPS_xTYPES we need the proper manually-compiled file, not some other file
    if ( -e $bubble_pmc_file ) {
        my integer $unlink_success = unlink $bubble_pmc_file;
        if ($unlink_success) {
            ok( 1, 'Unlink (delete) existing PMC file ' . $bubble_pmc_file );
        }
        else {
            ok( 0, 'Unlink (delete) existing PMC file ' . $bubble_pmc_file . q{ ... } . $OS_ERROR );

            # skip all tests in this mode if we cannot remove the PMC file (and presumably the other 2 modes, as well)
            next;
        }
    }

    lives_and( sub { require_ok('RPerl::Algorithm::Sort::Bubble'); }, q{require_ok('RPerl::Algorithm::Sort::Bubble') lives} );
}

my string $module_filename = 'RPerl/Algorithm/Sort/Bubble.pm';
my object $refresher       = Module::Refresh->new();

# NEED FIX: duplicate code
my string $bubble_pmc_file        = $RPerl::INCLUDE_PATH . '/RPerl/Algorithm/Sort/Bubble.pmc';
my string $bubble_pmc_file_manual = $bubble_pmc_file . '.MANUAL';
#RPerl::diag 'in 09_precompiled_sort.t, have $bubble_pmc_file = ' . $bubble_pmc_file . "\n";
#RPerl::diag 'in 09_precompiled_sort.t, have $bubble_pmc_file_manual = ' . $bubble_pmc_file_manual . "\n";

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
    if ( -e $bubble_pmc_file ) {
        my integer $unlink_success = unlink $bubble_pmc_file;
        if ($unlink_success) {
            ok( 1, 'Unlink (delete) existing PMC file ' . $bubble_pmc_file );
        }
        else {
            ok( 0, 'Unlink (delete) existing PMC file ' . $bubble_pmc_file . q{ ... } . $OS_ERROR );

            # skip all tests in this mode if we cannot remove the PMC file (and presumably the other 2 modes, as well)
            next;
        }
    }

    if ( $ops eq 'PERL' ) {
#        RPerl::diag 'in 09_precompiled_sort.t, have Bubble symtab entries:' . "\n" . RPerl::analyze_class_symtab_entries('RPerl::Algorithm::Sort::Bubble') . "\n\n";
    }
    else {    # $ops eq 'CPP'
        if ( -e ($bubble_pmc_file_manual) ) {
            my integer $copy_success = copy( $bubble_pmc_file_manual, $bubble_pmc_file );
            if ($copy_success) {
                ok( 1, 'Copy manually-compiled PMC file ' . $bubble_pmc_file_manual . ' to ' . $bubble_pmc_file );
            }
            else {
                ok( 0, 'Copy manually-compiled PMC file ' . $bubble_pmc_file_manual . ' to ' . $bubble_pmc_file . q{ ... } . $OS_ERROR );
            }
        }
        else {
            ok( 0, 'Copy manually-compiled PMC file ' . $bubble_pmc_file_manual . ' to ' . $bubble_pmc_file . q{ ... } . 'File does not exist' );
        }
 
        # C++ use, load, link

    lives_ok( sub { $refresher->refresh_module($module_filename) }, 'Refresh previously-loaded module: ' . $module_filename );
 
=DISABLED_because_unnecessary
        # NEED FIX: enable string_hashref_arrayref type
        #    my string_hashref_arrayref $remove_tree_errors = undef;
        my hashref_arrayref $remove_tree_errors = undef;
        remove_tree( '_Inline', { error => \$remove_tree_errors, keep_root => 1 } );

        # no errors returned on success
        if ( ( defined $remove_tree_errors ) and ( exists $remove_tree_errors->[0] ) ) {
            foreach my string_hashref $remove_tree_error ( @{$remove_tree_errors} ) {

                # remove_tree only creates one key/value pair per string_hashref
                my string $remove_tree_error_filename;
                my string $remove_tree_error_message;
                ( $remove_tree_error_filename, $remove_tree_error_message ) = %{$remove_tree_error};
                if ( $remove_tree_error_filename eq '' ) {
                    ok( 0, 'Remove tree (delete) existing _Inline build directory ... ' . $remove_tree_error_message );
                }
                else {
                    ok( 0, 'Remove tree (delete) existing _Inline build directory ... ' . $remove_tree_error_message . q{ ... } . $remove_tree_error_filename );
                }
            }
        }
        else {
            ok( 1, 'Remove tree (delete) existing _Inline build directory' );
        }
=cut

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

    # [[[ INTEGER SORT TESTS ]]]
    # [[[ INTEGER SORT TESTS ]]]
    # [[[ INTEGER SORT TESTS ]]]

    throws_ok(    # TIVALSOBU00
        sub { integer_bubblesort() },
        "/(EIVAVRV00.*$mode_tagline)|(Usage.*integer_bubblesort)/",    # DEV NOTE: 2 different error messages, RPerl & C
        q{TIVALSOBU00 integer_bubblesort() throws correct exception}
    );
    throws_ok(                                                         # TIVALSOBU01
        sub { integer_bubblesort(undef) },
        "/EIVAVRV00.*$mode_tagline/",
        q{TIVALSOBU01 integer_bubblesort(undef) throws correct exception}
    );
    throws_ok(                                                         # TIVALSOBU02
        sub { integer_bubblesort(2) },
        "/EIVAVRV01.*$mode_tagline/",
        q{TIVALSOBU02 integer_bubblesort(2) throws correct exception}
    );
    throws_ok(                                                         # TIVALSOBU03
        sub { integer_bubblesort(2.3) },
        "/EIVAVRV01.*$mode_tagline/",
        q{TIVALSOBU03 integer_bubblesort(2.3) throws correct exception}
    );
    throws_ok(                                                         # TIVALSOBU04
        sub { integer_bubblesort('2') },
        "/EIVAVRV01.*$mode_tagline/",
        q{TIVALSOBU04 integer_bubblesort('2') throws correct exception}
    );
    throws_ok(                                                         # TIVALSOBU05
        sub { integer_bubblesort( { a_key => 23 } ) },
        "/EIVAVRV01.*$mode_tagline/",
        q{TIVALSOBU05 integer_bubblesort({a_key => 23}) throws correct exception}
    );
    throws_ok(                                                         # TIVALSOBU10
        sub {
            integer_bubblesort( [ 2, 2112, undef, 23, -877, -33, 1701 ] );
        },
        "/EIVAVRV02.*$mode_tagline/",
        q{TIVALSOBU10 integer_bubblesort([2, 2112, undef, 23, -877, -33, 1701]) throws correct exception}
    );
    throws_ok(                                                         # TIVALSOBU11
        sub {
            integer_bubblesort( [ 2, 2112, 42, 23.3, -877, -33, 1701 ] );
        },
        "/EIVAVRV03.*$mode_tagline/",
        q{TIVALSOBU11 integer_bubblesort([2, 2112, 42, 23.3, -877, -33, 1701]) throws correct exception}
    );
    throws_ok(                                                         # TIVALSOBU12
        sub {
            integer_bubblesort( [ 2, 2112, 42, '23', -877, -33, 1701 ] );
        },
        "/EIVAVRV03.*$mode_tagline/",
        q{TIVALSOBU12 integer_bubblesort([2, 2112, 42, '23', -877, -33, 1701]) throws correct exception}
    );
    throws_ok(                                                         # TIVALSOBU13
        sub {
            integer_bubblesort( [ 2, 2112, 42, [23], -877, -33, 1701 ] );
        },
        "/EIVAVRV03.*$mode_tagline/",
        q{TIVALSOBU13 integer_bubblesort([2, 2112, 42, [23], -877, -33, 1701]) throws correct exception}
    );
    throws_ok(                                                         # TIVALSOBU14
        sub {
            integer_bubblesort( [ 2, 2112, 42, { a_subkey => 23 }, -877, -33, 1701 ] );
        },
        "/EIVAVRV03.*$mode_tagline/",
        q{TIVALSOBU14 integer_bubblesort([2, 2112, 42, {a_subkey => 23}, -877, -33, 1701]) throws correct exception}
    );
    lives_and(                                                         # TIVALSOBU20
        sub {
            is_deeply( integer_bubblesort( [23] ), [23], q{TIVALSOBU20 integer_bubblesort([23]) returns correct value} );
        },
        q{TIVALSOBU20 integer_bubblesort([23]) lives}
    );
    lives_and(                                                         # TIVALSOBU21
        sub {
            is_deeply(
                integer_bubblesort( [ 2, 2112, 42, 23, -877, -33, 1701 ] ),
                [ -877, -33, 2, 23, 42, 1701, 2112 ],
                q{TIVALSOBU21 integer_bubblesort([2, 2112, 42, 23, -877, -33, 1701]) returns correct value}
            );
        },
        q{TIVALSOBU21 integer_bubblesort([2, 2112, 42, 23, -877, -33, 1701]) lives}
    );
    lives_and(                                                         # TIVALSOBU22
        sub {
            is_deeply( integer_bubblesort( [ reverse 0 .. 7 ] ), [ 0 .. 7 ], q{TIVALSOBU22 integer_bubblesort([reverse 0 .. 7]) returns correct value} );
        },
        q{TIVALSOBU22 integer_bubblesort([reverse 0 .. 7]) lives}
    );
    lives_and(                                                         # TIVALSOBU22a
        sub {
            is_deeply(
                eval {
                    my $retval = integer_bubblesort( [ reverse 0 .. 7 ] );
                    return $retval;
                },                                                     # DEV NOTE: does different things to Perl stack than non-eval
                [ 0 .. 7 ],
                q{TIVALSOBU22a eval { my $retval = integer_bubblesort( [ reverse 0 .. 7 ] ); return $retval; } returns correct value}
            );
        },
        q{TIVALSOBU22a eval { my $retval = integer_bubblesort( [ reverse 0 .. 7 ] ); return $retval; } lives}
    );
    throws_ok(                                                         # TIVALSOBU30
        sub { integer_bubblesort__typetest0() },
        "/(EIVAVRV00.*$mode_tagline)|(Usage.*integer_bubblesort__typetest0)/"
        ,                                                              # DEV NOTE: 2 different error messages, RPerl & C
        q{TIVALSOBU30 integer_bubblesort__typetest0() throws correct exception}
    );
    throws_ok(                                                         # TIVALSOBU31
        sub { integer_bubblesort__typetest0(2) },
        "/EIVAVRV01.*$mode_tagline/",
        q{TIVALSOBU31 integer_bubblesort__typetest0(2) throws correct exception}
    );
    throws_ok(                                                         # TIVALSOBU32
        sub {
            integer_bubblesort__typetest0( [ 2, 2112, undef, 23, -877, -33, 1701 ] );
        },
        "/EIVAVRV02.*$mode_tagline/",
        q{TIVALSOBU32 integer_bubblesort__typetest0([2, 2112, undef, 23, -877, -33, 1701]) throws correct exception}
    );
    throws_ok(                                                         # TIVALSOBU33
        sub {
            integer_bubblesort__typetest0( [ 2, 2112, 42, 23, -877, -33, 1701, [ 23, -42.3 ] ] );
        },
        "/EIVAVRV03.*$mode_tagline/",
        q{TIVALSOBU33 integer_bubblesort__typetest0([2, 2112, 42, 23, -877, -33, 1701, [23, -42.3]]) throws correct exception}
    );
    lives_and(                                                         # TIVALSOBU34
        sub {
            is( integer_bubblesort__typetest0( [ 2, 2112, 42, 23, -877, -33, 1701 ] ),
                '[-877, -33, 2, 23, 42, 1701, 2112]' . $mode_tagline,
                q{TIVALSOBU34 integer_bubblesort__typetest0([2, 2112, 42, 23, -877, -33, 1701]) returns correct value}
            );
        },
        q{TIVALSOBU34 integer_bubblesort__typetest0([2, 2112, 42, 23, -877, -33, 1701]) lives}
    );
    lives_and(                                                         # TIVALSOBU34a
        sub {
            is( eval {
                    my $retval = integer_bubblesort__typetest0( [ 2, 2112, 42, 23, -877, -33, 1701 ] );
                    return $retval;
                },
                '[-877, -33, 2, 23, 42, 1701, 2112]' . $mode_tagline,
                q{TIVALSOBU34a eval { my $retval = integer_bubblesort__typetest0( [2, 2112, 42, 23, -877, -33, 1701] ); return $retval; } returns correct value}
            );
        },
        q{TIVALSOBU34a eval { my $retval = integer_bubblesort__typetest0( [2, 2112, 42, 23, -877, -33, 1701] ); return $retval; } lives}
    );

    # [[[ NUMBER SORT TESTS ]]]
    # [[[ NUMBER SORT TESTS ]]]
    # [[[ NUMBER SORT TESTS ]]]

    throws_ok(    # TNVALSOBU00
        sub { number_bubblesort() },
        "/(ENVAVRV00.*$mode_tagline)|(Usage.*number_bubblesort)/",    # DEV NOTE: 2 different error messages, RPerl & C
        q{TNVALSOBU00 number_bubblesort() throws correct exception}
    );
    throws_ok(                                                        # TNVALSOBU01
        sub { number_bubblesort(undef) },
        "/ENVAVRV00.*$mode_tagline/",
        q{TNVALSOBU01 number_bubblesort(undef) throws correct exception}
    );
    throws_ok(                                                        # TNVALSOBU02
        sub { number_bubblesort(2) },
        "/ENVAVRV01.*$mode_tagline/",
        q{TNVALSOBU02 number_bubblesort(2) throws correct exception}
    );
    throws_ok(                                                        # TNVALSOBU03
        sub { number_bubblesort(2.3) },
        "/ENVAVRV01.*$mode_tagline/",
        q{TNVALSOBU03 number_bubblesort(2.3) throws correct exception}
    );
    throws_ok(                                                        # TNVALSOBU04
        sub { number_bubblesort('2') },
        "/ENVAVRV01.*$mode_tagline/",
        q{TNVALSOBU04 number_bubblesort('2') throws correct exception}
    );
    throws_ok(                                                        # TNVALSOBU05
        sub { number_bubblesort( { a_key => 23 } ) },
        "/ENVAVRV01.*$mode_tagline/",
        q{TNVALSOBU05 number_bubblesort({a_key => 23}) throws correct exception}
    );
    throws_ok(                                                        # TNVALSOBU10
        sub {
            number_bubblesort( [ 2, 2112, undef, 23, -877, -33, 1701 ] );
        },
        "/ENVAVRV02.*$mode_tagline/",
        q{TNVALSOBU10 number_bubblesort([2, 2112, undef, 23, -877, -33, 1701]) throws correct exception}
    );
    throws_ok(                                                        # TNVALSOBU11
        sub {
            number_bubblesort( [ 2, 2112, 42, '23', -877, -33, 1701 ] );
        },
        "/ENVAVRV03.*$mode_tagline/",
        q{TNVALSOBU11 number_bubblesort([2, 2112, 42, '23', -877, -33, 1701]) throws correct exception}
    );
    throws_ok(                                                        # TNVALSOBU12
        sub {
            number_bubblesort( [ 2, 2112, 42, [23], -877, -33, 1701 ] );
        },
        "/ENVAVRV03.*$mode_tagline/",
        q{TNVALSOBU12 number_bubblesort([2, 2112, 42, [23], -877, -33, 1701]) throws correct exception}
    );
    throws_ok(                                                        # TNVALSOBU13
        sub {
            number_bubblesort( [ 2, 2112, 42, { a_subkey => 23 }, -877, -33, 1701 ] );
        },
        "/ENVAVRV03.*$mode_tagline/",
        q{TNVALSOBU13 number_bubblesort([2, 2112, 42, {a_subkey => 23}, -877, -33, 1701]) throws correct exception}
    );
    lives_and(                                                        # TNVALSOBU20
        sub {
            is_deeply( number_bubblesort( [23] ), [23], q{TNVALSOBU20 number_bubblesort([23]) returns correct value} );
        },
        q{TNVALSOBU20 number_bubblesort([23]) lives}
    );
    lives_and(                                                        # TNVALSOBU21
        sub {
            is_deeply(
                number_bubblesort( [ 2, 2112, 42, 23, -877, -33, 1701 ] ),
                [ -877, -33, 2, 23, 42, 1701, 2112 ],
                q{TNVALSOBU21 number_bubblesort([2, 2112, 42, 23, -877, -33, 1701]) returns correct value}
            );
        },
        q{TNVALSOBU21 number_bubblesort([2, 2112, 42, 23, -877, -33, 1701]) lives}
    );
    lives_and(                                                        # TNVALSOBU22
        sub {
            is_deeply( number_bubblesort( [ reverse 0 .. 7 ] ), [ 0 .. 7 ], q{TNVALSOBU22 number_bubblesort([reverse 0 .. 7]) returns correct value} );
        },
        q{TNVALSOBU22 number_bubblesort([reverse 0 .. 7]) lives}
    );
    lives_and(                                                        # TNVALSOBU22a
        sub {
            is_deeply(
                eval {
                    my $retval = number_bubblesort( [ reverse 0 .. 7 ] );
                    return $retval;
                },                                                    # DEV NOTE: does different things to Perl stack than non-eval
                [ 0 .. 7 ],
                q{TNVALSOBU22a eval { my $retval = number_bubblesort( [ reverse 0 .. 7 ] ); return $retval; } returns correct value}
            );
        },
        q{TNVALSOBU22a eval { my $retval = number_bubblesort( [ reverse 0 .. 7 ] ); return $retval; } lives}
    );
    lives_and(                                                        # TNVALSOBU23
        sub {
            is_deeply( number_bubblesort( [23.2] ), [23.2], q{TNVALSOBU23 number_bubblesort([23.2]) returns correct value} );
        },
        q{TNVALSOBU23 number_bubblesort([23.2]) lives}
    );
    lives_and(                                                        # TNVALSOBU24
        sub {
            is_deeply(
                number_bubblesort( [ 2.1, 2112.2, 42.3, 23, -877, -33, 1701 ] ),
                [ -877, -33, 2.1, 23, 42.3, 1701, 2112.2 ],
                q{TNVALSOBU24 number_bubblesort([2.1, 2112.2, 42.3, 23, -877, -33, 1701]) returns correct value}
            );
        },
        q{TNVALSOBU24 number_bubblesort([2.1, 2112.2, 42.3, 23, -877, -33, 1701]) lives}
    );
    lives_and(                                                        # TNVALSOBU25
        sub {
            is_deeply(
                number_bubblesort( [ 2.1234432112344321, 2112.4321, 42.4567, 23.765444444444444444, -877.5678, -33.876587658765875687658765, 1701.6789 ] ),
                [ -877.5678, -33.8765876587659, 2.12344321123443, 23.7654444444444, 42.4567, 1701.6789, 2112.4321 ],
                q{TNVALSOBU25 number_bubblesort([2.1234432112344321, ..., -33.876587658765875687658765, 1701.6789]) returns correct value}
            );
        },
        q{TNVALSOBU25 number_bubblesort([2.1234432112344321, ..., -33.876587658765875687658765, 1701.6789]) lives}
    );
    throws_ok(                                                        # TNVALSOBU30
        sub { number_bubblesort__typetest0() },
        "/(ENVAVRV00.*$mode_tagline)|(Usage.*number_bubblesort__typetest0)/"
        ,                                                             # DEV NOTE: 2 different error messages, RPerl & C
        q{TNVALSOBU30 number_bubblesort__typetest0() throws correct exception}
    );
    throws_ok(                                                        # TNVALSOBU31
        sub { number_bubblesort__typetest0(2) },
        "/ENVAVRV01.*$mode_tagline/",
        q{TNVALSOBU31 number_bubblesort__typetest0(2) throws correct exception}
    );
    throws_ok(                                                        # TNVALSOBU32
        sub {
            number_bubblesort__typetest0( [ 2.1234432112344321, 2112.4321, undef, 23.765444444444444444, -877.5678, -33.876587658765875687658765, 1701.6789 ] );
        },
        "/ENVAVRV02.*$mode_tagline/",
        q{TNVALSOBU32 number_bubblesort__typetest0([2.1234432112344321, 2112.4321, undef, ..., 1701.6789]) throws correct exception}
    );
    throws_ok(                                                        # TNVALSOBU33
        sub {
            number_bubblesort__typetest0(
                [ 2.1234432112344321, 2112.4321, 42.4567, 23.765444444444444444, -877.5678, 'abcdefg', -33.876587658765875687658765, 1701.6789 ] );
        },
        "/ENVAVRV03.*$mode_tagline/",
        q{TNVALSOBU33 number_bubblesort__typetest0([2.1234432112344321, ..., 'abcdefg', -33.876587658765875687658765, 1701.6789]) throws correct exception}
    );
    lives_and(                                                        # TNVALSOBU34
        sub {
            is( number_bubblesort__typetest0(
                    [ 2.1234432112344321, 2112.4321, 42.4567, 23.765444444444444444, -877.5678, -33.876587658765875687658765, 1701.6789 ]
                ),
                '[-877.5678, -33.8765876587659, 2.12344321123443, 23.7654444444444, 42.4567, 1701.6789, 2112.4321]' . $mode_tagline,
                q{TNVALSOBU34 number_bubblesort__typetest0([2.1234432112344321, ..., -33.876587658765875687658765, 1701.6789]) returns correct value}
            );
        },
        q{TNVALSOBU34 number_bubblesort__typetest0([2.1234432112344321, ..., -33.876587658765875687658765, 1701.6789]) lives}
    );
    lives_and(                                                        # TNVALSOBU34a
        sub {
            is( eval {
                    my $retval
                        = number_bubblesort__typetest0(
                        [ 2.1234432112344321, 2112.4321, 42.4567, 23.765444444444444444, -877.5678, -33.876587658765875687658765, 1701.6789 ] );
                    return $retval;
                },
                '[-877.5678, -33.8765876587659, 2.12344321123443, 23.7654444444444, 42.4567, 1701.6789, 2112.4321]' . $mode_tagline,
                q{TNVALSOBU34a eval { my $retval = number_bubblesort__typetest0( [2.1234432112344321, ..., 1701.6789] ); return $retval; } returns correct value}
            );
        },
        q{TNVALSOBU34a eval { my $retval = number_bubblesort__typetest0( [2.1234432112344321, ..., 1701.6789] ); return $retval; } lives}
    );
}

done_testing();
