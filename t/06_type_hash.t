#!/usr/bin/perl
use strict;
use warnings;
our $VERSION = 0.004_010;

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitStringySplit ProhibitInterpolationOfLiterals)  # DEVELOPER DEFAULT 2: allow string test values
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

use RPerl::Test;
use Test::More tests => 219;
use Test::Exception;

BEGIN {
    if ( $ENV{TEST_VERBOSE} ) {
        diag(
            '[[[ Beginning Hash Type Pre-Test Loading, RPerl Type System ]]]'
        );
    }
    lives_and( sub { use_ok('RPerl'); }, q{use_ok('RPerl') lives} );
    lives_and(
        sub { use_ok('RPerl::DataStructure::Hash_cpp'); },
        q{use_ok('RPerl::DataStructure::Hash_cpp') lives}
    );
}

# [[[ PRIMARY RUNLOOP ]]]
# [[[ PRIMARY RUNLOOP ]]]
# [[[ PRIMARY RUNLOOP ]]]

# loop 3 times, once for each mode: Pure-Perl, RPerl Perl-Data, and RPerl C-Data
foreach
    my scalartype__hash_ref $mode ( @{ $RPerl::Test::properties_class{modes} } ) ## no critic qw(ProhibitPackageVars)  # USER DEFAULT 3: allow OO properties
{
#    RPerl::diag "in 06_type_hash.t, top of for() loop, have \$OPS_TYPES_ID = $OPS_TYPES_ID\n" or croak; # no effect if suppressing output!
    if ( $ENV{TEST_VERBOSE} ) {
        Test::More::diag( '[[[ Beginning RPerl Hash Type Tests, '
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
        delete $main::{'RPerl__DataStructure__Hash__ops'};

        # Hash: C++ use, load, link
        lives_and(
            sub { require_ok('RPerl::DataStructure::Hash_cpp'); },
            q{require_ok('RPerl::DataStructure::Hash_cpp') lives}
        );
        lives_ok(
            sub { RPerl::DataStructure::Hash_cpp::cpp_load(); },
            q{RPerl::DataStructure::Hash_cpp::cpp_load() lives}
        );
    }

    foreach my string $type (qw(integer number string hash)) {
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

    # [[[ INTEGER HASH TESTS ]]]
    # [[[ INTEGER HASH TESTS ]]]
    # [[[ INTEGER HASH TESTS ]]]

    throws_ok(    # TIVHVRV00
        sub { integer__hash_ref__stringify() },
        "/(EIVHVRV00.*$OPS_TYPES)|(Usage.*integer__hash_ref__stringify)/", # DEV NOTE: 2 different error messages, RPerl & C
        q{TIVHVRV00 integer__hash_ref__stringify() throws correct exception}
    );
    throws_ok(    # TIVHVRV01
        sub { integer__hash_ref__stringify(undef) },
        "/EIVHVRV00.*$OPS_TYPES/",
        q{TIVHVRV01 integer__hash_ref__stringify(undef) throws correct exception}
    );
    throws_ok(    # TIVHVRV02
        sub { integer__hash_ref__stringify(2) },
        "/EIVHVRV01.*$OPS_TYPES/",
        q{TIVHVRV02 integer__hash_ref__stringify(2) throws correct exception}
    );
    throws_ok(    # TIVHVRV03
        sub { integer__hash_ref__stringify(2.3) },
        "/EIVHVRV01.*$OPS_TYPES/",
        q{TIVHVRV03 integer__hash_ref__stringify(2.3) throws correct exception}
    );
    throws_ok(    # TIVHVRV04
        sub { integer__hash_ref__stringify('2') },
        "/EIVHVRV01.*$OPS_TYPES/",
        q{TIVHVRV04 integer__hash_ref__stringify('2') throws correct exception}
    );
    throws_ok(    # TIVHVRV05
        sub { integer__hash_ref__stringify( [2] ) },
        "/EIVHVRV01.*$OPS_TYPES/",
        q{TIVHVRV05 integer__hash_ref__stringify([2]) throws correct exception}
    );
    throws_ok(    # TIVHVRV10
        sub {
            integer__hash_ref__stringify(
                {   a_key => 2,
                    b_key => 2112,
                    c_key => undef,
                    d_key => 23,
                    e_key => -877,
                    f_key => -33,
                    g_key => 1701
                }
            );
        },
        "/EIVHVRV02.*$OPS_TYPES/",
        q{TIVHVRV10 integer__hash_ref__stringify({a_key => 2, b_key => 2112, c_key => undef, d_key => 23, e_key => -877, f_key => -33, g_key => 1701}) throws correct exception}
    );
    throws_ok(    # TIVHVRV11
        sub {
            integer__hash_ref__stringify(
                {   a_key => 2,
                    b_key => 2112,
                    c_key => 42,
                    d_key => 23.3,
                    e_key => -877,
                    f_key => -33,
                    g_key => 1701
                }
            );
        },
        "/EIVHVRV03.*$OPS_TYPES/",
        q{TIVHVRV11 integer__hash_ref__stringify({a_key => 2, b_key => 2112, c_key => 42, d_key => 23.3, e_key => -877, f_key => -33, g_key => 1701}) throws correct exception}
    );
    throws_ok(    # TIVHVRV12
        sub {
            integer__hash_ref__stringify(
                {   a_key => 2,
                    b_key => 2112,
                    c_key => 42,
                    d_key => '23',
                    e_key => -877,
                    f_key => -33,
                    g_key => 1701
                }
            );
        },
        "/EIVHVRV03.*$OPS_TYPES/",
        q{TIVHVRV12 integer__hash_ref__stringify({a_key => 2, b_key => 2112, c_key => 42, d_key => '23', e_key => -877, f_key => -33, g_key => 1701}) throws correct exception}
    );
    throws_ok(    # TIVHVRV13
        sub {
            integer__hash_ref__stringify(
                {   a_key => 2,
                    b_key => 2112,
                    c_key => 42,
                    d_key => [23],
                    e_key => -877,
                    f_key => -33,
                    g_key => 1701
                }
            );
        },
        "/EIVHVRV03.*$OPS_TYPES/",
        q{TIVHVRV13 integer__hash_ref__stringify({a_key => 2, b_key => 2112, c_key => 42, d_key => [23], e_key => -877, f_key => -33, g_key => 1701}) throws correct exception}
    );
    throws_ok(    # TIVHVRV14
        sub {
            integer__hash_ref__stringify(
                {   a_key => 2,
                    b_key => 2112,
                    c_key => 42,
                    d_key => { a_subkey => 23 },
                    e_key => -877,
                    f_key => -33,
                    g_key => 1701
                }
            );
        },
        "/EIVHVRV03.*$OPS_TYPES/",

#        q{TIVHVRV14 integer__hash_ref__stringify({a_key => 2, b_key => 2112, c_key => 42, d_key => {a_subkey => 23}, e_key => -877, f_key => -33, g_key => 1701}) throws correct exception}
        q{TIVHVRV14 integer__hash_ref__stringify({a_key => 2, b_key => 2112, c_key => 42, d_key => {a_subkey => 23}, ..., g_key => 1701}) throws correct exception}
    );
    lives_and(    # TIVHVRV20
        sub {
            is( integer__hash_ref__stringify( { a_key => 23 } ),
                q{{'a_key' => 23}},
                q{TIVHVRV20 integer__hash_ref__stringify({a_key => 23}) returns correct value}
            );
        },
        q{TIVHVRV20 integer__hash_ref__stringify({a_key => 23}) lives}
    );
    lives_and(    # TIVHVRV21
        sub {
            like(
                integer__hash_ref__stringify(
                    {   a_key => 2,
                        b_key => 2112,
                        c_key => 42,
                        d_key => 23,
                        e_key => -877,
                        f_key => -33,
                        g_key => 1701
                    }
                ),

# NEED FIX: replace ".*" near end of this & following regexes with syntax to match exactly 6 occurrences of ", "; (,\s)* and variations don't work?
                q{/^\{(?=.*'a_key' => 2\b)(?=.*'b_key' => 2112\b)(?=.*'c_key' => 42\b)(?=.*'d_key' => 23\b)(?=.*'e_key' => -877\b)(?=.*'f_key' => -33\b)(?=.*'g_key' => 1701\b).*\}$/m},
                q{TIVHVRV21 integer__hash_ref__stringify({a_key => 2, b_key => 2112, c_key => 42, d_key => 23, e_key => -877, f_key => -33, g_key => 1701}) returns correct value}
            );
        },
        q{TIVHVRV21 integer__hash_ref__stringify({a_key => 2, b_key => 2112, c_key => 42, d_key => 23, e_key => -877, f_key => -33, g_key => 1701}) lives}
    );
    throws_ok(    # TIVHVRV30
        sub { integer__hash_ref__typetest0() },
        "/(EIVHVRV00.*$OPS_TYPES)|(Usage.*integer__hash_ref__typetest0)/", # DEV NOTE: 2 different error messages, RPerl & C
        q{TIVHVRV30 integer__hash_ref__typetest0() throws correct exception}
    );
    throws_ok(    # TIVHVRV31
        sub { integer__hash_ref__typetest0(2) },
        "/EIVHVRV01.*$OPS_TYPES/",
        q{TIVHVRV31 integer__hash_ref__typetest0(2) throws correct exception}
    );
    throws_ok(    # TIVHVRV32
        sub {
            integer__hash_ref__typetest0(
                {   'binary'       => 2,
                    'rush'         => 2112,
                    'ERROR_FUNKEY' => undef,
                    'answer'       => 42,
                    'fnord'        => 23,
                    'units'        => -877,
                    'degree'       => -33,
                    'ncc'          => 1701
                }
            );
        },
        "/EIVHVRV02.*$OPS_TYPES/",
        q{TIVHVRV32 integer__hash_ref__typetest0({'binary' => 2, 'rush' => 2112, 'ERROR_FUNKEY' => undef, ..., 'ncc' => 1701}) throws correct exception}
    );
    throws_ok(    # TIVHVRV33
        sub {
            integer__hash_ref__typetest0(
                {   'binary'       => 2,
                    'rush'         => 2112,
                    'ERROR_FUNKEY' => 'abcdefg',
                    'answer'       => 42,
                    'fnord'        => 23,
                    'units'        => -877,
                    'degree'       => -33,
                    'ncc'          => 1701
                }
            );
        },
        "/EIVHVRV03.*$OPS_TYPES/",
        q{TIVHVRV33 integer__hash_ref__typetest0({'binary' => 2, 'rush' => 2112, 'ERROR_FUNKEY' => 'abcdefg', ..., 'ncc' => 1701}) throws correct exception}
    );
    lives_and(    # TIVHVRV34
        sub {
            like(
                integer__hash_ref__typetest0(
                    {   'binary' => 2,
                        'rush'   => 2112,
                        'answer' => 42,
                        'fnord'  => 23,
                        'units'  => -877,
                        'degree' => -33,
                        'ncc'    => 1701
                    }
                ),
                q{/^\{(?=.*'binary' => 2\b)(?=.*'rush' => 2112\b)(?=.*'answer' => 42\b)(?=.*'fnord' => 23\b)(?=.*'units' => -877\b)(?=.*'degree' => -33\b)(?=.*'ncc' => 1701\b).*\}}
                    . $OPS_TYPES . q{$/m},

#                q{TIVHVRV34 integer__hash_ref__typetest0({'binary' => 2, 'rush' => 2112, 'answer' => 42, 'fnord' => 23, 'units' => -877, 'degree' => -33, 'ncc' => 1701}) returns correct value}
                q{TIVHVRV34 integer__hash_ref__typetest0({'binary' => 2, 'rush' => 2112, ..., 'ncc' => 1701}) returns correct value}
            );
        },
        q{TIVHVRV34 integer__hash_ref__typetest0({'binary' => 2, 'rush' => 2112, ..., 'ncc' => 1701}) lives}
    );
    lives_and(    # TIVHVRV40
        sub {
            is_deeply(
                integer__hash_ref__typetest1(5),
                {   "$OPS_TYPES\_funkey2" => 10,
                    "$OPS_TYPES\_funkey3" => 15,
                    "$OPS_TYPES\_funkey4" => 20,
                    "$OPS_TYPES\_funkey1" => 5,
                    "$OPS_TYPES\_funkey0" => 0
                },
                q{TIVHVRV40 integer__hash_ref__typetest1(5) returns correct value}
            );
        },
        q{TIVHVRV40 integer__hash_ref__typetest1(5) lives}
    );

    # [[[ NUMBER HASH TESTS ]]]
    # [[[ NUMBER HASH TESTS ]]]
    # [[[ NUMBER HASH TESTS ]]]

    throws_ok(    # TNVHVRV00
        sub { number__hash_ref__stringify() },
        "/(ENVHVRV00.*$OPS_TYPES)|(Usage.*number__hash_ref__stringify)/", # DEV NOTE: 2 different error messages, RPerl & C
        q{TNVHVRV00 number__hash_ref__stringify() throws correct exception}
    );
    throws_ok(    # TNVHVRV01
        sub { number__hash_ref__stringify(undef) },
        "/ENVHVRV00.*$OPS_TYPES/",
        q{TNVHVRV01 number__hash_ref__stringify(undef) throws correct exception}
    );
    throws_ok(    # TNVHVRV02
        sub { number__hash_ref__stringify(2) },
        "/ENVHVRV01.*$OPS_TYPES/",
        q{TNVHVRV02 number__hash_ref__stringify(2) throws correct exception}
    );
    throws_ok(    # TNVHVRV03
        sub { number__hash_ref__stringify(2.3) },
        "/ENVHVRV01.*$OPS_TYPES/",
        q{TNVHVRV03 number__hash_ref__stringify(2.3) throws correct exception}
    );
    throws_ok(    # TNVHVRV04
        sub { number__hash_ref__stringify('2') },
        "/ENVHVRV01.*$OPS_TYPES/",
        q{TNVHVRV04 number__hash_ref__stringify('2') throws correct exception}
    );
    throws_ok(    # TNVHVRV05
        sub { number__hash_ref__stringify( [2] ) },
        "/ENVHVRV01.*$OPS_TYPES/",
        q{TNVHVRV05 number__hash_ref__stringify([2]) throws correct exception}
    );
    throws_ok(    # TNVHVRV10
        sub {
            number__hash_ref__stringify(
                {   a_key => 2,
                    b_key => 2112,
                    c_key => undef,
                    d_key => 23,
                    e_key => -877,
                    f_key => -33,
                    g_key => 1701
                }
            );
        },
        "/ENVHVRV02.*$OPS_TYPES/",
        q{TNVHVRV10 number__hash_ref__stringify({a_key => 2, b_key => 2112, c_key => undef, d_key => 23, e_key => -877, f_key => -33, g_key => 1701}) throws correct exception}
    );
    throws_ok(    # TNVHVRV11
        sub {
            number__hash_ref__stringify(
                {   a_key => 2,
                    b_key => 2112,
                    c_key => 42.3,
                    d_key => '23',
                    e_key => -877,
                    f_key => -33,
                    g_key => 1701
                }
            );
        },
        "/ENVHVRV03.*$OPS_TYPES/",
        q{TNVHVRV11 number__hash_ref__stringify({a_key => 2, b_key => 2112, c_key => 42.3, d_key => '23', e_key => -877, f_key => -33, g_key => 1701}) throws correct exception}
    );
    throws_ok(    # TNVHVRV12
        sub {
            number__hash_ref__stringify(
                {   a_key => 2,
                    b_key => 2112,
                    c_key => 42.3,
                    d_key => [23],
                    e_key => -877,
                    f_key => -33,
                    g_key => 1701
                }
            );
        },
        "/ENVHVRV03.*$OPS_TYPES/",
        q{TNVHVRV12 number__hash_ref__stringify({a_key => 2, b_key => 2112, c_key => 42.3, d_key => [23], e_key => -877, f_key => -33, g_key => 1701}) throws correct exception}
    );
    throws_ok(    # TNVHVRV13
        sub {
            number__hash_ref__stringify(
                {   a_key => 2,
                    b_key => 2112,
                    c_key => 42.3,
                    d_key => { a_subkey => 23 },
                    e_key => -877,
                    f_key => -33,
                    g_key => 1701
                }
            );
        },
        "/ENVHVRV03.*$OPS_TYPES/",

#        q{TNVHVRV13 number__hash_ref__stringify({a_key => 2, b_key => 2112, c_key => 42.3, d_key => {a_subkey => 23}, e_key => -877, f_key => -33, g_key => 1701}) throws correct exception}
        q{TNVHVRV13 number__hash_ref__stringify({a_key => 2, b_key => 2112, c_key => 42.3, d_key => {a_subkey => 23}, ..., g_key => 1701}) throws correct exception}
    );
    lives_and(    # TNVHVRV20
        sub {
            is( number__hash_ref__stringify( { a_key => 23 } ),
                q{{'a_key' => 23}},
                q{TNVHVRV20 number__hash_ref__stringify({a_key => 23}) returns correct value}
            );
        },
        q{TNVHVRV20 number__hash_ref__stringify({a_key => 23}) lives}
    );
    lives_and(    # TNVHVRV21
        sub {
            like(
                number__hash_ref__stringify(
                    {   a_key => 2,
                        b_key => 2112,
                        c_key => 42,
                        d_key => 23,
                        e_key => -877,
                        f_key => -33,
                        g_key => 1701
                    }
                ),

                q{/^\{(?=.*'a_key' => 2\b)(?=.*'b_key' => 2112\b)(?=.*'c_key' => 42\b)(?=.*'d_key' => 23\b)(?=.*'e_key' => -877\b)(?=.*'f_key' => -33\b)(?=.*'g_key' => 1701\b).*\}$/m},
                q{TNVHVRV21 number__hash_ref__stringify({a_key => 2, b_key => 2112, c_key => 42, d_key => 23, e_key => -877, f_key => -33, g_key => 1701}) returns correct value}
            );
        },
        q{TNVHVRV21 number__hash_ref__stringify({a_key => 2, b_key => 2112, c_key => 42, d_key => 23, e_key => -877, f_key => -33, g_key => 1701}) lives}
    );
    lives_and(    # TNVHVRV22
        sub {
            is( number__hash_ref__stringify(
                    { a_key => 2.1234432112344321 }
                ),
                q{{'a_key' => 2.12344321123443}},
                q{TNVHVRV22 number__hash_ref__stringify({a_key => 2.1234432112344321}) returns correct value}
            );
        },
        q{TNVHVRV22 number__hash_ref__stringify({a_key => 2.1234432112344321}) lives}
    );
    lives_and(    # TNVHVRV23
        sub {
            like(
                number__hash_ref__stringify(
                    {   a_key => 2.1234432112344321,
                        b_key => 2112.4321,
                        c_key => 42.4567,
                        d_key => 23.765444444444444444,
                        e_key => -877.5678,
                        f_key => -33.876587658765875687658765,
                        g_key => 1701.6789
                    }
                ),
                q{/^\{(?=.*'a_key' => 2\.12344321123443\b)(?=.*'b_key' => 2112\.4321\b)(?=.*'c_key' => 42\.4567\b)(?=.*'d_key' => 23\.7654444444444\b)(?=.*'e_key' => -877\.5678\b)(?=.*'f_key' => -33\.8765876587659\b)(?=.*'g_key' => 1701\.6789\b).*\}$/m},

#                q{TNVHVRV23 number__hash_ref__stringify(a_key => 2.1234432112344321, b_key => 2112.4321, c_key => 42.4567, d_key => 23.765444444444444444, e_key => -877.5678, f_key => -33.876587658765875687658765, g_key => 1701.6789) returns correct value}
                q{TNVHVRV23 number__hash_ref__stringify(a_key => 2.1234432112344321, b_key => 2112.4321, c_key => 42.4567, ..., g_key => 1701.6789) returns correct value}
            );
        },
        q{TNVHVRV23 number__hash_ref__stringify(a_key => 2.1234432112344321, b_key => 2112.4321, c_key => 42.4567, d_key => 23.765444444444444444, e_key => -877.5678, f_key => -33.876587658765875687658765, g_key => 1701.6789) lives}
    );
    throws_ok(    # TNVHVRV30
        sub { number__hash_ref__typetest0() },
        "/(ENVHVRV00.*$OPS_TYPES)|(Usage.*number__hash_ref__typetest0)/", # DEV NOTE: 2 different error messages, RPerl & C
        q{TNVHVRV30 number__hash_ref__typetest0() throws correct exception}
    );
    throws_ok(    # TNVHVRV31
        sub { number__hash_ref__typetest0(2) },
        "/ENVHVRV01.*$OPS_TYPES/",
        q{TNVHVRV31 number__hash_ref__typetest0(2) throws correct exception}
    );
    throws_ok(    # TNVHVRV32
        sub {
            number__hash_ref__typetest0(
                {   'binary'       => 2.1234432112344321,
                    'rush'         => 2112.4321,
                    'ERROR_FUNKEY' => undef,
                    'answer'       => 42.4567,
                    'fnord'        => 23.765444444444444444,
                    'units'        => -877.5678,
                    'degree'       => -33.876587658765875687658765,
                    'ncc'          => 1701.6789
                }
            );
        },
        "/ENVHVRV02.*$OPS_TYPES/",
        q{TNVHVRV32 number__hash_ref__typetest0({'binary' => 2.1234432112344321, 'ERROR_FUNKEY' => undef, ..., 'ncc' => 1701.6789}) throws correct exception}
    );
    throws_ok(    # TNVHVRV33
        sub {
            number__hash_ref__typetest0(
                {   'binary'       => 2.1234432112344321,
                    'rush'         => 2112.4321,
                    'ERROR_FUNKEY' => 'abcdefg',
                    'answer'       => 42.4567,
                    'fnord'        => 23.765444444444444444,
                    'units'        => -877.5678,
                    'degree'       => -33.876587658765875687658765,
                    'ncc'          => 1701.6789
                }
            );
        },
        "/ENVHVRV03.*$OPS_TYPES/",
        q{TNVHVRV33 number__hash_ref__typetest0({'binary' => 2.1234432112344321, 'ERROR_FUNKEY' => 'abcdefg', ..., 'ncc' => 1701.6789}) throws correct exception}
    );
    lives_and(    # TNVHVRV34
        sub {
            like(
                number__hash_ref__typetest0(
                    {   'binary' => 2.1234432112344321,
                        'rush'   => 2112.4321,
                        'answer' => 42.4567,
                        'fnord'  => 23.765444444444444444,
                        'units'  => -877.5678,
                        'degree' => -33.876587658765875687658765,
                        'ncc'    => 1701.6789
                    }
                ),
                q{/^\{(?=.*'binary' => 2\.12344321123443\b)(?=.*'rush' => 2112\.4321\b)(?=.*'answer' => 42\.4567\b)(?=.*'fnord' => 23\.7654444444444\b)(?=.*'units' => -877\.5678\b)(?=.*'degree' => -33\.8765876587659\b)(?=.*'ncc' => 1701\.6789\b).*\}}
                    . $OPS_TYPES . q{$/m},
                q{TNVHVRV34 number__hash_ref__typetest0({'binary' => 2.1234432112344321, 'rush' => 2112.4321, ..., 'ncc' => 1701.6789}) returns correct value}
            );
        },
        q{TNVHVRV34 number__hash_ref__typetest0({'binary' => 2.1234432112344321, 'rush' => 2112.4321, ..., 'ncc' => 1701.6789}) lives}
    );
    lives_and(    # TNVHVRV40
        sub {
            is_deeply(
                number__hash_ref__typetest1(5),
                {   "$OPS_TYPES\_funkey2" => 10.246913578,
                    "$OPS_TYPES\_funkey3" => 15.370370367,
                    "$OPS_TYPES\_funkey4" => 20.493827156,
                    "$OPS_TYPES\_funkey1" => 5.123456789,
                    "$OPS_TYPES\_funkey0" => 0
                },
                q{TNVHVRV40 number__hash_ref__typetest1(5) returns correct value}
            );
        },
        q{TNVHVRV40 number__hash_ref__typetest1(5) lives}
    );

    # [[[ STRING HASH TESTS ]]]
    # [[[ STRING HASH TESTS ]]]
    # [[[ STRING HASH TESTS ]]]

    throws_ok(    # TPVHVRV00
        sub { string__hash_ref__stringify() },
        "/(EPVHVRV00.*$OPS_TYPES)|(Usage.*string__hash_ref__stringify)/", # DEV NOTE: 2 different error messages, RPerl & C
        q{TPVHVRV00 string__hash_ref__stringify() throws correct exception}
    );
    throws_ok(    # TPVHVRV01
        sub { string__hash_ref__stringify(undef) },
        "/EPVHVRV00.*$OPS_TYPES/",
        q{TPVHVRV01 string__hash_ref__stringify(undef) throws correct exception}
    );
    throws_ok(    # TPVHVRV02
        sub { string__hash_ref__stringify(2) },
        "/EPVHVRV01.*$OPS_TYPES/",
        q{TPVHVRV02 string__hash_ref__stringify(2) throws correct exception}
    );
    throws_ok(    # TPVHVRV03
        sub { string__hash_ref__stringify(2.3) },
        "/EPVHVRV01.*$OPS_TYPES/",
        q{TPVHVRV03 string__hash_ref__stringify(2.3) throws correct exception}
    );
    throws_ok(    # TPVHVRV04
        sub { string__hash_ref__stringify('Lone Ranger') },
        "/EPVHVRV01.*$OPS_TYPES/",
        q{TPVHVRV04 string__hash_ref__stringify('Lone Ranger') throws correct exception}
    );
    throws_ok(    # TPVHVRV05
        sub { string__hash_ref__stringify( ['Lone Ranger'] ) },
        "/EPVHVRV01.*$OPS_TYPES/",
        q{TPVHVRV05 string__hash_ref__stringify(['Lone Ranger']) throws correct exception}
    );
    throws_ok(    # TPVHVRV10
        sub {
            string__hash_ref__stringify(
                {   'kryptonian_manofsteel_clarkkent'  => 'Superman',
                    'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter',
                    'UNDEF_NOT_STRING'                 => undef
                }
            );
        },
        "/EPVHVRV02.*$OPS_TYPES/",
        q{TPVHVRV10 string__hash_ref__stringify({'kryptonian_manofsteel_clarkkent' => 'Superman', ..., 'UNDEF_NOT_STRING' => undef}) throws correct exception}
    );
    throws_ok(    # TPVHVRV11
        sub {
            string__hash_ref__stringify(
                {   'kryptonian_manofsteel_clarkkent'  => 'Superman',
                    'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter',
                    'INTEGER_NOT_STRING'               => 23
                }
            );
        },
        "/EPVHVRV03.*$OPS_TYPES/",
        q{TPVHVRV11 string__hash_ref__stringify({'kryptonian_manofsteel_clarkkent' => 'Superman', ..., 'INTEGER_NOT_STRING' => 23}) throws correct exception}
    );
    throws_ok(    # TPVHVRV12
        sub {
            string__hash_ref__stringify(
                {   'kryptonian_manofsteel_clarkkent'  => 'Superman',
                    'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter',
                    'NUMBER_NOT_STRING'                => -2112.23
                }
            );
        },
        "/EPVHVRV03.*$OPS_TYPES/",
        q{TPVHVRV12 string__hash_ref__stringify({'kryptonian_manofsteel_clarkkent' => 'Superman', ..., 'NUMBER_NOT_STRING' => -2112.23}) throws correct exception}
    );
    throws_ok(    # TPVHVRV13
        sub {
            string__hash_ref__stringify(
                {   'kryptonian_manofsteel_clarkkent'  => 'Superman',
                    'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter',
                    'ARRAY_NOT_STRING'                 => ['Tonto']
                }
            );
        },
        "/EPVHVRV03.*$OPS_TYPES/",
        q{TPVHVRV13 string__hash_ref__stringify({'kryptonian_manofsteel_clarkkent' => 'Superman', ..., 'ARRAY_NOT_STRING' => ['Tonto']}) throws correct exception}
    );
    throws_ok(    # TPVHVRV14
        sub {
            string__hash_ref__stringify(
                {   'kryptonian_manofsteel_clarkkent'  => 'Superman',
                    'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter',
                    'HASH_NOT_STRING'                  => { fizz => 3 }
                }
            );
        },
        "/EPVHVRV03.*$OPS_TYPES/",
        q{TPVHVRV14 string__hash_ref__stringify({'kryptonian_manofsteel_clarkkent' => 'Superman', ..., 'HASH_NOT_STRING' => {fizz => 3}}) throws correct exception}
    );
    lives_and(    # TPVHVRV20
        sub {
            like(
                string__hash_ref__stringify(
                    {   'stuckinaworldhenevercreated' => 'Howard The Duck',
                        'kryptonian_manofsteel_clarkkent' => 'Superman',
                        'gothamite_darkknight_brucewayne' => 'Batman',
                        'amazonian_dianathemyscira_dianaprince' =>
                            'Wonder Woman',
                        'scarletspeedster_barryallenetal' => 'Flash',
                        'alanscottetal'                   => 'Green Lantern',
                        'atlanteanhybrid_aquaticace_arthurcurryorin' =>
                            'Aquaman',
                        'greenmartian_bloodwynd_jonnjonnz' =>
                            'Martian Manhunter'
                    }
                ),
                q{/^\{(?=.*'stuckinaworldhenevercreated' => 'Howard The Duck')(?=.*'kryptonian_manofsteel_clarkkent' => 'Superman')(?=.*'gothamite_darkknight_brucewayne' => 'Batman')(?=.*'amazonian_dianathemyscira_dianaprince' => 'Wonder Woman')(?=.*'scarletspeedster_barryallenetal' => 'Flash')(?=.*'alanscottetal' => 'Green Lantern')(?=.*'atlanteanhybrid_aquaticace_arthurcurryorin' => 'Aquaman')(?=.*'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter').*\}$/m}
                ,    ## PERLTIDY BUG comma on newline
                q{TPVHVRV20 string__hash_ref__stringify({'stuckinaworldhenevercreated' => 'Howard The Duck', 'kryptonian_manofsteel_clarkkent' => 'Superman', ...}) returns correct value}
            );
        },
        q{TPVHVRV20 string__hash_ref__stringify({'stuckinaworldhenevercreated' => 'Howard The Duck', 'kryptonian_manofsteel_clarkkent' => 'Superman', ...}) lives}
    );
    lives_and(       # TPVHVRV21
        sub {
            like(
                string__hash_ref__stringify(
                    {   'kryptonian_manofsteel_clarkkent' => 'Superman',
                        'greenmartian_bloodwynd_jonnjonnz' =>
                            'Martian Manhunter',
                        'STRING_NOT_UNDEF' => 'undef'
                    }
                ),
                q{/^\{(?=.*'kryptonian_manofsteel_clarkkent' => 'Superman')(?=.*'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter')(?=.*'STRING_NOT_UNDEF' => 'undef').*\}$/m}
                ,    ## PERLTIDY BUG comma on newline
                q{TPVHVRV21 string__hash_ref__stringify({'kryptonian_manofsteel_clarkkent' => 'Superman', ..., 'STRING_NOT_UNDEF' => 'undef'}) returns correct value}
            );
        },
        q{TPVHVRV21 string__hash_ref__stringify({'kryptonian_manofsteel_clarkkent' => 'Superman', ..., 'STRING_NOT_UNDEF' => 'undef'}) lives}
    );
    lives_and(       # TPVHVRV22
        sub {
            like(
                string__hash_ref__stringify(
                    {   'kryptonian_manofsteel_clarkkent' => 'Superman',
                        'greenmartian_bloodwynd_jonnjonnz' =>
                            'Martian Manhunter',
                        'STRING_NOT_INTEGER' => '23'
                    }
                ),
                q{/^\{(?=.*'kryptonian_manofsteel_clarkkent' => 'Superman')(?=.*'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter')(?=.*'STRING_NOT_INTEGER' => '23').*\}$/m}
                ,    ## PERLTIDY BUG comma on newline
                q{TPVHVRV22 string__hash_ref__stringify({'kryptonian_manofsteel_clarkkent' => 'Superman', ..., 'STRING_NOT_INTEGER' => '23'}) returns correct value}
            );
        },
        q{TPVHVRV22 string__hash_ref__stringify({'kryptonian_manofsteel_clarkkent' => 'Superman', ..., 'STRING_NOT_INTEGER' => '23'}) lives}
    );
    lives_and(       # TPVHVRV23
        sub {
            like(
                string__hash_ref__stringify(
                    {   'kryptonian_manofsteel_clarkkent' => 'Superman',
                        'greenmartian_bloodwynd_jonnjonnz' =>
                            'Martian Manhunter',
                        'STRING_NOT_NUMBER' => '-2112.23'
                    }
                ),
                q{/^\{(?=.*'kryptonian_manofsteel_clarkkent' => 'Superman')(?=.*'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter')(?=.*'STRING_NOT_NUMBER' => '-2112.23').*\}$/m}
                ,    ## PERLTIDY BUG comma on newline
                q{TPVHVRV23 string__hash_ref__stringify({'kryptonian_manofsteel_clarkkent' => 'Superman', ..., 'STRING_NOT_NUMBER' => '-2112.23'}) returns correct value}
            );
        },
        q{TPVHVRV23 string__hash_ref__stringify({'kryptonian_manofsteel_clarkkent' => 'Superman', ..., 'STRING_NOT_NUMBER' => '-2112.23'}) lives}
    );
    lives_and(       # TPVHVRV24
        sub {
            like(
                string__hash_ref__stringify(
                    {   'kryptonian_manofsteel_clarkkent' => 'Superman',
                        'greenmartian_bloodwynd_jonnjonnz' =>
                            'Martian Manhunter',
                        "STRING_NOT_ARRAY" => "[Tonto]"
                    }
                ),
                q{/^\{(?=.*'kryptonian_manofsteel_clarkkent' => 'Superman')(?=.*'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter')(?=.*'STRING_NOT_ARRAY' => '\[Tonto\]').*\}$/m}
                ,    ## PERLTIDY BUG comma on newline
                q{TPVHVRV24 string__hash_ref__stringify({'kryptonian_manofsteel_clarkkent' => 'Superman', ..., "STRING_NOT_ARRAY" => "[Tonto]"}) returns correct value}
            );
        },
        q{TPVHVRV24 string__hash_ref__stringify({'kryptonian_manofsteel_clarkkent' => 'Superman', ..., "STRING_NOT_ARRAY" => "[Tonto]"}) lives}
    );
    lives_and(       # TPVHVRV25
        sub {
            like(
                string__hash_ref__stringify(
                    {   'kryptonian_manofsteel_clarkkent' => 'Superman',
                        'greenmartian_bloodwynd_jonnjonnz' =>
                            'Martian Manhunter',
                        "STRING_NOT_HASH" => "{buzz => 5}"
                    }
                ),
                q{/^\{(?=.*'kryptonian_manofsteel_clarkkent' => 'Superman')(?=.*'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter')(?=.*'STRING_NOT_HASH' => '\{buzz => 5\}').*\}$/m}
                ,    ## PERLTIDY BUG comma on newline
                q{TPVHVRV25 string__hash_ref__stringify({'kryptonian_manofsteel_clarkkent' => 'Superman', ..., "STRING_NOT_HASH" => "{buzz => 5}"}) returns correct value}
            );
        },
        q{TPVHVRV25 string__hash_ref__stringify({'kryptonian_manofsteel_clarkkent' => 'Superman', ..., "STRING_NOT_HASH" => "{buzz => 5}"}) lives}
    );
    throws_ok(       # TPVHVRV30
        sub { string__hash_ref__typetest0() },
        "/(EPVHVRV00.*$OPS_TYPES)|(Usage.*string__hash_ref__typetest0)/", # DEV NOTE: 2 different error messages, RPerl & C
        q{TPVHVRV30 string__hash_ref__typetest0() throws correct exception}
    );
    throws_ok(    # TPVHVRV31
        sub { string__hash_ref__typetest0(2) },
        "/EPVHVRV01.*$OPS_TYPES/",
        q{TPVHVRV31 string__hash_ref__typetest0(2) throws correct exception}
    );
    throws_ok(    # TPVHVRV32
        sub {
            string__hash_ref__typetest0(
                {   'kryptonian_manofsteel_clarkkent'       => 'Superman',
                    'gothamite_darkknight_brucewayne'       => 'Batman',
                    'amazonian_dianathemyscira_dianaprince' => 'Wonder Woman',
                    'scarletspeedster_barryallenetal'       => 'Flash',
                    'alanscottetal' => 'Green Lantern',
                    'atlanteanhybrid_aquaticace_arthurcurryorin' => 'Aquaman',
                    'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter',
                    'UNDEF_NOT_STRING'                 => undef
                }
            );
        },
        "/EPVHVRV02.*$OPS_TYPES/",
        q{TPVHVRV32 string__hash_ref__typetest0({'kryptonian_manofsteel_clarkkent' => 'Superman', ..., 'UNDEF_NOT_STRING' => undef}) throws correct exception}
    );
    throws_ok(    # TPVHVRV33
        sub {
            string__hash_ref__typetest0(
                {   'kryptonian_manofsteel_clarkkent'       => 'Superman',
                    'gothamite_darkknight_brucewayne'       => 'Batman',
                    'amazonian_dianathemyscira_dianaprince' => 'Wonder Woman',
                    'scarletspeedster_barryallenetal'       => 'Flash',
                    'alanscottetal' => 'Green Lantern',
                    'atlanteanhybrid_aquaticace_arthurcurryorin' => 'Aquaman',
                    'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter',
                    'ARRAY_NOT_STRING'                 => [ 23, -42.3 ]
                }
            );
        },
        "/EPVHVRV03.*$OPS_TYPES/",
        q{TPVHVRV33 string__hash_ref__typetest0({'kryptonian_manofsteel_clarkkent' => 'Superman', ..., 'ARRAY_NOT_STRING' => [23, -42.3]}) throws correct exception}
    );
    lives_and(    # TPVHVRV34
        sub {
            like(
                string__hash_ref__typetest0(
                    {   'stuckinaworldhenevercreated' => 'Howard The Duck',
                        'atlanteanhybrid_aquaticace_arthurcurryorin' =>
                            'Aquaman',
                        'greenmartian_bloodwynd_jonnjonnz' =>
                            'Martian Manhunter'
                    }
                ),
                q{/^\{(?=.*'stuckinaworldhenevercreated' => 'Howard The Duck')(?=.*'atlanteanhybrid_aquaticace_arthurcurryorin' => 'Aquaman')(?=.*'greenmartian_bloodwynd_jonnjonnz' => 'Martian Manhunter').*\}}
                    . $OPS_TYPES . q{$/m},
                q{TPVHVRV34 string__hash_ref__typetest0({'stuckinaworldhenevercreated' => 'Howard The Duck', ...}) returns correct value}
            );
        },
        q{TPVHVRV34 string__hash_ref__typetest0({'stuckinaworldhenevercreated' => 'Howard The Duck', ...}) lives}
    );
    lives_and(    # TPVHVRV40
        sub {
            is_deeply(
                string__hash_ref__typetest1(5),
                {   "$OPS_TYPES\_Luker_key3" => 'Jeffy Ten! 3/4',
                    "$OPS_TYPES\_Luker_key2" => 'Jeffy Ten! 2/4',
                    "$OPS_TYPES\_Luker_key1" => 'Jeffy Ten! 1/4',
                    "$OPS_TYPES\_Luker_key4" => 'Jeffy Ten! 4/4',
                    "$OPS_TYPES\_Luker_key0" => 'Jeffy Ten! 0/4'
                },
                q{TPVHVRV40 string__hash_ref__typetest1(5) returns correct value}
            );
        },
        q{TPVHVRV40 string__hash_ref__typetest1(5) lives}
    );
}

done_testing();
