#!/usr/bin/perl
## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
## no critic qw(RequireInterpolationOfMetachars)  ## RPERL allow single-quoted newline
use strict;
use warnings;
use version; our $VERSION = qv('0.2.5');

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
            use base ('RPerl');
            $RPerl::INCLUDE_PATH = $main::RPERL_INCLUDE_PATH;
        },
        q{use base ('RPerl');  $RPerl::INCLUDE_PATH = $main::RPERL_INCLUDE_PATH;} ## no critic qw(RequireInterpolationOfMetachars)  ## RPERL allow single-quoted sigils
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
                is( ops_integer(), 'PERL', q{ops_integer() returns 'PERL'} );
            },
            q{ops_integer() lives}
        );
        lives_and(
            sub {
                is( types_integer(), 'PERL',
                    q{types_integer() returns 'PERL'} );
            },
            q{types_integer() lives}
        );
        lives_and(
            sub { is( ops_number(), 'PERL', q{ops_number() returns 'PERL'} ) }
            ,
            q{ops_number() lives}
        );
        lives_and(
            sub {
                is( types_number(), 'PERL',
                    q{types_number() returns 'PERL'} );
            },
            q{types_number() lives}
        );
        lives_and(
            sub { is( ops_string(), 'PERL', q{ops_string() returns 'PERL'} ) }
            ,    ## PERLTIDY BUG comma on newline
            q{ops_string() lives}
        );
        lives_and(
            sub {
                is( types_string(), 'PERL',
                    q{types_string() returns 'PERL'} );
            },
            q{types_string() lives}
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
            sub { is( ops_integer(), 'CPP', q{ops_integer() returns 'CPP'} ) }
            ,
            q{ops_integer() lives}
        );
        lives_and(
            sub {
                is( types_integer(), 'PERL',
                    q{types_integer() returns 'PERL'} );
            },
            q{types_integer() lives}
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
            sub { is( ops_number(), 'CPP', q{ops_number() returns 'CPP'} ) },
            q{ops_number() lives}
        );
        lives_and(
            sub {
                is( types_number(), 'PERL',
                    q{types_number() returns 'PERL'} );
            },
            q{types_number() lives}
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
            sub { is( ops_string(), 'CPP', q{ops_string() returns 'CPP'} ) },
            q{ops_string() lives}
        );
        lives_and(
            sub {
                is( types_string(), 'PERL',
                    q{types_string() returns 'PERL'} );
            },
            q{types_string() lives}
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
            sub { is( ops_integer(), 'CPP', q{ops_integer() returns 'CPP'} ) }
            ,
            q{ops_integer() lives}
        );
        lives_and(
            sub {
                is( types_integer(), 'CPP',
                    q{types_integer() returns 'CPP'} );
            },
            q{types_integer() lives}
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
            sub { is( ops_number(), 'CPP', q{ops_number() returns 'CPP'} ) },
            q{ops_number() lives}
        );
        lives_and(
            sub {
                is( types_number(), 'CPP', q{types_number() returns 'CPP'} );
            },
            q{types_number() lives}
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
            sub { is( ops_string(), 'CPP', q{ops_string()  returns 'CPP'} ) },
            q{ops_string() lives}
        );
        lives_and(
            sub {
                is( types_string(), 'CPP', q{types_string()  returns 'CPP'} );
            },
            q{types_string() lives}
        );
    }

    # [[[ INTEGER TESTS ]]]
    # [[[ INTEGER TESTS ]]]
    # [[[ INTEGER TESTS ]]]

    throws_ok(    # TIV00
        sub { stringify_integer() },
        "/(EIV00.*$OPS_TYPES)|(Usage.*stringify_integer)/", # DEV NOTE: 2 different error messages, RPerl & C
        q{TIV00 stringify_integer() throws correct exception}
    );
    throws_ok(                                              # TIV01
        sub { stringify_integer(undef) },
        "/EIV00.*$OPS_TYPES/",
        q{TIV01 stringify_integer(undef) throws correct exception}
    );
    lives_and(                                              # TIV02
        sub {
            is( stringify_integer(3), '3',
                q{TIV02 stringify_integer(3) returns correct value} );
        },
        q{TIV02 stringify_integer(3) lives}
    );
    lives_and(                                              # TIV03
        sub {
            is( stringify_integer(-17), '-17',
                q{TIV03 stringify_integer(-17) returns correct value} );
        },
        q{TIV03 stringify_integer(-17) lives}
    );
    throws_ok(                                              # TIV04
        sub { stringify_integer(-17.3) },
        "/EIV01.*$OPS_TYPES/",
        q{TIV04 stringify_integer(-17.3) throws correct exception}
    );
    throws_ok(                                              # TIV05
        sub { stringify_integer('-17.3') },
        "/EIV01.*$OPS_TYPES/",
        q{TIV05 stringify_integer('-17.3') throws correct exception}
    );
    throws_ok(                                              # TIV06
        sub { stringify_integer( [3] ) },
        "/EIV01.*$OPS_TYPES/",
        q{TIV06 stringify_integer([3]) throws correct exception}
    );
    throws_ok(                                              # TIV07
        sub { stringify_integer( { a_key => 3 } ) },
        "/EIV01.*$OPS_TYPES/",
        q{TIV07 stringify_integer({a_key => 3}) throws correct exception}
    );
    lives_and(                                              # TIV08
        sub {
            is( stringify_integer(-1_234_567_890), '-1234567890',
                q{TIV08 stringify_integer(-1_234_567_890) returns correct value}
            );
        },
        q{TIV08 stringify_integer(-1_234_567_890) lives}
    );
    throws_ok(                                              # TIV09
        sub { stringify_integer(-1_234_567_890_000) },
        "/EIV01.*$OPS_TYPES/",
        q{TIV09 stringify_integer(-1_234_567_890_000) throws correct exception}
    );
    lives_and(                                              # TIV10
        sub {
            is( typetest___void__in___integer__out(),
                ( 3 + $OPS_TYPES_ID ),
                q{TIV10 typetest___void__in___integer__out() returns correct value}
            );
        },
        q{TIV10 typetest___void__in___integer__out() lives}
    );
    throws_ok(                                              # TIV20
        sub { typetest___integer__in___integer__out() },
        "/(EIV00.*$OPS_TYPES)|(Usage.*typetest___integer__in___integer__out)/"
        ,    # DEV NOTE: 2 different error messages, RPerl & C
        q{TIV20 typetest___integer__in___integer__out() throws correct exception}
    );
    throws_ok(    # TIV21
        sub { typetest___integer__in___integer__out(undef) },
        "/EIV00.*$OPS_TYPES/",
        q{TIV21 typetest___integer__in___integer__out(undef) throws correct exception}
    );
    lives_and(    # TIV22
        sub {
            is( typetest___integer__in___integer__out(3),
                ( ( 3 * 2 ) + $OPS_TYPES_ID ),
                q{TIV22 typetest___integer__in___integer__out(3) returns correct value}
            );
        },
        q{TIV22 typetest___integer__in___integer__out(3) lives}
    );
    lives_and(    # TIV23
        sub {
            is( typetest___integer__in___integer__out(-17),
                ( ( -17 * 2 ) + $OPS_TYPES_ID ),
                q{TIV23 typetest___integer__in___integer__out(-17) returns correct value}
            );
        },
        q{TIV23 typetest___integer__in___integer__out(-17) lives}
    );
    throws_ok(    # TIV24
        sub { typetest___integer__in___integer__out(-17.3) },
        "/EIV01.*$OPS_TYPES/",
        q{TIV24 typetest___integer__in___integer__out(-17.3) throws correct exception}
    );
    throws_ok(    # TIV25
        sub { typetest___integer__in___integer__out('-17.3') },
        "/EIV01.*$OPS_TYPES/",
        q{TIV25 typetest___integer__in___integer__out('-17.3') throws correct exception}
    );
    throws_ok(    # TIV26
        sub { typetest___integer__in___integer__out( [3] ) },
        "/EIV01.*$OPS_TYPES/",
        q{TIV26 typetest___integer__in___integer__out([3]) throws correct exception}
    );
    throws_ok(    # TIV27
        sub { typetest___integer__in___integer__out( { a_key => 3 } ) },
        "/EIV01.*$OPS_TYPES/",
        q{TIV27 typetest___integer__in___integer__out({a_key => 3}) throws correct exception}
    );
    lives_and(    # TIV28
        sub {
            is( typetest___integer__in___integer__out(-234_567_890),
                ( ( -234_567_890 * 2 ) + $OPS_TYPES_ID ),
                q{TIV28 typetest___integer__in___integer__out(-234_567_890) returns correct value}
            );
        },
        q{TIV28 typetest___integer__in___integer__out(-234_567_890) lives}
    );
    throws_ok(    # TIV29
        sub { typetest___integer__in___integer__out(-1_234_567_890_000) },
        "/EIV01.*$OPS_TYPES/",
        q{TIV29 typetest___integer__in___integer__out(-1_234_567_890_000) throws correct exception}
    );

    # [[[ NUMBER TESTS ]]]
    # [[[ NUMBER TESTS ]]]
    # [[[ NUMBER TESTS ]]]

    throws_ok(    # TNV00
        sub { stringify_number() },
        "/(ENV00.*$OPS_TYPES)|(Usage.*stringify_number)/", # DEV NOTE: 2 different error messages, RPerl & C
        q{TNV00 stringify_number() throws correct exception}
    );
    throws_ok(                                             # TNV01
        sub { stringify_number(undef) },
        "/ENV00.*$OPS_TYPES/",
        q{TNV01 stringify_number(undef) throws correct exception}
    );
    lives_and(                                             # TNV02
        sub {
            is( stringify_number(3), '3',
                q{TNV02 stringify_number(3) returns correct value} );
        },
        q{TNV02 stringify_number(3) lives}
    );
    lives_and(                                             # TNV03
        sub {
            is( stringify_number(-17), '-17',
                q{TNV03 stringify_number(-17) returns correct value} );
        },
        q{TNV03 stringify_number(-17) lives}
    );
    lives_and(                                             # TNV04
        sub {
            is( stringify_number(-17.3), '-17.3',
                q{TNV04 stringify_number(-17.3) returns correct value} );
        },
        q{TNV04 stringify_number(-17.3) lives}
    );
    throws_ok(                                             # TNV05
        sub { stringify_number('-17.3') },
        "/ENV01.*$OPS_TYPES/",
        q{TNV05 stringify_number('-17.3') throws correct exception}
    );
    throws_ok(                                             # TNV06
        sub { stringify_number( [3] ) },
        "/ENV01.*$OPS_TYPES/",
        q{TNV06 stringify_number([3]) throws correct exception}
    );
    throws_ok(                                             # TNV07
        sub { stringify_number( { a_key => 3 } ) },
        "/ENV01.*$OPS_TYPES/",
        q{TNV07 stringify_number({a_key => 3}) throws correct exception}
    );
    lives_and(                                             # TNV08
        sub {
            is( stringify_number(
                    3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679
                ),
                '3.14159265358979',
                q{TNV08 stringify_number(3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679) returns correct value}
            );
        },
        q{TNV08 stringify_number(3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679) lives}
    );
    lives_and(                                             # TNV10
        sub {
            cmp_ok(
                abs(typetest___void__in___number__out()
                        - ( 3.14285714285714 + $OPS_TYPES_ID )
                ),    ## PERLTIDY BUG comma on newline
                '<',
                $ERROR_MAX,
                q{TNV10 typetest___void__in___number__out() returns correct value}
            );
        },
        q{TNV10 typetest___void__in___number__out() lives}
    );
    throws_ok(        # TNV20
        sub { typetest___number__in___number__out() },
        "/(ENV00.*$OPS_TYPES)|(Usage.*typetest___number__in___number__out)/"
        ,             # DEV NOTE: 2 different error messages, RPerl & C
        q{TNV20 typetest___number__in___number__out() throws correct exception}
    );
    throws_ok(        # TNV21
        sub { typetest___number__in___number__out(undef) },
        "/ENV00.*$OPS_TYPES/",
        q{TNV21 typetest___number__in___number__out(undef) throws correct exception}
    );
    lives_and(        # TNV22
        sub {
            is( typetest___number__in___number__out(3),
                ( ( 3 * 2 ) + $OPS_TYPES_ID ),
                q{TNV22 typetest___number__in___number__out(3) returns correct value}
            );
        },
        q{TNV22 typetest___number__in___number__out(3) lives}
    );
    lives_and(        # TNV23
        sub {
            is( typetest___number__in___number__out(-17),
                ( ( -17 * 2 ) + $OPS_TYPES_ID ),
                q{TNV23 typetest___number__in___number__out(-17) returns correct value}
            );
        },
        q{TNV23 typetest___number__in___number__out(-17) lives}
    );
    lives_and(        # TNV24
        sub {
            is( typetest___number__in___number__out(-17.3),
                ( ( -17.3 * 2 ) + $OPS_TYPES_ID ),
                q{TNV24 typetest___number__in___number__out(-17.3) returns correct value}
            );
        },
        q{TNV24 typetest___number__in___number__out(-17.3) lives}
    );
    throws_ok(        # TNV25
        sub { typetest___number__in___number__out('-17.3') },
        "/ENV01.*$OPS_TYPES/",
        q{TNV25 typetest___number__in___number__out('-17.3') throws correct exception}
    );
    throws_ok(        # TNV26
        sub { typetest___number__in___number__out( [3] ) },
        "/ENV01.*$OPS_TYPES/",
        q{TNV26 typetest___number__in___number__out([3]) throws correct exception}
    );
    throws_ok(        # TNV27
        sub { typetest___number__in___number__out( { a_key => 3 } ) },
        "/ENV01.*$OPS_TYPES/",
        q{TNV27 typetest___number__in___number__out({a_key => 3}) throws correct exception}
    );
    lives_and(        # TNV28
        sub {
            cmp_ok(
                abs(typetest___number__in___number__out(
                        3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679
                    ) - ( ( 3.14159265358979 * 2 ) + $OPS_TYPES_ID )
                ),
                '<',
                $ERROR_MAX,
                q{TNV28 typetest___number__in___number__out(3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679) returns correct value}
            );
        },
        q{TNV28 typetest___number__in___number__out(3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679) lives}
    );

    # [[[ STRING TESTS ]]]
    # [[[ STRING TESTS ]]]
    # [[[ STRING TESTS ]]]

    lives_and(    # TPV00
        sub {
            is( typetest___void__in___string__out(),
                "Spice $OPS_TYPES",
                q{TPV00 typetest___void__in___string__out() returns correct value}
            );
        },
        q{TPV00 typetest___void__in___string__out() lives}
    );
    throws_ok(    # TPV10
        sub { typetest___string__in___string__out() },
        "/(EPV00.*$OPS_TYPES)|(Usage.*typetest___string__in___string__out)/"
        ,         # DEV NOTE: 2 different error messages, RPerl & C
        q{TPV10 typetest___string__in___string__out() throws correct exception}
    );
    throws_ok(    # TPV11
        sub { typetest___string__in___string__out(undef) },
        "/EPV00.*$OPS_TYPES/",
        q{TPV11 typetest___string__in___string__out(undef) throws correct exception}
    );
    throws_ok(    # TPV12
        sub { typetest___string__in___string__out(3) },
        "/EPV01.*$OPS_TYPES/",
        q{TPV12 typetest___string__in___string__out(3) throws correct exception}
    );
    throws_ok(    # TPV13
        sub { typetest___string__in___string__out(-17) },
        "/EPV01.*$OPS_TYPES/",
        q{TPV13 typetest___string__in___string__out(-17) throws correct exception}
    );
    throws_ok(    # TPV14
        sub { typetest___string__in___string__out(-17.3) },
        "/EPV01.*$OPS_TYPES/",
        q{TPV14 typetest___string__in___string__out(-17.3) throws correct exception}
    );
    lives_and(    # TPV15
        sub {
            is( typetest___string__in___string__out('-17.3'),
                "-17.3 $OPS_TYPES",
                q{TPV15 typetest___string__in___string__out('-17.3') returns correct value}
            );
        },
        q{TPV15 typetest___string__in___string__out('-17.3') lives}
    );
    throws_ok(    # TPV16
        sub { typetest___string__in___string__out( [3] ) },
        "/EPV01.*$OPS_TYPES/",
        q{TPV16 typetest___string__in___string__out([3]) throws correct exception}
    );
    throws_ok(    # TPV17
        sub { typetest___string__in___string__out( { a_key => 3 } ) },
        "/EPV01.*$OPS_TYPES/",
        q{TPV17 typetest___string__in___string__out({a_key => 3}) throws correct exception}
    );
    lives_and(    # TPV18
        sub {
            is( typetest___string__in___string__out('Melange'),
                "Melange $OPS_TYPES",
                q{TPV18 typetest___string__in___string__out('Melange') returns correct value}
            );
        },
        q{TPV18 typetest___string__in___string__out('Melange') lives}
    );
    lives_and(    # TPV19
        sub {
            is( typetest___string__in___string__out(
                    "\nThe Spice Extends Life\nThe Spice Expands Consciousness\nThe Spice Is Vital To Space Travel\n"
                ),
                "\nThe Spice Extends Life\nThe Spice Expands Consciousness\nThe Spice Is Vital To Space Travel\n $OPS_TYPES",
                q{TPV19 typetest___string__in___string__out("\nThe Spice Extends Life\nThe Spice Expands Consciousness\nThe Spice Is Vital To Space Travel\n") returns correct value}
            );
        },
        q{TPV19 typetest___string__in___string__out("\nThe Spice Extends Life\nThe Spice Expands Consciousness\nThe Spice Is Vital To Space Travel\n") lives}
    );
}

#done_testing();
