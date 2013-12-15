#!/usr/bin/perl
## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
## no critic qw(RequireInterpolationOfMetachars)  ## RPERL allow single-quoted newline
use strict;
use warnings;
use version; our $VERSION = qv('0.2.7');

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

use Test::More tests => 199;
use Test::Exception;
use Carp;
my $ERROR_MAX = 0.00000001;

BEGIN {
    diag(
        "\n[[[ Beginning Scalar Type Pre-Test Loading, RPerl Type System ]]]\n "
    );
}

BEGIN {
    lives_ok(
        sub {    ## PERLTIDY BUG blank newline

            package main;
            our $RPERL_INCLUDE_PATH = '/tmp/RPerl-latest/lib';
        },
        q{package main;  our $RPERL_INCLUDE_PATH = '/tmp/RPerl-latest/lib';} ## no critic qw(RequireInterpolationOfMetachars)  ## RPERL allow single-quoted sigils
    );
}    # NEED REMOVE hard-coded path

BEGIN {
    lives_ok(
        sub { use lib $main::RPERL_INCLUDE_PATH . '/CPAN/'; },
        q{use lib $main::RPERL_INCLUDE_PATH . '/CPAN/';} ## no critic qw(RequireInterpolationOfMetachars)  ## RPERL allow single-quoted sigils
    );
    lives_and( sub { use_ok('MyConfig'); }, q{use_ok('MyConfig') lives} );
}    # RPerl's MyConfig.pm

BEGIN {
    lives_ok(
        sub { use lib $main::RPERL_INCLUDE_PATH; },
        q{use lib $main::RPERL_INCLUDE_PATH;} ## no critic qw(RequireInterpolationOfMetachars)  ## RPERL allow single-quoted sigils
    );
    lives_and( sub { use_ok('RPerl'); }, q{use_ok('RPerl') lives} );
    lives_ok(
        sub {
            use parent ('RPerl');
            $RPerl::INCLUDE_PATH = $main::RPERL_INCLUDE_PATH;
        },
        q{use parent ('RPerl');  $RPerl::INCLUDE_PATH = $main::RPERL_INCLUDE_PATH;} ## no critic qw(RequireInterpolationOfMetachars)  ## RPERL allow single-quoted sigils
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
        q{our $AUTOLOAD;  sub AUTOLOAD {...}} ## no critic qw(RequireInterpolationOfMetachars)  ## RPERL allow single-quoted sigils
    );
}

# [[[ TEST RUNLOOP ]]]
# [[[ TEST RUNLOOP ]]]
# [[[ TEST RUNLOOP ]]]

