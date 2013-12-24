#!/usr/bin/perl
## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
## no critic qw(RequireCheckingReturnValueOfEval)  ## RPERL allow test code blocks
## no critic qw(RequireInterpolationOfMetachars)  ## RPERL allow single-quoted control characters, sigils, and regexes
use strict;
use warnings;
use version; our $VERSION = 0.000_014;

# [[[ SETUP ]]]
# [[[ SETUP ]]]
# [[[ SETUP ]]]

use Test::More;    # tests => 66;
use Test::Exception;
use Carp;

BEGIN {
    diag(
        "\n[[[ Beginning Pre-Compiled Sort Pre-Test Loading, RPerl Type System ]]]\n "
    );
}

BEGIN {
    lives_and( sub { use_ok('RPerl'); }, q{use_ok('RPerl') lives} );
    lives_ok(
        sub {
            use parent ('RPerl');
        },
        q{use parent ('RPerl');}
    );
}    # RPerl system files

BEGIN {
    lives_and( sub { use_ok('Data::Dumper'); },
        q{use_ok('Data::Dumper') lives} );
    lives_ok(
        sub {
            our $AUTOLOAD;

            sub AUTOLOAD { ## no critic qw(ProhibitAutoloading RequireArgUnpacking)  ## RPERL SYSTEM allow autoload  ## RPERL SYSTEM allow read-only @_
                croak(
                    "Error autoloading, AUTOLOAD purposefully disabled for debugging, have \$AUTOLOAD = '$AUTOLOAD' and \@_ = \n"
                        . Dumper( \@_ )
                        . ', croaking' );
            }
        },
        q{our $AUTOLOAD;  sub AUTOLOAD {...}}
    );
}

# [[[ TEST RUNLOOP ]]]
# [[[ TEST RUNLOOP ]]]
# [[[ TEST RUNLOOP ]]]

