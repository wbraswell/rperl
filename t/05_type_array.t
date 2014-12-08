#!/usr/bin/perl
use strict;
use warnings;
our $VERSION = 0.004_010;

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values and print operator
## no critic qw(ProhibitStringySplit ProhibitInterpolationOfLiterals)  # DEVELOPER DEFAULT 2: allow string test values
## no critic qw(RequireInterpolationOfMetachars)  # SYSTEM DEFAULT 2: allow single-quoted control characters, sigils, and regexes

use RPerl::Test;
use Test::More tests => 222;
use Test::Exception;

BEGIN {
    if ( $ENV{TEST_VERBOSE} ) {
        diag(
            '[[[ Beginning Array Type Pre-Test Loading, RPerl Type System ]]]'
        );
    }
    lives_and( sub { use_ok('RPerl'); }, q{use_ok('RPerl') lives} );
    lives_and(
        sub { use_ok('RPerl::DataStructure::Array_cpp'); },
        q{use_ok('RPerl::DataStructure::Array_cpp') lives}
    );
}

# [[[ PRIMARY RUNLOOP ]]]
# [[[ PRIMARY RUNLOOP ]]]
# [[[ PRIMARY RUNLOOP ]]]

# loop 3 times, once for each mode: Pure-Perl, RPerl Perl-Data, and RPerl C-Data
foreach
    my scalartype__hash_ref $mode ( @{ $RPerl::Test::properties_class{modes} } ) ## no critic qw(ProhibitPackageVars)  # USER DEFAULT 2: allow OO properties
{
#    RPerl::diag "in 05_type_array.t, top of for() loop, have \$OPS_TYPES_ID = $OPS_TYPES_ID\n" or croak;    # no effect if suppressing output!
    if ( $ENV{TEST_VERBOSE} ) {
        Test::More::diag( '[[[ Beginning RPerl Array Type Tests, '
                . RPerl::Test::description($mode)
                . ' ]]]' );
    }

    # [[[ PERLOPS_PERLTYPES SETUP ]]]
    # [[[ PERLOPS_PERLTYPES SETUP ]]]
    # [[[ PERLOPS_PERLTYPES SETUP ]]]
    my $ops                  = $mode->{ops};
    my $types                = $mode->{types};
    my string $OPS_TYPES     = RPerl::Test::id($mode);
    my integer $OPS_TYPES_ID = $mode->{index};

    lives_ok( sub { RPerl::Test::enable($mode) },
        q{mode '} . RPerl::Test::description($mode) . q{' enabled} );

    if ( $ops eq 'CPP' ) {

        # force reload
        delete $main::{'RPerl__DataStructure__Array__ops'};

        # Array: C++ use, load, link
        lives_and(
            sub { require_ok('RPerl::DataStructure::Array_cpp'); },
            q{require_ok('RPerl::DataStructure::Array_cpp') lives}
        );
        lives_ok(
            sub { RPerl::DataStructure::Array_cpp::cpp_load(); },
            q{RPerl::DataStructure::Array_cpp::cpp_load() lives}
        );
    }

    foreach my string $type (qw(integer number string array)) {
        lives_and(
            sub {
                is( __PACKAGE__->can( $type . '__ops' )->(),
                    $ops, $type . '__ops() returns ' . $ops );
            },
            $type . q{__ops() lives}
        );
        lives_and(
            sub {
                is( __PACKAGE__->can( $type . '__types' )->(),
                    $types, $type . '__types() returns ' . $types );
            },
            $type . q{__types() lives}
        );
    }

    # [[[ INTEGER ARRAY TESTS ]]]
    # [[[ INTEGER ARRAY TESTS ]]]
    # [[[ INTEGER ARRAY TESTS ]]]

    throws_ok(    # TIVAVRV00
        sub { integer__array_ref__stringify() },
        "/(EIVAVRV00.*$OPS_TYPES)|(Usage.*integer__array_ref__stringify)/", # DEV NOTE: 2 different error messages, RPerl & C
        q{TIVAVRV00 integer__array_ref__stringify() throws correct exception}
    );
    throws_ok(    # TIVAVRV01
        sub { integer__array_ref__stringify(undef) },
        "/EIVAVRV00.*$OPS_TYPES/",
        q{TIVAVRV01 integer__array_ref__stringify(undef) throws correct exception}
    );
    throws_ok(    # TIVAVRV02
        sub { integer__array_ref__stringify(2) },
        "/EIVAVRV01.*$OPS_TYPES/",
        q{TIVAVRV02 integer__array_ref__stringify(2) throws correct exception}
    );
    throws_ok(    # TIVAVRV03
        sub { integer__array_ref__stringify(2.3) },
        "/EIVAVRV01.*$OPS_TYPES/",
        q{TIVAVRV03 integer__array_ref__stringify(2.3) throws correct exception}
    );
    throws_ok(    # TIVAVRV04
        sub { integer__array_ref__stringify('2') },
        "/EIVAVRV01.*$OPS_TYPES/",
        q{TIVAVRV04 integer__array_ref__stringify('2') throws correct exception}
    );
    throws_ok(    # TIVAVRV05
        sub { integer__array_ref__stringify( { a_key => 23 } ) },
        "/EIVAVRV01.*$OPS_TYPES/",
        q{TIVAVRV05 integer__array_ref__stringify({a_key => 23}) throws correct exception}
    );
    throws_ok(    # TIVAVRV10
        sub {
            integer__array_ref__stringify(
                [ 2, 2112, undef, 23, -877, -33, 1701 ] );
        },
        "/EIVAVRV02.*$OPS_TYPES/",
        q{TIVAVRV10 integer__array_ref__stringify([2, 2112, undef, 23, -877, -33, 1701]) throws correct exception}
    );
    throws_ok(    # TIVAVRV11
        sub {
            integer__array_ref__stringify(
                [ 2, 2112, 42, 23.3, -877, -33, 1701 ] );
        },
        "/EIVAVRV03.*$OPS_TYPES/",
        q{TIVAVRV11 integer__array_ref__stringify([2, 2112, 42, 23.3, -877, -33, 1701]) throws correct exception}
    );
    throws_ok(    # TIVAVRV12
        sub {
            integer__array_ref__stringify(
                [ 2, 2112, 42, '23', -877, -33, 1701 ] );
        },
        "/EIVAVRV03.*$OPS_TYPES/",
        q{TIVAVRV12 integer__array_ref__stringify([2, 2112, 42, '23', -877, -33, 1701]) throws correct exception}
    );
    throws_ok(    # TIVAVRV13
        sub {
            integer__array_ref__stringify(
                [ 2, 2112, 42, [23], -877, -33, 1701 ] );
        },
        "/EIVAVRV03.*$OPS_TYPES/",
        q{TIVAVRV13 integer__array_ref__stringify([2, 2112, 42, [23], -877, -33, 1701]) throws correct exception}
    );
    throws_ok(    # TIVAVRV14
        sub {
            integer__array_ref__stringify(
                [ 2, 2112, 42, { a_subkey => 23 }, -877, -33, 1701 ] );
        },
        "/EIVAVRV03.*$OPS_TYPES/",
        q{TIVAVRV14 integer__array_ref__stringify([2, 2112, 42, {a_subkey => 23}, -877, -33, 1701]) throws correct exception}
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
                    [ 2, 2112, 42, 23, -877, -33, 1701 ]
                ),
                '[2, 2112, 42, 23, -877, -33, 1701]',
                q{TIVAVRV21 integer__array_ref__stringify([2, 2112, 42, 23, -877, -33, 1701]) returns correct value}
            );
        },
        q{TIVAVRV21 integer__array_ref__stringify([2, 2112, 42, 23, -877, -33, 1701]) lives}
    );
    throws_ok(    # TIVAVRV30
        sub { integer__array_ref__typetest0() },
        "/(EIVAVRV00.*$OPS_TYPES)|(Usage.*integer__array_ref__typetest0)/", # DEV NOTE: 2 different error messages, RPerl & C
        q{TIVAVRV30 integer__array_ref__typetest0() throws correct exception}
    );
    throws_ok(    # TIVAVRV31
        sub { integer__array_ref__typetest0(2) },
        "/EIVAVRV01.*$OPS_TYPES/",
        q{TIVAVRV31 integer__array_ref__typetest0(2) throws correct exception}
    );
    throws_ok(    # TIVAVRV32
        sub {
            integer__array_ref__typetest0(
                [ 2, 2112, undef, 23, -877, -33, 1701 ] );
        },
        "/EIVAVRV02.*$OPS_TYPES/",
        q{TIVAVRV32 integer__array_ref__typetest0([2, 2112, undef, 23, -877, -33, 1701]) throws correct exception}
    );
    throws_ok(    # TIVAVRV33
        sub {
            integer__array_ref__typetest0(
                [ 2, 2112, 42, 'abcdefg', -877, -33, 1701 ] );
        },
        "/EIVAVRV03.*$OPS_TYPES/",
        q{TIVAVRV33 integer__array_ref__typetest0([2, 2112, 42, 'abcdefg', -877, -33, 1701]) throws correct exception}
    );
    lives_and(    # TIVAVRV34
        sub {
            is( integer__array_ref__typetest0(
                    [ 2, 2112, 42, 23, -877, -33, 1701 ]
                ),
                '[2, 2112, 42, 23, -877, -33, 1701]' . $OPS_TYPES,
                q{TIVAVRV34 integer__array_ref__typetest0([2, 2112, 42, 23, -877, -33, 1701]) returns correct value}
            );
        },
        q{TIVAVRV34 integer__array_ref__typetest0([2, 2112, 42, 23, -877, -33, 1701]) lives}
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
        "/(ENVAVRV00.*$OPS_TYPES)|(Usage.*number__array_ref__stringify)/", # DEV NOTE: 2 different error messages, RPerl & C
        q{TNVAVRV00 number__array_ref__stringify() throws correct exception}
    );
    throws_ok(    # TNVAVRV01
        sub { number__array_ref__stringify(undef) },
        "/ENVAVRV00.*$OPS_TYPES/",
        q{TNVAVRV01 number__array_ref__stringify(undef) throws correct exception}
    );
    throws_ok(    # TNVAVRV02
        sub { number__array_ref__stringify(2) },
        "/ENVAVRV01.*$OPS_TYPES/",
        q{TNVAVRV02 number__array_ref__stringify(2) throws correct exception}
    );
    throws_ok(    # TNVAVRV03
        sub { number__array_ref__stringify(2.3) },
        "/ENVAVRV01.*$OPS_TYPES/",
        q{TNVAVRV03 number__array_ref__stringify(2.3) throws correct exception}
    );
    throws_ok(    # TNVAVRV04
        sub { number__array_ref__stringify('2') },
        "/ENVAVRV01.*$OPS_TYPES/",
        q{TNVAVRV04 number__array_ref__stringify('2') throws correct exception}
    );
    throws_ok(    # TNVAVRV05
        sub { number__array_ref__stringify( { a_key => 23 } ) },
        "/ENVAVRV01.*$OPS_TYPES/",
        q{TNVAVRV05 number__array_ref__stringify({a_key => 23}) throws correct exception}
    );
    throws_ok(    # TNVAVRV10
        sub {
            number__array_ref__stringify(
                [ 2, 2112, undef, 23, -877, -33, 1701 ] );
        },
        "/ENVAVRV02.*$OPS_TYPES/",
        q{TNVAVRV10 number__array_ref__stringify([2, 2112, undef, 23, -877, -33, 1701]) throws correct exception}
    );
    throws_ok(    # TNVAVRV11
        sub {
            number__array_ref__stringify(
                [ 2, 2112, 42, '23', -877, -33, 1701 ] );
        },
        "/ENVAVRV03.*$OPS_TYPES/",
        q{TNVAVRV11 number__array_ref__stringify([2, 2112, 42, '23', -877, -33, 1701]) throws correct exception}
    );
    throws_ok(    # TNVAVRV12
        sub {
            number__array_ref__stringify(
                [ 2, 2112, 42, [23], -877, -33, 1701 ] );
        },
        "/ENVAVRV03.*$OPS_TYPES/",
        q{TNVAVRV12 number__array_ref__stringify([2, 2112, 42, [23], -877, -33, 1701]) throws correct exception}
    );
    throws_ok(    # TNVAVRV13
        sub {
            number__array_ref__stringify(
                [ 2, 2112, 42, { a_subkey => 23 }, -877, -33, 1701 ] );
        },
        "/ENVAVRV03.*$OPS_TYPES/",
        q{TNVAVRV13 number__array_ref__stringify([2, 2112, 42, {a_subkey => 23}, -877, -33, 1701]) throws correct exception}
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
                    [ 2, 2112, 42, 23, -877, -33, 1701 ]
                ),
                '[2, 2112, 42, 23, -877, -33, 1701]',
                q{TNVAVRV21 number__array_ref__stringify([2, 2112, 42, 23, -877, -33, 1701]) returns correct value}
            );
        },
        q{TNVAVRV21 number__array_ref__stringify([2, 2112, 42, 23, -877, -33, 1701]) lives}
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
                    [ 2.1, 2112.2, 42.3, 23, -877, -33, 1701 ]
                ),
                '[2.1, 2112.2, 42.3, 23, -877, -33, 1701]',
                q{TNVAVRV23 number__array_ref__stringify([2.1, 2112.2, 42.3, 23, -877, -33, 1701]) returns correct value}
            );
        },
        q{TNVAVRV23 number__array_ref__stringify([2.1, 2112.2, 42.3, 23, -877, -33, 1701]) lives}
    );
    lives_and(    # TNVAVRV24
        sub {
            is( number__array_ref__stringify(
                    [   2.1234432112344321, 2112.4321,
                        42.4567,            23.765444444444444444,
                        -877.5678,          -33.876587658765875687658765,
                        1701.6789
                    ]
                ),
                '[2.12344321123443, 2112.4321, 42.4567, 23.7654444444444, -877.5678, -33.8765876587659, 1701.6789]',
                q{TNVAVRV24 number__array_ref__stringify([2.1234432112344321, 2112.4321, ..., 1701.6789]) returns correct value}
            );
        },
        q{TNVAVRV24 number__array_ref__stringify([2.1234432112344321, 2112.4321, ..., 1701.6789]) lives}
    );
    throws_ok(    # TNVAVRV30
        sub { number__array_ref__typetest0() },
        "/(ENVAVRV00.*$OPS_TYPES)|(Usage.*number__array_ref__typetest0)/", # DEV NOTE: 2 different error messages, RPerl & C
        q{TNVAVRV30 number__array_ref__typetest0() throws correct exception}
    );
    throws_ok(    # TNVAVRV31
        sub { number__array_ref__typetest0(2) },
        "/ENVAVRV01.*$OPS_TYPES/",
        q{TNVAVRV31 number__array_ref__typetest0(2) throws correct exception}
    );
    throws_ok(    # TNVAVRV32
        sub {
            number__array_ref__typetest0(
                [   2.1234432112344321, 2112.4321,
                    undef,              23.765444444444444444,
                    -877.5678,          -33.876587658765875687658765,
                    1701.6789
                ]
            );
        },
        "/ENVAVRV02.*$OPS_TYPES/",
        q{TNVAVRV32 number__array_ref__typetest0([2.1234432112344321, 2112.4321, undef, 23.765444444444444444, ..., 1701.6789]) throws correct exception}
    );
    throws_ok(    # TNVAVRV33
        sub {
            number__array_ref__typetest0(
                [   2.1234432112344321,           2112.4321,
                    42.4567,                      23.765444444444444444,
                    -877.5678,                    'abcdefg',
                    -33.876587658765875687658765, 1701.6789
                ]
            );
        },
        "/ENVAVRV03.*$OPS_TYPES/",
        q{TNVAVRV33 number__array_ref__typetest0([2.1234432112344321, ..., 'abcdefg', -33.876587658765875687658765, 1701.6789]) throws correct exception}
    );
    lives_and(    # TNVAVRV34
        sub {
            is( number__array_ref__typetest0(
                    [   2.1234432112344321, 2112.4321,
                        42.4567,            23.765444444444444444,
                        -877.5678,          -33.876587658765875687658765,
                        1701.6789
                    ]
                ),
                '[2.12344321123443, 2112.4321, 42.4567, 23.7654444444444, -877.5678, -33.8765876587659, 1701.6789]'
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
        "/(EPVAVRV00.*$OPS_TYPES)|(Usage.*string__array_ref__stringify)/", # DEV NOTE: 2 different error messages, RPerl & C
        q{TPVAVRV00 string__array_ref__stringify() throws correct exception}
    );
    throws_ok(    # TPVAVRV01
        sub { string__array_ref__stringify(undef) },
        "/EPVAVRV00.*$OPS_TYPES/",
        q{TPVAVRV01 string__array_ref__stringify(undef) throws correct exception}
    );
    throws_ok(    # TPVAVRV02
        sub { string__array_ref__stringify(2) },
        "/EPVAVRV01.*$OPS_TYPES/",
        q{TPVAVRV02 string__array_ref__stringify(2) throws correct exception}
    );
    throws_ok(    # TPVAVRV03
        sub { string__array_ref__stringify(2.3) },
        "/EPVAVRV01.*$OPS_TYPES/",
        q{TPVAVRV03 string__array_ref__stringify(2.3) throws correct exception}
    );
    throws_ok(    # TPVAVRV04
        sub { string__array_ref__stringify('Lone Ranger') },
        "/EPVAVRV01.*$OPS_TYPES/",
        q{TPVAVRV04 string__array_ref__stringify('Lone Ranger') throws correct exception}
    );
    throws_ok(    # TPVAVRV05
        sub { string__array_ref__stringify( { a_key => 'Lone Ranger' } ) },
        "/EPVAVRV01.*$OPS_TYPES/",
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
        "/EPVAVRV02.*$OPS_TYPES/",
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
        "/EPVAVRV03.*$OPS_TYPES/",
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
        "/EPVAVRV03.*$OPS_TYPES/",
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
        "/EPVAVRV03.*$OPS_TYPES/",
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
        "/EPVAVRV03.*$OPS_TYPES/",
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
        "/(EPVAVRV00.*$OPS_TYPES)|(Usage.*string__array_ref__typetest0)/", # DEV NOTE: 2 different error messages, RPerl & C
        q{TPVAVRV30 string__array_ref__typetest0() throws correct exception}
    );
    throws_ok(    # TPVAVRV31
        sub { string__array_ref__typetest0(2) },
        "/EPVAVRV01.*$OPS_TYPES/",
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
        "/EPVAVRV02.*$OPS_TYPES/",
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
        "/EPVAVRV03.*$OPS_TYPES/",
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
