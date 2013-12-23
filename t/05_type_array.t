#!/usr/bin/perl
## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
## no critic qw(ProhibitInterpolationOfLiterals)  ## RPERL allow string test values
## no critic qw(RequireInterpolationOfMetachars)  ## RPERL allow single-quoted control characters, sigils, and regexes
use strict;
use warnings;
use version; our $VERSION = -0.003_012;

# [[[ SETUP ]]]
# [[[ SETUP ]]]
# [[[ SETUP ]]]

# SUPPRESS OUTPUT FROM INDIVIDUAL TESTS, EXCLUDING TESTS INSIDE BEGIN{} BLOCKS
# order is BEGIN, UNITCHECK, CHECK, INIT, END; CHECK here suppresses Inline compile output from including HelperFunctions_cpp.pm from INIT in Array.pm
CHECK {
    open( STDOUT, '>', '/dev/null' )
        || croak('Error redirecting stdout, croaking');
    open( STDERR, '>', '/dev/null' )
        || croak('Error redirecting stderr, croaking');
}

use Test::More; # tests => 229;
use Test::Exception;
use Carp;

BEGIN {
    diag(
        "\n[[[ Beginning Array Type Pre-Test Loading, RPerl Type System ]]]\n "
    );
}

BEGIN {
    lives_ok(
        sub {    ## PERLTIDY BUG blank newline

            package main;
            our $RPERL_INCLUDE_PATH = '/tmp/RPerl-latest/lib';
        },
        q{package main; our $RPERL_INCLUDE_PATH = '/tmp/RPerl-latest/lib';}
    );
}    # NEED REMOVE hard-coded path

######BEGIN { lives_ok( sub { use lib $main::RPERL_INCLUDE_PATH . '/CPAN/'; }, q{use lib $main::RPERL_INCLUDE_PATH . '/CPAN/';} ); lives_and( sub { use_ok('MyConfig'); }, q{use_ok('MyConfig') lives} ); }    # RPerl's MyConfig.pm