# loop 3 times, once for each mode: Pure-Perl, RPerl Perl-Data, and RPerl C-Data
for my $i ( 0 .. 2 ) {

    #for my $i ( 1 .. 1 ) {  # TEMPORARY DEBUGGING CPPOPS_PERLTYPES ONLY
    print STDERR
        "in 08_precompiled_sort.t, top of for() loop, have \$i = $i\n"
        or croak;    # no effect if suppressing output!
    my $OPS_TYPES;

    # [[[ PERLOPS_PERLTYPES SETUP ]]]
    # [[[ PERLOPS_PERLTYPES SETUP ]]]
    # [[[ PERLOPS_PERLTYPES SETUP ]]]

    if ( $i == 0 ) {
        $OPS_TYPES = 'PERLOPS_PERLTYPES';
        diag(
            "\n[[[ Beginning RPerl's Pure-Perl Pre-Compiled Sort Tests, RPerl Type System Using Perl Data Types & Perl Operations ]]]\n "
        );

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
                is( bubblesort__ops(), 'PERL',
                    q{bubblesort__ops() returns 'PERL'} );
            },
            q{bubblesort__ops() lives}
        );
        lives_and(
            sub {
                is( bubblesort__types(), 'PERL',
                    q{bubblesort__types() returns 'PERL'} );
            },
            q{bubblesort__types() lives}
        );
    }

    # [[[ CPPOPS_PERLTYPES SETUP ]]]
    # [[[ CPPOPS_PERLTYPES SETUP ]]]
    # [[[ CPPOPS_PERLTYPES SETUP ]]]

    elsif ( $i == 1 ) {
        $OPS_TYPES = 'CPPOPS_PERLTYPES';
        diag(
            "\n[[[ Beginning RPerl's Perl-Data Mode Pre-Compiled Sort Tests, RPerl Type System Using Perl Data Types & C++ Operations ]]]\n "
        );

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
        lives_ok(
            sub { RPerl::Algorithm::Sort::Bubble_cpp::cpp_link(); },
            q{RPerl::Algorithm::Sort::Bubble_cpp::cpp_link() lives}
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
                is( bubblesort__ops(), 'CPP',
                    q{bubblesort__ops() returns 'CPP'} );
            },
            q{bubblesort__ops() lives}
        );
        lives_and(
            sub {
                is( bubblesort__types(), 'PERL',
                    q{bubblesort__types() returns 'PERL'} );
            },
            q{bubblesort__types() lives}
        );
    }

    # [[[ CPPOPS_CPPTYPES SETUP ]]]
    # [[[ CPPOPS_CPPTYPES SETUP ]]]
    # [[[ CPPOPS_CPPTYPES SETUP ]]]

    else {
        $OPS_TYPES = 'CPPOPS_CPPTYPES';
        diag(
            "\n[[[ Beginning RPerl's C-Data Mode Pre-Compiled Sort Tests, RPerl Type System Using C++ Data Types & C++ Operations ]]]\n "
        );
        lives_ok(
            sub { rperltypes::types_enable('CPP') },
            q{rperltypes::types_enable('CPP') lives}
        );

        # force reload and relink
        $RPerl::Algorithm::Sort::Bubble_cpp::CPP_LOADED = 0;
        $RPerl::Algorithm::Sort::Bubble_cpp::CPP_LINKED = 0;

        # Bubblesort: C++ use, load, link
        lives_ok(
            sub { RPerl::Algorithm::Sort::Bubble_cpp::cpp_load(); },
            q{RPerl::Algorithm::Sort::Bubble_cpp::cpp_load() lives}
        );
        lives_ok(
            sub { RPerl::Algorithm::Sort::Bubble_cpp::cpp_link(); },
            q{RPerl::Algorithm::Sort::Bubble_cpp::cpp_link() lives}
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
                is( bubblesort__ops(), 'CPP',
                    q{bubblesort__ops() returns 'CPP'} );
            },
            q{bubblesort__ops() lives}
        );
        lives_and(
            sub {
                is( bubblesort__types(), 'CPP',
                    q{bubblesort__types() returns 'CPP'} );
            },
            q{bubblesort__types() lives}
        );
    }

    # [[[ INTEGER SORT TESTS ]]]
    # [[[ INTEGER SORT TESTS ]]]
    # [[[ INTEGER SORT TESTS ]]]

    lives_and(    # TIVALSOBU20
        sub {
            is_deeply(
                integer__bubblesort( [ reverse 0 .. 7 ] ),
                [ 0 .. 7 ],
                q{TIVALSOBU20 integer__bubblesort([reverse 0 .. 7]) returns correct value}
            );
        },
        q{TIVALSOBU20 integer__bubblesort([reverse 0 .. 7]) lives}
    );
    lives_and(    # TIVALSOBU21
        sub {
            is_deeply(
                eval {
                    my $retval = integer__bubblesort( [ reverse 0 .. 7 ] );
                    return $retval;
                }, # DEV NOTE: does different things to Perl stack than non-eval
                [ 0 .. 7 ],
                q{TIVALSOBU21 eval { my $retval = integer__bubblesort( [ reverse 0 .. 7 ] ); return $retval; } returns correct value}
            );
        },
        q{TIVALSOBU21 eval { my $retval = integer__bubblesort( [ reverse 0 .. 7 ] ); return $retval; } lives}
    );

    lives_and(     # TIVALSOBU30
        sub {
            is( integer__bubblesort__typetest0( [ reverse 0 .. 7 ] ),
                '[0, 1, 2, 3, 4, 5, 6, 7]' . $OPS_TYPES,
                q{TIVALSOBU30 integer__bubblesort__typetest0([reverse 0 .. 7]) returns correct value}
            );
        },
        q{TIVALSOBU30 integer__bubblesort__typetest0([reverse 0 .. 7]) lives}
    );
    lives_and(     # TIVALSOBU31
        sub {
            is( eval {
                    my $retval
                        = integer__bubblesort__typetest0(
                        [ reverse 0 .. 7 ] );
                    return $retval;
                }, # DEBUG TEMP: works for weird multi-return values in CPPOPS_PERLTYPES
                '[0, 1, 2, 3, 4, 5, 6, 7]' . $OPS_TYPES,
                q{TIVALSOBU31 eval { my $retval = integer__bubblesort__typetest0( [ reverse 0 .. 7 ] ); return $retval; } returns correct value}
            );
        },
        q{TIVALSOBU31 eval { my $retval = integer__bubblesort__typetest0( [ reverse 0 .. 7 ] ); return $retval; } lives}
    );
}

done_testing();
