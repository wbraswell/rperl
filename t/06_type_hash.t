#!/usr/bin/perl

# [[[ PRE-HEADER ]]]
# suppress 'WEXRP00: Found multiple rperl executables' due to blib/ & pre-existing installation(s)
BEGIN { $ENV{RPERL_WARNINGS} = 0; }

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.007_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitStringySplit ProhibitInterpolationOfLiterals)  # DEVELOPER DEFAULT 2: allow string test values
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use RPerl::Test;
use Test::More tests => 247;
use Test::Exception;
use Test::Number::Delta;
use RPerl::DataStructure::Hash::SubTypes qw(integer_hashref__typetest0 integer_hashref__typetest1 number_hashref__typetest0 number_hashref__typetest1 string_hashref__typetest0 string_hashref__typetest1);

# [[[ OPERATIONS ]]]

BEGIN {
    if ( $ENV{RPERL_VERBOSE} ) {
        Test::More::diag('[[[ Beginning Hash Type Pre-Test Loading, RPerl Type System ]]]');
    }
    lives_and( sub { use_ok('RPerl::AfterSubclass'); }, q{use_ok('RPerl::AfterSubclass') lives} );
    lives_and( sub { use_ok('RPerl::DataStructure::Hash_cpp'); }, q{use_ok('RPerl::DataStructure::Hash_cpp') lives} );
}

# [[[ PRIMARY RUNLOOP ]]]
# [[[ PRIMARY RUNLOOP ]]]
# [[[ PRIMARY RUNLOOP ]]]

