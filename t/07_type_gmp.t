#!/usr/bin/perl

# suppress 'WEXRP00: Found multiple rperl executables' due to blib/ & pre-existing installation(s)
BEGIN { $ENV{RPERL_WARNINGS} = 0; }

use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.002_000;

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitStringySplit ProhibitInterpolationOfLiterals)  # DEVELOPER DEFAULT 2: allow string test values
## no critic qw(ProhibitStringyEval) # SYSTEM DEFAULT 1: allow eval()
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(RequireCheckingReturnValueOfEval)  # SYSTEM DEFAULT 4: allow eval() test code blocks

use RPerl::Test;
use rperltypesconv;
use Test::More;    # tests => XYZ;
use Test::Exception;
use Test::Number::Delta;

BEGIN {
    if ( $ENV{RPERL_VERBOSE} ) {
        Test::More::diag("[[[ Beginning GMP Type Pre-Test Loading, RPerl Type System ]]]");
    }
    lives_and( sub { use_ok('RPerl::AfterSubclass'); },            q{use_ok('RPerl::AfterSubclass') lives} );
    lives_and( sub { use_ok('rperlgmp'); }, q{use_ok('rperlgmp') lives} );
    lives_and( sub { use_ok('RPerl::DataType::GMPInteger_cpp'); }, q{use_ok('RPerl::DataType::GMPInteger_cpp') lives} );
}

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
        Test::More::diag( '[[[ Beginning RPerl GMP Type Tests, ' . $ops . ' operations and ' . $types . ' data types ]]]' );
    }

    #    $RPerl::DEBUG = 1;
    #    RPerl::diag('have $ops = ' . $ops . "\n");
    #    RPerl::diag('have $types = ' . $types . "\n");
    #    RPerl::diag('have $mode_tagline = ' . $mode_tagline . "\n");

    lives_ok( sub { rperltypes::types_enable($types) }, q{mode '} . $ops . ' operations and ' . $types . ' data types' . q{' enabled} );

    if ( $ops eq 'CPP' ) {

        # force reload
        delete $main::{'RPerl__DataType__GMPInteger__MODE_ID'};

        my $package = 'RPerl::DataType::GMPInteger_cpp';
        lives_and( sub { require_ok($package); }, 'require_ok(' . $package . ') lives' );

        #            lives_and( sub { use_ok($package); }, 'use_ok(' . $package . ') lives' );

        lives_ok( sub { eval( $package . '::cpp_load();' ) }, $package . '::cpp_load() lives' );
    }

    lives_ok( sub { main->can('RPerl__DataType__GMPInteger__MODE_ID') }, 'main::RPerl__DataType__GMPInteger__MODE_ID() exists' );

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

    # [[[ BOOLEANIFY TESTS ]]]
    # [[[ BOOLEANIFY TESTS ]]]
    # [[[ BOOLEANIFY TESTS ]]]

# START HERE: test *IFY here; test *IFY in 04*; test typetests()
# START HERE: test *IFY here; test *IFY in 04*; test typetests()
# START HERE: test *IFY here; test *IFY in 04*; test typetests()

    lives_and(                                                    # TGIV000
        sub {
            my gmp_integer $tmp1 = gmp_integer->new();
            gmp_set_signed_integer($tmp1, 0);
            is( gmp_integer_to_boolean($tmp1), 0, q{TGIV000 gmp_integer_to_boolean($tmp1==0) returns correct value} );
        },
        q{TGIV000 gmp_integer_to_boolean($tmp1==0) lives}
    );

    lives_and(                                                    # TGIV001
        sub {
            my gmp_integer $tmp1 = gmp_integer->new();
            gmp_set_signed_integer($tmp1, 1);
            is( gmp_integer_to_boolean($tmp1), 1, q{TGIV001 gmp_integer_to_boolean($tmp1==1) returns correct value} );
        },
        q{TGIV001 gmp_integer_to_boolean($tmp1==1) lives}
    );

    lives_and(                                                    # TGIV001
        sub {
            my gmp_integer $tmp1 = gmp_integer->new();
            gmp_set_signed_integer($tmp1, -1);
            is( gmp_integer_to_boolean($tmp1), 1, q{TGIV001 gmp_integer_to_boolean($tmp1==-1) returns correct value} );
        },
        q{TGIV001 gmp_integer_to_boolean($tmp1==-1) lives}
    );

    lives_and(                                                    # TGIV001
        sub {
            my gmp_integer $tmp1 = gmp_integer->new();
            gmp_set_signed_integer($tmp1, 1_234_567_890);
            is( gmp_integer_to_boolean($tmp1), 1, q{TGIV001 gmp_integer_to_boolean($tmp1==1_234_567_890) returns correct value} );
        },
        q{TGIV001 gmp_integer_to_boolean($tmp1==1_234_567_890) lives}
    );

    lives_and(                                                    # TGIV001
        sub {
            my gmp_integer $tmp1 = gmp_integer->new();
            gmp_set_signed_integer($tmp1, -1_234_567_890);
            is( gmp_integer_to_boolean($tmp1), 1, q{TGIV001 gmp_integer_to_boolean($tmp1==-1_234_567_890) returns correct value} );
        },
        q{TGIV001 gmp_integer_to_boolean($tmp1==-1_234_567_890) lives}
    );

    throws_ok(    # TGIV500
        sub { gmp_integer_to_boolean() },
        "/(EGIV00.*$mode_tagline)|(Usage.*gmp_integer_to_boolean)/",    # DEV NOTE: 2 different error messages, RPerl & C
        q{TGIV500 gmp_integer_to_boolean() throws correct exception}
    );

    # [[[ INTEGERIFY TESTS ]]]
    # [[[ INTEGERIFY TESTS ]]]
    # [[[ INTEGERIFY TESTS ]]]

    lives_and(                                                    # TGIV200
        sub {
            my gmp_integer $tmp1 = gmp_integer->new();
            gmp_set_signed_integer($tmp1, 34_567_890);
            is( gmp_integer_to_integer($tmp1), 34_567_890, q{TGIV200 gmp_integer_to_integer($tmp1==34_567_890) returns correct value} );
        },
        q{TGIV200 gmp_integer_to_integer($tmp1==34_567_890) lives}
    );

