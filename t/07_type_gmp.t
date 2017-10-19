#!/usr/bin/perl

# [[[ PRE-HEADER ]]]
# suppress 'WEXRP00: Found multiple rperl executables' due to blib/ & pre-existing installation(s)
BEGIN { $ENV{RPERL_WARNINGS} = 0; }

# [[[ HEADER ]]]
use strict;
use warnings;
#use RPerl::AfterSubclass;  # NEED FIX: moved by bulk88 to below BEGIN block to optimize for skip speed on Windows OS, should be 'use RPerlish;' ?
our $VERSION = 0.003_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitStringySplit ProhibitInterpolationOfLiterals)  # DEVELOPER DEFAULT 2: allow string test values
## no critic qw(ProhibitStringyEval)  # SYSTEM DEFAULT 1: allow eval()
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(RequireCheckingReturnValueOfEval)  # SYSTEM DEFAULT 4: allow eval() test code blocks

# [[[ INCLUDES ]]]

use Test::More;
BEGIN {
    # NEED FIX: get gmpxx installed & working in Windows
    use English;
    if ( $OSNAME eq 'MSWin32' ) {
        plan skip_all => "[[[ MS Windows OS Detected, GNU Multi-Precision Library Temporarily Disabled, Skipping GMP Type Tests, RPerl Type System ]]]";
    }
}
use RPerl::AfterSubclass;  # NEED FIX: should not be here, see NEED FIX in HEADER above
use RPerl::Test;
use RPerl::Test::Foo;
use rperltypesconv;
use Test::Exception;
use Test::Number::Delta;
use RPerl::DataType::GMPInteger qw(gmp_integer__typetest0 gmp_integer__typetest1);

# [[[ OPERATIONS ]]]

BEGIN {
    plan tests => 75;
    if ( $ENV{RPERL_VERBOSE} ) {
        Test::More::diag("[[[ Beginning GMP Type Pre-Test Loading, RPerl Type System ]]]");
    }
    lives_and( sub { use_ok('RPerl::AfterSubclass'); },            q{use_ok('RPerl::AfterSubclass') lives} );
    lives_and( sub { use_ok('rperlgmp'); }, q{use_ok('rperlgmp') lives} );
    lives_and( sub { use_ok('RPerl::DataType::GMPInteger_cpp'); }, q{use_ok('RPerl::DataType::GMPInteger_cpp') lives} );
}

my integer $number_of_tests_run = 3;  # initialize to 3 for use_ok() calls in BEGIN block above