# loop 3 times, once for each mode: PERLOPS_PERLTYPES, PERLOPS_CPPTYPES, CPPOPS_CPPTYPES
foreach my integer $mode_id ( sort keys %{$RPerl::MODES} ) {

    #for my $mode_id ( 1 .. 1 ) {  # TEMPORARY DEBUGGING CPPOPS_PERLTYPES ONLY

    # [[[ MODE SETUP ]]]
    #    RPerl::diag("in 06_type_hash.t, top of for() loop, have \$mode_id = $mode_id\n");
    my scalartype_hashref $mode = $RPerl::MODES->{$mode_id};
    my $ops                     = $mode->{ops};
    my $types                   = $mode->{types};
    my string $mode_tagline     = $ops . 'OPS_' . $types . 'TYPES';
    if ( $ENV{RPERL_VERBOSE} ) {
        Test::More::diag( '[[[ Beginning RPerl Hash Type Tests, ' . $ops . ' Operations & ' . $types . ' Data Types' . ' ]]]' );
    }

    lives_ok( sub { rperltypes::types_enable($types) }, q{mode '} . $ops . ' Operations & ' . $types . ' Data Types' . q{' enabled} );

    if ( $ops eq 'PERL' ) {
        lives_and( sub { use_ok('RPerl::DataStructure::Hash'); }, q{use_ok('RPerl::DataStructure::Hash') lives} );
    }
    else {
        if ( $types eq 'CPP' ) {

            # force reload
            delete $main::{'RPerl__DataStructure__Hash__MODE_ID'};
        }

        # C++ use, load, link
        lives_and( sub { require_ok('RPerl::DataStructure::Hash_cpp'); }, q{require_ok('RPerl::DataStructure::Hash_cpp') lives} );
        lives_ok( sub { RPerl::DataStructure::Hash_cpp::cpp_load(); }, q{RPerl::DataStructure::Hash_cpp::cpp_load() lives} );
    }

    foreach my string $type (qw(DataType__Integer DataType__Number DataType__String DataStructure__Hash)) {
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

    # [[[ INTEGER HASH TESTS ]]]
    # [[[ INTEGER HASH TESTS ]]]
    # [[[ INTEGER HASH TESTS ]]]

    throws_ok(    # TIVHVRV00
        sub { integer_hashref_to_string() },
        "/(EIVHVRV00.*$mode_tagline)|(Usage.*integer_hashref_to_string)/",    # DEV NOTE: 2 different error messages, RPerl & C
        q{TIVHVRV00 integer_hashref_to_string() throws correct exception}
    );
    throws_ok(                                                                # TIVHVRV01
        sub { integer_hashref_to_string(undef) },
        "/EIVHVRV00.*$mode_tagline/",
        q{TIVHVRV01 integer_hashref_to_string(undef) throws correct exception}
    );
    throws_ok(                                                                # TIVHVRV02
        sub { integer_hashref_to_string(2) },
        "/EIVHVRV01.*$mode_tagline/",
        q{TIVHVRV02 integer_hashref_to_string(2) throws correct exception}
    );
    throws_ok(                                                                # TIVHVRV03
        sub { integer_hashref_to_string(2.3) },
        "/EIVHVRV01.*$mode_tagline/",
        q{TIVHVRV03 integer_hashref_to_string(2.3) throws correct exception}
    );
    throws_ok(                                                                # TIVHVRV04
        sub { integer_hashref_to_string('2') },
        "/EIVHVRV01.*$mode_tagline/",
        q{TIVHVRV04 integer_hashref_to_string('2') throws correct exception}
    );
    throws_ok(                                                                # TIVHVRV05
        sub { integer_hashref_to_string( [2] ) },
        "/EIVHVRV01.*$mode_tagline/",
        q{TIVHVRV05 integer_hashref_to_string([2]) throws correct exception}
    );
    throws_ok(                                                                # TIVHVRV10
        sub {
            integer_hashref_to_string(
                {   a_key => 2,
                    b_key => 2_112,
                    c_key => undef,
                    d_key => 23,
                    e_key => -877,
                    f_key => -33,
                    g_key => 1_701
                }
            );
        },
        "/EIVHVRV02.*$mode_tagline/",
        q{TIVHVRV10 integer_hashref_to_string({a_key => 2, b_key => 2_112, c_key => undef, d_key => 23, e_key => -877, f_key => -33, g_key => 1_701}) throws correct exception}
    );
    throws_ok(    # TIVHVRV11
        sub {
            integer_hashref_to_string(
                {   a_key => 2,
                    b_key => 2_112,
                    c_key => 42,
                    d_key => 23.3,
                    e_key => -877,
                    f_key => -33,
                    g_key => 1_701
                }
            );
        },
        "/EIVHVRV03.*$mode_tagline/",
        q{TIVHVRV11 integer_hashref_to_string({a_key => 2, b_key => 2_112, c_key => 42, d_key => 23.3, e_key => -877, f_key => -33, g_key => 1_701}) throws correct exception}
    );
    throws_ok(    # TIVHVRV12
        sub {
            integer_hashref_to_string(
                {   a_key => 2,
                    b_key => 2_112,
                    c_key => 42,
                    d_key => '23',
                    e_key => -877,
                    f_key => -33,
                    g_key => 1_701
                }
            );
        },
        "/EIVHVRV03.*$mode_tagline/",
        q{TIVHVRV12 integer_hashref_to_string({a_key => 2, b_key => 2_112, c_key => 42, d_key => '23', e_key => -877, f_key => -33, g_key => 1_701}) throws correct exception}
    );
    throws_ok(    # TIVHVRV13
        sub {
            integer_hashref_to_string(
                {   a_key => 2,
                    b_key => 2_112,
                    c_key => 42,
                    d_key => [23],
                    e_key => -877,
                    f_key => -33,
                    g_key => 1_701
                }
            );
        },
        "/EIVHVRV03.*$mode_tagline/",
        q{TIVHVRV13 integer_hashref_to_string({a_key => 2, b_key => 2_112, c_key => 42, d_key => [23], e_key => -877, f_key => -33, g_key => 1_701}) throws correct exception}
    );
    throws_ok(    # TIVHVRV14
        sub {
            integer_hashref_to_string(
                {   a_key => 2,
                    b_key => 2_112,
                    c_key => 42,
                    d_key => { a_subkey => 23 },
                    e_key => -877,
                    f_key => -33,
                    g_key => 1_701
                }
            );
        },
        "/EIVHVRV03.*$mode_tagline/",

#        q{TIVHVRV14 integer_hashref_to_string({a_key => 2, b_key => 2_112, c_key => 42, d_key => {a_subkey => 23}, e_key => -877, f_key => -33, g_key => 1_701}) throws correct exception}
        q{TIVHVRV14 integer_hashref_to_string({a_key => 2, b_key => 2_112, c_key => 42, d_key => {a_subkey => 23}, ..., g_key => 1_701}) throws correct exception}
    );
    lives_and(    # TIVHVRV20
        sub {
            is( integer_hashref_to_string( { a_key => 23 } ), q{{'a_key' => 23}}, q{TIVHVRV20 integer_hashref_to_string({a_key => 23}) returns correct value} );
        },
        q{TIVHVRV20 integer_hashref_to_string({a_key => 23}) lives}
    );
    lives_and(    # TIVHVRV21
        sub {
            like(
                integer_hashref_to_string(
                    {   a_key => 2,
                        b_key => 2_112,
                        c_key => 42,
                        d_key => 23,
                        e_key => -877,
                        f_key => -33,
                        g_key => 1_701
                    }
                ),

             # NEED FIX: replace ".*" near end of this & following regexes with syntax to match exactly 6 occurrences of ", "; (,\s)* and variations don't work?
                q{/^\{(?=.*'a_key' => 2\b)(?=.*'b_key' => 2_112\b)(?=.*'c_key' => 42\b)(?=.*'d_key' => 23\b)(?=.*'e_key' => -877\b)(?=.*'f_key' => -33\b)(?=.*'g_key' => 1_701\b).*\}$/m},
                q{TIVHVRV21 integer_hashref_to_string({a_key => 2, b_key => 2_112, c_key => 42, d_key => 23, e_key => -877, f_key => -33, g_key => 1_701}) returns correct value}
            );
        },
        q{TIVHVRV21 integer_hashref_to_string({a_key => 2, b_key => 2_112, c_key => 42, d_key => 23, e_key => -877, f_key => -33, g_key => 1_701}) lives}
    );
    throws_ok(    # TIVHVRV30
        sub { integer_hashref__typetest0() },
        "/(EIVHVRV00.*$mode_tagline)|(Usage.*integer_hashref__typetest0)/",    # DEV NOTE: 2 different error messages, RPerl & C
        q{TIVHVRV30 integer_hashref__typetest0() throws correct exception}
    );
    throws_ok(                                                                 # TIVHVRV31
        sub { integer_hashref__typetest0(2) },
        "/EIVHVRV01.*$mode_tagline/",
        q{TIVHVRV31 integer_hashref__typetest0(2) throws correct exception}
    );
    throws_ok(                                                                 # TIVHVRV32
        sub {
            integer_hashref__typetest0(
                {   'binary'       => 2,
                    'rush'         => 2_112,
                    'ERROR_FUNKEY' => undef,
                    'answer'       => 42,
                    'fnord'        => 23,
                    'units'        => -877,
                    'degree'       => -33,
                    'ncc'          => 1_701
                }
            );
        },
        "/EIVHVRV02.*$mode_tagline/",
        q{TIVHVRV32 integer_hashref__typetest0({'binary' => 2, 'rush' => 2_112, 'ERROR_FUNKEY' => undef, ..., 'ncc' => 1_701}) throws correct exception}
    );
    throws_ok(    # TIVHVRV33
        sub {
            integer_hashref__typetest0(
                {   'binary'       => 2,
                    'rush'         => 2_112,
                    'ERROR_FUNKEY' => 'abcdefg',
                    'answer'       => 42,
                    'fnord'        => 23,
                    'units'        => -877,
                    'degree'       => -33,
                    'ncc'          => 1_701
                }
            );
        },
        "/EIVHVRV03.*$mode_tagline/",
        q{TIVHVRV33 integer_hashref__typetest0({'binary' => 2, 'rush' => 2_112, 'ERROR_FUNKEY' => 'abcdefg', ..., 'ncc' => 1_701}) throws correct exception}
    );
    lives_and(    # TIVHVRV34
        sub {
            like(
                integer_hashref__typetest0(
                    {   'binary' => 2,
                        'rush'   => 2_112,
                        'answer' => 42,
                        'fnord'  => 23,
                        'units'  => -877,
                        'degree' => -33,
                        'ncc'    => 1_701
                    }
                ),
                q{/^\{(?=.*'binary' => 2\b)(?=.*'rush' => 2_112\b)(?=.*'answer' => 42\b)(?=.*'fnord' => 23\b)(?=.*'units' => -877\b)(?=.*'degree' => -33\b)(?=.*'ncc' => 1_701\b).*\}}
                    . $mode_tagline . q{$/m},

#                q{TIVHVRV34 integer_hashref__typetest0({'binary' => 2, 'rush' => 2_112, 'answer' => 42, 'fnord' => 23, 'units' => -877, 'degree' => -33, 'ncc' => 1_701}) returns correct value}
                q{TIVHVRV34 integer_hashref__typetest0({'binary' => 2, 'rush' => 2_112, ..., 'ncc' => 1_701}) returns correct value}
            );
        },
        q{TIVHVRV34 integer_hashref__typetest0({'binary' => 2, 'rush' => 2_112, ..., 'ncc' => 1_701}) lives}
    );
    lives_and(    # TIVHVRV40
        sub {
            is_deeply(
                integer_hashref__typetest1(5),
                {   "$mode_tagline\_funkey2" => 10,
                    "$mode_tagline\_funkey3" => 15,
                    "$mode_tagline\_funkey4" => 20,
                    "$mode_tagline\_funkey1" => 5,
                    "$mode_tagline\_funkey0" => 0
                },
                q{TIVHVRV40 integer_hashref__typetest1(5) returns correct value}
            );
        },
        q{TIVHVRV40 integer_hashref__typetest1(5) lives}
    );

    # [[[ NUMBER HASH TESTS ]]]
    # [[[ NUMBER HASH TESTS ]]]
    # [[[ NUMBER HASH TESTS ]]]

    throws_ok(    # TNVHVRV00
        sub { number_hashref_to_string() },
        "/(ENVHVRV00.*$mode_tagline)|(Usage.*number_hashref_to_string)/",    # DEV NOTE: 2 different error messages, RPerl & C
        q{TNVHVRV00 number_hashref_to_string() throws correct exception}
    );
    throws_ok(                                                               # TNVHVRV01
        sub { number_hashref_to_string(undef) },
        "/ENVHVRV00.*$mode_tagline/",
        q{TNVHVRV01 number_hashref_to_string(undef) throws correct exception}
    );
    throws_ok(                                                               # TNVHVRV02
        sub { number_hashref_to_string(2) },
        "/ENVHVRV01.*$mode_tagline/",
        q{TNVHVRV02 number_hashref_to_string(2) throws correct exception}
    );
    throws_ok(                                                               # TNVHVRV03
        sub { number_hashref_to_string(2.3) },
        "/ENVHVRV01.*$mode_tagline/",
        q{TNVHVRV03 number_hashref_to_string(2.3) throws correct exception}
    );
    throws_ok(                                                               # TNVHVRV04
        sub { number_hashref_to_string('2') },
        "/ENVHVRV01.*$mode_tagline/",
        q{TNVHVRV04 number_hashref_to_string('2') throws correct exception}
    );
    throws_ok(                                                               # TNVHVRV05
        sub { number_hashref_to_string( [2] ) },
        "/ENVHVRV01.*$mode_tagline/",
        q{TNVHVRV05 number_hashref_to_string([2]) throws correct exception}
    );
    throws_ok(                                                               # TNVHVRV10
        sub {
            number_hashref_to_string(
                {   a_key => 2,
                    b_key => 2_112,
                    c_key => undef,
                    d_key => 23,
                    e_key => -877,
                    f_key => -33,
                    g_key => 1_701
                }
            );
        },
        "/ENVHVRV02.*$mode_tagline/",
        q{TNVHVRV10 number_hashref_to_string({a_key => 2, b_key => 2_112, c_key => undef, d_key => 23, e_key => -877, f_key => -33, g_key => 1_701}) throws correct exception}
    );
    throws_ok(    # TNVHVRV11
        sub {
            number_hashref_to_string(
                {   a_key => 2,
                    b_key => 2_112,
                    c_key => 42.3,
                    d_key => '23',
                    e_key => -877,
                    f_key => -33,
                    g_key => 1_701
                }
            );
        },
        "/ENVHVRV03.*$mode_tagline/",
        q{TNVHVRV11 number_hashref_to_string({a_key => 2, b_key => 2_112, c_key => 42.3, d_key => '23', e_key => -877, f_key => -33, g_key => 1_701}) throws correct exception}
    );
    throws_ok(    # TNVHVRV12
        sub {
            number_hashref_to_string(
                {   a_key => 2,
                    b_key => 2_112,
                    c_key => 42.3,
                    d_key => [23],
                    e_key => -877,
                    f_key => -33,
                    g_key => 1_701
                }
            );
        },
        "/ENVHVRV03.*$mode_tagline/",
        q{TNVHVRV12 number_hashref_to_string({a_key => 2, b_key => 2_112, c_key => 42.3, d_key => [23], e_key => -877, f_key => -33, g_key => 1_701}) throws correct exception}
    );
    throws_ok(    # TNVHVRV13
        sub {
            number_hashref_to_string(
                {   a_key => 2,
                    b_key => 2_112,
                    c_key => 42.3,
                    d_key => { a_subkey => 23 },
                    e_key => -877,
                    f_key => -33,
                    g_key => 1_701
                }
            );
        },
        "/ENVHVRV03.*$mode_tagline/",

#        q{TNVHVRV13 number_hashref_to_string({a_key => 2, b_key => 2_112, c_key => 42.3, d_key => {a_subkey => 23}, e_key => -877, f_key => -33, g_key => 1_701}) throws correct exception}
        q{TNVHVRV13 number_hashref_to_string({a_key => 2, b_key => 2_112, c_key => 42.3, d_key => {a_subkey => 23}, ..., g_key => 1_701}) throws correct exception}
    );
    lives_and(    # TNVHVRV20
        sub {
            is( number_hashref_to_string( { a_key => 23 } ), q{{'a_key' => 23}}, q{TNVHVRV20 number_hashref_to_string({a_key => 23}) returns correct value} );
        },
        q{TNVHVRV20 number_hashref_to_string({a_key => 23}) lives}
    );
    lives_and(    # TNVHVRV21
        sub {
            like(
                number_hashref_to_string(
                    {   a_key => 2,
                        b_key => 2_112,
                        c_key => 42,
                        d_key => 23,
                        e_key => -877,
                        f_key => -33,
                        g_key => 1_701
                    }
                ),

                q{/^\{(?=.*'a_key' => 2\b)(?=.*'b_key' => 2_112\b)(?=.*'c_key' => 42\b)(?=.*'d_key' => 23\b)(?=.*'e_key' => -877\b)(?=.*'f_key' => -33\b)(?=.*'g_key' => 1_701\b).*\}$/m},
                q{TNVHVRV21 number_hashref_to_string({a_key => 2, b_key => 2_112, c_key => 42, d_key => 23, e_key => -877, f_key => -33, g_key => 1_701}) returns correct value}
            );
        },
        q{TNVHVRV21 number_hashref_to_string({a_key => 2, b_key => 2_112, c_key => 42, d_key => 23, e_key => -877, f_key => -33, g_key => 1_701}) lives}
    );
    lives_and(    # TNVHVRV22
        sub {
            like(
                number_hashref_to_string( { a_key => 2.123_443_211_234_432_1 } ),
                qr/\{'a_key' => 2\.123_443_211_234/,
                q{TNVHVRV22 number_hashref_to_string({a_key => 2.123_443_211_234_432_1}) returns correct value}
            );
        },
        q{TNVHVRV22 number_hashref_to_string({a_key => 2.123_443_211_234_432_1}) lives}
    );
    lives_and(    # TNVHVRV23
        sub {
            like(
                number_hashref_to_string(
                    {   a_key => 2.123_443_211_234_432_1,
                        b_key => 2_112.432_1,
                        c_key => 42.456_7,
                        d_key => 23.765_444_444_444_444_444,
                        e_key => -877.567_8,
                        f_key => -33.876_587_658_765_875_687_658_765,
                        g_key => 1_701.678_9
                    }
                ),

# NEED DELETE OLD CODE
#                q{/^\{(?=.*'a_key' => 2\.123_443_211_234_4\b)(?=.*'b_key' => 2_112\.432_1\b)(?=.*'c_key' => 42\.456_7\b)(?=.*'d_key' => 23\.765_444_444_444\b)(?=.*'e_key' => -877\.5_678\b)(?=.*'f_key' => -33\.876_587_658_765\b)(?=.*'g_key' => 1_701\.6_789\b).*\}$/m},
                q{/^\{(?=.*'a_key' => 2\.123_443_211_234)(?=.*'b_key' => 2_112\.432_1)(?=.*'c_key' => 42\.456_7)(?=.*'d_key' => 23\.765_444_444_44)(?=.*'e_key' => -877\.567_8)(?=.*'f_key' => -33\.876_587_658_76)(?=.*'g_key' => 1_701\.678_9).*\}$/m},

#                q{TNVHVRV23 number_hashref_to_string(a_key => 2.123_443_211_234_432_1, b_key => 2_112.432_1, c_key => 42.456_7, d_key => 23.765_444_444_444_444_444, e_key => -877.567_8, f_key => -33.876_587_658_765_875_687_658_765, g_key => 1_701.678_9) returns correct value}
                q{TNVHVRV23 number_hashref_to_string(a_key => 2.123_443_211_234_432_1, b_key => 2_112.432_1, c_key => 42.456_7, ..., g_key => 1_701.678_9) returns correct value}
            );
        },
        q{TNVHVRV23 number_hashref_to_string(a_key => 2.123_443_211_234_432_1, b_key => 2_112.432_1, c_key => 42.456_7, d_key => 23.765_444_444_444_444_444, e_key => -877.567_8, f_key => -33.876_587_658_765_875_687_658_765, g_key => 1_701.678_9) lives}
    );
    throws_ok(    # TNVHVRV30
        sub { number_hashref__typetest0() },
        "/(ENVHVRV00.*$mode_tagline)|(Usage.*number_hashref__typetest0)/",    # DEV NOTE: 2 different error messages, RPerl & C
        q{TNVHVRV30 number_hashref__typetest0() throws correct exception}
    );
    throws_ok(                                                                # TNVHVRV31
        sub { number_hashref__typetest0(2) },
        "/ENVHVRV01.*$mode_tagline/",
        q{TNVHVRV31 number_hashref__typetest0(2) throws correct exception}
    );
    throws_ok(                                                                # TNVHVRV32
        sub {
            number_hashref__typetest0(
                {   'binary'       => 2.123_443_211_234_432_1,
                    'rush'         => 2_112.432_1,
                    'ERROR_FUNKEY' => undef,
                    'answer'       => 42.456_7,
                    'fnord'        => 23.765_444_444_444_444_444,
                    'units'        => -877.567_8,
                    'degree'       => -33.876_587_658_765_875_687_658_765,
                    'ncc'          => 1_701.678_9
                }
            );
        },
        "/ENVHVRV02.*$mode_tagline/",
        q{TNVHVRV32 number_hashref__typetest0({'binary' => 2.123_443_211_234_432_1, 'ERROR_FUNKEY' => undef, ..., 'ncc' => 1_701.678_9}) throws correct exception}
    );
    throws_ok(    # TNVHVRV33
        sub {
            number_hashref__typetest0(
                {   'binary'       => 2.123_443_211_234_432_1,
                    'rush'         => 2_112.432_1,
                    'ERROR_FUNKEY' => 'abcdefg',
                    'answer'       => 42.456_7,
                    'fnord'        => 23.765_444_444_444_444_444,
                    'units'        => -877.567_8,
                    'degree'       => -33.876_587_658_765_875_687_658_765,
                    'ncc'          => 1_701.678_9
                }
            );
        },
        "/ENVHVRV03.*$mode_tagline/",
        q{TNVHVRV33 number_hashref__typetest0({'binary' => 2.123_443_211_234_432_1, 'ERROR_FUNKEY' => 'abcdefg', ..., 'ncc' => 1_701.678_9}) throws correct exception}
    );
    lives_and(    # TNVHVRV34
        sub {
            like(
                number_hashref__typetest0(
                    {   'binary' => 2.123_443_211_234_432_1,
                        'rush'   => 2_112.432_1,
                        'answer' => 42.456_7,
                        'fnord'  => 23.765_444_444_444_444_444,
                        'units'  => -877.567_8,
                        'degree' => -33.876_587_658_765_875_687_658_765,
                        'ncc'    => 1_701.678_9
                    }
                ),

# NEED DELETE OLD CODE
#                q{/^\{(?=.*'binary' => 2\.123_443_211_234_43\b)(?=.*'rush' => 2_112\.432_1\b)(?=.*'answer' => 42\.456_7\b)(?=.*'fnord' => 23\.765_444_444_444_4\b)(?=.*'units' => -877\.567_8\b)(?=.*'degree' => -33\.8765876587659\b)(?=.*'ncc' => 1_701\.678_9\b).*\}}
                q{/^\{(?=.*'binary' => 2\.123_443_211_234)(?=.*'rush' => 2_112\.432_1)(?=.*'answer' => 42\.456_7)(?=.*'fnord' => 23\.765_444_444_44)(?=.*'units' => -877\.567_8)(?=.*'degree' => -33\.876_587_658_76)(?=.*'ncc' => 1_701\.678_9).*\}}
                    . $mode_tagline . q{$/m},
                q{TNVHVRV34 number_hashref__typetest0({'binary' => 2.123_443_211_234_432_1, 'rush' => 2_112.432_1, ..., 'ncc' => 1_701.678_9}) returns correct value}
            );
        },
        q{TNVHVRV34 number_hashref__typetest0({'binary' => 2.123_443_211_234_432_1, 'rush' => 2_112.432_1, ..., 'ncc' => 1_701.678_9}) lives}
    );
    lives_and(    # TNVHVRV40
        sub {
            # NEED DELETE OLD CODE
            #            is_deeply(
            #                number_hashref__typetest1(5),
            #                {   "$mode_tagline\_funkey2" => 10.246_913_578,
            #                    "$mode_tagline\_funkey3" => 15.370_370_367,
            #                    "$mode_tagline\_funkey4" => 20.493_827_156,
            #                    "$mode_tagline\_funkey1" => 5.123_456_789,
            #                    "$mode_tagline\_funkey0" => 0
            #                },
            #                q{TNVHVRV40 number_hashref__typetest1(5) returns correct value}
            #            );

            my number_hashref $tmp_retval    = number_hashref__typetest1(5);
            my number_hashref $correct_retval = {
                "$mode_tagline\_funkey2" => 10.246_913_578,
                "$mode_tagline\_funkey3" => 15.370_370_367,
                "$mode_tagline\_funkey4" => 20.493_827_156,
                "$mode_tagline\_funkey1" => 5.123_456_789,
                "$mode_tagline\_funkey0" => 0
            };
            foreach my string $correct_retval_key ( keys %{$correct_retval} ) {
                ok( ( ( exists $tmp_retval->{$correct_retval_key} ) and ( defined $tmp_retval->{$correct_retval_key} ) ),
                    q{TNVHVRV40a number_hashref__typetest1(5) returns defined value, at key } . $correct_retval_key
                );
                delta_ok(
                    $correct_retval->{$correct_retval_key},
                    $tmp_retval->{$correct_retval_key},
                    q{TNVHVRV40b number_hashref__typetest1(5) returns correct value, at key } . $correct_retval_key
                );
            }
        },
        q{TNVHVRV40 number_hashref__typetest1(5) lives}
    );

    # [[[ STRING HASH TESTS ]]]
    # [[[ STRING HASH TESTS ]]]
    # [[[ STRING HASH TESTS ]]]

    throws_ok(    # TPVHVRV00
        sub { string_hashref_to_string() },
        "/(EPVHVRV00.*$mode_tagline)|(Usage.*string_hashref_to_string)/",    # DEV NOTE: 2 different error messages, RPerl & C
        q{TPVHVRV00 string_hashref_to_string() throws correct exception}
    );
    throws_ok(                                                               # TPVHVRV01
        sub { string_hashref_to_string(undef) },
        "/EPVHVRV00.*$mode_tagline/",
        q{TPVHVRV01 string_hashref_to_string(undef) throws correct exception}
    );
    throws_ok(                                                               # TPVHVRV02
        sub { string_hashref_to_string(2) },
        "/EPVHVRV01.*$mode_tagline/",
        q{TPVHVRV02 string_hashref_to_string(2) throws correct exception}
    );
    throws_ok(                                                               # TPVHVRV03
        sub { string_hashref_to_string(2.3) },
        "/EPVHVRV01.*$mode_tagline/",
        q{TPVHVRV03 string_hashref_to_string(2.3) throws correct exception}
    );
    throws_ok(                                                               # TPVHVRV04
        sub { string_hashref_to_string('Lone Ranger') },
        "/EPVHVRV01.*$mode_tagline/",
        q{TPVHVRV04 string_hashref_to_string('Lone Ranger') throws correct exception}
    );
    throws_ok(                                                               # TPVHVRV05
        sub { string_hashref_to_string( ['Lone Ranger'] ) },
        "/EPVHVRV01.*$mode_tagline/",
        q{TPVHVRV05 string_hashref_to_string(['Lone Ranger']) throws correct exception}
    );
    throws_ok(                                                               # TPVHVRV10
        sub {
            string_hashref_to_string(
                {   'kryptonian_manofsteel_clarkkent'  => 'Superman',
                    'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter',
                    'UNDEF_NOT_STRING'                 => undef
                }
            );
        },
        "/EPVHVRV02.*$mode_tagline/",
        q{TPVHVRV10 string_hashref_to_string({'kryptonian_manofsteel_clarkkent' => 'Superman', ..., 'UNDEF_NOT_STRING' => undef}) throws correct exception}
    );
    throws_ok(                                                               # TPVHVRV11
        sub {
            string_hashref_to_string(
                {   'kryptonian_manofsteel_clarkkent'  => 'Superman',
                    'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter',
                    'INTEGER_NOT_STRING'               => 23
                }
            );
        },
        "/EPVHVRV03.*$mode_tagline/",
        q{TPVHVRV11 string_hashref_to_string({'kryptonian_manofsteel_clarkkent' => 'Superman', ..., 'INTEGER_NOT_STRING' => 23}) throws correct exception}
    );
    throws_ok(                                                               # TPVHVRV12
        sub {
            string_hashref_to_string(
                {   'kryptonian_manofsteel_clarkkent'  => 'Superman',
                    'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter',
                    'NUMBER_NOT_STRING'                => -2_112.23
                }
            );
        },
        "/EPVHVRV03.*$mode_tagline/",
        q{TPVHVRV12 string_hashref_to_string({'kryptonian_manofsteel_clarkkent' => 'Superman', ..., 'NUMBER_NOT_STRING' => -2_112.23}) throws correct exception}
    );
    throws_ok(                                                               # TPVHVRV13
        sub {
            string_hashref_to_string(
                {   'kryptonian_manofsteel_clarkkent'  => 'Superman',
                    'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter',
                    'ARRAY_NOT_STRING'                 => ['Tonto']
                }
            );
        },
        "/EPVHVRV03.*$mode_tagline/",
        q{TPVHVRV13 string_hashref_to_string({'kryptonian_manofsteel_clarkkent' => 'Superman', ..., 'ARRAY_NOT_STRING' => ['Tonto']}) throws correct exception}
    );
    throws_ok(                                                               # TPVHVRV14
        sub {
            string_hashref_to_string(
                {   'kryptonian_manofsteel_clarkkent'  => 'Superman',
                    'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter',
                    'HASH_NOT_STRING'                  => { fizz => 3 }
                }
            );
        },
        "/EPVHVRV03.*$mode_tagline/",
        q{TPVHVRV14 string_hashref_to_string({'kryptonian_manofsteel_clarkkent' => 'Superman', ..., 'HASH_NOT_STRING' => {fizz => 3}}) throws correct exception}
    );
    lives_and(                                                               # TPVHVRV20
        sub {
            like(
                string_hashref_to_string(
                    {   'stuckinaworldhenevercreated'                => 'Howard The Duck',
                        'kryptonian_manofsteel_clarkkent'            => 'Superman',
                        'gothamite_darkknight_brucewayne'            => 'Batman',
                        'amazonian_dianathemyscira_dianaprince'      => 'Wonder Woman',
                        'scarletspeedster_barryallenetal'            => 'Flash',
                        'alanscottetal'                              => 'Green Lantern',
                        'atlanteanhybrid_aquaticace_arthurcurryorin' => 'Aquaman',
                        'greenmartian_bloodwynd_jonnjonnz'           => 'Martian Manhunter'
                    }
                ),
                q{/^\{(?=.*'stuckinaworldhenevercreated' => 'Howard The Duck')(?=.*'kryptonian_manofsteel_clarkkent' => 'Superman')(?=.*'gothamite_darkknight_brucewayne' => 'Batman')(?=.*'amazonian_dianathemyscira_dianaprince' => 'Wonder Woman')(?=.*'scarletspeedster_barryallenetal' => 'Flash')(?=.*'alanscottetal' => 'Green Lantern')(?=.*'atlanteanhybrid_aquaticace_arthurcurryorin' => 'Aquaman')(?=.*'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter').*\}$/m}
                ,    ## PERLTIDY BUG comma on newline
                q{TPVHVRV20 string_hashref_to_string({'stuckinaworldhenevercreated' => 'Howard The Duck', 'kryptonian_manofsteel_clarkkent' => 'Superman', ...}) returns correct value}
            );
        },
        q{TPVHVRV20 string_hashref_to_string({'stuckinaworldhenevercreated' => 'Howard The Duck', 'kryptonian_manofsteel_clarkkent' => 'Superman', ...}) lives}
    );
    lives_and(       # TPVHVRV21
        sub {
            like(
                string_hashref_to_string(
                    {   'kryptonian_manofsteel_clarkkent'  => 'Superman',
                        'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter',
                        'STRING_NOT_UNDEF'                 => 'undef'
                    }
                ),
                q{/^\{(?=.*'kryptonian_manofsteel_clarkkent' => 'Superman')(?=.*'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter')(?=.*'STRING_NOT_UNDEF' => 'undef').*\}$/m}
                ,    ## PERLTIDY BUG comma on newline
                q{TPVHVRV21 string_hashref_to_string({'kryptonian_manofsteel_clarkkent' => 'Superman', ..., 'STRING_NOT_UNDEF' => 'undef'}) returns correct value}
            );
        },
        q{TPVHVRV21 string_hashref_to_string({'kryptonian_manofsteel_clarkkent' => 'Superman', ..., 'STRING_NOT_UNDEF' => 'undef'}) lives}
    );
    lives_and(       # TPVHVRV22
        sub {
            like(
                string_hashref_to_string(
                    {   'kryptonian_manofsteel_clarkkent'  => 'Superman',
                        'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter',
                        'STRING_NOT_INTEGER'               => '23'
                    }
                ),
                q{/^\{(?=.*'kryptonian_manofsteel_clarkkent' => 'Superman')(?=.*'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter')(?=.*'STRING_NOT_INTEGER' => '23').*\}$/m}
                ,    ## PERLTIDY BUG comma on newline
                q{TPVHVRV22 string_hashref_to_string({'kryptonian_manofsteel_clarkkent' => 'Superman', ..., 'STRING_NOT_INTEGER' => '23'}) returns correct value}
            );
        },
        q{TPVHVRV22 string_hashref_to_string({'kryptonian_manofsteel_clarkkent' => 'Superman', ..., 'STRING_NOT_INTEGER' => '23'}) lives}
    );
    lives_and(       # TPVHVRV23
        sub {
            like(
                string_hashref_to_string(
                    {   'kryptonian_manofsteel_clarkkent'  => 'Superman',
                        'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter',
                        'STRING_NOT_NUMBER'                => '-2_112.23'
                    }
                ),
                q{/^\{(?=.*'kryptonian_manofsteel_clarkkent' => 'Superman')(?=.*'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter')(?=.*'STRING_NOT_NUMBER' => '-2_112.23').*\}$/m}
                ,    ## PERLTIDY BUG comma on newline
                q{TPVHVRV23 string_hashref_to_string({'kryptonian_manofsteel_clarkkent' => 'Superman', ..., 'STRING_NOT_NUMBER' => '-2_112.23'}) returns correct value}
            );
        },
        q{TPVHVRV23 string_hashref_to_string({'kryptonian_manofsteel_clarkkent' => 'Superman', ..., 'STRING_NOT_NUMBER' => '-2_112.23'}) lives}
    );
    lives_and(       # TPVHVRV24
        sub {
            like(
                string_hashref_to_string(
                    {   'kryptonian_manofsteel_clarkkent'  => 'Superman',
                        'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter',
                        "STRING_NOT_ARRAY"                 => "[Tonto]"
                    }
                ),
                q{/^\{(?=.*'kryptonian_manofsteel_clarkkent' => 'Superman')(?=.*'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter')(?=.*'STRING_NOT_ARRAY' => '\[Tonto\]').*\}$/m}
                ,    ## PERLTIDY BUG comma on newline
                q{TPVHVRV24 string_hashref_to_string({'kryptonian_manofsteel_clarkkent' => 'Superman', ..., "STRING_NOT_ARRAY" => "[Tonto]"}) returns correct value}
            );
        },
        q{TPVHVRV24 string_hashref_to_string({'kryptonian_manofsteel_clarkkent' => 'Superman', ..., "STRING_NOT_ARRAY" => "[Tonto]"}) lives}
    );
    lives_and(       # TPVHVRV25
        sub {
            like(
                string_hashref_to_string(
                    {   'kryptonian_manofsteel_clarkkent'  => 'Superman',
                        'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter',
                        "STRING_NOT_HASH"                  => "{buzz => 5}"
                    }
                ),

   # DEV NOTE: must surround single-q-quote below with square brackets instead of curly braces, so that the backslash-escaped curly braces inside the string
   # will stay backslash-escaped as they are passed to the regex, to fix Perl v5.22 error 'Unescaped left brace in regex is deprecated, passed through in regex'
                q[/^\{(?=.*'kryptonian_manofsteel_clarkkent' => 'Superman')(?=.*'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter')(?=.*'STRING_NOT_HASH' => '\{buzz => 5\}').*\}$/m]
                ,    ## PERLTIDY BUG comma on newline
                q{TPVHVRV25 string_hashref_to_string({'kryptonian_manofsteel_clarkkent' => 'Superman', ..., "STRING_NOT_HASH" => "{buzz => 5}"}) returns correct value}
            );
        },
        q{TPVHVRV25 string_hashref_to_string({'kryptonian_manofsteel_clarkkent' => 'Superman', ..., "STRING_NOT_HASH" => "{buzz => 5}"}) lives}
    );
    throws_ok(       # TPVHVRV30
        sub { string_hashref__typetest0() },
        "/(EPVHVRV00.*$mode_tagline)|(Usage.*string_hashref__typetest0)/",    # DEV NOTE: 2 different error messages, RPerl & C
        q{TPVHVRV30 string_hashref__typetest0() throws correct exception}
    );
    throws_ok(                                                                # TPVHVRV31
        sub { string_hashref__typetest0(2) },
        "/EPVHVRV01.*$mode_tagline/",
        q{TPVHVRV31 string_hashref__typetest0(2) throws correct exception}
    );
    throws_ok(                                                                # TPVHVRV32
        sub {
            string_hashref__typetest0(
                {   'kryptonian_manofsteel_clarkkent'            => 'Superman',
                    'gothamite_darkknight_brucewayne'            => 'Batman',
                    'amazonian_dianathemyscira_dianaprince'      => 'Wonder Woman',
                    'scarletspeedster_barryallenetal'            => 'Flash',
                    'alanscottetal'                              => 'Green Lantern',
                    'atlanteanhybrid_aquaticace_arthurcurryorin' => 'Aquaman',
                    'greenmartian_bloodwynd_jonnjonnz'           => 'Martian Manhunter',
                    'UNDEF_NOT_STRING'                           => undef
                }
            );
        },
        "/EPVHVRV02.*$mode_tagline/",
        q{TPVHVRV32 string_hashref__typetest0({'kryptonian_manofsteel_clarkkent' => 'Superman', ..., 'UNDEF_NOT_STRING' => undef}) throws correct exception}
    );
    throws_ok(    # TPVHVRV33
        sub {
            string_hashref__typetest0(
                {   'kryptonian_manofsteel_clarkkent'            => 'Superman',
                    'gothamite_darkknight_brucewayne'            => 'Batman',
                    'amazonian_dianathemyscira_dianaprince'      => 'Wonder Woman',
                    'scarletspeedster_barryallenetal'            => 'Flash',
                    'alanscottetal'                              => 'Green Lantern',
                    'atlanteanhybrid_aquaticace_arthurcurryorin' => 'Aquaman',
                    'greenmartian_bloodwynd_jonnjonnz'           => 'Martian Manhunter',
                    'ARRAY_NOT_STRING'                           => [ 23, -42.3 ]
                }
            );
        },
        "/EPVHVRV03.*$mode_tagline/",
        q{TPVHVRV33 string_hashref__typetest0({'kryptonian_manofsteel_clarkkent' => 'Superman', ..., 'ARRAY_NOT_STRING' => [23, -42.3]}) throws correct exception}
    );
    lives_and(    # TPVHVRV34
        sub {
            like(
                string_hashref__typetest0(
                    {   'stuckinaworldhenevercreated'                => 'Howard The Duck',
                        'atlanteanhybrid_aquaticace_arthurcurryorin' => 'Aquaman',
                        'greenmartian_bloodwynd_jonnjonnz'           => 'Martian Manhunter'
                    }
                ),
                q{/^\{(?=.*'stuckinaworldhenevercreated' => 'Howard The Duck')(?=.*'atlanteanhybrid_aquaticace_arthurcurryorin' => 'Aquaman')(?=.*'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter').*\}}
                    . $mode_tagline . q{$/m},
                q{TPVHVRV34 string_hashref__typetest0({'stuckinaworldhenevercreated' => 'Howard The Duck', ...}) returns correct value}
            );
        },
        q{TPVHVRV34 string_hashref__typetest0({'stuckinaworldhenevercreated' => 'Howard The Duck', ...}) lives}
    );
    lives_and(    # TPVHVRV40
        sub {
            is_deeply(
                string_hashref__typetest1(5),
                {   "$mode_tagline\_Luker_key3" => 'Jeffy Ten! 3/4',
                    "$mode_tagline\_Luker_key2" => 'Jeffy Ten! 2/4',
                    "$mode_tagline\_Luker_key1" => 'Jeffy Ten! 1/4',
                    "$mode_tagline\_Luker_key4" => 'Jeffy Ten! 4/4',
                    "$mode_tagline\_Luker_key0" => 'Jeffy Ten! 0/4'
                },
                q{TPVHVRV40 string_hashref__typetest1(5) returns correct value}
            );
        },
        q{TPVHVRV40 string_hashref__typetest1(5) lives}
    );
}

done_testing();
