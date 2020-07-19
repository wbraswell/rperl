#!/usr/bin/env perl

# [[[ PRE-HEADER ]]]
# suppress 'WEXRP00: Found multiple rperl executables' due to blib/ & pre-existing installation(s)
BEGIN { $ENV{RPERL_WARNINGS} = 0; }

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.013_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitStringySplit ProhibitInterpolationOfLiterals)  # DEVELOPER DEFAULT 2: allow string test values
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use RPerl::Test;
use Test::More tests => 490;
#use Test::More tests => xyz;  # TMP DEBUG PERLOPS_PERLTYPES & CPPOPS_PERLTYPES
#use Test::More tests => xyz;  # TMP DEBUG, ONE MODE ONLY
use Test::Exception;
use Test::Number::Delta;
use Time::HiRes qw(usleep);

use RPerl::DataStructure::Array::SubTypes1D qw(integer_arrayref_typetest0 integer_arrayref_typetest1 number_arrayref_typetest0 number_arrayref_typetest1 string_arrayref_typetest0 string_arrayref_typetest1);

# [[[ OPERATIONS ]]]

BEGIN {
    if ( $ENV{RPERL_VERBOSE} ) {
        Test::More::diag('[[[ Beginning Array Type Pre-Test Loading, RPerl Type System ]]]');
    }
    lives_and( sub { use_ok('RPerl::AfterSubclass'); }, q{use_ok('RPerl::AfterSubclass') lives} );
    lives_and( sub { use_ok('RPerl::DataStructure::Array_cpp'); }, q{use_ok('RPerl::DataStructure::Array_cpp') lives} );
}

# [[[ PRIMARY RUNLOOP ]]]
# [[[ PRIMARY RUNLOOP ]]]
# [[[ PRIMARY RUNLOOP ]]]