# loop 3 times, once for each mode: Pure-Perl, RPerl Perl-Data, and RPerl C-Data
for my $OPS_TYPES_ID ( 0 .. 2 ) {
    print
        "in 04_type_scalar.t, top of for() loop, have \$OPS_TYPES_ID = $OPS_TYPES_ID\n"
        or croak;    # no effect if suppressing output!
    my $OPS_TYPES;

    # [[[ PERLOPS_PERLTYPES SETUP ]]]
    # [[[ PERLOPS_PERLTYPES SETUP ]]]
    # [[[ PERLOPS_PERLTYPES SETUP ]]]

    if ( $OPS_TYPES_ID == 0 ) {
        $OPS_TYPES = 'PERLOPS_PERLTYPES';
        diag(
            "\n[[[ Beginning RPerl's Pure-Perl Scalar Type Tests, RPerl Type System Using Perl Data Types & Perl Operations ]]]\n "
        );
        lives_and(
            sub {
                is( integer__ops(), 'PERL', q{integer__ops() returns 'PERL'} );
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
            sub { is( number__ops(), 'PERL', q{number__ops() returns 'PERL'} ) }
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
            sub { is( string__ops(), 'PERL', q{string__ops() returns 'PERL'} ) }
            ,    ## PERLTIDY BUG comma on newline
            q{string__ops() lives}
        );
        lives_and(
            sub {
                is( string__types(), 'PERL',
                    q{string__types() returns 'PERL'} );
            },
            q{string__types() lives}
        );
    }

    # [[[ CPPOPS_PERLTYPES SETUP ]]]
    # [[[ CPPOPS_PERLTYPES SETUP ]]]
    # [[[ CPPOPS_PERLTYPES SETUP ]]]

    elsif ( $OPS_TYPES_ID == 1 ) {
        $OPS_TYPES = 'CPPOPS_PERLTYPES';
        diag(
            "\n[[[ Beginning RPerl's Perl-Data Mode Scalar Type Tests, RPerl Type System Using Perl Data Types & C++ Operations ]]]\n "
        );

#		lives_ok(sub { types_enable('PERL') }, q{types_enable('PERL') lives});  # NEED FIX?  RPerl typed functions not working in types.pm, must call as normal Perl function
        lives_ok(
            sub { types::types_enable('PERL') },
            q{types::types_enable('PERL') lives}
        );

        # Integer: C++ use, load, link
        BEGIN {
            lives_and(
                sub { use_ok('RPerl::DataType::Integer_cpp'); },
                q{use_ok('RPerl::DataType::Integer_cpp') lives}
            );
        }
        lives_and(
            sub { require_ok('RPerl::DataType::Integer_cpp'); },
            q{require_ok('RPerl::DataType::Integer_cpp') lives}
        );
        lives_ok(
            sub { RPerl::DataType::Integer_cpp::cpp_load(); },
            q{RPerl::DataType::Integer_cpp::cpp_load() lives}
        );
        lives_ok(
            sub { RPerl::DataType::Integer_cpp::cpp_link(); },
            q{RPerl::DataType::Integer_cpp::cpp_link() lives}
        );
        lives_and(
            sub { is( integer__ops(), 'CPP', q{integer__ops() returns 'CPP'} ) }
            ,
            q{integer__ops() lives}
        );
        lives_and(
            sub {
                is( integer__types(), 'PERL',
                    q{integer__types() returns 'PERL'} );
            },
            q{integer__types() lives}
        );

        # Number: C++ use, load, link
        BEGIN {
            lives_and(
                sub { use_ok('RPerl::DataType::Number_cpp'); },
                q{use_ok('RPerl::DataType::Number_cpp') lives}
            );
        }
        lives_and(
            sub { require_ok('RPerl::DataType::Number_cpp'); },
            q{require_ok('RPerl::DataType::Number_cpp') lives}
        );
        lives_ok(
            sub { RPerl::DataType::Number_cpp::cpp_load(); },
            q{RPerl::DataType::Number_cpp::cpp_load() lives}
        );
        lives_ok(
            sub { RPerl::DataType::Number_cpp::cpp_link(); },
            q{RPerl::DataType::Number_cpp::cpp_link() lives}
        );
        lives_and(
            sub { is( number__ops(), 'CPP', q{number__ops() returns 'CPP'} ) },
            q{number__ops() lives}
        );
        lives_and(
            sub {
                is( number__types(), 'PERL',
                    q{number__types() returns 'PERL'} );
            },
            q{number__types() lives}
        );

        # String: C++ use, load, link
        BEGIN {
            lives_and(
                sub { use_ok('RPerl::DataType::String_cpp'); },
                q{use_ok('RPerl::DataType::String_cpp') lives}
            );
        }
        lives_and(
            sub { require_ok('RPerl::DataType::String_cpp'); },
            q{require_ok('RPerl::DataType::String_cpp') lives}
        );
        lives_ok(
            sub { RPerl::DataType::String_cpp::cpp_load(); },
            q{RPerl::DataType::String_cpp::cpp_load() lives}
        );
        lives_ok(
            sub { RPerl::DataType::String_cpp::cpp_link(); },
            q{RPerl::DataType::String_cpp::cpp_link() lives}
        );
        lives_and(
            sub { is( string__ops(), 'CPP', q{string__ops() returns 'CPP'} ) },
            q{string__ops() lives}
        );
        lives_and(
            sub {
                is( string__types(), 'PERL',
                    q{string__types() returns 'PERL'} );
            },
            q{string__types() lives}
        );
    }

    # [[[ CPPOPS_CPPTYPES SETUP ]]]
    # [[[ CPPOPS_CPPTYPES SETUP ]]]
    # [[[ CPPOPS_CPPTYPES SETUP ]]]

    else {
        $OPS_TYPES = 'CPPOPS_CPPTYPES';
        diag(
            "\n[[[ Beginning RPerl's C-Data Mode Scalar Type Tests, RPerl Type System Using C++ Data Types & C++ Operations ]]]\n "
        );
        lives_ok(
            sub { types::types_enable('CPP') },
            q{types::types_enable('CPP') lives}
        );

        # force reload and relink
        $RPerl::DataType::Integer_cpp::CPP_LOADED = 0;
        $RPerl::DataType::Integer_cpp::CPP_LINKED = 0;
        $RPerl::DataType::Number_cpp::CPP_LOADED  = 0;
        $RPerl::DataType::Number_cpp::CPP_LINKED  = 0;
        $RPerl::DataType::String_cpp::CPP_LOADED  = 0;
        $RPerl::DataType::String_cpp::CPP_LINKED  = 0;

# Integer: C++ use, load, link
#		BEGIN { lives_and(sub { use_ok('RPerl::DataType::Integer_cpp'); }); }  # duplicate
#		lives_and(sub { require_ok('RPerl::DataType::Integer_cpp'); });  # duplicate
        lives_ok(
            sub { RPerl::DataType::Integer_cpp::cpp_load(); },
            q{RPerl::DataType::Integer_cpp::cpp_load() lives}
        );
        lives_ok(
            sub { RPerl::DataType::Integer_cpp::cpp_link(); },
            q{RPerl::DataType::Integer_cpp::cpp_link() lives}
        );
        lives_and(
            sub { is( integer__ops(), 'CPP', q{integer__ops() returns 'CPP'} ) }
            ,
            q{integer__ops() lives}
        );
        lives_and(
            sub {
                is( integer__types(), 'CPP',
                    q{integer__types() returns 'CPP'} );
            },
            q{integer__types() lives}
        );

# Number: C++ use, load, link
#		BEGIN { lives_and(sub { use_ok('RPerl::DataType::Number_cpp'); }); }  # duplicate
#		lives_and(sub { require_ok('RPerl::DataType::Number_cpp'); });  # duplicate
        lives_ok(
            sub { RPerl::DataType::Number_cpp::cpp_load(); },
            q{RPerl::DataType::Number_cpp::cpp_load() lives}
        );
        lives_ok(
            sub { RPerl::DataType::Number_cpp::cpp_link(); },
            q{RPerl::DataType::Number_cpp::cpp_link() lives}
        );
        lives_and(
            sub { is( number__ops(), 'CPP', q{number__ops() returns 'CPP'} ) },
            q{number__ops() lives}
        );
        lives_and(
            sub {
                is( number__types(), 'CPP', q{number__types() returns 'CPP'} );
            },
            q{number__types() lives}
        );

# String: C++ use, load, link
#		BEGIN { lives_and(sub { use_ok('RPerl::DataType::String_cpp'); }); }  # duplicate
#		lives_and(sub { require_ok('RPerl::DataType::String_cpp'); });  # duplicate
        lives_ok(
            sub { RPerl::DataType::String_cpp::cpp_load(); },
            q{RPerl::DataType::String_cpp::cpp_load() lives}
        );
        lives_ok(
            sub { RPerl::DataType::String_cpp::cpp_link(); },
            q{RPerl::DataType::String_cpp::cpp_link() lives}
        );
        lives_and(
            sub { is( string__ops(), 'CPP', q{string__ops()  returns 'CPP'} ) },
            q{string__ops() lives}
        );
        lives_and(
            sub {
                is( string__types(), 'CPP', q{string__types()  returns 'CPP'} );
            },
            q{string__types() lives}
        );
    }

    # [[[ INTEGER TESTS ]]]
    # [[[ INTEGER TESTS ]]]
    # [[[ INTEGER TESTS ]]]

    throws_ok(    # TIV00
        sub { integer__stringify() },
        "/(EIV00.*$OPS_TYPES)|(Usage.*integer__stringify)/", # DEV NOTE: 2 different error messages, RPerl & C
        q{TIV00 integer__stringify() throws correct exception}
    );
    throws_ok(                                              # TIV01
        sub { integer__stringify(undef) },
        "/EIV00.*$OPS_TYPES/",
        q{TIV01 integer__stringify(undef) throws correct exception}
    );
    lives_and(                                              # TIV02
        sub {
            is( integer__stringify(3), '3',
                q{TIV02 integer__stringify(3) returns correct value} );
        },
        q{TIV02 integer__stringify(3) lives}
    );
    lives_and(                                              # TIV03
        sub {
            is( integer__stringify(-17), '-17',
                q{TIV03 integer__stringify(-17) returns correct value} );
        },
        q{TIV03 integer__stringify(-17) lives}
    );
    throws_ok(                                              # TIV04
        sub { integer__stringify(-17.3) },
        "/EIV01.*$OPS_TYPES/",
        q{TIV04 integer__stringify(-17.3) throws correct exception}
    );
    throws_ok(                                              # TIV05
        sub { integer__stringify('-17.3') },
        "/EIV01.*$OPS_TYPES/",
        q{TIV05 integer__stringify('-17.3') throws correct exception}
    );
    throws_ok(                                              # TIV06
        sub { integer__stringify( [3] ) },
        "/EIV01.*$OPS_TYPES/",
        q{TIV06 integer__stringify([3]) throws correct exception}
    );
    throws_ok(                                              # TIV07
        sub { integer__stringify( { a_key => 3 } ) },
        "/EIV01.*$OPS_TYPES/",
        q{TIV07 integer__stringify({a_key => 3}) throws correct exception}
    );
    lives_and(                                              # TIV08
        sub {
            is( integer__stringify(-1_234_567_890), '-1234567890',
                q{TIV08 integer__stringify(-1_234_567_890) returns correct value}
            );
        },
        q{TIV08 integer__stringify(-1_234_567_890) lives}
    );
    throws_ok(                                              # TIV09
        sub { integer__stringify(-1_234_567_890_000) },
        "/EIV01.*$OPS_TYPES/",
        q{TIV09 integer__stringify(-1_234_567_890_000) throws correct exception}
    );
    lives_and(                                              # TIV10
        sub {
            is( integer__typetest0(),
                ( 3 + $OPS_TYPES_ID ),
                q{TIV10 integer__typetest0() returns correct value}
            );
        },
        q{TIV10 integer__typetest0() lives}
    );
    throws_ok(                                              # TIV20
        sub { integer__typetest1() },
        "/(EIV00.*$OPS_TYPES)|(Usage.*integer__typetest1)/"
        ,    # DEV NOTE: 2 different error messages, RPerl & C
        q{TIV20 integer__typetest1() throws correct exception}
    );
    throws_ok(    # TIV21
        sub { integer__typetest1(undef) },
        "/EIV00.*$OPS_TYPES/",
        q{TIV21 integer__typetest1(undef) throws correct exception}
    );
    lives_and(    # TIV22
        sub {
            is( integer__typetest1(3),
                ( ( 3 * 2 ) + $OPS_TYPES_ID ),
                q{TIV22 integer__typetest1(3) returns correct value}
            );
        },
        q{TIV22 integer__typetest1(3) lives}
    );
    lives_and(    # TIV23
        sub {
            is( integer__typetest1(-17),
                ( ( -17 * 2 ) + $OPS_TYPES_ID ),
                q{TIV23 integer__typetest1(-17) returns correct value}
            );
        },
        q{TIV23 integer__typetest1(-17) lives}
    );
    throws_ok(    # TIV24
        sub { integer__typetest1(-17.3) },
        "/EIV01.*$OPS_TYPES/",
        q{TIV24 integer__typetest1(-17.3) throws correct exception}
    );
    throws_ok(    # TIV25
        sub { integer__typetest1('-17.3') },
        "/EIV01.*$OPS_TYPES/",
        q{TIV25 integer__typetest1('-17.3') throws correct exception}
    );
    throws_ok(    # TIV26
        sub { integer__typetest1( [3] ) },
        "/EIV01.*$OPS_TYPES/",
        q{TIV26 integer__typetest1([3]) throws correct exception}
    );
    throws_ok(    # TIV27
        sub { integer__typetest1( { a_key => 3 } ) },
        "/EIV01.*$OPS_TYPES/",
        q{TIV27 integer__typetest1({a_key => 3}) throws correct exception}
    );
    lives_and(    # TIV28
        sub {
            is( integer__typetest1(-234_567_890),
                ( ( -234_567_890 * 2 ) + $OPS_TYPES_ID ),
                q{TIV28 integer__typetest1(-234_567_890) returns correct value}
            );
        },
        q{TIV28 integer__typetest1(-234_567_890) lives}
    );
    throws_ok(    # TIV29
        sub { integer__typetest1(-1_234_567_890_000) },
        "/EIV01.*$OPS_TYPES/",
        q{TIV29 integer__typetest1(-1_234_567_890_000) throws correct exception}
    );

    # [[[ NUMBER TESTS ]]]
    # [[[ NUMBER TESTS ]]]
    # [[[ NUMBER TESTS ]]]

    throws_ok(    # TNV00
        sub { number__stringify() },
        "/(ENV00.*$OPS_TYPES)|(Usage.*number__stringify)/", # DEV NOTE: 2 different error messages, RPerl & C
        q{TNV00 number__stringify() throws correct exception}
    );
    throws_ok(                                             # TNV01
        sub { number__stringify(undef) },
        "/ENV00.*$OPS_TYPES/",
        q{TNV01 number__stringify(undef) throws correct exception}
    );
    lives_and(                                             # TNV02
        sub {
            is( number__stringify(3), '3',
                q{TNV02 number__stringify(3) returns correct value} );
        },
        q{TNV02 number__stringify(3) lives}
    );
    lives_and(                                             # TNV03
        sub {
            is( number__stringify(-17), '-17',
                q{TNV03 number__stringify(-17) returns correct value} );
        },
        q{TNV03 number__stringify(-17) lives}
    );
    lives_and(                                             # TNV04
        sub {
            is( number__stringify(-17.3), '-17.3',
                q{TNV04 number__stringify(-17.3) returns correct value} );
        },
        q{TNV04 number__stringify(-17.3) lives}
    );
    throws_ok(                                             # TNV05
        sub { number__stringify('-17.3') },
        "/ENV01.*$OPS_TYPES/",
        q{TNV05 number__stringify('-17.3') throws correct exception}
    );
    throws_ok(                                             # TNV06
        sub { number__stringify( [3] ) },
        "/ENV01.*$OPS_TYPES/",
        q{TNV06 number__stringify([3]) throws correct exception}
    );
    throws_ok(                                             # TNV07
        sub { number__stringify( { a_key => 3 } ) },
        "/ENV01.*$OPS_TYPES/",
        q{TNV07 number__stringify({a_key => 3}) throws correct exception}
    );
    lives_and(                                             # TNV08
        sub {
            is( number__stringify(
                    3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679
                ),
                '3.14159265358979',
                q{TNV08 number__stringify(3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679) returns correct value}
            );
        },
        q{TNV08 number__stringify(3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679) lives}
    );
    lives_and(                                             # TNV10
        sub {
            cmp_ok(
                abs(number__typetest0()
                        - ( 3.14285714285714 + $OPS_TYPES_ID )
                ),    ## PERLTIDY BUG comma on newline
                '<',
                $ERROR_MAX,
                q{TNV10 number__typetest0() returns correct value}
            );
        },
        q{TNV10 number__typetest0() lives}
    );
    throws_ok(        # TNV20
        sub { number__typetest1() },
        "/(ENV00.*$OPS_TYPES)|(Usage.*number__typetest1)/"
        ,             # DEV NOTE: 2 different error messages, RPerl & C
        q{TNV20 number__typetest1() throws correct exception}
    );
    throws_ok(        # TNV21
        sub { number__typetest1(undef) },
        "/ENV00.*$OPS_TYPES/",
        q{TNV21 number__typetest1(undef) throws correct exception}
    );
    lives_and(        # TNV22
        sub {
            is( number__typetest1(3),
                ( ( 3 * 2 ) + $OPS_TYPES_ID ),
                q{TNV22 number__typetest1(3) returns correct value}
            );
        },
        q{TNV22 number__typetest1(3) lives}
    );
    lives_and(        # TNV23
        sub {
            is( number__typetest1(-17),
                ( ( -17 * 2 ) + $OPS_TYPES_ID ),
                q{TNV23 number__typetest1(-17) returns correct value}
            );
        },
        q{TNV23 number__typetest1(-17) lives}
    );
    lives_and(        # TNV24
        sub {
            is( number__typetest1(-17.3),
                ( ( -17.3 * 2 ) + $OPS_TYPES_ID ),
                q{TNV24 number__typetest1(-17.3) returns correct value}
            );
        },
        q{TNV24 number__typetest1(-17.3) lives}
    );
    throws_ok(        # TNV25
        sub { number__typetest1('-17.3') },
        "/ENV01.*$OPS_TYPES/",
        q{TNV25 number__typetest1('-17.3') throws correct exception}
    );
    throws_ok(        # TNV26
        sub { number__typetest1( [3] ) },
        "/ENV01.*$OPS_TYPES/",
        q{TNV26 number__typetest1([3]) throws correct exception}
    );
    throws_ok(        # TNV27
        sub { number__typetest1( { a_key => 3 } ) },
        "/ENV01.*$OPS_TYPES/",
        q{TNV27 number__typetest1({a_key => 3}) throws correct exception}
    );
    lives_and(        # TNV28
        sub {
            cmp_ok(
                abs(number__typetest1(
                        3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679
                    ) - ( ( 3.14159265358979 * 2 ) + $OPS_TYPES_ID )
                ),
                '<',
                $ERROR_MAX,
                q{TNV28 number__typetest1(3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679) returns correct value}
            );
        },
        q{TNV28 number__typetest1(3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679) lives}
    );

    # [[[ STRING TESTS ]]]
    # [[[ STRING TESTS ]]]
    # [[[ STRING TESTS ]]]

    lives_and(    # TPV00
        sub {
            is( string__typetest0(),
                "Spice $OPS_TYPES",
                q{TPV00 string__typetest0() returns correct value}
            );
        },
        q{TPV00 string__typetest0() lives}
    );
    throws_ok(    # TPV10
        sub { string__typetest1() },
        "/(EPV00.*$OPS_TYPES)|(Usage.*string__typetest1)/"
        ,         # DEV NOTE: 2 different error messages, RPerl & C
        q{TPV10 string__typetest1() throws correct exception}
    );
    throws_ok(    # TPV11
        sub { string__typetest1(undef) },
        "/EPV00.*$OPS_TYPES/",
        q{TPV11 string__typetest1(undef) throws correct exception}
    );
    throws_ok(    # TPV12
        sub { string__typetest1(3) },
        "/EPV01.*$OPS_TYPES/",
        q{TPV12 string__typetest1(3) throws correct exception}
    );
    throws_ok(    # TPV13
        sub { string__typetest1(-17) },
        "/EPV01.*$OPS_TYPES/",
        q{TPV13 string__typetest1(-17) throws correct exception}
    );
    throws_ok(    # TPV14
        sub { string__typetest1(-17.3) },
        "/EPV01.*$OPS_TYPES/",
        q{TPV14 string__typetest1(-17.3) throws correct exception}
    );
    lives_and(    # TPV15
        sub {
            is( string__typetest1('-17.3'),
                "'-17.3' $OPS_TYPES",
                q{TPV15 string__typetest1('-17.3') returns correct value}
            );
        },
        q{TPV15 string__typetest1('-17.3') lives}
    );
    throws_ok(    # TPV16
        sub { string__typetest1( [3] ) },
        "/EPV01.*$OPS_TYPES/",
        q{TPV16 string__typetest1([3]) throws correct exception}
    );
    throws_ok(    # TPV17
        sub { string__typetest1( { a_key => 3 } ) },
        "/EPV01.*$OPS_TYPES/",
        q{TPV17 string__typetest1({a_key => 3}) throws correct exception}
    );
    lives_and(    # TPV18
        sub {
            is( string__typetest1('Melange'),
                "'Melange' $OPS_TYPES",
                q{TPV18 string__typetest1('Melange') returns correct value}
            );
        },
        q{TPV18 string__typetest1('Melange') lives}
    );
    lives_and(    # TPV19
        sub {
            is( string__typetest1(
                    "\nThe Spice Extends Life\nThe Spice Expands Consciousness\nThe Spice Is Vital To Space Travel\n"
                ),
                "'\nThe Spice Extends Life\nThe Spice Expands Consciousness\nThe Spice Is Vital To Space Travel\n' $OPS_TYPES",
                q{TPV19 string__typetest1("\nThe Spice Extends Life\nThe Spice Expands Consciousness\nThe Spice Is Vital To Space Travel\n") returns correct value}
            );
        },
        q{TPV19 string__typetest1("\nThe Spice Extends Life\nThe Spice Expands Consciousness\nThe Spice Is Vital To Space Travel\n") lives}
    );
}

#done_testing();