=DISABLE
    throws_ok(    # TGIV500
        sub { gmp_integer_to_string() },
        "/(EGIV00.*$mode_tagline)|(Usage.*gmp_integer_to_string)/",    # DEV NOTE: 2 different error messages, RPerl & C
        q{TGIV500 gmp_integer_to_string() throws correct exception}
    );

    throws_ok(                                                    # TGIV501
        sub { gmp_integer_to_string(undef) },
        "/EGIV00.*$mode_tagline/",
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
        "/EGIV01.*$mode_tagline/",
        q{TGIV506 gmp_integer_to_string(-17.3) throws correct exception}
    );
    throws_ok(                                                    # TGIV507
        sub { gmp_integer_to_string('-17.3') },
        "/EGIV01.*$mode_tagline/",
        q{TGIV507 gmp_integer_to_string('-17.3') throws correct exception}
    );
    throws_ok(                                                    # TGIV508
        sub { gmp_integer_to_string( [3] ) },
        "/EGIV01.*$mode_tagline/",
        q{TGIV508 gmp_integer_to_string([3]) throws correct exception}
    );
    throws_ok(                                                    # TGIV509
        sub { gmp_integer_to_string( { a_key => 3 } ) },
        "/EGIV01.*$mode_tagline/",
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
        "/EGIV01.*$mode_tagline/",
        q{TGIV516 gmp_integer_to_string(-1_234_567_890_000_000_000_000_000_000_000_000) throws correct exception}
    );
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

    # [[[ TYPE TESTING TESTS ]]]
    # [[[ TYPE TESTING TESTS ]]]
    # [[[ TYPE TESTING TESTS ]]]
 
    lives_and(                                                    # TGIV700
        sub {
            is( gmp_integer__typetest0(), ( 3 + $mode_id ), q{TGIV700 gmp_integer__typetest0() returns correct value} );
        },
        q{TGIV700 gmp_integer__typetest0() lives}
    );


=DISABLE
    throws_ok(                                                    # TGIV610
        sub { gmp_integer__typetest1() },
        "/(EGIV00.*$mode_tagline)|(Usage.*gmp_integer__typetest1)/"
        ,                                                         # DEV NOTE: 2 different error messages, RPerl & C
        q{TGIV610 gmp_integer__typetest1() throws correct exception}
    );
    throws_ok(                                                    # TGIV611
        sub { gmp_integer__typetest1(undef) },
        "/EGIV00.*$mode_tagline/",
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
        "/EGIV01.*$mode_tagline/",
        q{TGIV614 gmp_integer__typetest1(-17.3) throws correct exception}
    );
    throws_ok(                                                    # TGIV615
        sub { gmp_integer__typetest1('-17.3') },
        "/EGIV01.*$mode_tagline/",
        q{TGIV615 gmp_integer__typetest1('-17.3') throws correct exception}
    );
    throws_ok(                                                    # TGIV616
        sub { gmp_integer__typetest1( [3] ) },
        "/EGIV01.*$mode_tagline/",
        q{TGIV616 gmp_integer__typetest1([3]) throws correct exception}
    );
    throws_ok(                                                    # TGIV617
        sub { gmp_integer__typetest1( { a_key => 3 } ) },
        "/EGIV01.*$mode_tagline/",
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
        "/EGIV01.*$mode_tagline/",
        q{TGIV619 gmp_integer__typetest1(-1_234_567_890_000_000_000_000_000_000_000_000) throws correct exception}
    );
=cut
}

done_testing();
