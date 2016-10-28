#!/usr/bin/perl

# suppress 'WEXRP00: Found multiple rperl executables' due to blib/ & pre-existing installation(s)
BEGIN { $ENV{RPERL_WARNINGS} = 0; }

use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.007_000;

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitStringySplit ProhibitInterpolationOfLiterals)  # DEVELOPER DEFAULT 2: allow string test values
## no critic qw(ProhibitStringyEval)  # SYSTEM DEFAULT 1: allow eval()
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(RequireCheckingReturnValueOfEval)  # SYSTEM DEFAULT 4: allow eval() test code blocks

use RPerl::Test;
use rperltypesconv;
use Test::More tests => 310;
use Test::Exception;
use Test::Number::Delta;

BEGIN {
    if ( $ENV{RPERL_VERBOSE} ) {
        Test::More::diag("[[[ Beginning Scalar Type Pre-Test Loading, RPerl Type System ]]]");
    }
    lives_and( sub { use_ok('RPerl::AfterSubclass'); }, q{use_ok('RPerl::AfterSubclass') lives} );

    foreach my string $type (qw(Integer Number String)) {
        lives_and( sub { use_ok( 'RPerl::DataType::' . $type . '_cpp' ); }, q{use_ok('RPerl::DataType::' . $type . '_cpp') lives} );
    }
}

# use Data::Dumper() to stringify a string
#our string $string_dumperify = sub {  # NEED FIX: RPerl subroutines disabled here
sub string_dumperify {
    ( my string $input_string ) = @_;

    #    RPerl::diag("in 04_type_scalar.t string_dumperify(), received have \$input_string =\n$input_string\n\n");
    $input_string = Dumper( [$input_string] );
    $input_string =~ s/^\s+|\s+$//xmsg;    # strip leading whitespace
    my @input_string_split = split "\n", $input_string;
    $input_string = $input_string_split[1];    # only select the data line
    return $input_string;
}

# [[[ PRIMARY RUNLOOP ]]]
# [[[ PRIMARY RUNLOOP ]]]
# [[[ PRIMARY RUNLOOP ]]]

