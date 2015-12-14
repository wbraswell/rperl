#!/usr/bin/perl

# suppress 'WEXRP00: Found multiple rperl executables' due to blib/ & pre-existing installation(s)
BEGIN { $ENV{RPERL_WARNINGS} = 0; }

use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.001_000;

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

    # [[[ GMP INTEGER TESTS ]]]
    # [[[ GMP INTEGER TESTS ]]]
    # [[[ GMP INTEGER TESTS ]]]

# START HERE: why is gmp_integer_to_string() not properly bound in CPPOPS_CPPTYPES mode?  do we need shims in GMPInteger_cpp.pm?  If so, why don't we need them in Integer_cpp.pm?
# START HERE: why is gmp_integer_to_string() not properly bound in CPPOPS_CPPTYPES mode?  do we need shims in GMPInteger_cpp.pm?  If so, why don't we need them in Integer_cpp.pm?
# START HERE: why is gmp_integer_to_string() not properly bound in CPPOPS_CPPTYPES mode?  do we need shims in GMPInteger_cpp.pm?  If so, why don't we need them in Integer_cpp.pm?

=START HERE
    throws_ok(    # TGIV00
        sub { gmp_integer_to_string() },
        "/(EGIV00.*$mode_tagline)|(Usage.*gmp_integer_to_string)/",    # DEV NOTE: 2 different error messages, RPerl & C
        q{TGIV00 gmp_integer_to_string() throws correct exception}
    );
=cut
 