# loop 3 times, once for each mode: PERLOPS_PERLTYPES, PERLOPS_CPPTYPES, CPPOPS_CPPTYPES
foreach my integer $mode_id ( sort keys %{$RPerl::MODES} ) {
#for my $mode_id ( 0 .. 0 ) {  # TMP DEBUG, PERLOPS_PERLTYPES ONLY
#for my $mode_id ( 1 .. 1 ) {  # TMP DEBUG, CPPOPS_PERLTYPES ONLY
#for my $mode_id ( 0 .. 1 ) {  # TMP DEBUG, PERLOPS_PERLTYPES & CPPOPS_PERLTYPES
#for my $mode_id ( 2 .. 2 ) {  # TMP DEBUG, CPPOPS_CPPTYPES ONLY

    # [[[ MODE SETUP ]]]
    #    RPerl::diag("in 05_type_array.t, top of for() loop, have \$mode_id = $mode_id\n");
    my scalartype_hashref $mode = $RPerl::MODES->{$mode_id};
    my $ops                 = $mode->{ops};
    my $types               = $mode->{types};
    my string $mode_tagline = $ops . 'OPS_' . $types . 'TYPES';
    if ( $ENV{RPERL_VERBOSE} ) {
        Test::More::diag( '[[[ Beginning RPerl Array Type Tests, ' . $ops . ' Operations & ' . $types . ' Data Types' . ' ]]]' );
    }

    lives_ok( sub { rperltypes::types_enable($types) }, q{mode '} . $ops . ' Operations & ' . $types . ' Data Types' . q{' enabled} );

    if ( $ops eq 'PERL' ) {
        lives_and( sub { use_ok('RPerl::DataStructure::Array'); }, q{use_ok('RPerl::DataStructure::Array') lives} );
    }
    else {
        if ( $types eq 'CPP' ) {

            # force reload
            delete $main::{'RPerl__DataStructure__Array__MODE_ID'};
        }

        # C++ use, load, link
        lives_and( sub { require_ok('RPerl::DataStructure::Array_cpp'); }, q{require_ok('RPerl::DataStructure::Array_cpp') lives} );
        lives_ok( sub { RPerl::DataStructure::Array_cpp::cpp_load(); }, q{RPerl::DataStructure::Array_cpp::cpp_load() lives} );
    }

    foreach my string $type (qw(DataType__Integer DataType__Number DataType__String DataStructure__Array)) {
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

    # [[[ INTEGER ARRAY TESTS ]]]
    # [[[ INTEGER ARRAY TESTS ]]]
    # [[[ INTEGER ARRAY TESTS ]]]

    throws_ok(    # TIVAVRV00
        sub { integer_arrayref_to_string() },
        "/(EIVAVRV00.*$mode_tagline)|(Usage.*integer_arrayref_to_string)/",    # DEV NOTE: 2 different error messages, RPerl & C
        q{TIVAVRV00 integer_arrayref_to_string() throws correct exception}
    );
    throws_ok(                                                                 # TIVAVRV01
        sub { integer_arrayref_to_string(undef) },
        "/EIVAVRV00.*$mode_tagline/",
        q{TIVAVRV01 integer_arrayref_to_string(undef) throws correct exception}
    );
    throws_ok(                                                                 # TIVAVRV02
        sub { integer_arrayref_to_string(2) },
        "/EIVAVRV01.*$mode_tagline/",
        q{TIVAVRV02 integer_arrayref_to_string(2) throws correct exception}
    );
    throws_ok(                                                                 # TIVAVRV03
        sub { integer_arrayref_to_string(2.3) },
        "/EIVAVRV01.*$mode_tagline/",
        q{TIVAVRV03 integer_arrayref_to_string(2.3) throws correct exception}
    );
    throws_ok(                                                                 # TIVAVRV04
        sub { integer_arrayref_to_string('2') },
        "/EIVAVRV01.*$mode_tagline/",
        q{TIVAVRV04 integer_arrayref_to_string('2') throws correct exception}
    );
    throws_ok(                                                                 # TIVAVRV05
        sub { integer_arrayref_to_string( { a_key => 23 } ) },
        "/EIVAVRV01.*$mode_tagline/",
        q{TIVAVRV05 integer_arrayref_to_string({a_key => 23}) throws correct exception}
    );
    throws_ok(                                                                 # TIVAVRV10
        sub {
            integer_arrayref_to_string( [ 2, 2_112, undef, 23, -877, -33, 1_701 ] );
        },
        "/EIVAVRV02.*$mode_tagline/",
        q{TIVAVRV10 integer_arrayref_to_string([ 2, 2_112, undef, 23, -877, -33, 1_701 ]) throws correct exception}
    );
    throws_ok(                                                                 # TIVAVRV11
        sub {
            integer_arrayref_to_string( [ 2, 2_112, 42, 23.3, -877, -33, 1_701 ] );
        },
        "/EIVAVRV03.*$mode_tagline/",
        q{TIVAVRV11 integer_arrayref_to_string([ 2, 2_112, 42, 23.3, -877, -33, 1_701 ]) throws correct exception}
    );
    throws_ok(                                                                 # TIVAVRV12
        sub {
            integer_arrayref_to_string( [ 2, 2_112, 42, '23', -877, -33, 1_701 ] );
        },
        "/EIVAVRV03.*$mode_tagline/",
        q{TIVAVRV12 integer_arrayref_to_string([ 2, 2_112, 42, '23', -877, -33, 1_701 ]) throws correct exception}
    );
    throws_ok(                                                                 # TIVAVRV13
        sub {
            integer_arrayref_to_string( [ 2, 2_112, 42, [ 23 ], -877, -33, 1_701 ] );
        },
        "/EIVAVRV03.*$mode_tagline/",
        q{TIVAVRV13 integer_arrayref_to_string([ 2, 2_112, 42, [ 23 ], -877, -33, 1_701 ]) throws correct exception}
    );
    throws_ok(                                                                 # TIVAVRV14
        sub {
            integer_arrayref_to_string( [ 2, 2_112, 42, { a_subkey => 23 }, -877, -33, 1_701 ] );
        },
        "/EIVAVRV03.*$mode_tagline/",
        q{TIVAVRV14 integer_arrayref_to_string([ 2, 2_112, 42, {a_subkey => 23}, -877, -33, 1_701 ]) throws correct exception}
    );


# VERY x 8: implement PERLOPS_PERLTYPES & CPPOPS_CPPTYPES dynamic error checking for blessed objects
# VERY x 8: implement PERLOPS_PERLTYPES & CPPOPS_CPPTYPES dynamic error checking for blessed objects
# VERY x 8: implement PERLOPS_PERLTYPES & CPPOPS_CPPTYPES dynamic error checking for blessed objects


    throws_ok(  # TIVAVRV15, DYNAMIC DISPATCH
        sub {
            arrayref_to_string( bless [ 23 ], 'string_arrayref' );
        },
        "/EPVAVRV03.*$mode_tagline/",
        q{TIVAVRV15 arrayref_to_string( bless [ 23 ], 'string_arrayref' ) throws correct exception}
    );


    lives_and(  # TIVAVRV20a
        sub {
            is(              integer_arrayref_to_string( [ 23 ] ),
                                                        '[ 23 ]',
                q{TIVAVRV20a integer_arrayref_to_string( [ 23 ] ) returns correct value}
            );
        },
                q{TIVAVRV20a integer_arrayref_to_string( [ 23 ] ) lives}
    );
    lives_and(  # TIVAVRV20b
        sub {
            is(              integer_arrayref_to_string( my integer_arrayref $foo = [ 23 ] ),
                                                                                   '[ 23 ]',
                q{TIVAVRV20b integer_arrayref_to_string( my integer_arrayref $foo = [ 23 ] ) returns correct value}
            );
        },
                q{TIVAVRV20b integer_arrayref_to_string( my integer_arrayref $foo = [ 23 ] ) lives}
    );
    lives_and(  # TIVAVRV20c
        sub {
            is(              integer_arrayref_to_string( bless [ 23 ], 'integer_arrayref' ),
                                                              '[ 23 ]',
                q{TIVAVRV20c integer_arrayref_to_string( bless [ 23 ], 'integer_arrayref' ) returns correct value}
            );
        },
                q{TIVAVRV20c integer_arrayref_to_string( bless [ 23 ], 'integer_arrayref' ) lives}
    );
    # DEV NOTE: TIVAVRV20d and TNVAVRV20d are identical, disable TNVAVRV20d
    lives_and(  # TIVAVRV20d, DYNAMIC DISPATCH
        sub {
            is(                     arrayref_to_string( [ 23 ] ),
                                                       '[ 23 ]',
                q{TIVAVRV20d        arrayref_to_string( [ 23 ] ) returns correct value}
            );
        },
                q{TIVAVRV20d        arrayref_to_string( [ 23 ] ) lives}
    );
    lives_and(  # TIVAVRV20e, DYNAMIC DISPATCH
        sub {
            is(                     arrayref_to_string( my integer_arrayref $foo = [ 23 ] ),
                                                                                  '[ 23 ]',
                q{TIVAVRV20e        arrayref_to_string( my integer_arrayref $foo = [ 23 ] ) returns correct value}
            );
        },
                q{TIVAVRV20e        arrayref_to_string( my integer_arrayref $foo = [ 23 ] ) lives}
    );
    lives_and(  # TIVAVRV20f, DYNAMIC DISPATCH
        sub {
            is(                     arrayref_to_string( bless [ 23 ], 'integer_arrayref' ),
                                                             '[ 23 ]',
                q{TIVAVRV20f        arrayref_to_string( bless [ 23 ], 'integer_arrayref' ) returns correct value}
            );
        },
                q{TIVAVRV20f        arrayref_to_string( bless [ 23 ], 'integer_arrayref' ) lives}
    );




    lives_and(  # TIVAVRV30a
        sub {
            is(              integer_arrayref_to_string_compact( [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ),
                                                                '[2,2_112,42,23,-877,-33,1_701]',
                q{TIVAVRV30a integer_arrayref_to_string_compact( [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ) returns correct value}
            );
        },
                q{TIVAVRV30a integer_arrayref_to_string_compact( [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ) lives}
    );
    usleep(100_000);  # TMP DEBUG, give output time to catch up before starting another operation
    lives_and(  # TIVAVRV30b
        sub {
            is(              integer_arrayref_to_string_compact( my integer_arrayref $foo = [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ),
                                                                                           '[2,2_112,42,23,-877,-33,1_701]',
                q{TIVAVRV30b integer_arrayref_to_string_compact( my integer_arrayref $foo = [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ) returns correct value}
            );
        },
                q{TIVAVRV30b integer_arrayref_to_string_compact( my integer_arrayref $foo = [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ) lives}
    );
    usleep(100_000);  # TMP DEBUG, give output time to catch up before starting another operation
    lives_and(  # TIVAVRV30c
        sub {
            is(              integer_arrayref_to_string_compact( bless [ 2, 2_112, 42, 23, -877, -33, 1_701 ], 'integer_arrayref' ),
                                                                      '[2,2_112,42,23,-877,-33,1_701]',
                q{TIVAVRV30c integer_arrayref_to_string_compact( bless [ 2, 2_112, 42, 23, -877, -33, 1_701 ], 'integer_arrayref' ) returns correct value}
            );
        },
                q{TIVAVRV30c integer_arrayref_to_string_compact( bless [ 2, 2_112, 42, 23, -877, -33, 1_701 ], 'integer_arrayref' ) lives}
    );
    usleep(100_000);  # TMP DEBUG, give output time to catch up before starting another operation


    lives_and(  # TIVAVRV31a
        sub {
            is(              integer_arrayref_to_string( [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ),
                                                        '[ 2, 2_112, 42, 23, -877, -33, 1_701 ]',
                q{TIVAVRV31a integer_arrayref_to_string( [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ) returns correct value}
            );
        },
                q{TIVAVRV31a integer_arrayref_to_string( [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ) lives}
    );
    usleep(100_000);  # TMP DEBUG, give output time to catch up before starting another operation
    lives_and(  # TIVAVRV31b
        sub {
            is(              integer_arrayref_to_string( my integer_arrayref $foo = [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ),
                                                                                   '[ 2, 2_112, 42, 23, -877, -33, 1_701 ]',
                q{TIVAVRV31b integer_arrayref_to_string( my integer_arrayref $foo = [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ) returns correct value}
            );
        },
                q{TIVAVRV31b integer_arrayref_to_string( my integer_arrayref $foo = [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ) lives}
    );
    usleep(100_000);  # TMP DEBUG, give output time to catch up before starting another operation
    lives_and(  # TIVAVRV31c
        sub {
            is(              integer_arrayref_to_string( bless [ 2, 2_112, 42, 23, -877, -33, 1_701 ], 'integer_arrayref' ),
                                                              '[ 2, 2_112, 42, 23, -877, -33, 1_701 ]',
                q{TIVAVRV31c integer_arrayref_to_string( bless [ 2, 2_112, 42, 23, -877, -33, 1_701 ], 'integer_arrayref' ) returns correct value}
            );
        },
                q{TIVAVRV31c integer_arrayref_to_string( bless [ 2, 2_112, 42, 23, -877, -33, 1_701 ], 'integer_arrayref' ) lives}
    );
    usleep(100_000);  # TMP DEBUG, give output time to catch up before starting another operation


    lives_and(  # TIVAVRV32a
        sub {
            is(              integer_arrayref_to_string_pretty( [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ),
                                                               '[ 2, 2_112, 42, 23, -877, -33, 1_701 ]',
                q{TIVAVRV32a integer_arrayref_to_string_pretty( [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ) returns correct value}
            );
        },
                q{TIVAVRV32a integer_arrayref_to_string_pretty( [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ) lives}
    );
    usleep(100_000);  # TMP DEBUG, give output time to catch up before starting another operation
    lives_and(  # TIVAVRV32b
        sub {
            is(              integer_arrayref_to_string_pretty( my integer_arrayref $foo = [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ),
                                                                                          '[ 2, 2_112, 42, 23, -877, -33, 1_701 ]',
                q{TIVAVRV32b integer_arrayref_to_string_pretty( my integer_arrayref $foo = [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ) returns correct value}
            );
        },
                q{TIVAVRV32b integer_arrayref_to_string_pretty( my integer_arrayref $foo = [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ) lives}
    );
    usleep(100_000);  # TMP DEBUG, give output time to catch up before starting another operation
    lives_and(  # TIVAVRV32c
        sub {
            is(              integer_arrayref_to_string_pretty( bless [ 2, 2_112, 42, 23, -877, -33, 1_701 ], 'integer_arrayref' ),
                                                                     '[ 2, 2_112, 42, 23, -877, -33, 1_701 ]',
                q{TIVAVRV32c integer_arrayref_to_string_pretty( bless [ 2, 2_112, 42, 23, -877, -33, 1_701 ], 'integer_arrayref' ) returns correct value}
            );
        },
                q{TIVAVRV32c integer_arrayref_to_string_pretty( bless [ 2, 2_112, 42, 23, -877, -33, 1_701 ], 'integer_arrayref' ) lives}
    );
    usleep(100_000);  # TMP DEBUG, give output time to catch up before starting another operation


    lives_and(  # TIVAVRV33a
        sub {
            is(              integer_arrayref_to_string_expand( [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ),
'[
    2,
    2_112,
    42,
    23,
    -877,
    -33,
    1_701
]',
                q{TIVAVRV33a integer_arrayref_to_string_expand( [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ) returns correct value}
            );
        },
                q{TIVAVRV33a integer_arrayref_to_string_expand( [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ) lives}
    );
    usleep(100_000);  # TMP DEBUG, give output time to catch up before starting another operation
    lives_and(  # TIVAVRV33b
        sub {
            is(              integer_arrayref_to_string_expand( my integer_arrayref $foo = [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ),
'[
    2,
    2_112,
    42,
    23,
    -877,
    -33,
    1_701
]',
                q{TIVAVRV33b integer_arrayref_to_string_expand( my integer_arrayref $foo = [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ) returns correct value}
            );
        },
                q{TIVAVRV33b integer_arrayref_to_string_expand( my integer_arrayref $foo = [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ) lives}
    );
    usleep(100_000);  # TMP DEBUG, give output time to catch up before starting another operation
    lives_and(  # TIVAVRV33c
        sub {
            is(              integer_arrayref_to_string_expand( bless [ 2, 2_112, 42, 23, -877, -33, 1_701 ], 'integer_arrayref' ),
'[
    2,
    2_112,
    42,
    23,
    -877,
    -33,
    1_701
]',
                q{TIVAVRV33c integer_arrayref_to_string_expand( bless [ 2, 2_112, 42, 23, -877, -33, 1_701 ], 'integer_arrayref' ) returns correct value}
            );
        },
                q{TIVAVRV33c integer_arrayref_to_string_expand( bless [ 2, 2_112, 42, 23, -877, -33, 1_701 ], 'integer_arrayref' ) lives}
    );
    usleep(100_000);  # TMP DEBUG, give output time to catch up before starting another operation


    lives_and(  # TIVAVRV34a
        sub {
            is(              integer_arrayref_to_string_format( [ 2, 2_112, 42, 23, -877, -33, 1_701 ], 0, 0 ),
                                                               '[ 2, 2_112, 42, 23, -877, -33, 1_701 ]',
                q{TIVAVRV34a integer_arrayref_to_string_format( [ 2, 2_112, 42, 23, -877, -33, 1_701 ], 0, 0 ) returns correct value}
            );
        },
                q{TIVAVRV34a integer_arrayref_to_string_format( [ 2, 2_112, 42, 23, -877, -33, 1_701 ], 0, 0 ) lives}
    );
    usleep(100_000);  # TMP DEBUG, give output time to catch up before starting another operation
    lives_and(  # TIVAVRV34b
        sub {
            is(              integer_arrayref_to_string_format( my integer_arrayref $foo = [ 2, 2_112, 42, 23, -877, -33, 1_701 ], 0, 0 ),
                                                                                          '[ 2, 2_112, 42, 23, -877, -33, 1_701 ]',
                q{TIVAVRV34b integer_arrayref_to_string_format( my integer_arrayref $foo = [ 2, 2_112, 42, 23, -877, -33, 1_701 ], 0, 0 ) returns correct value}
            );
        },
                q{TIVAVRV34b integer_arrayref_to_string_format( my integer_arrayref $foo = [ 2, 2_112, 42, 23, -877, -33, 1_701 ], 0, 0 ) lives}
    );
    usleep(100_000);  # TMP DEBUG, give output time to catch up before starting another operation
    lives_and(  # TIVAVRV34c
        sub {
            is(              integer_arrayref_to_string_format( ( bless [ 2, 2_112, 42, 23, -877, -33, 1_701 ], 'integer_arrayref' ), 0, 0 ),
                                                                       '[ 2, 2_112, 42, 23, -877, -33, 1_701 ]',
                q{TIVAVRV34c integer_arrayref_to_string_format( ( bless [ 2, 2_112, 42, 23, -877, -33, 1_701 ], 'integer_arrayref' ), 0, 0 ) returns correct value}
            );
        },
                q{TIVAVRV34c integer_arrayref_to_string_format( ( bless [ 2, 2_112, 42, 23, -877, -33, 1_701 ], 'integer_arrayref' ), 0, 0 ) lives}
    );
    usleep(100_000);  # TMP DEBUG, give output time to catch up before starting another operation


    lives_and(  # TIVAVRV40a, DYNAMIC DISPATCH
        sub {
            is(              arrayref_to_string_compact( [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ),
                                                        '[2,2_112,42,23,-877,-33,1_701]',
                q{TIVAVRV40a arrayref_to_string_compact( [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ) returns correct value}
            );
        },
                q{TIVAVRV40a arrayref_to_string_compact( [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ) lives}
    );
    usleep(100_000);  # TMP DEBUG, give output time to catch up before starting another operation
    lives_and(  # TIVAVRV40b, DYNAMIC DISPATCH
        sub {
            is(              arrayref_to_string_compact( my integer_arrayref $foo = [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ),
                                                                                   '[2,2_112,42,23,-877,-33,1_701]',
                q{TIVAVRV40b arrayref_to_string_compact( my integer_arrayref $foo = [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ) returns correct value}
            );
        },
                q{TIVAVRV40b arrayref_to_string_compact( my integer_arrayref $foo = [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ) lives}
    );
    usleep(100_000);  # TMP DEBUG, give output time to catch up before starting another operation
    lives_and(  # TIVAVRV40c, DYNAMIC DISPATCH
        sub {
            is(              arrayref_to_string_compact( bless [ 2, 2_112, 42, 23, -877, -33, 1_701 ], 'integer_arrayref' ),
                                                              '[2,2_112,42,23,-877,-33,1_701]',
                q{TIVAVRV40c arrayref_to_string_compact( bless [ 2, 2_112, 42, 23, -877, -33, 1_701 ], 'integer_arrayref' ) returns correct value}
            );
        },
                q{TIVAVRV40c arrayref_to_string_compact( bless [ 2, 2_112, 42, 23, -877, -33, 1_701 ], 'integer_arrayref' ) lives}
    );
    usleep(100_000);  # TMP DEBUG, give output time to catch up before starting another operation
 

    lives_and(  # TIVAVRV41a, DYNAMIC DISPATCH
        sub {
            is(              arrayref_to_string( [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ),
                                                '[ 2, 2_112, 42, 23, -877, -33, 1_701 ]',
                q{TIVAVRV41a arrayref_to_string( [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ) returns correct value}
            );
        },
                q{TIVAVRV41a arrayref_to_string( [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ) lives}
    );
    usleep(100_000);  # TMP DEBUG, give output time to catch up before starting another operation
    lives_and(  # TIVAVRV41b, DYNAMIC DISPATCH
        sub {
            is(              arrayref_to_string( my integer_arrayref $foo = [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ),
                                                                           '[ 2, 2_112, 42, 23, -877, -33, 1_701 ]',
                q{TIVAVRV41b arrayref_to_string( my integer_arrayref $foo = [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ) returns correct value}
            );
        },
                q{TIVAVRV41b arrayref_to_string( my integer_arrayref $foo = [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ) lives}
    );
    usleep(100_000);  # TMP DEBUG, give output time to catch up before starting another operation
    lives_and(  # TIVAVRV41c, DYNAMIC DISPATCH
        sub {
            is(              arrayref_to_string( bless [ 2, 2_112, 42, 23, -877, -33, 1_701 ], 'integer_arrayref' ),
                                                      '[ 2, 2_112, 42, 23, -877, -33, 1_701 ]',
                q{TIVAVRV41c arrayref_to_string( bless [ 2, 2_112, 42, 23, -877, -33, 1_701 ], 'integer_arrayref' ) returns correct value}
            );
        },
                q{TIVAVRV41c arrayref_to_string( bless [ 2, 2_112, 42, 23, -877, -33, 1_701 ], 'integer_arrayref' ) lives}
    );
    usleep(100_000);  # TMP DEBUG, give output time to catch up before starting another operation


    lives_and(  # TIVAVRV42a, DYNAMIC DISPATCH
        sub {
            is(              arrayref_to_string_pretty( [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ),
                                                       '[ 2, 2_112, 42, 23, -877, -33, 1_701 ]',
                q{TIVAVRV42a arrayref_to_string_pretty( [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ) returns correct value}
            );
        },
                q{TIVAVRV42a arrayref_to_string_pretty( [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ) lives}
    );
    usleep(100_000);  # TMP DEBUG, give output time to catch up before starting another operation
    lives_and(  # TIVAVRV42b, DYNAMIC DISPATCH
        sub {
            is(              arrayref_to_string_pretty( my integer_arrayref $foo = [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ),
                                                                                  '[ 2, 2_112, 42, 23, -877, -33, 1_701 ]',
                q{TIVAVRV42b arrayref_to_string_pretty( my integer_arrayref $foo = [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ) returns correct value}
            );
        },
                q{TIVAVRV42b arrayref_to_string_pretty( my integer_arrayref $foo = [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ) lives}
    );
    usleep(100_000);  # TMP DEBUG, give output time to catch up before starting another operation
    lives_and(  # TIVAVRV42c, DYNAMIC DISPATCH
        sub {
            is(              arrayref_to_string_pretty( bless [ 2, 2_112, 42, 23, -877, -33, 1_701 ], 'integer_arrayref' ),
                                                             '[ 2, 2_112, 42, 23, -877, -33, 1_701 ]',
                q{TIVAVRV42c arrayref_to_string_pretty( bless [ 2, 2_112, 42, 23, -877, -33, 1_701 ], 'integer_arrayref' ) returns correct value}
            );
        },
                q{TIVAVRV42c arrayref_to_string_pretty( bless [ 2, 2_112, 42, 23, -877, -33, 1_701 ], 'integer_arrayref' ) lives}
    );
    usleep(100_000);  # TMP DEBUG, give output time to catch up before starting another operation


    lives_and(  # TIVAVRV43a, DYNAMIC DISPATCH
        sub {
            is(              arrayref_to_string_expand( [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ),
'[
    2,
    2_112,
    42,
    23,
    -877,
    -33,
    1_701
]',
                q{TIVAVRV43a arrayref_to_string_expand( [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ) returns correct value}
            );
        },
                q{TIVAVRV43a arrayref_to_string_expand( [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ) lives}
    );
    usleep(100_000);  # TMP DEBUG, give output time to catch up before starting another operation
    lives_and(  # TIVAVRV43b, DYNAMIC DISPATCH
        sub {
            is(              arrayref_to_string_expand( my integer_arrayref $foo = [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ),
'[
    2,
    2_112,
    42,
    23,
    -877,
    -33,
    1_701
]',
                q{TIVAVRV43b arrayref_to_string_expand( my integer_arrayref $foo = [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ) returns correct value}
            );
        },
                q{TIVAVRV43b arrayref_to_string_expand( my integer_arrayref $foo = [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ) lives}
    );
    usleep(100_000);  # TMP DEBUG, give output time to catch up before starting another operation
    lives_and(  # TIVAVRV43c, DYNAMIC DISPATCH
        sub {
            is(              arrayref_to_string_expand( bless [ 2, 2_112, 42, 23, -877, -33, 1_701 ], 'integer_arrayref' ),
'[
    2,
    2_112,
    42,
    23,
    -877,
    -33,
    1_701
]',
                q{TIVAVRV43c arrayref_to_string_expand( bless [ 2, 2_112, 42, 23, -877, -33, 1_701 ], 'integer_arrayref' ) returns correct value}
            );
        },
                q{TIVAVRV43c arrayref_to_string_expand( bless [ 2, 2_112, 42, 23, -877, -33, 1_701 ], 'integer_arrayref' ) lives}
    );
    usleep(100_000);  # TMP DEBUG, give output time to catch up before starting another operation


    lives_and(  # TIVAVRV44a
        sub {
            is(              arrayref_to_string_format( [ 2, 2_112, 42, 23, -877, -33, 1_701 ], 0, 0 ),
                                                       '[ 2, 2_112, 42, 23, -877, -33, 1_701 ]',
                q{TIVAVRV44a arrayref_to_string_format( [ 2, 2_112, 42, 23, -877, -33, 1_701 ], 0, 0 ) returns correct value}
            );
        },
                q{TIVAVRV44a arrayref_to_string_format( [ 2, 2_112, 42, 23, -877, -33, 1_701 ], 0, 0 ) lives}
    );
    usleep(100_000);  # TMP DEBUG, give output time to catch up before starting another operation
    lives_and(  # TIVAVRV44b
        sub {
            is(              arrayref_to_string_format( my integer_arrayref $foo = [ 2, 2_112, 42, 23, -877, -33, 1_701 ], 0, 0 ),
                                                                                  '[ 2, 2_112, 42, 23, -877, -33, 1_701 ]',
                q{TIVAVRV44b arrayref_to_string_format( my integer_arrayref $foo = [ 2, 2_112, 42, 23, -877, -33, 1_701 ], 0, 0 ) returns correct value}
            );
        },
                q{TIVAVRV44b arrayref_to_string_format( my integer_arrayref $foo = [ 2, 2_112, 42, 23, -877, -33, 1_701 ], 0, 0 ) lives}
    );
    usleep(100_000);  # TMP DEBUG, give output time to catch up before starting another operation
    lives_and(  # TIVAVRV44c
        sub {
            is(              arrayref_to_string_format( ( bless [ 2, 2_112, 42, 23, -877, -33, 1_701 ], 'integer_arrayref' ), 0, 0 ),
                                                               '[ 2, 2_112, 42, 23, -877, -33, 1_701 ]',
                q{TIVAVRV44c arrayref_to_string_format( ( bless [ 2, 2_112, 42, 23, -877, -33, 1_701 ], 'integer_arrayref' ), 0, 0 ) returns correct value}
            );
        },
                q{TIVAVRV44c arrayref_to_string_format( ( bless [ 2, 2_112, 42, 23, -877, -33, 1_701 ], 'integer_arrayref' ), 0, 0 ) lives}
    );
    usleep(100_000);  # TMP DEBUG, give output time to catch up before starting another operation


    throws_ok(  # TIVAVRV50
        sub { integer_arrayref_typetest0() },
        "/(EIVAVRV00.*$mode_tagline)|(Usage.*integer_arrayref_typetest0)/",    # DEV NOTE: 2 different error messages, RPerl & C
                q{TIVAVRV50 integer_arrayref_typetest0() throws correct exception}
    );
    throws_ok(  # TIVAVRV51
        sub { integer_arrayref_typetest0(2) },
        "/EIVAVRV01.*$mode_tagline/",
                q{TIVAVRV51 integer_arrayref_typetest0(2) throws correct exception}
    );
    throws_ok(  # TIVAVRV52
        sub {
            integer_arrayref_typetest0( [ 2, 2_112, undef, 23, -877, -33, 1_701 ] );
        },
        "/EIVAVRV02.*$mode_tagline/",
                q{TIVAVRV52 integer_arrayref_typetest0([ 2, 2_112, undef, 23, -877, -33, 1_701 ]) throws correct exception}
    );
    throws_ok(  # TIVAVRV53
        sub {
            integer_arrayref_typetest0( [ 2, 2_112, 42, 'abcdefg', -877, -33, 1_701 ] );
        },
        "/EIVAVRV03.*$mode_tagline/",
                q{TIVAVRV53 integer_arrayref_typetest0([ 2, 2_112, 42, 'abcdefg', -877, -33, 1_701 ]) throws correct exception}
    );
    lives_and(  # TIVAVRV54
        sub {
            is( integer_arrayref_typetest0( [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ),
                '[ 2, 2_112, 42, 23, -877, -33, 1_701 ]' . $mode_tagline,
                q{TIVAVRV54 integer_arrayref_typetest0([ 2, 2_112, 42, 23, -877, -33, 1_701 ]) returns correct value}
            );
        },
                q{TIVAVRV54 integer_arrayref_typetest0([ 2, 2_112, 42, 23, -877, -33, 1_701 ]) lives}
    );
    lives_and(  # TIVAVRV60
        sub {
            is_deeply( integer_arrayref_typetest1(5), [ 0, 5, 10, 15, 20 ], 
                q{TIVAVRV60 integer_arrayref_typetest1(5) returns correct value} );
        },
                q{TIVAVRV60 integer_arrayref_typetest1(5) lives}
    );

    # [[[ NUMBER ARRAY TESTS ]]]
    # [[[ NUMBER ARRAY TESTS ]]]
    # [[[ NUMBER ARRAY TESTS ]]]

    throws_ok(    # TNVAVRV00
        sub { number_arrayref_to_string() },
        "/(ENVAVRV00.*$mode_tagline)|(Usage.*number_arrayref_to_string)/",    # DEV NOTE: 2 different error messages, RPerl & C
        q{TNVAVRV00 number_arrayref_to_string() throws correct exception}
    );
    throws_ok(                                                                # TNVAVRV01
        sub { number_arrayref_to_string(undef) },
        "/E(NV)?AVRV00.*$mode_tagline/",
        q{TNVAVRV01 number_arrayref_to_string(undef) throws correct exception}
    );
    throws_ok(                                                                # TNVAVRV02
        sub { number_arrayref_to_string(2) },
        "/E(NV)?AVRV01.*$mode_tagline/",
        q{TNVAVRV02 number_arrayref_to_string(2) throws correct exception}
    );
    throws_ok(                                                                # TNVAVRV03
        sub { number_arrayref_to_string(2.3) },
        "/E(NV)?AVRV01.*$mode_tagline/",
        q{TNVAVRV03 number_arrayref_to_string(2.3) throws correct exception}
    );
    throws_ok(                                                                # TNVAVRV04
        sub { number_arrayref_to_string('2') },
        "/E(NV)?AVRV01.*$mode_tagline/",
        q{TNVAVRV04 number_arrayref_to_string('2') throws correct exception}
    );
    throws_ok(                                                                # TNVAVRV05
        sub { number_arrayref_to_string( { a_key => 23 } ) },
        "/E(NV)?AVRV01.*$mode_tagline/",
        q{TNVAVRV05 number_arrayref_to_string({a_key => 23}) throws correct exception}
    );
    throws_ok(                                                                # TNVAVRV10
        sub {
            number_arrayref_to_string( [ 2, 2_112, undef, 23, -877, -33, 1_701 ] );
        },
        "/ENVAVRV02.*$mode_tagline/",
        q{TNVAVRV10 number_arrayref_to_string([ 2, 2_112, undef, 23, -877, -33, 1_701 ]) throws correct exception}
    );
    throws_ok(                                                                # TNVAVRV11
        sub {
            number_arrayref_to_string( [ 2, 2_112, 42, '23', -877, -33, 1_701 ] );
        },
        "/ENVAVRV03.*$mode_tagline/",
        q{TNVAVRV11 number_arrayref_to_string([ 2, 2_112, 42, '23', -877, -33, 1_701 ]) throws correct exception}
    );
    throws_ok(                                                                # TNVAVRV12
        sub {
            number_arrayref_to_string( [ 2, 2_112, 42, [ 23 ], -877, -33, 1_701 ] );
        },
        "/ENVAVRV03.*$mode_tagline/",
        q{TNVAVRV12 number_arrayref_to_string([ 2, 2_112, 42, [ 23 ], -877, -33, 1_701 ]) throws correct exception}
    );
    throws_ok(                                                                # TNVAVRV13
        sub {
            number_arrayref_to_string( [ 2, 2_112, 42, { a_subkey => 23 }, -877, -33, 1_701 ] );
        },
        "/ENVAVRV03.*$mode_tagline/",
        q{TNVAVRV13 number_arrayref_to_string([ 2, 2_112, 42, {a_subkey => 23}, -877, -33, 1_701 ]) throws correct exception}
    );


    throws_ok(  # TNVAVRV15, DYNAMIC DISPATCH
        sub {
            arrayref_to_string( bless [ 23.2 ], 'integer_arrayref' );
        },
        "/EIVAVRV03.*$mode_tagline/",
        q{TNVAVRV15 arrayref_to_string( bless [ 23.2 ], 'integer_arrayref' ) throws correct exception}
    );
    throws_ok(  # TNVAVRV16, DYNAMIC DISPATCH
        sub {
            arrayref_to_string( bless [ 23.2 ], 'string_arrayref' );
        },
        "/EPVAVRV03.*$mode_tagline/",
        q{TNVAVRV16 arrayref_to_string( bless [ 23.2 ], 'string_arrayref' ) throws correct exception}
    );


    lives_and(  # TNVAVRV20a
        sub {
            is(              number_arrayref_to_string( [ 23 ] ),
                                                       '[ 23 ]',
                q{TNVAVRV20a number_arrayref_to_string( [ 23 ] ) returns correct value}
            );
        },
                q{TNVAVRV20a number_arrayref_to_string( [ 23 ] ) lives}
    );
    lives_and(  # TNVAVRV20b
        sub {
            is(              number_arrayref_to_string( my number_arrayref $foo = [ 23 ] ),
                                                                                 '[ 23 ]',
                q{TNVAVRV20b number_arrayref_to_string( my number_arrayref $foo = [ 23 ] ) returns correct value}
            );
        },
                q{TNVAVRV20b number_arrayref_to_string( my number_arrayref $foo = [ 23 ] ) lives}
    );
    lives_and(  # TNVAVRV20c
        sub {
            is(              number_arrayref_to_string( bless [ 23 ], 'number_arrayref' ),
                                                             '[ 23 ]',
                q{TNVAVRV20c number_arrayref_to_string( bless [ 23 ], 'number_arrayref' ) returns correct value}
            );
        },
                q{TNVAVRV20c number_arrayref_to_string( bless [ 23 ], 'number_arrayref' ) lives}
    );
    # DEV NOTE: TIVAVRV20d and TNVAVRV20d are identical, disable TNVAVRV20d
#    lives_and(  # TNVAVRV20d, DYNAMIC DISPATCH
#        sub {
#            is(                     arrayref_to_string( [ 23 ] ),
#                                                       '[ 23 ]',
#                q{TNVAVRV20d        arrayref_to_string( [ 23 ] ) returns correct value}
#            );
#        },
#                q{TNVAVRV20d        arrayref_to_string( [ 23 ] ) lives}
#    );
    lives_and(  # TNVAVRV20e, DYNAMIC DISPATCH
        sub {
            is(                     arrayref_to_string( my number_arrayref $foo = [ 23 ] ),
                                                                                 '[ 23 ]',
                q{TNVAVRV20e        arrayref_to_string( my number_arrayref $foo = [ 23 ] ) returns correct value}
            );
        },
                q{TNVAVRV20e        arrayref_to_string( my number_arrayref $foo = [ 23 ] ) lives}
    );
    lives_and(  # TNVAVRV20f, DYNAMIC DISPATCH
        sub {
            is(                     arrayref_to_string( bless [ 23 ], 'number_arrayref' ),
                                                             '[ 23 ]',
                q{TNVAVRV20f        arrayref_to_string( bless [ 23 ], 'number_arrayref' ) returns correct value}
            );
        },
                q{TNVAVRV20f        arrayref_to_string( bless [ 23 ], 'number_arrayref' ) lives}
    );


    lives_and(  # TNVAVRV21a
        sub {
            is(              number_arrayref_to_string( [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ),
                                                       '[ 2, 2_112, 42, 23, -877, -33, 1_701 ]',
                q{TNVAVRV21a number_arrayref_to_string( [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ) returns correct value}
            );
        },
                q{TNVAVRV21a number_arrayref_to_string( [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ) lives}
    );
    lives_and(  # TNVAVRV21b
        sub {
            is(              number_arrayref_to_string( my number_arrayref $foo = [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ),
                                                                                 '[ 2, 2_112, 42, 23, -877, -33, 1_701 ]',
                q{TNVAVRV21b number_arrayref_to_string( my number_arrayref $foo = [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ) returns correct value}
            );
        },
                q{TNVAVRV21b number_arrayref_to_string( my number_arrayref $foo = [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ) lives}
    );
    lives_and(  # TNVAVRV21c
        sub {
            is(              number_arrayref_to_string( bless [ 2, 2_112, 42, 23, -877, -33, 1_701 ], 'number_arrayref' ),
                                                             '[ 2, 2_112, 42, 23, -877, -33, 1_701 ]',
                q{TNVAVRV21c number_arrayref_to_string( bless [ 2, 2_112, 42, 23, -877, -33, 1_701 ], 'number_arrayref' ) returns correct value}
            );
        },
                q{TNVAVRV21c number_arrayref_to_string( bless [ 2, 2_112, 42, 23, -877, -33, 1_701 ], 'number_arrayref' ) lives}
    );
    lives_and(  # TNVAVRV21d, DYNAMIC DISPATCH
        sub {
            is(                     arrayref_to_string( [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ),
                                                       '[ 2, 2_112, 42, 23, -877, -33, 1_701 ]',
                q{TNVAVRV21d        arrayref_to_string( [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ) returns correct value}
            );
        },
                q{TNVAVRV21d        arrayref_to_string( [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ) lives}
    );
    lives_and(  # TNVAVRV21e, DYNAMIC DISPATCH
        sub {
            is(                     arrayref_to_string( my number_arrayref $foo = [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ),
                                                                                 '[ 2, 2_112, 42, 23, -877, -33, 1_701 ]',
                q{TNVAVRV21e        arrayref_to_string( my number_arrayref $foo = [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ) returns correct value}
            );
        },
                q{TNVAVRV21e        arrayref_to_string( my number_arrayref $foo = [ 2, 2_112, 42, 23, -877, -33, 1_701 ] ) lives}
    );
    lives_and(  # TNVAVRV21f, DYNAMIC DISPATCH
        sub {
            is(                     arrayref_to_string( bless [ 2, 2_112, 42, 23, -877, -33, 1_701 ], 'number_arrayref' ),
                                                             '[ 2, 2_112, 42, 23, -877, -33, 1_701 ]',
                q{TNVAVRV21f        arrayref_to_string( bless [ 2, 2_112, 42, 23, -877, -33, 1_701 ], 'number_arrayref' ) returns correct value}
            );
        },
                q{TNVAVRV21f        arrayref_to_string( bless [ 2, 2_112, 42, 23, -877, -33, 1_701 ], 'number_arrayref' ) lives}
    );


    lives_and(  # TNVAVRV22a
        sub {
            is(              number_arrayref_to_string( [ 23.2 ] ),
                                                       '[ 23.2 ]',
                q{TNVAVRV22a number_arrayref_to_string( [ 23.2 ] ) returns correct value}
            );
        },
                q{TNVAVRV22a number_arrayref_to_string( [ 23.2 ] ) lives}
    );
    lives_and(  # TNVAVRV22b
        sub {
            is(              number_arrayref_to_string( my number_arrayref $foo = [ 23.2 ] ),
                                                                                 '[ 23.2 ]',
                q{TNVAVRV22b number_arrayref_to_string( my number_arrayref $foo = [ 23.2 ] ) returns correct value}
            );
        },
                q{TNVAVRV22b number_arrayref_to_string( my number_arrayref $foo = [ 23.2 ] ) lives}
    );
    lives_and(  # TNVAVRV22c
        sub {
            is(              number_arrayref_to_string( bless [ 23.2 ], 'number_arrayref' ),
                                                             '[ 23.2 ]',
                q{TNVAVRV22c number_arrayref_to_string( bless [ 23.2 ], 'number_arrayref' ) returns correct value}
            );
        },
                q{TNVAVRV22c number_arrayref_to_string( bless [ 23.2 ], 'number_arrayref' ) lives}
    );
    lives_and(  # TNVAVRV22d, DYNAMIC DISPATCH
        sub {
            is(                     arrayref_to_string( [ 23.2 ] ),
                                                       '[ 23.2 ]',
                q{TNVAVRV22d        arrayref_to_string( [ 23.2 ] ) returns correct value}
            );
        },
                q{TNVAVRV22d        arrayref_to_string( [ 23.2 ] ) lives}
    );
    lives_and(  # TNVAVRV22e, DYNAMIC DISPATCH
        sub {
            is(                     arrayref_to_string( my number_arrayref $foo = [ 23.2 ] ),
                                                                                 '[ 23.2 ]',
                q{TNVAVRV22e        arrayref_to_string( my number_arrayref $foo = [ 23.2 ] ) returns correct value}
            );
        },
                q{TNVAVRV22e        arrayref_to_string( my number_arrayref $foo = [ 23.2 ] ) lives}
    );
    lives_and(  # TNVAVRV22f, DYNAMIC DISPATCH
        sub {
            is(                     arrayref_to_string( bless [ 23.2 ], 'number_arrayref' ),
                                                             '[ 23.2 ]',
                q{TNVAVRV22f        arrayref_to_string( bless [ 23.2 ], 'number_arrayref' ) returns correct value}
            );
        },
                q{TNVAVRV22f        arrayref_to_string( bless [ 23.2 ], 'number_arrayref' ) lives}
    );


    lives_and(  # TNVAVRV23a
        sub {
            is(              number_arrayref_to_string( [ 2.1, 2_112.2, 42.3, 23, -877, -33, 1_701 ] ),
                                                       '[ 2.1, 2_112.2, 42.3, 23, -877, -33, 1_701 ]',
                q{TNVAVRV23a number_arrayref_to_string( [ 2.1, 2_112.2, 42.3, 23, -877, -33, 1_701 ] ) returns correct value}
            );
        },
                q{TNVAVRV23a number_arrayref_to_string( [ 2.1, 2_112.2, 42.3, 23, -877, -33, 1_701 ] ) lives}
    );
    lives_and(  # TNVAVRV23b
        sub {
            is(              number_arrayref_to_string( my number_arrayref $foo = [ 2.1, 2_112.2, 42.3, 23, -877, -33, 1_701 ] ),
                                                                                 '[ 2.1, 2_112.2, 42.3, 23, -877, -33, 1_701 ]',
                q{TNVAVRV23b number_arrayref_to_string( my number_arrayref $foo = [ 2.1, 2_112.2, 42.3, 23, -877, -33, 1_701 ] ) returns correct value}
            );
        },
                q{TNVAVRV23b number_arrayref_to_string( my number_arrayref $foo = [ 2.1, 2_112.2, 42.3, 23, -877, -33, 1_701 ] ) lives}
    );
    lives_and(  # TNVAVRV23c
        sub {
            is(              number_arrayref_to_string( bless [ 2.1, 2_112.2, 42.3, 23, -877, -33, 1_701 ], 'number_arrayref' ),
                                                             '[ 2.1, 2_112.2, 42.3, 23, -877, -33, 1_701 ]',
                q{TNVAVRV23c number_arrayref_to_string( bless [ 2.1, 2_112.2, 42.3, 23, -877, -33, 1_701 ], 'number_arrayref' ) returns correct value}
            );
        },
                q{TNVAVRV23c number_arrayref_to_string( bless [ 2.1, 2_112.2, 42.3, 23, -877, -33, 1_701 ], 'number_arrayref' ) lives}
    );
    lives_and(  # TNVAVRV23d, DYNAMIC DISPATCH
        sub {
            is(                     arrayref_to_string( [ 2.1, 2_112.2, 42.3, 23, -877, -33, 1_701 ] ),
                                                       '[ 2.1, 2_112.2, 42.3, 23, -877, -33, 1_701 ]',
                q{TNVAVRV23d        arrayref_to_string( [ 2.1, 2_112.2, 42.3, 23, -877, -33, 1_701 ] ) returns correct value}
            );
        },
                q{TNVAVRV23d        arrayref_to_string( [ 2.1, 2_112.2, 42.3, 23, -877, -33, 1_701 ] ) lives}
    );
    lives_and(  # TNVAVRV23e, DYNAMIC DISPATCH
        sub {
            is(                     arrayref_to_string( my number_arrayref $foo = [ 2.1, 2_112.2, 42.3, 23, -877, -33, 1_701 ] ),
                                                                                 '[ 2.1, 2_112.2, 42.3, 23, -877, -33, 1_701 ]',
                q{TNVAVRV23e        arrayref_to_string( my number_arrayref $foo = [ 2.1, 2_112.2, 42.3, 23, -877, -33, 1_701 ] ) returns correct value}
            );
        },
                q{TNVAVRV23e        arrayref_to_string( my number_arrayref $foo = [ 2.1, 2_112.2, 42.3, 23, -877, -33, 1_701 ] ) lives}
    );
    lives_and(  # TNVAVRV23f, DYNAMIC DISPATCH
        sub {
            is(                     arrayref_to_string( bless [ 2.1, 2_112.2, 42.3, 23, -877, -33, 1_701 ], 'number_arrayref' ),
                                                             '[ 2.1, 2_112.2, 42.3, 23, -877, -33, 1_701 ]',
                q{TNVAVRV23f        arrayref_to_string( bless [ 2.1, 2_112.2, 42.3, 23, -877, -33, 1_701 ], 'number_arrayref' ) returns correct value}
            );
        },
                q{TNVAVRV23f        arrayref_to_string( bless [ 2.1, 2_112.2, 42.3, 23, -877, -33, 1_701 ], 'number_arrayref' ) lives}
    );


# OLD CODE: high precision numbers, causes failure on systems with different precision than original development system 
#    lives_and(                                                                # TNVAVRV24
#        sub {
#            is( number_arrayref_to_string( [ 2.123_443_211_234_432_1, 2_112.432_1, 42.456_7, 23.765_444_444_444_444_444, -877.567_8, -33.876_587_658_765_875_687_658_765, 1_701.678_9 ] ),
#                '[ 2.123_443_211_234_43, 2_112.432_1, 42.456_7, 23.765_444_444_444_4, -877.567_8, -33.876_587_658_765_9, 1_701.678_9 ]',
#                q{TNVAVRV24 number_arrayref_to_string([ 2.123_443_211_234_432_1, ... ]) returns correct value}
#            );
#        },
#        q{TNVAVRV24 number_arrayref_to_string([ 2.123_443_211_234_432_1, ... ]) lives}
#    );

    lives_and(                                        # TNVAVRV24a
        sub {
            my string $tmp_retval = number_arrayref_to_string(                                [ 2.123_443_211_234_432_1, 2_112.432_1, 42.456_7, 23.765_444_444_444_444_444, -877.567_8, -33.876_587_658_765_875_687_658_765, 1_701.678_9 ] );
            like( $tmp_retval, qr/\[ 2\.123_443_211/, q{TNVAVRV24a1 number_arrayref_to_string([ 2.123_443_211_234_432_1, ... ]) returns correct value, array beginning} );
            like( $tmp_retval, qr/, -33\.876_587/,    q{TNVAVRV24a2 number_arrayref_to_string([ 2.123_443_211_234_432_1, ... ]) returns correct value, array middle} );
            like( $tmp_retval, qr/, 1_701\.678_9 \]/, q{TNVAVRV24a3 number_arrayref_to_string([ 2.123_443_211_234_432_1, ... ]) returns correct value, array end} );
        },
                                                      q{TNVAVRV24a  number_arrayref_to_string([ 2.123_443_211_234_432_1, ... ]) lives}
    );
    lives_and(                                        # TNVAVRV24b
        sub {
            my string $tmp_retval = number_arrayref_to_string(                                my number_arrayref $foo = [ 2.123_443_211_234_432_1, 2_112.432_1, 42.456_7, 23.765_444_444_444_444_444, -877.567_8, -33.876_587_658_765_875_687_658_765, 1_701.678_9 ] );
            like( $tmp_retval, qr/\[ 2\.123_443_211/, q{TNVAVRV24b1 number_arrayref_to_string(my number_arrayref $foo = [ 2.123_443_211_234_432_1, ... ]) returns correct value, array beginning} );
            like( $tmp_retval, qr/, -33\.876_587/,    q{TNVAVRV24b2 number_arrayref_to_string(my number_arrayref $foo = [ 2.123_443_211_234_432_1, ... ]) returns correct value, array middle} );
            like( $tmp_retval, qr/, 1_701\.678_9 \]/, q{TNVAVRV24b3 number_arrayref_to_string(my number_arrayref $foo = [ 2.123_443_211_234_432_1, ... ]) returns correct value, array end} );
        },
                                                      q{TNVAVRV24b  number_arrayref_to_string(my number_arrayref $foo = [ 2.123_443_211_234_432_1, ... ]) lives}
    );
    lives_and(                                        # TNVAVRV24c
        sub {
            my string $tmp_retval = number_arrayref_to_string(                                bless [ 2.123_443_211_234_432_1, 2_112.432_1, 42.456_7, 23.765_444_444_444_444_444, -877.567_8, -33.876_587_658_765_875_687_658_765, 1_701.678_9 ], 'number_arrayref' );
            like( $tmp_retval, qr/\[ 2\.123_443_211/, q{TNVAVRV24c1 number_arrayref_to_string(bless [ 2.123_443_211_234_432_1, ... ], 'number_arrayref') returns correct value, array beginning} );
            like( $tmp_retval, qr/, -33\.876_587/,    q{TNVAVRV24c2 number_arrayref_to_string(bless [ 2.123_443_211_234_432_1, ... ], 'number_arrayref') returns correct value, array middle} );
            like( $tmp_retval, qr/, 1_701\.678_9 \]/, q{TNVAVRV24c3 number_arrayref_to_string(bless [ 2.123_443_211_234_432_1, ... ], 'number_arrayref') returns correct value, array end} );
        },
                                                      q{TNVAVRV24c  number_arrayref_to_string(bless [ 2.123_443_211_234_432_1, ... ], 'number_arrayref') lives}
    );
    lives_and(                                        # TNVAVRV24d
        sub {
            my string $tmp_retval = number_arrayref_to_string(                                [ 2.123_443_211_234_432_1, 2_112.432_1, 42.456_7, 23.765_444_444_444_444_444, -877.567_8, -33.876_587_658_765_875_687_658_765, 1_701.678_9 ] );
            like( $tmp_retval, qr/\[ 2\.123_443_211/, q{TNVAVRV24d1 arrayref_to_string([ 2.123_443_211_234_432_1, ... ]) returns correct value, array beginning} );
            like( $tmp_retval, qr/, -33\.876_587/,    q{TNVAVRV24d2 arrayref_to_string([ 2.123_443_211_234_432_1, ... ]) returns correct value, array middle} );
            like( $tmp_retval, qr/, 1_701\.678_9 \]/, q{TNVAVRV24d3 arrayref_to_string([ 2.123_443_211_234_432_1, ... ]) returns correct value, array end} );
        },
                                                      q{TNVAVRV24d  arrayref_to_string([ 2.123_443_211_234_432_1, ... ]) lives}
    );
    lives_and(                                        # TNVAVRV24e
        sub {
            my string $tmp_retval = arrayref_to_string(                                my number_arrayref $foo = [ 2.123_443_211_234_432_1, 2_112.432_1, 42.456_7, 23.765_444_444_444_444_444, -877.567_8, -33.876_587_658_765_875_687_658_765, 1_701.678_9 ] );
            like( $tmp_retval, qr/\[ 2\.123_443_211/, q{TNVAVRV24e1 arrayref_to_string(my number_arrayref $foo = [ 2.123_443_211_234_432_1, ... ]) returns correct value, array beginning} );
            like( $tmp_retval, qr/, -33\.876_587/,    q{TNVAVRV24e2 arrayref_to_string(my number_arrayref $foo = [ 2.123_443_211_234_432_1, ... ]) returns correct value, array middle} );
            like( $tmp_retval, qr/, 1_701\.678_9 \]/, q{TNVAVRV24e3 arrayref_to_string(my number_arrayref $foo = [ 2.123_443_211_234_432_1, ... ]) returns correct value, array end} );
        },
                                                      q{TNVAVRV24e  arrayref_to_string(my number_arrayref $foo = [ 2.123_443_211_234_432_1, ... ]) lives}
    );
    lives_and(                                        # TNVAVRV24f
        sub {
            my string $tmp_retval = arrayref_to_string(                                bless [ 2.123_443_211_234_432_1, 2_112.432_1, 42.456_7, 23.765_444_444_444_444_444, -877.567_8, -33.876_587_658_765_875_687_658_765, 1_701.678_9 ], 'number_arrayref' );
            like( $tmp_retval, qr/\[ 2\.123_443_211/, q{TNVAVRV24f1 arrayref_to_string(bless [ 2.123_443_211_234_432_1, ... ], 'number_arrayref') returns correct value, array beginning} );
            like( $tmp_retval, qr/, -33\.876_587/,    q{TNVAVRV24f2 arrayref_to_string(bless [ 2.123_443_211_234_432_1, ... ], 'number_arrayref') returns correct value, array middle} );
            like( $tmp_retval, qr/, 1_701\.678_9 \]/, q{TNVAVRV24f3 arrayref_to_string(bless [ 2.123_443_211_234_432_1, ... ], 'number_arrayref') returns correct value, array end} );
        },
                                                      q{TNVAVRV24f  arrayref_to_string(bless [ 2.123_443_211_234_432_1, ... ], 'number_arrayref') lives}
    );


    throws_ok(                                                                # TNVAVRV30
        sub { number_arrayref_typetest0() },
        "/(ENVAVRV00.*$mode_tagline)|(Usage.*number_arrayref_typetest0)/",    # DEV NOTE: 2 different error messages, RPerl & C
        q{TNVAVRV30 number_arrayref_typetest0() throws correct exception}
    );
    throws_ok(                                                                 # TNVAVRV31
        sub { number_arrayref_typetest0(2) },
        "/ENVAVRV01.*$mode_tagline/",
        q{TNVAVRV31 number_arrayref_typetest0(2) throws correct exception}
    );
    throws_ok(                                                                 # TNVAVRV32
        sub {
            number_arrayref_typetest0( [ 2.123_443_211_234_432_1, 2_112.432_1, undef, 23.765_444_444_444_444_444, -877.567_8, -33.876_587_658_765_875_687_658_765, 1_701.678_9 ] );
        },
        "/ENVAVRV02.*$mode_tagline/",
        q{TNVAVRV32 number_arrayref_typetest0([ 2.123_443_211_234_432_1, 2_112.432_1, undef, 23.765_444_444_444_444_444, ..., 1_701.678_9 ]) throws correct exception}
    );
    throws_ok(                                                                 # TNVAVRV33
        sub {
            number_arrayref_typetest0(
                [ 2.123_443_211_234_432_1, 2_112.432_1, 42.456_7, 23.765_444_444_444_444_444, -877.567_8, 'abcdefg', -33.876_587_658_765_875_687_658_765, 1_701.678_9 ] );
        },
        "/ENVAVRV03.*$mode_tagline/",
        q{TNVAVRV33 number_arrayref_typetest0([ 2.123_443_211_234_432_1, ..., 'abcdefg', -33.876_587_658_765_875_687_658_765, 1_701.678_9 ]) throws correct exception}
    );
    
# OLD CODE: high precision numbers, causes failure on systems with different precision than original development system 
#    lives_and(                                                                 # TNVAVRV34
#        sub {
#            is( 
#                number_arrayref_typetest0( [ 2.123_443_211_234_432_1, 2_112.432_1, 42.456_7, 23.765_444_444_444_444_444, -877.567_8, -33.876_587_658_765_875_687_658_765, 1_701.678_9 ] ),
#                '[ 2.123_443_211_234_43, 2_112.432_1, 42.456_7, 23.765_444_444_444_4, -877.567_8, -33.876_587_658_765_9, 1_701.678_9 ]' . $mode_tagline,
#                q{TNVAVRV34 number_arrayref_typetest0([ 2.123_443_211_234_432_1, ... ]) returns correct value}
#            );
#        },
#        q{TNVAVRV34 number_arrayref_typetest0([ 2.123_443_211_234_432_1, ... ]) lives}
#    );
    lives_and(                                                                 # TNVAVRV34
        sub {
            my string $tmp_retval = number_arrayref_typetest0( [ 2.123_443_211_234_432_1, 2_112.432_1, 42.456_7, 23.765_444_444_444_444_444, -877.567_8, -33.876_587_658_765_875_687_658_765, 1_701.678_9 ] );
            like(
                $tmp_retval,
                qr/\[ 2\.123_443_211/,
                q{TNVAVRV34a number_arrayref_typetest0([ 2.123_443_211_234_432_1, ... ]) returns correct value, array beginning}
            );
            like(
                $tmp_retval,
                qr/, 1_701\.678_9 \]/,
                q{TNVAVRV34b number_arrayref_typetest0([ 2.123_443_211_234_432_1, ... ]) returns correct value, array end}
            );
            like(
                $tmp_retval,
                qr/$mode_tagline/,
                q{TNVAVRV34c number_arrayref_typetest0([ 2.123_443_211_234_432_1, ... ]) returns correct value, mode tagline}
            );
        },
        q{TNVAVRV34 number_arrayref_typetest0([ 2.123_443_211_234_432_1, ... ]) lives}
    );

    lives_and(                                                                 # TNVAVRV40
        sub {
            # NEED DELETE OLD CODE
#            is_deeply(
            delta_ok(
                number_arrayref_typetest1(5),
                [ 0, 5.123456789, 10.246913578, 15.370370367, 20.493827156 ]
                ,                                                              ## PERLTIDY BUG comma on newline
                q{TNVAVRV40 number_arrayref_typetest1(5) returns correct value}
            );
        },
        q{TNVAVRV40 number_arrayref_typetest1(5) lives}
    );

    # [[[ STRING ARRAY TESTS ]]]
    # [[[ STRING ARRAY TESTS ]]]
    # [[[ STRING ARRAY TESTS ]]]

    throws_ok(    # TPVAVRV00
        sub { string_arrayref_to_string() },
        "/(EPVAVRV00.*$mode_tagline)|(Usage.*string_arrayref_to_string)/",    # DEV NOTE: 2 different error messages, RPerl & C
        q{TPVAVRV00 string_arrayref_to_string() throws correct exception}
    );
    throws_ok(                                                                # TPVAVRV01
        sub { string_arrayref_to_string(undef) },
        "/EPVAVRV00.*$mode_tagline/",
        q{TPVAVRV01 string_arrayref_to_string(undef) throws correct exception}
    );
    throws_ok(                                                                # TPVAVRV02
        sub { string_arrayref_to_string(2) },
        "/EPVAVRV01.*$mode_tagline/",
        q{TPVAVRV02 string_arrayref_to_string(2) throws correct exception}
    );
    throws_ok(                                                                # TPVAVRV03
        sub { string_arrayref_to_string(2.3) },
        "/EPVAVRV01.*$mode_tagline/",
        q{TPVAVRV03 string_arrayref_to_string(2.3) throws correct exception}
    );
    throws_ok(                                                                # TPVAVRV04
        sub { string_arrayref_to_string('Lone Ranger') },
        "/EPVAVRV01.*$mode_tagline/",
        q{TPVAVRV04 string_arrayref_to_string('Lone Ranger') throws correct exception}
    );
    throws_ok(                                                                # TPVAVRV05
        sub { string_arrayref_to_string( { a_key => 'Lone Ranger' } ) },
        "/EPVAVRV01.*$mode_tagline/",
        q{TPVAVRV05 string_arrayref_to_string({a_key => 'Lone Ranger'}) throws correct exception}
    );
    throws_ok(                                                                # TPVAVRV10
        sub {
            string_arrayref_to_string( [ 'Superman', 'Batman', 'Wonder Woman', undef, 'Green Lantern', 'Aquaman', 'Martian Manhunter' ] );
        },
        "/EPVAVRV02.*$mode_tagline/",
        q{TPVAVRV10 string_arrayref_to_string([ 'Superman', 'Batman', 'Wonder Woman', undef, 'Green Lantern', 'Aquaman', 'Martian Manhunter' ]) throws correct exception}
    );
    throws_ok(                                                                # TPVAVRV11
        sub {
            string_arrayref_to_string( [ 'Superman', 'Batman', 23, 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter' ] );
        },
        "/EPVAVRV03.*$mode_tagline/",
        q{TPVAVRV11 string_arrayref_to_string([ 'Superman', 'Batman', 23, 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter' ]) throws correct exception}
    );
    throws_ok(                                                                # TPVAVRV12
        sub {
            string_arrayref_to_string( [ 'Superman', 'Batman', 23.2, 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter' ] );
        },
        "/EPVAVRV03.*$mode_tagline/",
        q{TPVAVRV12 string_arrayref_to_string([ 'Superman', 'Batman', 23.2, 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter' ]) throws correct exception}
    );
    throws_ok(                                                                # TPVAVRV13
        sub {
            string_arrayref_to_string( [ 'Superman', 'Batman', ['Wonder Woman'], 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter' ] );
        },
        "/EPVAVRV03.*$mode_tagline/",
        q{TPVAVRV13 string_arrayref_to_string([ 'Superman', 'Batman', ['Wonder Woman'], 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter' ]) throws correct exception}
    );
    throws_ok(                                                                # TPVAVRV14
        sub {
            string_arrayref_to_string( [ 'Superman', 'Batman', { a_subkey => 'Wonder Woman' }, 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter' ] );
        },
        "/EPVAVRV03.*$mode_tagline/",
        q{TPVAVRV14 string_arrayref_to_string([ 'Superman', 'Batman', {a_subkey => 'Wonder Woman'}, ..., 'Martian Manhunter' ]) throws correct exception}
    );


    throws_ok(  # TPVAVRV15, DYNAMIC DISPATCH
        sub {
            arrayref_to_string( bless [ 'Howard The Duck' ], 'integer_arrayref' );
        },
        "/EIVAVRV03.*$mode_tagline/",
        q{TPVAVRV15 arrayref_to_string( bless [ 'Howard The Duck' ], 'integer_arrayref' ) throws correct exception}
    );
    throws_ok(  # TPVAVRV16, DYNAMIC DISPATCH
        sub {
            arrayref_to_string( bless [ 'Howard The Duck' ], 'number_arrayref' );
        },
        "/ENVAVRV03.*$mode_tagline/",
        q{TPVAVRV16 arrayref_to_string( bless [ 'Howard The Duck' ], 'number_arrayref' ) throws correct exception}
    );


    lives_and(  # TPVAVRV20a
        sub {
            is(              string_arrayref_to_string([ 'Howard The Duck' ]),
                                                     q{[ 'Howard The Duck' ]},
                q{TPVAVRV20a string_arrayref_to_string([ 'Howard The Duck' ]) returns correct value}
            );
        },
                q{TPVAVRV20a string_arrayref_to_string([ 'Howard The Duck' ]) lives}
    );
    lives_and(  # TPVAVRV20b
        sub {
            is(              string_arrayref_to_string( my string_arrayref $foo = [ 'Howard The Duck' ] ),
                                                                                q{[ 'Howard The Duck' ]},
                q{TPVAVRV20b string_arrayref_to_string( my string_arrayref $foo = [ 'Howard The Duck' ] ) returns correct value}
            );
        },
                q{TPVAVRV20b string_arrayref_to_string( my string_arrayref $foo = [ 'Howard The Duck' ] ) lives}
    );
    lives_and(  # TPVAVRV20c
        sub {
            is(              string_arrayref_to_string( bless [ 'Howard The Duck' ], 'string_arrayref' ),
                                                            q{[ 'Howard The Duck' ]},
                q{TPVAVRV20c string_arrayref_to_string( bless [ 'Howard The Duck' ], 'string_arrayref' ) returns correct value}
            );
        },
                q{TPVAVRV20c string_arrayref_to_string( bless [ 'Howard The Duck' ], 'string_arrayref' ) lives}
    );
    lives_and(  # TPVAVRV20d, DYNAMIC DISPATCH
        sub {
            is(                     arrayref_to_string([ 'Howard The Duck' ]),
                                                     q{[ 'Howard The Duck' ]},
                q{TPVAVRV20d        arrayref_to_string([ 'Howard The Duck' ]) returns correct value}
            );
        },
                q{TPVAVRV20d        arrayref_to_string([ 'Howard The Duck' ]) lives}
    );
    lives_and(  # TPVAVRV20e, DYNAMIC DISPATCH
        sub {
            is(                     arrayref_to_string( my string_arrayref $foo = [ 'Howard The Duck' ] ),
                                                                                q{[ 'Howard The Duck' ]},
                q{TPVAVRV20e        arrayref_to_string( my string_arrayref $foo = [ 'Howard The Duck' ] ) returns correct value}
            );
        },
                q{TPVAVRV20e        arrayref_to_string( my string_arrayref $foo = [ 'Howard The Duck' ] ) lives}
    );
    lives_and(  # TPVAVRV20f, DYNAMIC DISPATCH
        sub {
            is(                     arrayref_to_string( bless [ 'Howard The Duck' ], 'string_arrayref' ),
                                                            q{[ 'Howard The Duck' ]},
                q{TPVAVRV20f        arrayref_to_string( bless [ 'Howard The Duck' ], 'string_arrayref' ) returns correct value}
            );
        },
                q{TPVAVRV20f        arrayref_to_string( bless [ 'Howard The Duck' ], 'string_arrayref' ) lives}
    );


    lives_and(  # TPVAVRV21a
        sub {
            is(              string_arrayref_to_string( [ 'Howard The Duck', 'Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter' ] ),
                                                      q{[ 'Howard The Duck', 'Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter' ]},
                q{TPVAVRV21a string_arrayref_to_string( [ 'Howard The Duck', 'Superman', 'Batman', 'Wonder Woman', ..., 'Martian Manhunter' ] ) returns correct value}
            );
        },
                q{TPVAVRV21a string_arrayref_to_string( [ 'Howard The Duck', 'Superman', 'Batman', 'Wonder Woman', ..., 'Martian Manhunter' ] ) lives}
    );
    lives_and(  # TPVAVRV21b
        sub {
            is(              string_arrayref_to_string( my string_arrayref $foo = [ 'Howard The Duck', 'Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter' ] ),
                                                                                q{[ 'Howard The Duck', 'Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter' ]},
                q{TPVAVRV21b string_arrayref_to_string( my string_arrayref $foo = [ 'Howard The Duck', 'Superman', 'Batman', 'Wonder Woman', ..., 'Martian Manhunter' ] ) returns correct value}
            );
        },
                q{TPVAVRV21b string_arrayref_to_string( my string_arrayref $foo = [ 'Howard The Duck', 'Superman', 'Batman', 'Wonder Woman', ..., 'Martian Manhunter' ] ) lives}
    );
    lives_and(  # TPVAVRV21c
        sub {
            is(              string_arrayref_to_string( bless [ 'Howard The Duck', 'Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter' ], 'string_arrayref' ),
                                                            q{[ 'Howard The Duck', 'Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter' ]},
                q{TPVAVRV21c string_arrayref_to_string( bless [ 'Howard The Duck', 'Superman', 'Batman', 'Wonder Woman', ..., 'Martian Manhunter' ], 'string_arrayref' ) returns correct value}
            );
        },
                q{TPVAVRV21c string_arrayref_to_string( bless [ 'Howard The Duck', 'Superman', 'Batman', 'Wonder Woman', ..., 'Martian Manhunter' ], 'string_arrayref' ) lives}
    );
    lives_and(  # TPVAVRV21d, DYNAMIC DISPATCH
        sub {
            is(                     arrayref_to_string( [ 'Howard The Duck', 'Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter' ] ),
                                                      q{[ 'Howard The Duck', 'Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter' ]},
                q{TPVAVRV21d        arrayref_to_string( [ 'Howard The Duck', 'Superman', 'Batman', 'Wonder Woman', ..., 'Martian Manhunter' ] ) returns correct value}
            );
        },
                q{TPVAVRV21d        arrayref_to_string( [ 'Howard The Duck', 'Superman', 'Batman', 'Wonder Woman', ..., 'Martian Manhunter' ] ) lives}
    );
    lives_and(  # TPVAVRV21e, DYNAMIC DISPATCH
        sub {
            is(                     arrayref_to_string( my string_arrayref $foo = [ 'Howard The Duck', 'Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter' ] ),
                                                                                q{[ 'Howard The Duck', 'Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter' ]},
                q{TPVAVRV21e        arrayref_to_string( my string_arrayref $foo = [ 'Howard The Duck', 'Superman', 'Batman', 'Wonder Woman', ..., 'Martian Manhunter' ] ) returns correct value}
            );
        },
                q{TPVAVRV21e        arrayref_to_string( my string_arrayref $foo = [ 'Howard The Duck', 'Superman', 'Batman', 'Wonder Woman', ..., 'Martian Manhunter' ] ) lives}
    );
    lives_and(  # TPVAVRV21f, DYNAMIC DISPATCH
        sub {
            is(                     arrayref_to_string( bless [ 'Howard The Duck', 'Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter' ], 'string_arrayref' ),
                                                            q{[ 'Howard The Duck', 'Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter' ]},
                q{TPVAVRV21f        arrayref_to_string( bless [ 'Howard The Duck', 'Superman', 'Batman', 'Wonder Woman', ..., 'Martian Manhunter' ], 'string_arrayref' ) returns correct value}
            );
        },
                q{TPVAVRV21f        arrayref_to_string( bless [ 'Howard The Duck', 'Superman', 'Batman', 'Wonder Woman', ..., 'Martian Manhunter' ], 'string_arrayref' ) lives}
    );


    # tests to ensure string parsing does not incorrectly detect void or number or array or hash when inside quotes
    lives_and(  # TPVAVRV22a
        sub {
            is(              string_arrayref_to_string([ 'Superman', 'Martian Manhunter', 'undef', '23', '-2_112.23', "[\\'Tonto'\\]", '{buzz => 5}' ]),
                                                     q{[ 'Superman', 'Martian Manhunter', 'undef', '23', '-2_112.23', '[\\\\\'Tonto\'\\\\]', '{buzz => 5}' ]},
                q{TPVAVRV22a string_arrayref_to_string([ 'Superman', 'Martian Manhunter', 'undef', '23', '-2_112.23', "[\\'Tonto'\\]", '{buzz => 5}' ]) returns correct value}
            );
        },
                q{TPVAVRV22a string_arrayref_to_string([ 'Superman', 'Martian Manhunter', 'undef', '23', '-2_112.23', "[\\'Tonto'\\]", '{buzz => 5}' ]) lives}
    );
    lives_and(  # TPVAVRV22b
        sub {
            is(              string_arrayref_to_string( my string_arrayref $foo = [ 'Superman', 'Martian Manhunter', 'undef', '23', '-2_112.23', "[\\'Tonto'\\]", '{buzz => 5}' ] ),
                                                                                 q{[ 'Superman', 'Martian Manhunter', 'undef', '23', '-2_112.23', '[\\\\\'Tonto\'\\\\]', '{buzz => 5}' ]},
                q{TPVAVRV22b string_arrayref_to_string( my string_arrayref $foo = [ 'Superman', 'Martian Manhunter', 'undef', '23', '-2_112.23', "[\\'Tonto'\\]", '{buzz => 5}' ] ) returns correct value}
            );
        },
                q{TPVAVRV22b string_arrayref_to_string( my string_arrayref $foo = [ 'Superman', 'Martian Manhunter', 'undef', '23', '-2_112.23', "[\\'Tonto'\\]", '{buzz => 5}' ] ) lives}
    );
    lives_and(  # TPVAVRV22c
        sub {
            is(              string_arrayref_to_string( bless [ 'Superman', 'Martian Manhunter', 'undef', '23', '-2_112.23', "[\\'Tonto'\\]", '{buzz => 5}' ], 'string_arrayref' ),
                                                            q{[ 'Superman', 'Martian Manhunter', 'undef', '23', '-2_112.23', '[\\\\\'Tonto\'\\\\]', '{buzz => 5}' ]},
                q{TPVAVRV22c string_arrayref_to_string( bless [ 'Superman', 'Martian Manhunter', 'undef', '23', '-2_112.23', "[\\'Tonto'\\]", '{buzz => 5}' ], 'string_arrayref' ) returns correct value}
            );
        },
                q{TPVAVRV22c string_arrayref_to_string( bless [ 'Superman', 'Martian Manhunter', 'undef', '23', '-2_112.23', "[\\'Tonto'\\]", '{buzz => 5}' ], 'string_arrayref' ) lives}
    );
    lives_and(  # TPVAVRV22d, DYNAMIC DISPATCH
        sub {
            is(                     arrayref_to_string([ 'Superman', 'Martian Manhunter', 'undef', '23', '-2_112.23', "[\\'Tonto'\\]", '{buzz => 5}' ]),
                                                     q{[ 'Superman', 'Martian Manhunter', 'undef', '23', '-2_112.23', '[\\\\\'Tonto\'\\\\]', '{buzz => 5}' ]},
                q{TPVAVRV22d        arrayref_to_string([ 'Superman', 'Martian Manhunter', 'undef', '23', '-2_112.23', "[\\'Tonto'\\]", '{buzz => 5}' ]) returns correct value}
            );
        },
                q{TPVAVRV22d        arrayref_to_string([ 'Superman', 'Martian Manhunter', 'undef', '23', '-2_112.23', "[\\'Tonto'\\]", '{buzz => 5}' ]) lives}
    );
    lives_and(  # TPVAVRV22e, DYNAMIC DISPATCH
        sub {
            is(                     arrayref_to_string( my string_arrayref $foo = [ 'Superman', 'Martian Manhunter', 'undef', '23', '-2_112.23', "[\\'Tonto'\\]", '{buzz => 5}' ] ),
                                                                                 q{[ 'Superman', 'Martian Manhunter', 'undef', '23', '-2_112.23', '[\\\\\'Tonto\'\\\\]', '{buzz => 5}' ]},
                q{TPVAVRV22e        arrayref_to_string( my string_arrayref $foo = [ 'Superman', 'Martian Manhunter', 'undef', '23', '-2_112.23', "[\\'Tonto'\\]", '{buzz => 5}' ] ) returns correct value}
            );
        },
                q{TPVAVRV22e        arrayref_to_string( my string_arrayref $foo = [ 'Superman', 'Martian Manhunter', 'undef', '23', '-2_112.23', "[\\'Tonto'\\]", '{buzz => 5}' ] ) lives}
    );
    lives_and(  # TPVAVRV22f, DYNAMIC DISPATCH
        sub {
            is(                     arrayref_to_string( bless [ 'Superman', 'Martian Manhunter', 'undef', '23', '-2_112.23', "[\\'Tonto'\\]", '{buzz => 5}' ], 'string_arrayref' ),
                                                            q{[ 'Superman', 'Martian Manhunter', 'undef', '23', '-2_112.23', '[\\\\\'Tonto\'\\\\]', '{buzz => 5}' ]},
                q{TPVAVRV22f        arrayref_to_string( bless [ 'Superman', 'Martian Manhunter', 'undef', '23', '-2_112.23', "[\\'Tonto'\\]", '{buzz => 5}' ], 'string_arrayref' ) returns correct value}
            );
        },
                q{TPVAVRV22f        arrayref_to_string( bless [ 'Superman', 'Martian Manhunter', 'undef', '23', '-2_112.23', "[\\'Tonto'\\]", '{buzz => 5}' ], 'string_arrayref' ) lives}
    );


    throws_ok(                                                                # TPVAVRV30
        sub { string_arrayref_typetest0() },
        "/(EPVAVRV00.*$mode_tagline)|(Usage.*string_arrayref_typetest0)/",    # DEV NOTE: 2 different error messages, RPerl & C
        q{TPVAVRV30 string_arrayref_typetest0() throws correct exception}
    );
    throws_ok(                                                                 # TPVAVRV31
        sub { string_arrayref_typetest0(2) },
        "/EPVAVRV01.*$mode_tagline/",
        q{TPVAVRV31 string_arrayref_typetest0(2) throws correct exception}
    );
    throws_ok(                                                                 # TPVAVRV32
        sub {
            string_arrayref_typetest0( [ 'Superman', 'Batman', 'Wonder Woman', undef, 'Green Lantern', 'Aquaman', 'Martian Manhunter' ] );
        },
        "/EPVAVRV02.*$mode_tagline/",
        q{TPVAVRV32 string_arrayref_typetest0([ 'Superman', 'Batman', 'Wonder Woman', undef, 'Green Lantern', 'Aquaman', 'Martian Manhunter' ]) throws correct exception}
    );
    throws_ok(                                                                 # TPVAVRV33
        sub {
            string_arrayref_typetest0( [ 'Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter', [ 23, -42.3 ] ] );
        },
        "/EPVAVRV03.*$mode_tagline/",
        q{TPVAVRV33 string_arrayref_typetest0([ 'Superman', 'Batman', 'Wonder Woman', ..., 'Martian Manhunter', [ 23, -42.3 ] ]) throws correct exception}
    );
    lives_and(                                                                 # TPVAVRV34
        sub {
            is( string_arrayref_typetest0( [ 'Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter' ] ),
                q{[ 'Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter' ]} . $mode_tagline,
                q{TPVAVRV34 string_arrayref_typetest0([ 'Superman', ..., 'Green Lantern', 'Aquaman', 'Martian Manhunter' ]) returns correct value}
            );
        },
        q{TPVAVRV34 string_arrayref_typetest0([ 'Superman', ..., 'Green Lantern', 'Aquaman', 'Martian Manhunter' ]) lives}
    );
    lives_and(                                                                 # TPVAVRV40
        sub {
            is_deeply(
                string_arrayref_typetest1(5),
                [   'Jeffy Ten! 0/4 ' . $mode_tagline,
                    'Jeffy Ten! 1/4 ' . $mode_tagline,
                    'Jeffy Ten! 2/4 ' . $mode_tagline,
                    'Jeffy Ten! 3/4 ' . $mode_tagline,
                    'Jeffy Ten! 4/4 ' . $mode_tagline,
                ],
                q{TPVAVRV40 string_arrayref_typetest1(5) returns correct value}
            );
        },
        q{TPVAVRV40 string_arrayref_typetest1(5) lives}
    );
}

done_testing();
