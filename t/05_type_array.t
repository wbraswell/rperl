#!/usr/bin/perl
use strict;
use warnings;
our $VERSION = 0.004_020;

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitStringySplit ProhibitInterpolationOfLiterals)  # DEVELOPER DEFAULT 2: allow string test values
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

use RPerl::Test;
use Test::More tests => 211;
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

# loop 3 times, once for each mode: PERLOPS_PERLTYPES, PERLOPS_CPPTYPES, CPPOPS_CPPTYPES
foreach my integer $mode_id ( sort keys %{$RPerl::MODES} ) {

#for my $mode_id ( 1 .. 1 ) {  # TEMPORARY DEBUGGING CPPOPS_PERLTYPES ONLY
#    RPerl::diag "in 05_type_array.t, top of for() loop, have \$mode_id = $mode_id\n";
    my scalartype_hashref $mode = $RPerl::MODES->{$mode_id};
    if ( $ENV{TEST_VERBOSE} ) {
        Test::More::diag( '[[[ Beginning RPerl Array Type Tests, '
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
            sub { require_ok('RPerl::DataStructure::Array'); },
            q{require_ok('RPerl::DataStructure::Array') lives}
        );
    }
    else {
        if ( $types eq 'CPP' ) {

            # force reload
            delete $main::{'RPerl__DataStructure__Array__MODE_ID'};
        }

        # C++ use, load, link
        lives_and(
            sub { require_ok('RPerl::DataStructure::Array_cpp'); },
            q{require_ok('RPerl::DataStructure::Array_cpp') lives}
        );
        lives_ok(
            sub { RPerl::DataStructure::Array_cpp::cpp_load(); },
            q{RPerl::DataStructure::Array_cpp::cpp_load() lives}
        );
    }

    foreach my string $type (qw(DataType__Integer DataType__Number DataType__String DataStructure__Array)) {
        lives_and(
            sub {
                is( $RPerl::MODES->{ main->can(
                            'RPerl__' . $type . '__MODE_ID'
                        )->()
                        }->{ops},
                    $ops,
                    'main::RPerl__'
                        . $type
                        . '__MODE_ID() ops returns '
                        . $ops
                );
            },
            'main::RPerl__' . $type . '__MODE_ID() lives'
        );
    }

    # [[[ INTEGER ARRAY TESTS ]]]
    # [[[ INTEGER ARRAY TESTS ]]]
    # [[[ INTEGER ARRAY TESTS ]]]

    throws_ok(    # TIVAVRV00
        sub { integer_arrayref_to_string() },
        "/(EIVAVRV00.*$mode_tagline)|(Usage.*integer_arrayref_to_string)/", # DEV NOTE: 2 different error messages, RPerl & C
        q{TIVAVRV00 integer_arrayref_to_string() throws correct exception}
    );
    throws_ok(    # TIVAVRV01
        sub { integer_arrayref_to_string(undef) },
        "/EIVAVRV00.*$mode_tagline/",
        q{TIVAVRV01 integer_arrayref_to_string(undef) throws correct exception}
    );
    throws_ok(    # TIVAVRV02
        sub { integer_arrayref_to_string(2) },
        "/EIVAVRV01.*$mode_tagline/",
        q{TIVAVRV02 integer_arrayref_to_string(2) throws correct exception}
    );
    throws_ok(    # TIVAVRV03
        sub { integer_arrayref_to_string(2.3) },
        "/EIVAVRV01.*$mode_tagline/",
        q{TIVAVRV03 integer_arrayref_to_string(2.3) throws correct exception}
    );
    throws_ok(    # TIVAVRV04
        sub { integer_arrayref_to_string('2') },
        "/EIVAVRV01.*$mode_tagline/",
        q{TIVAVRV04 integer_arrayref_to_string('2') throws correct exception}
    );
    throws_ok(    # TIVAVRV05
        sub { integer_arrayref_to_string( { a_key => 23 } ) },
        "/EIVAVRV01.*$mode_tagline/",
        q{TIVAVRV05 integer_arrayref_to_string({a_key => 23}) throws correct exception}
    );
    throws_ok(    # TIVAVRV10
        sub {
            integer_arrayref_to_string(
                [ 2, 2112, undef, 23, -877, -33, 1701 ] );
        },
        "/EIVAVRV02.*$mode_tagline/",
        q{TIVAVRV10 integer_arrayref_to_string([2, 2112, undef, 23, -877, -33, 1701]) throws correct exception}
    );
    throws_ok(    # TIVAVRV11
        sub {
            integer_arrayref_to_string(
                [ 2, 2112, 42, 23.3, -877, -33, 1701 ] );
        },
        "/EIVAVRV03.*$mode_tagline/",
        q{TIVAVRV11 integer_arrayref_to_string([2, 2112, 42, 23.3, -877, -33, 1701]) throws correct exception}
    );
    throws_ok(    # TIVAVRV12
        sub {
            integer_arrayref_to_string(
                [ 2, 2112, 42, '23', -877, -33, 1701 ] );
        },
        "/EIVAVRV03.*$mode_tagline/",
        q{TIVAVRV12 integer_arrayref_to_string([2, 2112, 42, '23', -877, -33, 1701]) throws correct exception}
    );
    throws_ok(    # TIVAVRV13
        sub {
            integer_arrayref_to_string(
                [ 2, 2112, 42, [23], -877, -33, 1701 ] );
        },
        "/EIVAVRV03.*$mode_tagline/",
        q{TIVAVRV13 integer_arrayref_to_string([2, 2112, 42, [23], -877, -33, 1701]) throws correct exception}
    );
    throws_ok(    # TIVAVRV14
        sub {
            integer_arrayref_to_string(
                [ 2, 2112, 42, { a_subkey => 23 }, -877, -33, 1701 ] );
        },
        "/EIVAVRV03.*$mode_tagline/",
        q{TIVAVRV14 integer_arrayref_to_string([2, 2112, 42, {a_subkey => 23}, -877, -33, 1701]) throws correct exception}
    );
    lives_and(    # TIVAVRV20
        sub {
            is( integer_arrayref_to_string( [23] ),
                '[23]',
                q{TIVAVRV20 integer_arrayref_to_string([23]) returns correct value}
            );
        },
        q{TIVAVRV20 integer_arrayref_to_string([23]) lives}
    );
    lives_and(    # TIVAVRV21
        sub {
            is( integer_arrayref_to_string(
                    [ 2, 2112, 42, 23, -877, -33, 1701 ]
                ),
                '[2, 2112, 42, 23, -877, -33, 1701]',
                q{TIVAVRV21 integer_arrayref_to_string([2, 2112, 42, 23, -877, -33, 1701]) returns correct value}
            );
        },
        q{TIVAVRV21 integer_arrayref_to_string([2, 2112, 42, 23, -877, -33, 1701]) lives}
    );
    throws_ok(    # TIVAVRV30
        sub { integer_arrayref__typetest0() },
        "/(EIVAVRV00.*$mode_tagline)|(Usage.*integer_arrayref__typetest0)/", # DEV NOTE: 2 different error messages, RPerl & C
        q{TIVAVRV30 integer_arrayref__typetest0() throws correct exception}
    );
    throws_ok(    # TIVAVRV31
        sub { integer_arrayref__typetest0(2) },
        "/EIVAVRV01.*$mode_tagline/",
        q{TIVAVRV31 integer_arrayref__typetest0(2) throws correct exception}
    );
    throws_ok(    # TIVAVRV32
        sub {
            integer_arrayref__typetest0(
                [ 2, 2112, undef, 23, -877, -33, 1701 ] );
        },
        "/EIVAVRV02.*$mode_tagline/",
        q{TIVAVRV32 integer_arrayref__typetest0([2, 2112, undef, 23, -877, -33, 1701]) throws correct exception}
    );
    throws_ok(    # TIVAVRV33
        sub {
            integer_arrayref__typetest0(
                [ 2, 2112, 42, 'abcdefg', -877, -33, 1701 ] );
        },
        "/EIVAVRV03.*$mode_tagline/",
        q{TIVAVRV33 integer_arrayref__typetest0([2, 2112, 42, 'abcdefg', -877, -33, 1701]) throws correct exception}
    );
    lives_and(    # TIVAVRV34
        sub {
            is( integer_arrayref__typetest0(
                    [ 2, 2112, 42, 23, -877, -33, 1701 ]
                ),
                '[2, 2112, 42, 23, -877, -33, 1701]' . $mode_tagline,
                q{TIVAVRV34 integer_arrayref__typetest0([2, 2112, 42, 23, -877, -33, 1701]) returns correct value}
            );
        },
        q{TIVAVRV34 integer_arrayref__typetest0([2, 2112, 42, 23, -877, -33, 1701]) lives}
    );
    lives_and(    # TIVAVRV40
        sub {
            is_deeply(
                integer_arrayref__typetest1(5),
                [ 0, 5, 10, 15, 20 ],
                q{TIVAVRV40 integer_arrayref__typetest1(5) returns correct value}
            );
        },
        q{TIVAVRV40 integer_arrayref__typetest1(5) lives}
    );

    # [[[ NUMBER ARRAY TESTS ]]]
    # [[[ NUMBER ARRAY TESTS ]]]
    # [[[ NUMBER ARRAY TESTS ]]]

    throws_ok(    # TNVAVRV00
        sub { number_arrayref_to_string() },
        "/(ENVAVRV00.*$mode_tagline)|(Usage.*number_arrayref_to_string)/", # DEV NOTE: 2 different error messages, RPerl & C
        q{TNVAVRV00 number_arrayref_to_string() throws correct exception}
    );
    throws_ok(    # TNVAVRV01
        sub { number_arrayref_to_string(undef) },
        "/ENVAVRV00.*$mode_tagline/",
        q{TNVAVRV01 number_arrayref_to_string(undef) throws correct exception}
    );
    throws_ok(    # TNVAVRV02
        sub { number_arrayref_to_string(2) },
        "/ENVAVRV01.*$mode_tagline/",
        q{TNVAVRV02 number_arrayref_to_string(2) throws correct exception}
    );
    throws_ok(    # TNVAVRV03
        sub { number_arrayref_to_string(2.3) },
        "/ENVAVRV01.*$mode_tagline/",
        q{TNVAVRV03 number_arrayref_to_string(2.3) throws correct exception}
    );
    throws_ok(    # TNVAVRV04
        sub { number_arrayref_to_string('2') },
        "/ENVAVRV01.*$mode_tagline/",
        q{TNVAVRV04 number_arrayref_to_string('2') throws correct exception}
    );
    throws_ok(    # TNVAVRV05
        sub { number_arrayref_to_string( { a_key => 23 } ) },
        "/ENVAVRV01.*$mode_tagline/",
        q{TNVAVRV05 number_arrayref_to_string({a_key => 23}) throws correct exception}
    );
    throws_ok(    # TNVAVRV10
        sub {
            number_arrayref_to_string(
                [ 2, 2112, undef, 23, -877, -33, 1701 ] );
        },
        "/ENVAVRV02.*$mode_tagline/",
        q{TNVAVRV10 number_arrayref_to_string([2, 2112, undef, 23, -877, -33, 1701]) throws correct exception}
    );
    throws_ok(    # TNVAVRV11
        sub {
            number_arrayref_to_string(
                [ 2, 2112, 42, '23', -877, -33, 1701 ] );
        },
        "/ENVAVRV03.*$mode_tagline/",
        q{TNVAVRV11 number_arrayref_to_string([2, 2112, 42, '23', -877, -33, 1701]) throws correct exception}
    );
    throws_ok(    # TNVAVRV12
        sub {
            number_arrayref_to_string(
                [ 2, 2112, 42, [23], -877, -33, 1701 ] );
        },
        "/ENVAVRV03.*$mode_tagline/",
        q{TNVAVRV12 number_arrayref_to_string([2, 2112, 42, [23], -877, -33, 1701]) throws correct exception}
    );
    throws_ok(    # TNVAVRV13
        sub {
            number_arrayref_to_string(
                [ 2, 2112, 42, { a_subkey => 23 }, -877, -33, 1701 ] );
        },
        "/ENVAVRV03.*$mode_tagline/",
        q{TNVAVRV13 number_arrayref_to_string([2, 2112, 42, {a_subkey => 23}, -877, -33, 1701]) throws correct exception}
    );
    lives_and(    # TNVAVRV20
        sub {
            is( number_arrayref_to_string( [23] ),
                '[23]',
                q{TNVAVRV20 number_arrayref_to_string([23]) returns correct value}
            );
        },
        q{TNVAVRV20 number_arrayref_to_string([23]) lives}
    );
    lives_and(    # TNVAVRV21
        sub {
            is( number_arrayref_to_string(
                    [ 2, 2112, 42, 23, -877, -33, 1701 ]
                ),
                '[2, 2112, 42, 23, -877, -33, 1701]',
                q{TNVAVRV21 number_arrayref_to_string([2, 2112, 42, 23, -877, -33, 1701]) returns correct value}
            );
        },
        q{TNVAVRV21 number_arrayref_to_string([2, 2112, 42, 23, -877, -33, 1701]) lives}
    );
    lives_and(    # TNVAVRV22
        sub {
            is( number_arrayref_to_string( [23.2] ),
                '[23.2]',
                q{TNVAVRV22 number_arrayref_to_string([23.2]) returns correct value}
            );
        },
        q{TNVAVRV22 number_arrayref_to_string([23.2]) lives}
    );
    lives_and(    # TNVAVRV23
        sub {
            is( number_arrayref_to_string(
                    [ 2.1, 2112.2, 42.3, 23, -877, -33, 1701 ]
                ),
                '[2.1, 2112.2, 42.3, 23, -877, -33, 1701]',
                q{TNVAVRV23 number_arrayref_to_string([2.1, 2112.2, 42.3, 23, -877, -33, 1701]) returns correct value}
            );
        },
        q{TNVAVRV23 number_arrayref_to_string([2.1, 2112.2, 42.3, 23, -877, -33, 1701]) lives}
    );
    lives_and(    # TNVAVRV24
        sub {
            is( number_arrayref_to_string(
                    [   2.1234432112344321, 2112.4321,
                        42.4567,            23.765444444444444444,
                        -877.5678,          -33.876587658765875687658765,
                        1701.6789
                    ]
                ),
                '[2.12344321123443, 2112.4321, 42.4567, 23.7654444444444, -877.5678, -33.8765876587659, 1701.6789]',
                q{TNVAVRV24 number_arrayref_to_string([2.1234432112344321, 2112.4321, ..., 1701.6789]) returns correct value}
            );
        },
        q{TNVAVRV24 number_arrayref_to_string([2.1234432112344321, 2112.4321, ..., 1701.6789]) lives}
    );
    throws_ok(    # TNVAVRV30
        sub { number_arrayref__typetest0() },
        "/(ENVAVRV00.*$mode_tagline)|(Usage.*number_arrayref__typetest0)/", # DEV NOTE: 2 different error messages, RPerl & C
        q{TNVAVRV30 number_arrayref__typetest0() throws correct exception}
    );
    throws_ok(    # TNVAVRV31
        sub { number_arrayref__typetest0(2) },
        "/ENVAVRV01.*$mode_tagline/",
        q{TNVAVRV31 number_arrayref__typetest0(2) throws correct exception}
    );
    throws_ok(    # TNVAVRV32
        sub {
            number_arrayref__typetest0(
                [   2.1234432112344321, 2112.4321,
                    undef,              23.765444444444444444,
                    -877.5678,          -33.876587658765875687658765,
                    1701.6789
                ]
            );
        },
        "/ENVAVRV02.*$mode_tagline/",
        q{TNVAVRV32 number_arrayref__typetest0([2.1234432112344321, 2112.4321, undef, 23.765444444444444444, ..., 1701.6789]) throws correct exception}
    );
    throws_ok(    # TNVAVRV33
        sub {
            number_arrayref__typetest0(
                [   2.1234432112344321,           2112.4321,
                    42.4567,                      23.765444444444444444,
                    -877.5678,                    'abcdefg',
                    -33.876587658765875687658765, 1701.6789
                ]
            );
        },
        "/ENVAVRV03.*$mode_tagline/",
        q{TNVAVRV33 number_arrayref__typetest0([2.1234432112344321, ..., 'abcdefg', -33.876587658765875687658765, 1701.6789]) throws correct exception}
    );
    lives_and(    # TNVAVRV34
        sub {
            is( number_arrayref__typetest0(
                    [   2.1234432112344321, 2112.4321,
                        42.4567,            23.765444444444444444,
                        -877.5678,          -33.876587658765875687658765,
                        1701.6789
                    ]
                ),
                '[2.12344321123443, 2112.4321, 42.4567, 23.7654444444444, -877.5678, -33.8765876587659, 1701.6789]'
                    . $mode_tagline,
                q{TNVAVRV34 number_arrayref__typetest0([2.1234432112344321, 2112.4321, ..., 1701.6789]) returns correct value}
            );
        },
        q{TNVAVRV34 number_arrayref__typetest0([2.1234432112344321, 2112.4321, ..., 1701.6789]) lives}
    );
    lives_and(    # TNVAVRV40
        sub {
            is_deeply(
                number_arrayref__typetest1(5),
                [ 0, 5.123456789, 10.246913578, 15.370370367, 20.493827156 ]
                ,    ## PERLTIDY BUG comma on newline
                q{TNVAVRV40 number_arrayref__typetest1(5) returns correct value}
            );
        },
        q{TNVAVRV40 number_arrayref__typetest1(5) lives}
    );

    # [[[ STRING ARRAY TESTS ]]]
    # [[[ STRING ARRAY TESTS ]]]
    # [[[ STRING ARRAY TESTS ]]]

    throws_ok(    # TPVAVRV00
        sub { string_arrayref_to_string() },
        "/(EPVAVRV00.*$mode_tagline)|(Usage.*string_arrayref_to_string)/", # DEV NOTE: 2 different error messages, RPerl & C
        q{TPVAVRV00 string_arrayref_to_string() throws correct exception}
    );
    throws_ok(    # TPVAVRV01
        sub { string_arrayref_to_string(undef) },
        "/EPVAVRV00.*$mode_tagline/",
        q{TPVAVRV01 string_arrayref_to_string(undef) throws correct exception}
    );
    throws_ok(    # TPVAVRV02
        sub { string_arrayref_to_string(2) },
        "/EPVAVRV01.*$mode_tagline/",
        q{TPVAVRV02 string_arrayref_to_string(2) throws correct exception}
    );
    throws_ok(    # TPVAVRV03
        sub { string_arrayref_to_string(2.3) },
        "/EPVAVRV01.*$mode_tagline/",
        q{TPVAVRV03 string_arrayref_to_string(2.3) throws correct exception}
    );
    throws_ok(    # TPVAVRV04
        sub { string_arrayref_to_string('Lone Ranger') },
        "/EPVAVRV01.*$mode_tagline/",
        q{TPVAVRV04 string_arrayref_to_string('Lone Ranger') throws correct exception}
    );
    throws_ok(    # TPVAVRV05
        sub { string_arrayref_to_string( { a_key => 'Lone Ranger' } ) },
        "/EPVAVRV01.*$mode_tagline/",
        q{TPVAVRV05 string_arrayref_to_string({a_key => 'Lone Ranger'}) throws correct exception}
    );
    throws_ok(    # TPVAVRV10
        sub {
            string_arrayref_to_string(
                [   'Superman',      'Batman',
                    'Wonder Woman',  undef,
                    'Green Lantern', 'Aquaman',
                    'Martian Manhunter'
                ]
            );
        },
        "/EPVAVRV02.*$mode_tagline/",
        q{TPVAVRV10 string_arrayref_to_string(['Superman', 'Batman', 'Wonder Woman', undef, 'Green Lantern', 'Aquaman', 'Martian Manhunter']) throws correct exception}
    );
    throws_ok(    # TPVAVRV11
        sub {
            string_arrayref_to_string(
                [   'Superman',      'Batman',
                    23,              'Flash',
                    'Green Lantern', 'Aquaman',
                    'Martian Manhunter'
                ]
            );
        },
        "/EPVAVRV03.*$mode_tagline/",
        q{TPVAVRV11 string_arrayref_to_string(['Superman', 'Batman', 23, 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter']) throws correct exception}
    );
    throws_ok(    # TPVAVRV12
        sub {
            string_arrayref_to_string(
                [   'Superman',      'Batman',
                    23.2,            'Flash',
                    'Green Lantern', 'Aquaman',
                    'Martian Manhunter'
                ]
            );
        },
        "/EPVAVRV03.*$mode_tagline/",
        q{TPVAVRV12 string_arrayref_to_string(['Superman', 'Batman', 23.2, 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter']) throws correct exception}
    );
    throws_ok(    # TPVAVRV13
        sub {
            string_arrayref_to_string(
                [   'Superman',       'Batman',
                    ['Wonder Woman'], 'Flash',
                    'Green Lantern',  'Aquaman',
                    'Martian Manhunter'
                ]
            );
        },
        "/EPVAVRV03.*$mode_tagline/",
        q{TPVAVRV13 string_arrayref_to_string(['Superman', 'Batman', ['Wonder Woman'], 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter']) throws correct exception}
    );
    throws_ok(    # TPVAVRV14
        sub {
            string_arrayref_to_string(
                [   'Superman', 'Batman',
                    { a_subkey => 'Wonder Woman' }, 'Flash',
                    'Green Lantern', 'Aquaman',
                    'Martian Manhunter'
                ]
            );
        },
        "/EPVAVRV03.*$mode_tagline/",
        q{TPVAVRV14 string_arrayref_to_string(['Superman', 'Batman', {a_subkey => 'Wonder Woman'}, ..., 'Martian Manhunter']) throws correct exception}
    );
    lives_and(    # TPVAVRV20
        sub {
            is( string_arrayref_to_string(
                    [   'Howard The Duck', 'Superman',
                        'Batman',          'Wonder Woman',
                        'Flash',           'Green Lantern',
                        'Aquaman',         'Martian Manhunter'
                    ]
                ),
                q{['Howard The Duck', 'Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter']},
                q{TPVAVRV20 string_arrayref_to_string(['Howard The Duck', 'Superman', 'Batman', 'Wonder Woman', ..., 'Martian Manhunter']) returns correct value}
            );
        },
        q{TPVAVRV20 string_arrayref_to_string(['Howard The Duck', 'Superman', 'Batman', 'Wonder Woman', ..., 'Martian Manhunter']) lives}
    );
    lives_and(    # TPVAVRV21
        sub {
            is( string_arrayref_to_string(
                    [ 'Superman', 'Martian Manhunter', 'undef' ]
                ),
                q{['Superman', 'Martian Manhunter', 'undef']},
                q{TPVAVRV21 string_arrayref_to_string(['Superman', 'Martian Manhunter', 'undef']) returns correct value}
            );
        },
        q{TPVAVRV21 string_arrayref_to_string(['Superman', 'Martian Manhunter', 'undef']) lives}
    );
    lives_and(    # TPVAVRV22
        sub {
            is( string_arrayref_to_string(
                    [ 'Superman', 'Martian Manhunter', '23' ]
                ),
                q{['Superman', 'Martian Manhunter', '23']},
                q{TPVAVRV22 string_arrayref_to_string(['Superman', 'Martian Manhunter', '23']) returns correct value}
            );
        },
        q{TPVAVRV22 string_arrayref_to_string(['Superman', 'Martian Manhunter', '23']) lives}
    );
    lives_and(    # TPVAVRV23
        sub {
            is( string_arrayref_to_string(
                    [ 'Superman', 'Martian Manhunter', '-2112.23' ]
                ),
                q{['Superman', 'Martian Manhunter', '-2112.23']},
                q{TPVAVRV23 string_arrayref_to_string(['Superman', 'Martian Manhunter', '-2112.23']) returns correct value}
            );
        },
        q{TPVAVRV23 string_arrayref_to_string(['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter', '-2112.23']) lives}
    );
    lives_and(    # TPVAVRV24
        sub {
            is( string_arrayref_to_string(
                    [ 'Superman', 'Martian Manhunter', "[\\'Tonto'\\]" ]
                ),
                q{['Superman', 'Martian Manhunter', '[\\\\\'Tonto\'\\\\]']},
                q{TPVAVRV24 string_arrayref_to_string(['Superman', 'Martian Manhunter', "[\\'Tonto'\\]"]) returns correct value}
            );
        },
        q{TPVAVRV24 string_arrayref_to_string(['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', "Martian Manhunter", "-2112.23"]) lives}
    );
    lives_and(    # TPVAVRV25
        sub {
            is( string_arrayref_to_string(
                    [ 'Superman', 'Martian Manhunter', '{buzz => 5}' ]
                ),
                q{['Superman', 'Martian Manhunter', '{buzz => 5}']},
                q{TPVAVRV25 string_arrayref_to_string(['Superman', 'Martian Manhunter', '{buzz => 5}']) returns correct value}
            );
        },
        q{TPVAVRV25 string_arrayref_to_string(['Superman', 'Martian Manhunter', '{buzz => 5}']) lives}
    );
    throws_ok(    # TPVAVRV30
        sub { string_arrayref__typetest0() },
        "/(EPVAVRV00.*$mode_tagline)|(Usage.*string_arrayref__typetest0)/", # DEV NOTE: 2 different error messages, RPerl & C
        q{TPVAVRV30 string_arrayref__typetest0() throws correct exception}
    );
    throws_ok(    # TPVAVRV31
        sub { string_arrayref__typetest0(2) },
        "/EPVAVRV01.*$mode_tagline/",
        q{TPVAVRV31 string_arrayref__typetest0(2) throws correct exception}
    );
    throws_ok(    # TPVAVRV32
        sub {
            string_arrayref__typetest0(
                [   'Superman',      'Batman',
                    'Wonder Woman',  undef,
                    'Green Lantern', 'Aquaman',
                    'Martian Manhunter'
                ]
            );
        },
        "/EPVAVRV02.*$mode_tagline/",
        q{TPVAVRV32 string_arrayref__typetest0(['Superman', 'Batman', 'Wonder Woman', undef, 'Green Lantern', 'Aquaman', 'Martian Manhunter']) throws correct exception}
    );
    throws_ok(    # TPVAVRV33
        sub {
            string_arrayref__typetest0(
                [   'Superman',      'Batman',
                    'Wonder Woman',  'Flash',
                    'Green Lantern', 'Aquaman',
                    'Martian Manhunter', [ 23, -42.3 ]
                ]
            );
        },
        "/EPVAVRV03.*$mode_tagline/",
        q{TPVAVRV33 string_arrayref__typetest0(['Superman', 'Batman', 'Wonder Woman', ..., 'Martian Manhunter', [23, -42.3]]) throws correct exception}
    );
    lives_and(    # TPVAVRV34
        sub {
            is( string_arrayref__typetest0(
                    [   'Superman',      'Batman',
                        'Wonder Woman',  'Flash',
                        'Green Lantern', 'Aquaman',
                        'Martian Manhunter'
                    ]
                ),
                q{['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter']}
                    . $mode_tagline,
                q{TPVAVRV34 string_arrayref__typetest0(['Superman', ..., 'Green Lantern', 'Aquaman', 'Martian Manhunter']) returns correct value}
            );
        },
        q{TPVAVRV34 string_arrayref__typetest0(['Superman', ..., 'Green Lantern', 'Aquaman', 'Martian Manhunter']) lives}
    );
    lives_and(    # TPVAVRV40
        sub {
            is_deeply(
                string_arrayref__typetest1(5),
                [   'Jeffy Ten! 0/4 ' . $mode_tagline,
                    'Jeffy Ten! 1/4 ' . $mode_tagline,
                    'Jeffy Ten! 2/4 ' . $mode_tagline,
                    'Jeffy Ten! 3/4 ' . $mode_tagline,
                    'Jeffy Ten! 4/4 ' . $mode_tagline,
                ],
                q{TPVAVRV40 string_arrayref__typetest1(5) returns correct value}
            );
        },
        q{TPVAVRV40 string_arrayref__typetest1(5) lives}
    );
}

done_testing();