BEGIN {
######    lives_ok( sub { use lib $main::RPERL_INCLUDE_PATH; }, q{use lib $main::RPERL_INCLUDE_PATH;} );
    lives_and( sub { use_ok('RPerl'); }, q{use_ok('RPerl') lives} );
    lives_ok(
        sub {
            use parent ('RPerl');
            $RPerl::INCLUDE_PATH = $main::RPERL_INCLUDE_PATH;
        },
        q{use parent ('RPerl');  $RPerl::INCLUDE_PATH = $main::RPERL_INCLUDE_PATH;}
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
    print "in 05_type_array.t, top of for() loop, have \$i = $i\n"
        or croak;    # no effect if suppressing output!
    my $OPS_TYPES;

    # [[[ PERLOPS_PERLTYPES SETUP ]]]
    # [[[ PERLOPS_PERLTYPES SETUP ]]]
    # [[[ PERLOPS_PERLTYPES SETUP ]]]

    if ( $i == 0 ) {
        $OPS_TYPES = 'PERLOPS_PERLTYPES';
        diag(
            "\n[[[ Beginning RPerl's Pure-Perl Array Type Tests, RPerl Type System Using Perl Data Types & Perl Operations ]]]\n "
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
    }

    # [[[ CPPOPS_PERLTYPES SETUP ]]]
    # [[[ CPPOPS_PERLTYPES SETUP ]]]
    # [[[ CPPOPS_PERLTYPES SETUP ]]]

    elsif ( $i == 1 ) {
        $OPS_TYPES = 'CPPOPS_PERLTYPES';
        diag(
            "\n[[[ Beginning RPerl's Perl-Data Mode Array Type Tests, RPerl Type System Using Perl Data Types & C++ Operations ]]]\n "
        );

        lives_ok(
            sub { types::types_enable('PERL') },
            q{types::types_enable('PERL') lives}
        );

        # Array: C++ use, load, link
        BEGIN {
            lives_and(
                sub { use_ok('RPerl::DataStructure::Array_cpp'); },
                q{use_ok('RPerl::DataStructure::Array_cpp') lives}
            );
        }
        lives_and(
            sub { require_ok('RPerl::DataStructure::Array_cpp'); },
            q{require_ok('RPerl::DataStructure::Array_cpp') lives}
        );
        lives_ok(
            sub { RPerl::DataStructure::Array_cpp::cpp_load(); },
            q{RPerl::DataStructure::Array_cpp::cpp_load() lives}
        );
        lives_ok(
            sub { RPerl::DataStructure::Array_cpp::cpp_link(); },
            q{RPerl::DataStructure::Array_cpp::cpp_link() lives}
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
    }

    # [[[ CPPOPS_CPPTYPES SETUP ]]]
    # [[[ CPPOPS_CPPTYPES SETUP ]]]
    # [[[ CPPOPS_CPPTYPES SETUP ]]]

    else {
        $OPS_TYPES = 'CPPOPS_CPPTYPES';
        diag(
            "\n[[[ Beginning RPerl's C-Data Mode Array Type Tests, RPerl Type System Using C++ Data Types & C++ Operations ]]]\n "
        );
        lives_ok(
            sub { types::types_enable('CPP') },
            q{types::types_enable('CPP') lives}
        );

        # force reload and relink
        $RPerl::DataStructure::Array_cpp::CPP_LOADED = 0;
        $RPerl::DataStructure::Array_cpp::CPP_LINKED = 0;

        # Array: C++ use, load, link
        lives_ok(
            sub { RPerl::DataStructure::Array_cpp::cpp_load(); },
            q{RPerl::DataStructure::Array_cpp::cpp_load() lives}
        );
        lives_ok(
            sub { RPerl::DataStructure::Array_cpp::cpp_link(); },
            q{RPerl::DataStructure::Array_cpp::cpp_link() lives}
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
            },    ## PERLTIDY BUG comma on newline
            q{array__types() lives}
        );
    }

    # [[[ INTEGER ARRAY TESTS ]]]
    # [[[ INTEGER ARRAY TESTS ]]]
    # [[[ INTEGER ARRAY TESTS ]]]

    throws_ok(    # TIVAVRV00
        sub { integer__array_ref__stringify() },
        "/(EAVRV00.*$OPS_TYPES)|(Usage.*integer__array_ref__stringify)/", # DEV NOTE: 2 different error messages, RPerl & C
        q{TIVAVRV00 integer__array_ref__stringify() throws correct exception}
    );
    throws_ok(    # TIVAVRV01
        sub { integer__array_ref__stringify(undef) },
        "/EAVRV00.*$OPS_TYPES/",
        q{TIVAVRV01 integer__array_ref__stringify(undef) throws correct exception}
    );
    throws_ok(    # TIVAVRV02
        sub { integer__array_ref__stringify(2) },
        "/EAVRV01.*$OPS_TYPES/",
        q{TIVAVRV02 integer__array_ref__stringify(2) throws correct exception}
    );
    throws_ok(    # TIVAVRV03
        sub { integer__array_ref__stringify(2.3) },
        "/EAVRV01.*$OPS_TYPES/",
        q{TIVAVRV03 integer__array_ref__stringify(2.3) throws correct exception}
    );
    throws_ok(    # TIVAVRV04
        sub { integer__array_ref__stringify('2') },
        "/EAVRV01.*$OPS_TYPES/",
        q{TIVAVRV04 integer__array_ref__stringify('2') throws correct exception}
    );
    throws_ok(    # TIVAVRV05
        sub { integer__array_ref__stringify( { a_key => 23 } ) },
        "/EAVRV01.*$OPS_TYPES/",
        q{TIVAVRV05 integer__array_ref__stringify({a_key => 23}) throws correct exception}
    );
    throws_ok(    # TIVAVRV10
        sub {
            integer__array_ref__stringify(
                [ 2, 2112, undef, 23, -877, 33, 1701 ] );
        },
        "/EIV00.*$OPS_TYPES/",
        q{TIVAVRV10 integer__array_ref__stringify([2, 2112, undef, 23, -877, 33, 1701]) throws correct exception}
    );
    throws_ok(    # TIVAVRV11
        sub {
            integer__array_ref__stringify(
                [ 2, 2112, 42, 23.3, -877, 33, 1701 ] );
        },
        "/EIV01.*$OPS_TYPES/",
        q{TIVAVRV11 integer__array_ref__stringify([2, 2112, 42, 23.3, -877, 33, 1701]) throws correct exception}
    );
    throws_ok(    # TIVAVRV12
        sub {
            integer__array_ref__stringify(
                [ 2, 2112, 42, '23', -877, 33, 1701 ] );
        },
        "/EIV01.*$OPS_TYPES/",
        q{TIVAVRV12 integer__array_ref__stringify([2, 2112, 42, '23', -877, 33, 1701]) throws correct exception}
    );
    throws_ok(    # TIVAVRV13
        sub {
            integer__array_ref__stringify(
                [ 2, 2112, 42, [23], -877, 33, 1701 ] );
        },
        "/EIV01.*$OPS_TYPES/",
        q{TIVAVRV13 integer__array_ref__stringify([2, 2112, 42, [23], -877, 33, 1701]) throws correct exception}
    );
    throws_ok(    # TIVAVRV14
        sub {
            integer__array_ref__stringify(
                [ 2, 2112, 42, { a_subkey => 23 }, -877, 33, 1701 ] );
        },
        "/EIV01.*$OPS_TYPES/",
        q{TIVAVRV14 integer__array_ref__stringify([2, 2112, 42, {a_subkey => 23}, -877, 33, 1701]) throws correct exception}
    );
    lives_and(    # TIVAVRV20
        sub {
            is( integer__array_ref__stringify( [23] ),
                '[23]',
                q{TIVAVRV20 integer__array_ref__stringify([23]) returns correct value}
            );
        },
        q{TIVAVRV20 integer__array_ref__stringify([23]) lives}
    );
    lives_and(    # TIVAVRV21
        sub {
            is( integer__array_ref__stringify(
                    [ 2, 2112, 42, 23, -877, 33, 1701 ]
                ),
                '[2, 2112, 42, 23, -877, 33, 1701]',
                q{TIVAVRV21 integer__array_ref__stringify([2, 2112, 42, 23, -877, 33, 1701]) returns correct value}
            );
        },
        q{TIVAVRV21 integer__array_ref__stringify([2, 2112, 42, 23, -877, 33, 1701]) lives}
    );
    throws_ok(    # TIVAVRV30
        sub { integer__array_ref__typetest0() },
        "/(EAVRV00.*$OPS_TYPES)|(Usage.*integer__array_ref__typetest0)/", # DEV NOTE: 2 different error messages, RPerl & C
        q{TIVAVRV30 integer__array_ref__typetest0() throws correct exception}
    );
    throws_ok(    # TIVAVRV31
        sub { integer__array_ref__typetest0(2) },
        "/EAVRV01.*$OPS_TYPES/",
        q{TIVAVRV31 integer__array_ref__typetest0(2) throws correct exception}
    );
    throws_ok(    # TIVAVRV32
        sub {
            integer__array_ref__typetest0(
                [ 2, 2112, undef, 23, -877, 33, 1701 ] );
        },
        "/EIV00.*$OPS_TYPES/",
        q{TIVAVRV32 integer__array_ref__typetest0([2, 2112, undef, 23, -877, 33, 1701]) throws correct exception}
    );
    throws_ok(    # TIVAVRV33
        sub {
            integer__array_ref__typetest0(
                [ 2, 2112, 42, 'abcdefg', -877, 33, 1701 ] );
        },
        "/EIV01.*$OPS_TYPES/",
        q{TIVAVRV33 integer__array_ref__typetest0([2, 2112, 42, 'abcdefg', -877, 33, 1701]) throws correct exception}
    );
    lives_and(    # TIVAVRV34
        sub {
            is( integer__array_ref__typetest0(
                    [ 2, 2112, 42, 23, -877, 33, 1701 ]
                ),
                '[2, 2112, 42, 23, -877, 33, 1701]' . $OPS_TYPES,
                q{TIVAVRV34 integer__array_ref__typetest0([2, 2112, 42, 23, -877, 33, 1701]) returns correct value}
            );
        },
        q{TIVAVRV34 integer__array_ref__typetest0([2, 2112, 42, 23, -877, 33, 1701]) lives}
    );
    lives_and(    # TIVAVRV40
        sub {
            is_deeply(
                integer__array_ref__typetest1(5),
                [ 0, 5, 10, 15, 20 ],
                q{TIVAVRV40 integer__array_ref__typetest1(5) returns correct value}
            );
        },
        q{TIVAVRV40 integer__array_ref__typetest1(5) lives}
    );

    # [[[ NUMBER ARRAY TESTS ]]]
    # [[[ NUMBER ARRAY TESTS ]]]
    # [[[ NUMBER ARRAY TESTS ]]]

    throws_ok(    # TNVAVRV00
        sub { number__array_ref__stringify() },
        "/(EAVRV00.*$OPS_TYPES)|(Usage.*number__array_ref__stringify)/", # DEV NOTE: 2 different error messages, RPerl & C
        q{TNVAVRV00 number__array_ref__stringify() throws correct exception}
    );
    throws_ok(    # TNVAVRV01
        sub { number__array_ref__stringify(undef) },
        "/EAVRV00.*$OPS_TYPES/",
        q{TNVAVRV01 number__array_ref__stringify(undef) throws correct exception}
    );
    throws_ok(    # TNVAVRV02
        sub { number__array_ref__stringify(2) },
        "/EAVRV01.*$OPS_TYPES/",
        q{TNVAVRV02 number__array_ref__stringify(2) throws correct exception}
    );
    throws_ok(    # TNVAVRV03
        sub { number__array_ref__stringify(2.3) },
        "/EAVRV01.*$OPS_TYPES/",
        q{TNVAVRV03 number__array_ref__stringify(2.3) throws correct exception}
    );
    throws_ok(    # TNVAVRV04
        sub { number__array_ref__stringify('2') },
        "/EAVRV01.*$OPS_TYPES/",
        q{TNVAVRV04 number__array_ref__stringify('2') throws correct exception}
    );
    throws_ok(    # TNVAVRV05
        sub { number__array_ref__stringify( { a_key => 23 } ) },
        "/EAVRV01.*$OPS_TYPES/",
        q{TNVAVRV05 number__array_ref__stringify({a_key => 23}) throws correct exception}
    );
    throws_ok(    # TNVAVRV10
        sub {
            number__array_ref__stringify(
                [ 2, 2112, undef, 23, -877, 33, 1701 ] );
        },
        "/ENV00.*$OPS_TYPES/",
        q{TNVAVRV10 number__array_ref__stringify([2, 2112, undef, 23, -877, 33, 1701]) throws correct exception}
    );
    throws_ok(    # TNVAVRV11
        sub {
            number__array_ref__stringify(
                [ 2, 2112, 42, '23', -877, 33, 1701 ] );
        },
        "/ENV01.*$OPS_TYPES/",
        q{TNVAVRV11 number__array_ref__stringify([2, 2112, 42, '23', -877, 33, 1701]) throws correct exception}
    );
    throws_ok(    # TNVAVRV12
        sub {
            number__array_ref__stringify(
                [ 2, 2112, 42, [23], -877, 33, 1701 ] );
        },
        "/ENV01.*$OPS_TYPES/",
        q{TNVAVRV12 number__array_ref__stringify([2, 2112, 42, [23], -877, 33, 1701]) throws correct exception}
    );
    throws_ok(    # TNVAVRV13
        sub {
            number__array_ref__stringify(
                [ 2, 2112, 42, { a_subkey => 23 }, -877, 33, 1701 ] );
        },
        "/ENV01.*$OPS_TYPES/",
        q{TNVAVRV13 number__array_ref__stringify([2, 2112, 42, {a_subkey => 23}, -877, 33, 1701]) throws correct exception}
    );
    lives_and(    # TNVAVRV20
        sub {
            is( number__array_ref__stringify( [23] ),
                '[23]',
                q{TNVAVRV20 number__array_ref__stringify([23]) returns correct value}
            );
        },
        q{TNVAVRV20 number__array_ref__stringify([23]) lives}
    );
    lives_and(    # TNVAVRV21
        sub {
            is( number__array_ref__stringify(
                    [ 2, 2112, 42, 23, -877, 33, 1701 ]
                ),
                '[2, 2112, 42, 23, -877, 33, 1701]',
                q{TNVAVRV21 number__array_ref__stringify([2, 2112, 42, 23, -877, 33, 1701]) returns correct value}
            );
        },
        q{TNVAVRV21 number__array_ref__stringify([2, 2112, 42, 23, -877, 33, 1701]) lives}
    );
    lives_and(    # TNVAVRV22
        sub {
            is( number__array_ref__stringify( [23.2] ),
                '[23.2]',
                q{TNVAVRV22 number__array_ref__stringify([23.2]) returns correct value}
            );
        },
        q{TNVAVRV22 number__array_ref__stringify([23.2]) lives}
    );
    lives_and(    # TNVAVRV23
        sub {
            is( number__array_ref__stringify(
                    [ 2.1, 2112.2, 42.3, 23, -877, 33, 1701 ]
                ),
                '[2.1, 2112.2, 42.3, 23, -877, 33, 1701]',
                q{TNVAVRV23 number__array_ref__stringify([2.1, 2112.2, 42.3, 23, -877, 33, 1701]) returns correct value}
            );
        },
        q{TNVAVRV23 number__array_ref__stringify([2.1, 2112.2, 42.3, 23, -877, 33, 1701]) lives}
    );
    lives_and(    # TNVAVRV24
        sub {
            is( number__array_ref__stringify(
                    [   2.1234432112344321, 2112.4321,
                        42.4567,            23.765444444444444444,
                        -877.5678,          33.876587658765875687658765,
                        1701.6789
                    ]
                ),
                '[2.12344321123443, 2112.4321, 42.4567, 23.7654444444444, -877.5678, 33.8765876587659, 1701.6789]',
                q{TNVAVRV24 number__array_ref__stringify([2.1234432112344321, 2112.4321, ..., 1701.6789]) returns correct value}
            );
        },
        q{TNVAVRV24 number__array_ref__stringify([2.1234432112344321, 2112.4321, ..., 1701.6789]) lives}
    );
    throws_ok(    # TNVAVRV30
        sub { number__array_ref__typetest0() },
        "/(EAVRV00.*$OPS_TYPES)|(Usage.*number__array_ref__typetest0)/", # DEV NOTE: 2 different error messages, RPerl & C
        q{TNVAVRV30 number__array_ref__typetest0() throws correct exception}
    );
    throws_ok(    # TNVAVRV31
        sub { number__array_ref__typetest0(2) },
        "/EAVRV01.*$OPS_TYPES/",
        q{TNVAVRV31 number__array_ref__typetest0(2) throws correct exception}
    );
    throws_ok(    # TNVAVRV32
        sub {
            number__array_ref__typetest0(
                [   2.1234432112344321, 2112.4321,
                    undef,              23.765444444444444444,
                    -877.5678,          33.876587658765875687658765,
                    1701.6789
                ]
            );
        },
        "/ENV00.*$OPS_TYPES/",
        q{TNVAVRV32 number__array_ref__typetest0([2.1234432112344321, 2112.4321, undef, 23.765444444444444444, ..., 1701.6789]) throws correct exception}
    );
    throws_ok(    # TNVAVRV33
        sub {
            number__array_ref__typetest0(
                [   2.1234432112344321,          2112.4321,
                    42.4567,                     23.765444444444444444,
                    -877.5678,                   'abcdefg',
                    33.876587658765875687658765, 1701.6789
                ]
            );
        },
        "/ENV01.*$OPS_TYPES/",
        q{TNVAVRV33 number__array_ref__typetest0([2.1234432112344321, ..., 'abcdefg', 33.876587658765875687658765, 1701.6789]) throws correct exception}
    );
    lives_and(    # TNVAVRV34
        sub {
            is( number__array_ref__typetest0(
                    [   2.1234432112344321, 2112.4321,
                        42.4567,            23.765444444444444444,
                        -877.5678,          33.876587658765875687658765,
                        1701.6789
                    ]
                ),
                '[2.12344321123443, 2112.4321, 42.4567, 23.7654444444444, -877.5678, 33.8765876587659, 1701.6789]'
                    . $OPS_TYPES,
                q{TNVAVRV34 number__array_ref__typetest0([2.1234432112344321, 2112.4321, ..., 1701.6789]) returns correct value}
            );
        },
        q{TNVAVRV34 number__array_ref__typetest0([2.1234432112344321, 2112.4321, ..., 1701.6789]) lives}
    );
    lives_and(    # TNVAVRV40
        sub {
            is_deeply(
                number__array_ref__typetest1(5),
                [ 0, 5.123456789, 10.246913578, 15.370370367, 20.493827156 ]
                ,    ## PERLTIDY BUG comma on newline
                q{TNVAVRV40 number__array_ref__typetest1(5) returns correct value}
            );
        },
        q{TNVAVRV40 number__array_ref__typetest1(5) lives}
    );

    # [[[ STRING ARRAY TESTS ]]]
    # [[[ STRING ARRAY TESTS ]]]
    # [[[ STRING ARRAY TESTS ]]]

    throws_ok(    # TPVAVRV00
        sub { string__array_ref__stringify() },
        "/(EAVRV00.*$OPS_TYPES)|(Usage.*string__array_ref__stringify)/", # DEV NOTE: 2 different error messages, RPerl & C
        q{TPVAVRV00 string__array_ref__stringify() throws correct exception}
    );
    throws_ok(    # TPVAVRV01
        sub { string__array_ref__stringify(undef) },
        "/EAVRV00.*$OPS_TYPES/",
        q{TPVAVRV01 string__array_ref__stringify(undef) throws correct exception}
    );
    throws_ok(    # TPVAVRV02
        sub { string__array_ref__stringify(2) },
        "/EAVRV01.*$OPS_TYPES/",
        q{TPVAVRV02 string__array_ref__stringify(2) throws correct exception}
    );
    throws_ok(    # TPVAVRV03
        sub { string__array_ref__stringify(2.3) },
        "/EAVRV01.*$OPS_TYPES/",
        q{TPVAVRV03 string__array_ref__stringify(2.3) throws correct exception}
    );
    throws_ok(    # TPVAVRV04
        sub { string__array_ref__stringify('Lone Ranger') },
        "/EAVRV01.*$OPS_TYPES/",
        q{TPVAVRV04 string__array_ref__stringify('Lone Ranger') throws correct exception}
    );
    throws_ok(    # TPVAVRV05
        sub { string__array_ref__stringify( { a_key => 'Lone Ranger' } ) },
        "/EAVRV01.*$OPS_TYPES/",
        q{TPVAVRV05 string__array_ref__stringify({a_key => 'Lone Ranger'}) throws correct exception}
    );
    throws_ok(    # TPVAVRV10
        sub {
            string__array_ref__stringify(
                [   'Superman',      'Batman',
                    'Wonder Woman',  undef,
                    'Green Lantern', 'Aquaman',
                    'Martian Manhunter'
                ]
            );
        },
        "/EPV00.*$OPS_TYPES/",
        q{TPVAVRV10 string__array_ref__stringify(['Superman', 'Batman', 'Wonder Woman', undef, 'Green Lantern', 'Aquaman', 'Martian Manhunter']) throws correct exception}
    );
    throws_ok(    # TPVAVRV11
        sub {
            string__array_ref__stringify(
                [   'Superman',      'Batman',
                    23,              'Flash',
                    'Green Lantern', 'Aquaman',
                    'Martian Manhunter'
                ]
            );
        },
        "/EPV01.*$OPS_TYPES/",
        q{TPVAVRV11 string__array_ref__stringify(['Superman', 'Batman', 23, 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter']) throws correct exception}
    );
    throws_ok(    # TPVAVRV12
        sub {
            string__array_ref__stringify(
                [   'Superman',      'Batman',
                    23.2,            'Flash',
                    'Green Lantern', 'Aquaman',
                    'Martian Manhunter'
                ]
            );
        },
        "/EPV01.*$OPS_TYPES/",
        q{TPVAVRV12 string__array_ref__stringify(['Superman', 'Batman', 23.2, 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter']) throws correct exception}
    );
    throws_ok(    # TPVAVRV13
        sub {
            string__array_ref__stringify(
                [   'Superman',       'Batman',
                    ['Wonder Woman'], 'Flash',
                    'Green Lantern',  'Aquaman',
                    'Martian Manhunter'
                ]
            );
        },
        "/EPV01.*$OPS_TYPES/",
        q{TPVAVRV13 string__array_ref__stringify(['Superman', 'Batman', ['Wonder Woman'], 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter']) throws correct exception}
    );
    throws_ok(    # TPVAVRV14
        sub {
            string__array_ref__stringify(
                [   'Superman', 'Batman',
                    { a_subkey => 'Wonder Woman' }, 'Flash',
                    'Green Lantern', 'Aquaman',
                    'Martian Manhunter'
                ]
            );
        },
        "/EPV01.*$OPS_TYPES/",
        q{TPVAVRV14 string__array_ref__stringify(['Superman', 'Batman', {a_subkey => 'Wonder Woman'}, ..., 'Martian Manhunter']) throws correct exception}
    );
    lives_and(    # TPVAVRV20
        sub {
            is( string__array_ref__stringify(
                    [   'Howard The Duck', 'Superman',
                        'Batman',          'Wonder Woman',
                        'Flash',           'Green Lantern',
                        'Aquaman',         'Martian Manhunter'
                    ]
                ),
                q{['Howard The Duck', 'Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter']},
                q{TPVAVRV20 string__array_ref__stringify(['Howard The Duck', 'Superman', 'Batman', 'Wonder Woman', ..., 'Martian Manhunter']) returns correct value}
            );
        },
        q{TPVAVRV20 string__array_ref__stringify(['Howard The Duck', 'Superman', 'Batman', 'Wonder Woman', ..., 'Martian Manhunter']) lives}
    );
    lives_and(    # TPVAVRV21
        sub {
            is( string__array_ref__stringify(
                    [ 'Superman', 'Martian Manhunter', 'undef' ]
                ),
                q{['Superman', 'Martian Manhunter', 'undef']},
                q{TPVAVRV21 string__array_ref__stringify(['Superman', 'Martian Manhunter', 'undef']) returns correct value}
            );
        },
        q{TPVAVRV21 string__array_ref__stringify(['Superman', 'Martian Manhunter', 'undef']) lives}
    );
    lives_and(    # TPVAVRV22
        sub {
            is( string__array_ref__stringify(
                    [ 'Superman', 'Martian Manhunter', '23' ]
                ),
                q{['Superman', 'Martian Manhunter', '23']},
                q{TPVAVRV22 string__array_ref__stringify(['Superman', 'Martian Manhunter', '23']) returns correct value}
            );
        },
        q{TPVAVRV22 string__array_ref__stringify(['Superman', 'Martian Manhunter', '23']) lives}
    );
    lives_and(    # TPVAVRV23
        sub {
            is( string__array_ref__stringify(
                    [ 'Superman', 'Martian Manhunter', '-2112.23' ]
                ),
                q{['Superman', 'Martian Manhunter', '-2112.23']},
                q{TPVAVRV23 string__array_ref__stringify(['Superman', 'Martian Manhunter', '-2112.23']) returns correct value}
            );
        },
        q{TPVAVRV23 string__array_ref__stringify(['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter', '-2112.23']) lives}
    );
    lives_and(    # TPVAVRV24
        sub {
            is( string__array_ref__stringify(
                    [ 'Superman', 'Martian Manhunter', "[\\'Tonto'\\]" ]
                ),
                q{['Superman', 'Martian Manhunter', '[\\\\\'Tonto\'\\\\]']},
                q{TPVAVRV24 string__array_ref__stringify(['Superman', 'Martian Manhunter', "[\\'Tonto'\\]"]) returns correct value}
            );
        },
        q{TPVAVRV24 string__array_ref__stringify(['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', "Martian Manhunter", "-2112.23"]) lives}
    );
    lives_and(    # TPVAVRV25
        sub {
            is( string__array_ref__stringify(
                    [ 'Superman', 'Martian Manhunter', '{buzz => 5}' ]
                ),
                q{['Superman', 'Martian Manhunter', '{buzz => 5}']},
                q{TPVAVRV25 string__array_ref__stringify(['Superman', 'Martian Manhunter', '{buzz => 5}']) returns correct value}
            );
        },
        q{TPVAVRV25 string__array_ref__stringify(['Superman', 'Martian Manhunter', '{buzz => 5}']) lives}
    );
    throws_ok(    # TPVAVRV30
        sub { string__array_ref__typetest0() },
        "/(EAVRV00.*$OPS_TYPES)|(Usage.*string__array_ref__typetest0)/", # DEV NOTE: 2 different error messages, RPerl & C
        q{TPVAVRV30 string__array_ref__typetest0() throws correct exception}
    );
    throws_ok(    # TPVAVRV31
        sub { string__array_ref__typetest0(2) },
        "/EAVRV01.*$OPS_TYPES/",
        q{TPVAVRV31 string__array_ref__typetest0(2) throws correct exception}
    );
    throws_ok(    # TPVAVRV32
        sub {
            string__array_ref__typetest0(
                [   'Superman',      'Batman',
                    'Wonder Woman',  undef,
                    'Green Lantern', 'Aquaman',
                    'Martian Manhunter'
                ]
            );
        },
        "/EPV00.*$OPS_TYPES/",
        q{TPVAVRV32 string__array_ref__typetest0(['Superman', 'Batman', 'Wonder Woman', undef, 'Green Lantern', 'Aquaman', 'Martian Manhunter']) throws correct exception}
    );
    throws_ok(    # TPVAVRV33
        sub {
            string__array_ref__typetest0(
                [   'Superman',      'Batman',
                    'Wonder Woman',  'Flash',
                    'Green Lantern', 'Aquaman',
                    'Martian Manhunter', [ 23, -42.3 ]
                ]
            );
        },
        "/EPV01.*$OPS_TYPES/",
        q{TPVAVRV33 string__array_ref__typetest0(['Superman', 'Batman', 'Wonder Woman', ..., 'Martian Manhunter', [23, -42.3]]) throws correct exception}
    );
    lives_and(    # TPVAVRV34
        sub {
            is( string__array_ref__typetest0(
                    [   'Superman',      'Batman',
                        'Wonder Woman',  'Flash',
                        'Green Lantern', 'Aquaman',
                        'Martian Manhunter'
                    ]
                ),
                q{['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter']}
                    . $OPS_TYPES,
                q{TPVAVRV34 string__array_ref__typetest0(['Superman', ..., 'Green Lantern', 'Aquaman', 'Martian Manhunter']) returns correct value}
            );
        },
        q{TPVAVRV34 string__array_ref__typetest0(['Superman', ..., 'Green Lantern', 'Aquaman', 'Martian Manhunter']) lives}
    );
    lives_and(    # TPVAVRV40
        sub {
            is_deeply(
                string__array_ref__typetest1(5),
                [   'Jeffy Ten! 0/4 ' . $OPS_TYPES,
                    'Jeffy Ten! 1/4 ' . $OPS_TYPES,
                    'Jeffy Ten! 2/4 ' . $OPS_TYPES,
                    'Jeffy Ten! 3/4 ' . $OPS_TYPES,
                    'Jeffy Ten! 4/4 ' . $OPS_TYPES,
                ],
                q{TPVAVRV40 string__array_ref__typetest1(5) returns correct value}
            );
        },
        q{TPVAVRV40 string__array_ref__typetest1(5) lives}
    );
}

done_testing();