# loop 3 times, once for each mode: PERLOPS_PERLTYPES, PERLOPS_CPPTYPES, CPPOPS_CPPTYPES
foreach my integer $mode_id ( sort keys %{$RPerl::MODES} ) {
#for my $mode_id ( 1 .. 1 ) {  # TEMPORARY DEBUGGING CPPOPS_PERLTYPES ONLY

    # [[[ MODE SETUP ]]]
    #    RPerl::diag("in 04_type_scalar.t, top of for() loop, have \$mode_id = $mode_id\n");
    my scalartype_hashref $mode = $RPerl::MODES->{$mode_id};
    my string $ops          = $mode->{ops};
    my string $types        = $mode->{types};
    my string $mode_tagline = $ops . 'OPS_' . $types . 'TYPES';
    if ( $ENV{RPERL_VERBOSE} ) {
        Test::More::diag( '[[[ Beginning RPerl Scalar Type Tests, ' . $ops . ' Operations & ' . $types . ' Data Types' . ' ]]]' );
    }

    #    $RPerl::DEBUG = 1;
    #    RPerl::diag('have $ops = ' . $ops . "\n");
    #    RPerl::diag('have $types = ' . $types . "\n");
    #    RPerl::diag('have $mode_tagline = ' . $mode_tagline . "\n");

    lives_ok( sub { rperltypes::types_enable($types) }, q{mode '} . $ops . ' Operations & ' . $types . ' Data Types' . q{' enabled} );

    foreach my string $type (qw(Integer Number String)) {
        if ( $ops eq 'CPP' ) {

            # force reload
            delete $main::{ 'RPerl__DataType__' . $type . '__MODE_ID' };

            my $package = 'RPerl::DataType::' . $type . '_cpp';
            lives_and( sub { require_ok($package); }, 'require_ok(' . $package . ') lives' );

            #            lives_and( sub { use_ok($package); }, 'use_ok(' . $package . ') lives' );

            lives_ok( sub { eval( $package . '::cpp_load();' ) }, $package . '::cpp_load() lives' );
        }

        lives_ok( sub { main->can( 'RPerl__DataType__' . $type . '__MODE_ID' ) }, 'main::RPerl__DataType__' . $type . '__MODE_ID() exists' );

        # NEED ANSWER: why does direct-calling *MODE_ID() always return 0, but main->can(...) and eval(...) returns correct values?
        #        RPerl::diag('have $type = ' . $type . "\n");
        #        my string $eval_string = 'main::RPerl__DataType__' . $type . '__MODE_ID();';
        #        RPerl::diag('have $eval_string = ' . $eval_string . "\n");
        #        my string $eval_retval = eval($eval_string);
        #        RPerl::diag('have $eval_retval = ' . $eval_retval . "\n");
        #        RPerl::diag(q{have main::RPerl__DataType__Integer__MODE_ID() = '} . main::RPerl__DataType__Integer__MODE_ID() . "'\n");
        #        RPerl::diag(q{have main::RPerl__DataType__Number__MODE_ID() = '} . main::RPerl__DataType__Number__MODE_ID() . "'\n");
        #        RPerl::diag(q{have main::RPerl__DataType__String__MODE_ID() = '} . main::RPerl__DataType__String__MODE_ID() . "'\n");
 
#RPerl::diag('in 04_type_scalar.t, top of for() loop, have $RPerl::MODES = ' . "\n" . Dumper($RPerl::MODES) . "\n");
#RPerl::diag('in 04_type_scalar.t, top of for() loop, have RPerl__DataType__ . $type . __MODE_ID = ' . 'RPerl__DataType__' . $type . '__MODE_ID' . "\n");
#RPerl::diag('in 04_type_scalar.t, top of for() loop, have main::RPerl__DataType__Integer__MODE_ID() = ' . main::RPerl__DataType__Integer__MODE_ID() . "\n");
#RPerl::diag('in 04_type_scalar.t, top of for() loop, have eval(main::RPerl__DataType__Integer__MODE_ID()) = ' . eval('main::RPerl__DataType__Integer__MODE_ID()') . "\n");
#RPerl::diag('in 04_type_scalar.t, top of for() loop, have main->can(...) = ' . main->can( 'RPerl__DataType__Integer__MODE_ID' ) . "\n");
#RPerl::diag('in 04_type_scalar.t, top of for() loop, have main->can(...)->() = ' . main->can( 'RPerl__DataType__Integer__MODE_ID' )->() . "\n");
#RPerl::diag('in 04_type_scalar.t, top of for() loop, have Dumper(\%main::) = ' . Dumper(\%main::) . "\n");

        lives_and(
            sub {
                is( $RPerl::MODES->{ main->can( 'RPerl__DataType__' . $type . '__MODE_ID' )->() }->{types},
                    $types, 'main::RPerl__DataType__' . $type . '__MODE_ID() types returns ' . $types );
            },
            'main::RPerl__DataType__' . $type . '__MODE_ID() lives'
        );
    }

    # [[[ INTEGER TESTS ]]]
    # [[[ INTEGER TESTS ]]]
    # [[[ INTEGER TESTS ]]]

    throws_ok(    # TIV00
        sub { integer_to_string() },
        "/(EIV00.*$mode_tagline)|(Usage.*integer_to_string)/",    # DEV NOTE: 2 different error messages, RPerl & C
        q{TIV00 integer_to_string() throws correct exception}
    );
    throws_ok(                                                    # TIV01
        sub { integer_to_string(undef) },
        "/EIV00.*$mode_tagline/",
        q{TIV01 integer_to_string(undef) throws correct exception}
    );
    lives_and(                                                    # TIV02
        sub {
            is( integer_to_string(0), '0', q{TIV02 integer_to_string(0) returns correct value} );
        },
        q{TIV02 integer_to_string(0) lives}
    );
    lives_and(                                                    # TIV03
        sub {
            is( integer_to_string(-0), '0', q{TIV03 integer_to_string(-0) returns correct value} );
        },
        q{TIV03 integer_to_string(-0) lives}
    );
    lives_and(                                                    # TIV04
        sub {
            is( integer_to_string(3), '3', q{TIV04 integer_to_string(3) returns correct value} );
        },
        q{TIV04 integer_to_string(3) lives}
    );
    lives_and(                                                    # TIV05
        sub {
            is( integer_to_string(-17), '-17', q{TIV05 integer_to_string(-17) returns correct value} );
        },
        q{TIV05 integer_to_string(-17) lives}
    );
    throws_ok(                                                    # TIV06
        sub { integer_to_string(-17.3) },
        "/EIV01.*$mode_tagline/",
        q{TIV06 integer_to_string(-17.3) throws correct exception}
    );
    throws_ok(                                                    # TIV07
        sub { integer_to_string('-17.3') },
        "/EIV01.*$mode_tagline/",
        q{TIV07 integer_to_string('-17.3') throws correct exception}
    );
    throws_ok(                                                    # TIV08
        sub { integer_to_string( [3] ) },
        "/EIV01.*$mode_tagline/",
        q{TIV08 integer_to_string([3]) throws correct exception}
    );
    throws_ok(                                                    # TIV09
        sub { integer_to_string( { a_key => 3 } ) },
        "/EIV01.*$mode_tagline/",
        q{TIV09 integer_to_string({a_key => 3}) throws correct exception}
    );
    lives_and(                                                    # TIV10
        sub {
            is( integer_to_string(34_567_890), '34_567_890', q{TIV10 integer_to_string(34_567_890) returns correct value} );
        },
        q{TIV10 integer_to_string(34_567_890) lives}
    );
    lives_and(                                                    # TIV11
        sub {
            is( integer_to_string(-34_567_890), '-34_567_890', q{TIV11 integer_to_string(-34_567_890) returns correct value} );
        },
        q{TIV11 integer_to_string(-34_567_890) lives}
    );
    lives_and(                                                    # TIV12
        sub {
            is( integer_to_string(234_567_890), '234_567_890', q{TIV12 integer_to_string(234_567_890) returns correct value} );
        },
        q{TIV12 integer_to_string(234_567_890) lives}
    );
    lives_and(                                                    # TIV13
        sub {
            is( integer_to_string(-234_567_890), '-234_567_890', q{TIV13 integer_to_string(-234_567_890) returns correct value} );
        },
        q{TIV13 integer_to_string(-234_567_890) lives}
    );
    lives_and(                                                    # TIV14
        sub {
            is( integer_to_string(1_234_567_890), '1_234_567_890', q{TIV14 integer_to_string(1_234_567_890) returns correct value} );
        },
        q{TIV14 integer_to_string(1_234_567_890) lives}
    );
    lives_and(                                                    # TIV15
        sub {
            is( integer_to_string(-1_234_567_890), '-1_234_567_890', q{TIV15 integer_to_string(-1_234_567_890) returns correct value} );
        },
        q{TIV15 integer_to_string(-1_234_567_890) lives}
    );
    throws_ok(                                                    # TIV16
        sub {
            integer_to_string(-1_234_567_890_000_000_000_000_000_000_000_000);
        },
        "/EIV01.*$mode_tagline/",
        q{TIV16 integer_to_string(-1_234_567_890_000_000_000_000_000_000_000_000) throws correct exception}
    );
    lives_and(                                                    # TIV20
        sub {
            is( integer__typetest0(), ( 3 + $mode_id ), q{TIV20 integer__typetest0() returns correct value} );
        },
        q{TIV20 integer__typetest0() lives}
    );
    throws_ok(                                                    # TIV30
        sub { integer__typetest1() },
        "/(EIV00.*$mode_tagline)|(Usage.*integer__typetest1)/"
        ,                                                         # DEV NOTE: 2 different error messages, RPerl & C
        q{TIV30 integer__typetest1() throws correct exception}
    );
    throws_ok(                                                    # TIV31
        sub { integer__typetest1(undef) },
        "/EIV00.*$mode_tagline/",
        q{TIV31 integer__typetest1(undef) throws correct exception}
    );
    lives_and(                                                    # TIV32
        sub {
            is( integer__typetest1(3), ( ( 3 * 2 ) + $mode_id ), q{TIV32 integer__typetest1(3) returns correct value} );
        },
        q{TIV32 integer__typetest1(3) lives}
    );
    lives_and(                                                    # TIV33
        sub {
            is( integer__typetest1(-17), ( ( -17 * 2 ) + $mode_id ), q{TIV33 integer__typetest1(-17) returns correct value} );
        },
        q{TIV33 integer__typetest1(-17) lives}
    );
    throws_ok(                                                    # TIV34
        sub { integer__typetest1(-17.3) },
        "/EIV01.*$mode_tagline/",
        q{TIV34 integer__typetest1(-17.3) throws correct exception}
    );
    throws_ok(                                                    # TIV35
        sub { integer__typetest1('-17.3') },
        "/EIV01.*$mode_tagline/",
        q{TIV35 integer__typetest1('-17.3') throws correct exception}
    );
    throws_ok(                                                    # TIV36
        sub { integer__typetest1( [3] ) },
        "/EIV01.*$mode_tagline/",
        q{TIV36 integer__typetest1([3]) throws correct exception}
    );
    throws_ok(                                                    # TIV37
        sub { integer__typetest1( { a_key => 3 } ) },
        "/EIV01.*$mode_tagline/",
        q{TIV37 integer__typetest1({a_key => 3}) throws correct exception}
    );
    lives_and(                                                    # TIV38
        sub {
            is( integer__typetest1(-234_567_890), ( ( -234_567_890 * 2 ) + $mode_id ), q{TIV38 integer__typetest1(-234_567_890) returns correct value} );
        },
        q{TIV38 integer__typetest1(-234_567_890) lives}
    );
    throws_ok(                                                    # TIV39
        sub {
            integer__typetest1(-1_234_567_890_000_000_000_000_000_000_000_000);
        },
        "/EIV01.*$mode_tagline/",
        q{TIV39 integer__typetest1(-1_234_567_890_000_000_000_000_000_000_000_000) throws correct exception}
    );

    # [[[ NUMBER TESTS ]]]
    # [[[ NUMBER TESTS ]]]
    # [[[ NUMBER TESTS ]]]

    throws_ok(    # TNV00
        sub { number_to_string() },
        "/(ENV00.*$mode_tagline)|(Usage.*number_to_string)/",    # DEV NOTE: 2 different error messages, RPerl & C
        q{TNV00 number_to_string() throws correct exception}
    );
    throws_ok(                                                   # TNV01
        sub { number_to_string(undef) },
        "/ENV00.*$mode_tagline/",
        q{TNV01 number_to_string(undef) throws correct exception}
    );
    lives_and(                                                   # TNV02
        sub {
            is( number_to_string(3), '3', q{TNV02 number_to_string(3) returns correct value} );
        },
        q{TNV02 number_to_string(3) lives}
    );
    lives_and(                                                   # TNV03
        sub {
            is( number_to_string(-17), '-17', q{TNV03 number_to_string(-17) returns correct value} );
        },
        q{TNV03 number_to_string(-17) lives}
    );
    lives_and(                                                   # TNV04
        sub {
            is( number_to_string(-17.3), '-17.3', q{TNV04 number_to_string(-17.3) returns correct value} );
        },
        q{TNV04 number_to_string(-17.3) lives}
    );
    throws_ok(                                                   # TNV05
        sub { number_to_string('-17.3') },
        "/ENV01.*$mode_tagline/",
        q{TNV05 number_to_string('-17.3') throws correct exception}
    );
    throws_ok(                                                   # TNV06
        sub { number_to_string( [3] ) },
        "/ENV01.*$mode_tagline/",
        q{TNV06 number_to_string([3]) throws correct exception}
    );
    throws_ok(                                                   # TNV07
        sub { number_to_string( { a_key => 3 } ) },
        "/ENV01.*$mode_tagline/",
        q{TNV07 number_to_string({a_key => 3}) throws correct exception}
    );
    lives_and(                                                   # TNV08
        sub {
            # NEED DELETE OLD CODE
#            is( number_to_string(3.141_592_653_589_793_238_462_643_383_279_502_884_197_169_399_375_105_820_974_944_592_307_816_406_286_208_998_628_034_825_342_117_067_9),
#                '3.141_592_653_589_79',
            like( number_to_string(3.141_592_653_589_793_238_462_643_383_279_502_884_197_169_399_375_105_820_974_944_592_307_816_406_286_208_998_628_034_825_342_117_067_9),
                qr/3.141_592_653_589_7/,
                q{TNV08 number_to_string(3.141_592_653_589_793_238_462_643_383_279_502_884_197_169_399_375_105_820_974_944_592_307_816_406_286_208_998_628_034_825_342_117_067_9) returns correct value}
            );
        },
        q{TNV08 number_to_string(3.141_592_653_589_793_238_462_643_383_279_502_884_197_169_399_375_105_820_974_944_592_307_816_406_286_208_998_628_034_825_342_117_067_9) lives}
    );
    lives_and(                                                   # TNV09
        sub {
            # NEED DELETE OLD CODE
#            is( number_to_string(1_234_567.890_123_456), '1_234_567.890_123_46', q{TNV09 number_to_string(1_234_567.890_123_456) returns correct value} );
            like( number_to_string(1_234_567.890_123_456), qr/1_234_567.890_123_4/, q{TNV09 number_to_string(1_234_567.890_123_456) returns correct value} );
        },
        q{TNV09 number_to_string(1_234_567.890_123_456) lives}
    );
    lives_and(                                                   # TNV10
        sub {
            is( number_to_string(123_456_789.678_90), '123_456_789.678_9', q{TNV10 number_to_string(123_456_789.678_90) returns correct value} );
        },
        q{TNV10 number_to_string(123_456_789.678_90) lives}
    );
    lives_and(                                                   # TNV11
        sub {
            is( number_to_string(123_456_789.0), '123_456_789', q{TNV11 number_to_string(123_456_789.0) returns correct value} );
        },
        q{TNV11 number_to_string(123_456_789.0) lives}
    );
    lives_and(                                                   # TNV12
        sub {
            is( number_to_string(0.011_111_122_22), '0.011_111_122_22', q{TNV12 number_to_string(0.011_111_122_22) returns correct value} );
        },
        q{TNV12 number_to_string(0.011_111_122_22) lives}
    );
    lives_and(                                                   # TNV13
        sub {
            is( number_to_string(.011_111_122_22), '0.011_111_122_22', q{TNV13 number_to_string(.011_111_122_22) returns correct value} );
        },
        q{TNV13 number_to_string(.011_111_122_22) lives}
    );
    lives_and(                                                   # TNV14
        sub {
            is( number_to_string(-10.011_111_122_22), '-10.011_111_122_22', q{TNV14 number_to_string(-10.011_111_122_22) returns correct value} );
        },
        q{TNV14 number_to_string(-10.011_111_122_22) lives}
    );
    lives_and(                                                   # TNV15
        sub {
            is( number_to_string(-103.011_111_122_22), '-103.011_111_122_22', q{TNV15 number_to_string(-103.011_111_122_22) returns correct value} );
        },
        q{TNV15 number_to_string(-103.011_111_122_22) lives}
    );
    lives_and(                                                   # TNV20
        sub {
            delta_ok( number__typetest0(), ( 3.14285714285714 + $mode_id ),
                q{TNV20 number__typetest0() returns correct value});
        },
        q{TNV20 number__typetest0() lives}
    );
    throws_ok(                                                                   # TNV30
        sub { number__typetest1() },
        "/(ENV00.*$mode_tagline)|(Usage.*number__typetest1)/"
        ,                                                                        # DEV NOTE: 2 different error messages, RPerl & C
        q{TNV30 number__typetest1() throws correct exception}
    );
    throws_ok(                                                                   # TNV31
        sub { number__typetest1(undef) },
        "/ENV00.*$mode_tagline/",
        q{TNV31 number__typetest1(undef) throws correct exception}
    );
    lives_and(                                                                   # TNV32
        sub {
            is( number__typetest1(3), ( ( 3 * 2 ) + $mode_id ), q{TNV32 number__typetest1(3) returns correct value} );
        },
        q{TNV32 number__typetest1(3) lives}
    );
    lives_and(                                                                   # TNV33
        sub {
            is( number__typetest1(-17), ( ( -17 * 2 ) + $mode_id ), q{TNV33 number__typetest1(-17) returns correct value} );
        },
        q{TNV33 number__typetest1(-17) lives}
    );
    lives_and(                                                                   # TNV34
        sub {
            # NEED DELETE OLD CODE
#            is( number__typetest1(-17.3), ( ( -17.3 * 2 ) + $mode_id ), q{TNV34 number__typetest1(-17.3) returns correct value} );
            delta_ok( number__typetest1(-17.3), ( ( -17.3 * 2 ) + $mode_id ), q{TNV34 number__typetest1(-17.3) returns correct value} );
        },
        q{TNV34 number__typetest1(-17.3) lives}
    );
    throws_ok(                                                                   # TNV35
        sub { number__typetest1('-17.3') },
        "/ENV01.*$mode_tagline/",
        q{TNV35 number__typetest1('-17.3') throws correct exception}
    );
    throws_ok(                                                                   # TNV36
        sub { number__typetest1( [3] ) },
        "/ENV01.*$mode_tagline/",
        q{TNV36 number__typetest1([3]) throws correct exception}
    );
    throws_ok(                                                                   # TNV37
        sub { number__typetest1( { a_key => 3 } ) },
        "/ENV01.*$mode_tagline/",
        q{TNV37 number__typetest1({a_key => 3}) throws correct exception}
    );
    lives_and(                                                                   # TNV38
        sub {
            delta_ok(number__typetest1(3.141_592_653_589_793_238_462_643_383_279_502_884_197_169_399_375_105_820_974_944_592_307_816_406_286_208_998_628_034_825_342_117_067_9),
                ( ( 3.141_592_653_589_79 * 2 ) + $mode_id ),
                q{TNV38 number__typetest1(3.141_592_653_589_793_238_462_643_383_279_502_884_197_169_399_375_105_820_974_944_592_307_816_406_286_208_998_628_034_825_342_117_067_9) returns correct value}
            );
        },
        q{TNV38 number__typetest1(3.141_592_653_589_793_238_462_643_383_279_502_884_197_169_399_375_105_820_974_944_592_307_816_406_286_208_998_628_034_825_342_117_067_9) lives}
    );

    # [[[ STRING TESTS ]]]
    # [[[ STRING TESTS ]]]
    # [[[ STRING TESTS ]]]

    throws_ok(    # TPV00
        sub { string_to_string() },
        "/(EPV00.*$mode_tagline)|(Usage.*string_to_string)/",    # DEV NOTE: 2 different error messages, RPerl & C
        q{TPV00 string_to_string() throws correct exception}
    );
    throws_ok(                                                   # TPV01
        sub { string_to_string(undef) },
        "/EPV00.*$mode_tagline/",
        q{TPV01 string_to_string(undef) throws correct exception}
    );
    throws_ok(                                                   # TPV02
        sub { string_to_string(3) },
        "/EPV01.*$mode_tagline/",
        q{TPV02 string_to_string(3) throws correct exception}
    );
    throws_ok(                                                   # TPV03
        sub { string_to_string(-17) },
        "/EPV01.*$mode_tagline/",
        q{TPV03 string_to_string(-17) throws correct exception}
    );
    throws_ok(                                                   # TPV04
        sub { string_to_string(-17.3) },
        "/EPV01.*$mode_tagline/",
        q{TPV04 string_to_string(-17.3) throws correct exception}
    );
    lives_and(                                                   # TPV05
        sub {
            is( string_to_string('-17.3'), "'-17.3'", q{TPV05 string_to_string('-17.3') returns correct value} );
        },
        q{TPV05 string_to_string('-17.3') lives}
    );
    throws_ok(                                                   # TPV06
        sub { string_to_string( [3] ) },
        "/EPV01.*$mode_tagline/",
        q{TPV06 string_to_string([3]) throws correct exception}
    );
    throws_ok(                                                   # TPV07
        sub { string_to_string( { a_key => 3 } ) },
        "/EPV01.*$mode_tagline/",
        q{TPV07 string_to_string({a_key => 3}) throws correct exception}
    );
    lives_and(                                                   # TPV08
        sub {
            is( string_to_string('Melange'), "'Melange'", q{TPV08 string_to_string('Melange') returns correct value} );
        },
        q{TPV08 string_to_string('Melange') lives}
    );
    lives_and(                                                   # TPV09
        sub {
            is( string_to_string("\nThe Spice Extends Life\nThe Spice Expands Consciousness\nThe Spice Is Vital To Space Travel\n"),
                "'\nThe Spice Extends Life\nThe Spice Expands Consciousness\nThe Spice Is Vital To Space Travel\n'",
                q{TPV09 string_to_string("\nThe Spice Extends Life\nThe Spice Expands Consciousness\nThe Spice Is Vital To Space Travel\n") returns correct value}
            );
        },
        q{TPV09 string_to_string("\nThe Spice Extends Life\nThe Spice Expands Consciousness\nThe Spice Is Vital To Space Travel\n") lives}
    );

    lives_and(                                                   # TPV10
        sub {
            is( string_to_string(
                    '\'I am a single-quoted string, in a single-quoted string with back-slash control chars\', the first string said introspectively.'
                ),
                string_dumperify(
                    '\'I am a single-quoted string, in a single-quoted string with back-slash control chars\', the first string said introspectively.'
                ),
                q{TPV10 string_to_string('\'I am a single-quoted string...\', the first string said introspectively.') returns correct value}
            );
        },
        q{TPV10 string_to_string('\'I am a single-quoted string...\', the first string said introspectively.') lives}
    );
    lives_and(    # TPV11
        sub {
            is( string_to_string('"I am a double-quoted string, in a single-quoted string with no back-slash chars", the second string observed.'),
                string_dumperify('"I am a double-quoted string, in a single-quoted string with no back-slash chars", the second string observed.'),
                q{TPV11 string_to_string('"I am a double-quoted string...", the second string observed.') returns correct value}
            );
        },
        q{TPV11 string_to_string('"I am a double-quoted string...", the second string observed.') lives}
    );
    lives_and(    # TPV12
        sub {
            is( string_to_string("'I am a single-quoted string, in a double-quoted string with no back-slash chars', the third string added."),
                string_dumperify("'I am a single-quoted string, in a double-quoted string with no back-slash chars', the third string added."),
                q{TPV12 string_to_string("'I am a single-quoted string...', the third string added.") returns correct value}
            );
        },
        q{TPV12 string_to_string("'I am a single-quoted string...', the third string added.") lives}
    );
    lives_and(    # TPV13
        sub {
            is( string_to_string("\"I am a double-quoted string, in a double-quoted string with back-slash control chars\", the fourth string offered."),
                string_dumperify("\"I am a double-quoted string, in a double-quoted string with back-slash control chars\", the fourth string offered."),
                q{TPV13 string_to_string("\"I am a double-quoted string...\", the fourth string offered.") returns correct value}
            );
        },
        q{TPV13 string_to_string("\"I am a double-quoted string...\", the fourth string offered.") lives}
    );
    lives_and(    # TPV14
        sub {
            is( string_to_string(
                    '\'I am a single-quoted string, in a single-quoted string with back-slash control and \ display \ chars\', the fifth string shouted.'
                ),
                string_dumperify(
                    '\'I am a single-quoted string, in a single-quoted string with back-slash control and \ display \ chars\', the fifth string shouted.'
                ),
                q{TPV14 string_to_string('\'I am a single-quoted string... and \ display \ chars\', the fifth string shouted.') returns correct value}
            );
        },
        q{TPV14 string_to_string('\'I am a single-quoted string... and \ display \ chars\', the fifth string shouted.') lives}
    );
    lives_and(    # TPV15
        sub {
            is( string_to_string('"I am a double-quoted string, in a single-quoted string with back-slash \ display \ chars", the sixth string hollered.'),
                string_dumperify('"I am a double-quoted string, in a single-quoted string with back-slash \ display \ chars", the sixth string hollered.'),
                q{TPV15 string_to_string('"I am a double-quoted string... \ display \ chars", the sixth string hollered.') returns correct value}
            );
        },
        q{TPV15 string_to_string('"I am a double-quoted string... \ display \ chars", the sixth string hollered.') lives}
    );
    lives_and(    # TPV16
        sub {
            is( string_to_string("'I am a single-quoted string, in a double-quoted string with back-slash \\ display \\ chars', the seventh string yelled."),
                string_dumperify("'I am a single-quoted string, in a double-quoted string with back-slash \\ display \\ chars', the seventh string yelled."),
                q{TPV16 string_to_string("'I am a single-quoted string... \\ display \\ chars', the seventh string yelled.") returns correct value}
            );
        },
        q{TPV16 string_to_string("'I am a single-quoted string... \\ display \\ chars', the seventh string yelled.") lives}
    );
    lives_and(    # TPV17
        sub {
            is( string_to_string(
                    "\"I am a double-quoted string, in a double-quoted string with back-slash control and \\ display \\ chars\", the eighth string belted."
                ),
                string_dumperify(
                    "\"I am a double-quoted string, in a double-quoted string with back-slash control and \\ display \\ chars\", the eighth string belted."
                ),
                q{TPV17 string_to_string("\"I am a double-quoted string... and \\ display \\ chars\", the eighth string belted.") returns correct value}
            );
        },
        q{TPV17 string_to_string("\"I am a double-quoted string... and \\ display \\ chars\", the eighth string belted.") lives}
    );
    lives_and(    # TPV20
        sub {
            is( string_to_string(q{'I am a single-quoted string, in a single-quoted q{} string with no back-slash chars', the ninth string chimed in.}),
                string_dumperify(q{'I am a single-quoted string, in a single-quoted q{} string with no back-slash chars', the ninth string chimed in.}),
                q{TPV20 string_to_string(q{'I am a single-quoted string...', the ninth string chimed in.}) returns correct value}
            );
        },
        q{TPV20 string_to_string(q{'I am a single-quoted string...', the ninth string chimed in.}) lives}
    );
    lives_and(    # TPV21
        sub {
            is( string_to_string(q{"I am a double-quoted string, in a single-quoted q{} string with no back-slash chars", the tenth string opined.}),
                string_dumperify(q{"I am a double-quoted string, in a single-quoted q{} string with no back-slash chars", the tenth string opined.}),
                q{TPV21 string_to_string(q{"I am a double-quoted string...", the tenth string opined.}) returns correct value}
            );
        },
        q{TPV21 string_to_string(q{"I am a double-quoted string...", the tenth string opined.}) lives}
    );
    lives_and(    # TPV22
        sub {
            is( string_to_string(qq{'I am a single-quoted string, in a double-quoted qq{} string with no back-slash chars', the eleventh string asserted.}),
                string_dumperify(qq{'I am a single-quoted string, in a double-quoted qq{} string with no back-slash chars', the eleventh string asserted.}),
                q{TPV22 string_to_string(qq{'I am a single-quoted string...', the eleventh string asserted.}) returns correct value}
            );
        },
        q{TPV22 string_to_string(qq{'I am a single-quoted string...', the eleventh string asserted.}) lives}
    );
    lives_and(    # TPV23
        sub {
            is( string_to_string(qq{"I am a double-quoted string, in a double-quoted qq{} string with no back-slash chars", the twelfth string insisted.}),
                string_dumperify(qq{"I am a double-quoted string, in a double-quoted qq{} string with no back-slash chars", the twelfth string insisted.}),
                q{TPV23 string_to_string(qq{"I am a double-quoted string...", the twelfth string insisted.}) returns correct value}
            );
        },
        q{TPV23 string_to_string(qq{"I am a double-quoted string...", the twelfth string insisted.}) lives}
    );
    lives_and(    # TPV24
        sub {
            is( string_to_string(
                    q{'I am a single-quoted string, in a single-quoted q{} string with back-slash \ display \ chars', the thirteenth string whispered.}
                ),
                string_dumperify(
                    q{'I am a single-quoted string, in a single-quoted q{} string with back-slash \ display \ chars', the thirteenth string whispered.}
                ),
                q{TPV24 string_to_string(q{'I am a single-quoted string... \ display \ chars', the thirteenth string whispered.}) returns correct value}
            );
        },
        q{TPV24 string_to_string(q{'I am a single-quoted string... \ display \ chars', the thirteenth string whispered.}) lives}
    );
    lives_and(    # TPV25
        sub {
            is( string_to_string(
                    q{"I am a double-quoted string, in a single-quoted q{} string with back-slash \ display \ chars", the fourteenth string breathed.}
                ),
                string_dumperify(
                    q{"I am a double-quoted string, in a single-quoted q{} string with back-slash \ display \ chars", the fourteenth string breathed.}
                ),
                q{TPV25 string_to_string(q{"I am a double-quoted string... \ display \ chars", the fourteenth string breathed.}) returns correct value}
            );
        },
        q{TPV25 string_to_string(q{"I am a double-quoted string... \ display \ chars", the fourteenth string breathed.}) lives}
    );
    lives_and(    # TPV26
        sub {
            is( string_to_string(
                    qq{'I am a single-quoted string, in a double-quoted qq{} string with back-slash \\ display \\ chars', the fifteenth string mouthed.}
                ),
                string_dumperify(
                    qq{'I am a single-quoted string, in a double-quoted qq{} string with back-slash \\ display \\ chars', the fifteenth string mouthed.}
                ),
                q{TPV26 string_to_string(qq{'I am a single-quoted string... back-slash \\ display \\ chars', the fifteenth string mouthed.}) returns correct value}
            );
        },
        q{TPV26 string_to_string(qq{'I am a single-quoted string... back-slash \\ display \\ chars', the fifteenth string mouthed.}) lives}
    );
    lives_and(    # TPV27
        sub {
            is( string_to_string(
                    qq{"I am a double-quoted string, in a double-quoted qq{} string with back-slash \\ display \\ chars", the sixteenth string implied.}
                ),
                string_dumperify(
                    qq{"I am a double-quoted string, in a double-quoted qq{} string with back-slash \\ display \\ chars", the sixteenth string implied.}
                ),
                q{TPV27 string_to_string(qq{"I am a double-quoted string... back-slash \\ display \\ chars", the sixteenth string implied.}) returns correct value}
            );
        },
        q{TPV27 string_to_string(qq{"I am a double-quoted string... back-slash \\ display \\ chars", the sixteenth string implied.}) lives}
    );
    lives_and(    # TPV30
        sub {
            is( string__typetest0(), "Spice $mode_tagline", q{TPV30 string__typetest0() returns correct value} );
        },
        q{TPV30 string__typetest0() lives}
    );
    throws_ok(    # TPV40
        sub { string__typetest1() },
        "/(EPV00.*$mode_tagline)|(Usage.*string__typetest1)/"
        ,         # DEV NOTE: 2 different error messages, RPerl & C
        q{TPV40 string__typetest1() throws correct exception}
    );
    throws_ok(    # TPV41
        sub { string__typetest1(undef) },
        "/EPV00.*$mode_tagline/",
        q{TPV41 string__typetest1(undef) throws correct exception}
    );
    throws_ok(    # TPV42
        sub { string__typetest1(3) },
        "/EPV01.*$mode_tagline/",
        q{TPV42 string__typetest1(3) throws correct exception}
    );
    throws_ok(    # TPV43
        sub { string__typetest1(-17) },
        "/EPV01.*$mode_tagline/",
        q{TPV43 string__typetest1(-17) throws correct exception}
    );
    throws_ok(    # TPV44
        sub { string__typetest1(-17.3) },
        "/EPV01.*$mode_tagline/",
        q{TPV44 string__typetest1(-17.3) throws correct exception}
    );
    lives_and(    # TPV45
        sub {
            is( string__typetest1('-17.3'), "'-17.3' $mode_tagline", q{TPV45 string__typetest1('-17.3') returns correct value} );
        },
        q{TPV45 string__typetest1('-17.3') lives}
    );
    throws_ok(    # TPV46
        sub { string__typetest1( [3] ) },
        "/EPV01.*$mode_tagline/",
        q{TPV46 string__typetest1([3]) throws correct exception}
    );
    throws_ok(    # TPV47
        sub { string__typetest1( { a_key => 3 } ) },
        "/EPV01.*$mode_tagline/",
        q{TPV47 string__typetest1({a_key => 3}) throws correct exception}
    );
    lives_and(    # TPV48
        sub {
            is( string__typetest1('Melange'), "'Melange' $mode_tagline", q{TPV48 string__typetest1('Melange') returns correct value} );
        },
        q{TPV48 string__typetest1('Melange') lives}
    );
    lives_and(    # TPV49
        sub {
            is( string__typetest1("\nThe Spice Extends Life\nThe Spice Expands Consciousness\nThe Spice Is Vital To Space Travel\n"),
                "'\nThe Spice Extends Life\nThe Spice Expands Consciousness\nThe Spice Is Vital To Space Travel\n' $mode_tagline",
                q{TPV49 string__typetest1("\nThe Spice Extends Life\nThe Spice Expands Consciousness\nThe Spice Is Vital To Space Travel\n") returns correct value}
            );
        },
        q{TPV49 string__typetest1("\nThe Spice Extends Life\nThe Spice Expands Consciousness\nThe Spice Is Vital To Space Travel\n") lives}
    );
}

done_testing();