=DISABLE
    throws_ok(                                                    # TGIV01
        sub { integer_to_string(undef) },
        "/EGIV00.*$mode_tagline/",
        q{TGIV01 integer_to_string(undef) throws correct exception}
    );
    lives_and(                                                    # TGIV02
        sub {
            is( integer_to_string(0), '0', q{TGIV02 integer_to_string(0) returns correct value} );
        },
        q{TGIV02 integer_to_string(0) lives}
    );
    lives_and(                                                    # TGIV03
        sub {
            is( integer_to_string(-0), '0', q{TGIV03 integer_to_string(-0) returns correct value} );
        },
        q{TGIV03 integer_to_string(-0) lives}
    );
    lives_and(                                                    # TGIV04
        sub {
            is( integer_to_string(3), '3', q{TGIV04 integer_to_string(3) returns correct value} );
        },
        q{TGIV04 integer_to_string(3) lives}
    );
    lives_and(                                                    # TGIV05
        sub {
            is( integer_to_string(-17), '-17', q{TGIV05 integer_to_string(-17) returns correct value} );
        },
        q{TGIV05 integer_to_string(-17) lives}
    );
    throws_ok(                                                    # TGIV06
        sub { integer_to_string(-17.3) },
        "/EGIV01.*$mode_tagline/",
        q{TGIV06 integer_to_string(-17.3) throws correct exception}
    );
    throws_ok(                                                    # TGIV07
        sub { integer_to_string('-17.3') },
        "/EGIV01.*$mode_tagline/",
        q{TGIV07 integer_to_string('-17.3') throws correct exception}
    );
    throws_ok(                                                    # TGIV08
        sub { integer_to_string( [3] ) },
        "/EGIV01.*$mode_tagline/",
        q{TGIV08 integer_to_string([3]) throws correct exception}
    );
    throws_ok(                                                    # TGIV09
        sub { integer_to_string( { a_key => 3 } ) },
        "/EGIV01.*$mode_tagline/",
        q{TGIV09 integer_to_string({a_key => 3}) throws correct exception}
    );
    lives_and(                                                    # TGIV10
        sub {
            is( integer_to_string(34_567_890), '34_567_890', q{TGIV10 integer_to_string(34_567_890) returns correct value} );
        },
        q{TGIV10 integer_to_string(34_567_890) lives}
    );
    lives_and(                                                    # TGIV11
        sub {
            is( integer_to_string(-34_567_890), '-34_567_890', q{TGIV11 integer_to_string(-34_567_890) returns correct value} );
        },
        q{TGIV11 integer_to_string(-34_567_890) lives}
    );
    lives_and(                                                    # TGIV12
        sub {
            is( integer_to_string(234_567_890), '234_567_890', q{TGIV12 integer_to_string(234_567_890) returns correct value} );
        },
        q{TGIV12 integer_to_string(234_567_890) lives}
    );
    lives_and(                                                    # TGIV13
        sub {
            is( integer_to_string(-234_567_890), '-234_567_890', q{TGIV13 integer_to_string(-234_567_890) returns correct value} );
        },
        q{TGIV13 integer_to_string(-234_567_890) lives}
    );
    lives_and(                                                    # TGIV14
        sub {
            is( integer_to_string(1_234_567_890), '1_234_567_890', q{TGIV14 integer_to_string(1_234_567_890) returns correct value} );
        },
        q{TGIV14 integer_to_string(1_234_567_890) lives}
    );
    lives_and(                                                    # TGIV15
        sub {
            is( integer_to_string(-1_234_567_890), '-1_234_567_890', q{TGIV15 integer_to_string(-1_234_567_890) returns correct value} );
        },
        q{TGIV15 integer_to_string(-1_234_567_890) lives}
    );
    throws_ok(                                                    # TGIV16
        sub {
            integer_to_string(-1_234_567_890_000_000_000_000_000_000_000_000);
        },
        "/EGIV01.*$mode_tagline/",
        q{TGIV16 integer_to_string(-1_234_567_890_000_000_000_000_000_000_000_000) throws correct exception}
    );
    lives_and(                                                    # TGIV20
        sub {
            is( integer__typetest0(), ( 3 + $mode_id ), q{TGIV20 integer__typetest0() returns correct value} );
        },
        q{TGIV20 integer__typetest0() lives}
    );
    throws_ok(                                                    # TGIV30
        sub { integer__typetest1() },
        "/(EGIV00.*$mode_tagline)|(Usage.*integer__typetest1)/"
        ,                                                         # DEV NOTE: 2 different error messages, RPerl & C
        q{TGIV30 integer__typetest1() throws correct exception}
    );
    throws_ok(                                                    # TGIV31
        sub { integer__typetest1(undef) },
        "/EGIV00.*$mode_tagline/",
        q{TGIV31 integer__typetest1(undef) throws correct exception}
    );
    lives_and(                                                    # TGIV32
        sub {
            is( integer__typetest1(3), ( ( 3 * 2 ) + $mode_id ), q{TGIV32 integer__typetest1(3) returns correct value} );
        },
        q{TGIV32 integer__typetest1(3) lives}
    );
    lives_and(                                                    # TGIV33
        sub {
            is( integer__typetest1(-17), ( ( -17 * 2 ) + $mode_id ), q{TGIV33 integer__typetest1(-17) returns correct value} );
        },
        q{TGIV33 integer__typetest1(-17) lives}
    );
    throws_ok(                                                    # TGIV34
        sub { integer__typetest1(-17.3) },
        "/EGIV01.*$mode_tagline/",
        q{TGIV34 integer__typetest1(-17.3) throws correct exception}
    );
    throws_ok(                                                    # TGIV35
        sub { integer__typetest1('-17.3') },
        "/EGIV01.*$mode_tagline/",
        q{TGIV35 integer__typetest1('-17.3') throws correct exception}
    );
    throws_ok(                                                    # TGIV36
        sub { integer__typetest1( [3] ) },
        "/EGIV01.*$mode_tagline/",
        q{TGIV36 integer__typetest1([3]) throws correct exception}
    );
    throws_ok(                                                    # TGIV37
        sub { integer__typetest1( { a_key => 3 } ) },
        "/EGIV01.*$mode_tagline/",
        q{TGIV37 integer__typetest1({a_key => 3}) throws correct exception}
    );
    lives_and(                                                    # TGIV38
        sub {
            is( integer__typetest1(-234_567_890), ( ( -234_567_890 * 2 ) + $mode_id ), q{TGIV38 integer__typetest1(-234_567_890) returns correct value} );
        },
        q{TGIV38 integer__typetest1(-234_567_890) lives}
    );
    throws_ok(                                                    # TGIV39
        sub {
            integer__typetest1(-1_234_567_890_000_000_000_000_000_000_000_000);
        },
        "/EGIV01.*$mode_tagline/",
        q{TGIV39 integer__typetest1(-1_234_567_890_000_000_000_000_000_000_000_000) throws correct exception}
    );
=cut
}

done_testing();