# use Data::Dumper() to stringify a string
#our string $string_dumperify = sub {  # NEED FIX: RPerl subroutines disabled here
sub string_dumperify {
    ( my string $input_string ) = @_;

    #    RPerl::diag("in 07_type_gmp.t string_dumperify(), received have \$input_string =\n$input_string\n\n");
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
#foreach my integer $mode_id ( sort keys %{$RPerl::MODES} ) {
for my $mode_id ( 0, 2 ) {    # DEV NOTE: PERLOPS_PERLTYPES & CPPOPS_CPPTYPES only currently supported

    #for my $mode_id ( 1 .. 1 ) {  # TEMPORARY DEBUGGING CPPOPS_PERLTYPES ONLY

    # [[[ MODE SETUP ]]]
    #    RPerl::diag("in 07_type_gmp.t, top of for() loop, have \$mode_id = $mode_id\n");
    my scalartype_hashref $mode = $RPerl::MODES->{$mode_id};
    my string $ops              = $mode->{ops};
    my string $types            = $mode->{types};
    my string $mode_tagline     = $ops . 'OPS_' . $types . 'TYPES';
    if ( $ENV{RPERL_VERBOSE} ) {
        Test::More::diag( '[[[ Beginning RPerl GMP Type Tests, ' . $ops . ' Operations & ' . $types . ' Data Types' . ' ]]]' );
    }

    #    $RPerl::DEBUG = 1;
    #    RPerl::diag('have $ops = ' . $ops . "\n");
    #    RPerl::diag('have $types = ' . $types . "\n");
    #    RPerl::diag('have $mode_tagline = ' . $mode_tagline . "\n");

    lives_ok( sub { rperltypes::types_enable($types) }, q{mode '} . $ops . ' Operations & ' . $types . ' Data Types' . q{' enabled} );
    $number_of_tests_run++;

    if ( $ops eq 'CPP' ) {

        # force reload
        delete $main::{'RPerl__DataType__GMPInteger__MODE_ID'};

        my $package = 'RPerl::DataType::GMPInteger_cpp';
        lives_and( sub { require_ok($package); }, 'require_ok(' . $package . ') lives' );
        $number_of_tests_run++;
  
        #            lives_and( sub { use_ok($package); }, 'use_ok(' . $package . ') lives' );

        lives_ok( sub { eval( $package . '::cpp_load();' ) }, $package . '::cpp_load() lives' );
        $number_of_tests_run++;
    }

    lives_ok( sub { main->can('RPerl__DataType__GMPInteger__MODE_ID') }, 'main::RPerl__DataType__GMPInteger__MODE_ID() exists' );
    $number_of_tests_run++;

#RPerl::diag('in 07_type_gmp.t, top of for() loop, have $RPerl::MODES = ' . "\n" . Dumper($RPerl::MODES) . "\n");
#RPerl::diag('in 07_type_gmp.t, top of for() loop, have RPerl__DataType__ . $type . __MODE_ID = RPerl__DataType__GMPInteger__MODE_ID' . "\n");
#RPerl::diag('in 07_type_gmp.t, top of for() loop, have main::RPerl__DataType__GMPInteger__MODE_ID() = ' . main::RPerl__DataType__GMPInteger__MODE_ID() . "\n");
#RPerl::diag('in 07_type_gmp.t, top of for() loop, have eval(main::RPerl__DataType__GMPInteger__MODE_ID()) = ' . eval('main::RPerl__DataType__GMPInteger__MODE_ID()') . "\n");
#RPerl::diag('in 07_type_gmp.t, top of for() loop, have main->can(...) = ' . main->can( 'RPerl__DataType__GMPInteger__MODE_ID' ) . "\n");
#RPerl::diag('in 07_type_gmp.t, top of for() loop, have main->can(...)->() = ' . main->can( 'RPerl__DataType__GMPInteger__MODE_ID' )->() . "\n");
#die 'TMP DEBUG';

    lives_and(
        sub {
            is( $RPerl::MODES->{ main->can('RPerl__DataType__GMPInteger__MODE_ID')->() }->{types},
                $types, 'main::RPerl__DataType__GMPInteger__MODE_ID() types returns ' . $types );
        },
        'main::RPerl__DataType__GMPInteger__MODE_ID() lives'
    );
    $number_of_tests_run++;
 
    # [[[ TYPE CHECKING TESTS ]]]
    # [[[ TYPE CHECKING TESTS ]]]
    # [[[ TYPE CHECKING TESTS ]]]

    throws_ok(    # TGIV000
        sub { gmp_integer_to_boolean() },
        "/(EMPV00.*$mode_tagline)|(Usage.*gmp_integer_to_boolean)/",    # DEV NOTE: 2 different error messages, RPerl & C
        q{TGIV000 gmp_integer_to_boolean() throws correct exception}
    );

    throws_ok(    # TGIV001
        sub { gmp_integer_to_boolean(undef) },
        "/(EMPV00.*$mode_tagline)/",
        q{TGIV001 gmp_integer_to_boolean(undef) throws correct exception}
    );

    throws_ok(    # TGIV002
        sub { gmp_integer_to_boolean(0) },
        "/(EMPV01.*$mode_tagline)/",
        q{TGIV002 gmp_integer_to_boolean(0) throws correct exception}
    );

    throws_ok(    # TGIV003
        sub { gmp_integer_to_boolean(-23.42) },
        "/(EMPV01.*$mode_tagline)/",
        q{TGIV003 gmp_integer_to_boolean(-23.42) throws correct exception}
    );

    throws_ok(    # TGIV004
        sub { gmp_integer_to_boolean('howdy') },
        "/(EMPV01.*$mode_tagline)/",
        q{TGIV004 gmp_integer_to_boolean('howdy') throws correct exception}
    );

    throws_ok(    # TGIV005
        sub { gmp_integer_to_boolean([]) },
        "/(EMPV01.*$mode_tagline)/",
        q{TGIV005 gmp_integer_to_boolean([]) throws correct exception}
    );

    throws_ok(    # TGIV006
        sub { gmp_integer_to_boolean([21, 12, 23]) },
        "/(EMPV01.*$mode_tagline)/",
        q{TGIV006 gmp_integer_to_boolean([21, 12, 23]) throws correct exception}
    );

    throws_ok(    # TGIV007
        sub { gmp_integer_to_boolean({}) },
        "/(EMPV02.*$mode_tagline)/",
        q{TGIV007 gmp_integer_to_boolean({}) throws correct exception}
    );

    throws_ok(    # TGIV008
        sub { gmp_integer_to_boolean({carter => 'chris', duchovny => 'david', anderson => 'gillian'}) },
        "/(EMPV02.*$mode_tagline)/",
        q{TGIV008 gmp_integer_to_boolean({carter => 'chris', duchovny => 'david', anderson => 'gillian'}) throws correct exception}
    );

    throws_ok(    # TGIV009
        sub { gmp_integer_to_boolean(RPerl::Test::Foo->new()) },
        "/(EMPV03.*$mode_tagline)/",
        q{TGIV009 gmp_integer_to_boolean(RPerl::Test::Foo->new()) throws correct exception}
    );

    throws_ok(    # TGIV010
        sub { gmp_integer_to_boolean(Math::BigInt->new(0)) },
        "/(EMPV04.*$mode_tagline)/",
        q{TGIV010 gmp_integer_to_boolean(Math::BigInt->new()) throws correct exception}
    );

    throws_ok(    # TGIV011
        sub { 
            my gmp_integer $gmp_integer_no_value = gmp_integer->new();
            delete $gmp_integer_no_value->{value};
            gmp_integer_to_boolean($gmp_integer_no_value);
        },
        "/(EMPV05.*$mode_tagline)/",
        q{TGIV011 gmp_integer_to_boolean($gmp_integer_no_value) throws correct exception}
    );
    
    # NEED ADDRESS: is there no way to trigger CPPOPS EMPV06?

    throws_ok(    # TGIV012
        sub { 
            my gmp_integer $gmp_integer_undef_value = gmp_integer->new();
            $gmp_integer_undef_value->{value} = undef;
            gmp_integer_to_boolean($gmp_integer_undef_value);
        },
        "/(EMPV07.*$mode_tagline)/",
        q{TGIV012 gmp_integer_to_boolean($gmp_integer_undef_value) throws correct exception}
    );

    throws_ok(    # TGIV013
        sub { 
            my gmp_integer $gmp_integer_nonobject_value = gmp_integer->new();
            $gmp_integer_nonobject_value->{value} = 0;
            gmp_integer_to_boolean($gmp_integer_nonobject_value);
        },
        "/(EMPV08.*$mode_tagline)/",
        q{TGIV013 gmp_integer_to_boolean($gmp_integer_nonobject_value->{value} = 0) throws correct exception}
    );

    throws_ok(    # TGIV014
        sub { 
            my gmp_integer $gmp_integer_nonobject_value = gmp_integer->new();
            $gmp_integer_nonobject_value->{value} = 'the truth is out there';
            gmp_integer_to_boolean($gmp_integer_nonobject_value);
        },
        "/(EMPV08.*$mode_tagline)/",
        q{TGIV014 gmp_integer_to_boolean($gmp_integer_nonobject_value->{value} = 'the truth is out there') throws correct exception}
    );

    throws_ok(    # TGIV015
        sub { 
            my gmp_integer $gmp_integer_nonobject_value = gmp_integer->new();
            $gmp_integer_nonobject_value->{value} = [];
            gmp_integer_to_boolean($gmp_integer_nonobject_value);
        },
        "/(EMPV08.*$mode_tagline)/",
        q{TGIV015 gmp_integer_to_boolean($gmp_integer_nonobject_value->{value} = []) throws correct exception}
    );

    throws_ok(    # TGIV016
        sub { 
            my gmp_integer $gmp_integer_nonobject_value = gmp_integer->new();
            $gmp_integer_nonobject_value->{value} = {};
            gmp_integer_to_boolean($gmp_integer_nonobject_value);
        },
        "/(EMPV08.*$mode_tagline)/",
        q{TGIV016 gmp_integer_to_boolean($gmp_integer_nonobject_value->{value} = {}) throws correct exception}
    );

    throws_ok(    # TGIV017
        sub { 
            my gmp_integer $gmp_integer_object_value = gmp_integer->new();
            $gmp_integer_object_value->{value} = RPerl::Test::Foo->new();
            gmp_integer_to_boolean($gmp_integer_object_value);
        },
        "/(EMPV09.*$mode_tagline)/",
        q{TGIV017 gmp_integer_to_boolean($gmp_integer_object_value) throws correct exception}
    );

    $number_of_tests_run += 18;

    # [[[ BOOLEANIFY TESTS ]]]
    # [[[ BOOLEANIFY TESTS ]]]
    # [[[ BOOLEANIFY TESTS ]]]

    lives_and(                                                    # TGIV100
        sub {
            my gmp_integer $tmp1 = gmp_integer->new();
            gmp_set_signed_integer($tmp1, 0);
            is( gmp_integer_to_boolean($tmp1), 0, q{TGIV100 gmp_integer_to_boolean($tmp1==0) returns correct value} );
        },
        q{TGIV100 gmp_integer_to_boolean($tmp1==0) lives}
    );

    lives_and(                                                    # TGIV101
        sub {
            my gmp_integer $tmp1 = gmp_integer->new();
            gmp_set_signed_integer($tmp1, 1);
            is( gmp_integer_to_boolean($tmp1), 1, q{TGIV101 gmp_integer_to_boolean($tmp1==1) returns correct value} );
        },
        q{TGIV101 gmp_integer_to_boolean($tmp1==1) lives}
    );

    lives_and(                                                    # TGIV102
        sub {
            my gmp_integer $tmp1 = gmp_integer->new();
            gmp_set_signed_integer($tmp1, -1);
            is( gmp_integer_to_boolean($tmp1), 1, q{TGIV102 gmp_integer_to_boolean($tmp1==-1) returns correct value} );
        },
        q{TGIV102 gmp_integer_to_boolean($tmp1==-1) lives}
    );

    lives_and(                                                    # TGIV103
        sub {
            my gmp_integer $tmp1 = gmp_integer->new();
            gmp_set_signed_integer($tmp1, 1_234_567_890);
            is( gmp_integer_to_boolean($tmp1), 1, q{TGIV103 gmp_integer_to_boolean($tmp1==1_234_567_890) returns correct value} );
        },
        q{TGIV103 gmp_integer_to_boolean($tmp1==1_234_567_890) lives}
    );

    lives_and(                                                    # TGIV104
        sub {
            my gmp_integer $tmp1 = gmp_integer->new();
            gmp_set_signed_integer($tmp1, -1_234_567_890);
            is( gmp_integer_to_boolean($tmp1), 1, q{TGIV104 gmp_integer_to_boolean($tmp1==-1_234_567_890) returns correct value} );
        },
        q{TGIV104 gmp_integer_to_boolean($tmp1==-1_234_567_890) lives}
    );

    $number_of_tests_run += 5;

    # [[[ UNSIGNED INTEGERIFY TESTS ]]]
    # [[[ UNSIGNED INTEGERIFY TESTS ]]]
    # [[[ UNSIGNED INTEGERIFY TESTS ]]]

    lives_and(                                                    # TGIV200
        sub {
            my gmp_integer $tmp1 = gmp_integer->new();
            gmp_set_signed_integer($tmp1, 0);
            is( gmp_integer_to_unsigned_integer($tmp1), 0, q{TGIV200 gmp_integer_to_unsigned_integer($tmp1==0) returns correct value} );
        },
        q{TGIV200 gmp_integer_to_unsigned_integer($tmp1==0) lives}
    );

    lives_and(                                                    # TGIV201
        sub {
            my gmp_integer $tmp1 = gmp_integer->new();
            gmp_set_signed_integer($tmp1, 34_567_890);
            is( gmp_integer_to_unsigned_integer($tmp1), 34_567_890, q{TGIV201 gmp_integer_to_unsigned_integer($tmp1==34_567_890) returns correct value} );
        },
        q{TGIV201 gmp_integer_to_unsigned_integer($tmp1==34_567_890) lives}
    );

    lives_and(                                                    # TGIV202
        sub {
            my gmp_integer $tmp1 = gmp_integer->new();
            gmp_set_signed_integer($tmp1, -34_567_890);
            is( gmp_integer_to_unsigned_integer($tmp1), 34_567_890, q{TGIV202 gmp_integer_to_unsigned_integer($tmp1==-34_567_890) returns correct value} );
        },
        q{TGIV202 gmp_integer_to_unsigned_integer($tmp1==-34_567_890) lives}
    );

=DISABLE
    throws_ok(    # TGIV210
        sub { gmp_integer_to_unsigned_integer(undef) },
        "/(EMPV00.*$mode_tagline)/",
        q{TGIV210 gmp_integer_to_unsigned_integer(undef) throws correct exception}
    );
=cut

    $number_of_tests_run += 3;

    # [[[ INTEGERIFY TESTS ]]]
    # [[[ INTEGERIFY TESTS ]]]
    # [[[ INTEGERIFY TESTS ]]]

    lives_and(                                                    # TGIV300
        sub {
            my gmp_integer $tmp1 = gmp_integer->new();
            gmp_set_signed_integer($tmp1, 0);
            is( gmp_integer_to_integer($tmp1), 0, q{TGIV300 gmp_integer_to_integer($tmp1==0) returns correct value} );
        },
        q{TGIV300 gmp_integer_to_integer($tmp1==0) lives}
    );

    lives_and(                                                    # TGIV301
        sub {
            my gmp_integer $tmp1 = gmp_integer->new();
            gmp_set_signed_integer($tmp1, 34_567_890);
            is( gmp_integer_to_integer($tmp1), 34_567_890, q{TGIV301 gmp_integer_to_integer($tmp1==34_567_890) returns correct value} );
        },
        q{TGIV301 gmp_integer_to_integer($tmp1==34_567_890) lives}
    );

    lives_and(                                                    # TGIV302
        sub {
            my gmp_integer $tmp1 = gmp_integer->new();
            gmp_set_signed_integer($tmp1, -34_567_890);
            is( gmp_integer_to_integer($tmp1), -34_567_890, q{TGIV302 gmp_integer_to_integer($tmp1==-34_567_890) returns correct value} );
        },
        q{TGIV302 gmp_integer_to_integer($tmp1==-34_567_890) lives}
    );

    $number_of_tests_run += 3;

    # [[[ STRINGIFY TESTS ]]]
    # [[[ STRINGIFY TESTS ]]]
    # [[[ STRINGIFY TESTS ]]]

=DISABLE
    throws_ok(    # TGIV500
        sub { gmp_integer_to_string() },
        "/(EMPV00.*$mode_tagline)|(Usage.*gmp_integer_to_string)/",    # DEV NOTE: 2 different error messages, RPerl & C
        q{TGIV500 gmp_integer_to_string() throws correct exception}
    );

    throws_ok(                                                    # TGIV501
        sub { gmp_integer_to_string(undef) },
        "/EMPV00.*$mode_tagline/",
        q{TGIV501 gmp_integer_to_string(undef) throws correct exception}
    );
    lives_and(                                                    # TGIV502
        sub {
            is( gmp_integer_to_string(0), '0', q{TGIV502 gmp_integer_to_string(0) returns correct value} );
        },
        q{TGIV502 gmp_integer_to_string(0) lives}
    );
    lives_and(                                                    # TGIV503
        sub {
            is( gmp_integer_to_string(-0), '0', q{TGIV503 gmp_integer_to_string(-0) returns correct value} );
        },
        q{TGIV503 gmp_integer_to_string(-0) lives}
    );
    lives_and(                                                    # TGIV504
        sub {
            is( gmp_integer_to_string(3), '3', q{TGIV504 gmp_integer_to_string(3) returns correct value} );
        },
        q{TGIV504 gmp_integer_to_string(3) lives}
    );
    lives_and(                                                    # TGIV505
        sub {
            is( gmp_integer_to_string(-17), '-17', q{TGIV505 gmp_integer_to_string(-17) returns correct value} );
        },
        q{TGIV505 gmp_integer_to_string(-17) lives}
    );
    throws_ok(                                                    # TGIV506
        sub { gmp_integer_to_string(-17.3) },
        "/EMPV01.*$mode_tagline/",
        q{TGIV506 gmp_integer_to_string(-17.3) throws correct exception}
    );
    throws_ok(                                                    # TGIV507
        sub { gmp_integer_to_string('-17.3') },
        "/EMPV01.*$mode_tagline/",
        q{TGIV507 gmp_integer_to_string('-17.3') throws correct exception}
    );
    throws_ok(                                                    # TGIV508
        sub { gmp_integer_to_string( [3] ) },
        "/EMPV01.*$mode_tagline/",
        q{TGIV508 gmp_integer_to_string([3]) throws correct exception}
    );
    throws_ok(                                                    # TGIV509
        sub { gmp_integer_to_string( { a_key => 3 } ) },
        "/EMPV01.*$mode_tagline/",
        q{TGIV509 gmp_integer_to_string({a_key => 3}) throws correct exception}
    );
    lives_and(                                                    # TGIV510
        sub {
            is( gmp_integer_to_string(34_567_890), '34_567_890', q{TGIV510 gmp_integer_to_string(34_567_890) returns correct value} );
        },
        q{TGIV510 gmp_integer_to_string(34_567_890) lives}
    );
    lives_and(                                                    # TGIV511
        sub {
            is( gmp_integer_to_string(-34_567_890), '-34_567_890', q{TGIV511 gmp_integer_to_string(-34_567_890) returns correct value} );
        },
        q{TGIV511 gmp_integer_to_string(-34_567_890) lives}
    );
    lives_and(                                                    # TGIV512
        sub {
            is( gmp_integer_to_string(234_567_890), '234_567_890', q{TGIV512 gmp_integer_to_string(234_567_890) returns correct value} );
        },
        q{TGIV512 gmp_integer_to_string(234_567_890) lives}
    );
    lives_and(                                                    # TGIV513
        sub {
            is( gmp_integer_to_string(-234_567_890), '-234_567_890', q{TGIV513 gmp_integer_to_string(-234_567_890) returns correct value} );
        },
        q{TGIV513 gmp_integer_to_string(-234_567_890) lives}
    );
    lives_and(                                                    # TGIV514
        sub {
            is( gmp_integer_to_string(1_234_567_890), '1_234_567_890', q{TGIV514 gmp_integer_to_string(1_234_567_890) returns correct value} );
        },
        q{TGIV514 gmp_integer_to_string(1_234_567_890) lives}
    );
    lives_and(                                                    # TGIV515
        sub {
            is( gmp_integer_to_string(-1_234_567_890), '-1_234_567_890', q{TGIV515 gmp_integer_to_string(-1_234_567_890) returns correct value} );
        },
        q{TGIV515 gmp_integer_to_string(-1_234_567_890) lives}
    );
    throws_ok(                                                    # TGIV516
        sub {
            gmp_integer_to_string(-1_234_567_890_000_000_000_000_000_000_000_000);
        },
        "/EMPV01.*$mode_tagline/",
        q{TGIV516 gmp_integer_to_string(-1_234_567_890_000_000_000_000_000_000_000_000) throws correct exception}
    );

    $number_of_tests_run += 17;
=cut

    # [[[ GMP INTEGERIFY TESTS ]]]
    # [[[ GMP INTEGERIFY TESTS ]]]
    # [[[ GMP INTEGERIFY TESTS ]]]

    lives_and(                                                    # TGIV600
        sub {
            is( gmp_integer_to_integer(integer_to_gmp_integer(34_567_890)), 34_567_890, q{TGIV600 gmp_integer_to_integer(integer_to_gmp_integer(34_567_890)) returns correct value} );
        },
        q{TGIV600 gmp_integer_to_integer(integer_to_gmp_integer(34_567_890)) lives}
    );

    lives_and(                                                    # TGIV601
        sub {
            is( gmp_get_signed_integer(integer_to_gmp_integer(34_567_890)), 34_567_890, q{TGIV601 gmp_get_signed_integer(integer_to_gmp_integer(34_567_890)) returns correct value} );
        },
        q{TGIV601 gmp_get_signed_integer(integer_to_gmp_integer(34_567_890)) lives}
    );

    $number_of_tests_run += 2;

    # [[[ TYPE TESTING TESTS ]]]
    # [[[ TYPE TESTING TESTS ]]]
    # [[[ TYPE TESTING TESTS ]]]
 
    lives_and(                                                    # TGIV700
        sub {
            is( gmp_integer__typetest0(), ( 3 + $mode_id ), q{TGIV700 gmp_integer__typetest0() returns correct value} );
        },
        q{TGIV700 gmp_integer__typetest0() lives}
    );

    $number_of_tests_run += 1;

=DISABLE
    throws_ok(                                                    # TGIV610
        sub { gmp_integer__typetest1() },
        "/(EMPV00.*$mode_tagline)|(Usage.*gmp_integer__typetest1)/"
        ,                                                         # DEV NOTE: 2 different error messages, RPerl & C
        q{TGIV610 gmp_integer__typetest1() throws correct exception}
    );
    throws_ok(                                                    # TGIV611
        sub { gmp_integer__typetest1(undef) },
        "/EMPV00.*$mode_tagline/",
        q{TGIV611 gmp_integer__typetest1(undef) throws correct exception}
    );
    lives_and(                                                    # TGIV612
        sub {
            is( gmp_integer__typetest1(3), ( ( 3 * 2 ) + $mode_id ), q{TGIV612 gmp_integer__typetest1(3) returns correct value} );
        },
        q{TGIV612 gmp_integer__typetest1(3) lives}
    );
    lives_and(                                                    # TGIV613
        sub {
            is( gmp_integer__typetest1(-17), ( ( -17 * 2 ) + $mode_id ), q{TGIV613 gmp_integer__typetest1(-17) returns correct value} );
        },
        q{TGIV613 gmp_integer__typetest1(-17) lives}
    );
    throws_ok(                                                    # TGIV614
        sub { gmp_integer__typetest1(-17.3) },
        "/EMPV01.*$mode_tagline/",
        q{TGIV614 gmp_integer__typetest1(-17.3) throws correct exception}
    );
    throws_ok(                                                    # TGIV615
        sub { gmp_integer__typetest1('-17.3') },
        "/EMPV01.*$mode_tagline/",
        q{TGIV615 gmp_integer__typetest1('-17.3') throws correct exception}
    );
    throws_ok(                                                    # TGIV616
        sub { gmp_integer__typetest1( [3] ) },
        "/EMPV01.*$mode_tagline/",
        q{TGIV616 gmp_integer__typetest1([3]) throws correct exception}
    );
    throws_ok(                                                    # TGIV617
        sub { gmp_integer__typetest1( { a_key => 3 } ) },
        "/EMPV01.*$mode_tagline/",
        q{TGIV617 gmp_integer__typetest1({a_key => 3}) throws correct exception}
    );
    lives_and(                                                    # TGIV618
        sub {
            is( gmp_integer__typetest1(-234_567_890), ( ( -234_567_890 * 2 ) + $mode_id ), q{TGIV618 gmp_integer__typetest1(-234_567_890) returns correct value} );
        },
        q{TGIV618 gmp_integer__typetest1(-234_567_890) lives}
    );
    throws_ok(                                                    # TGIV619
        sub {
            gmp_integer__typetest1(-1_234_567_890_000_000_000_000_000_000_000_000);
        },
        "/EMPV01.*$mode_tagline/",
        q{TGIV619 gmp_integer__typetest1(-1_234_567_890_000_000_000_000_000_000_000_000) throws correct exception}
    );
=cut
}

done_testing($number_of_tests_run);
