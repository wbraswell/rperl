#!/usr/bin/perl
## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
use strict;
use warnings;
use version; our $VERSION = qv('0.1.1');

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

use Test::More;    # tests => 49;
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
        sub {      ## PERLTIDY BUG blank newline

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
    lives_and(                                              # TIV01
        sub {
            is( stringify_integer(3), '3',
                q{TIV01 stringify_integer(3) returns correct value} );
        },
        q{stringify_integer(3) lives}
    );
    lives_and(                                              # TIV02
        sub {
            is( stringify_integer(-17), '-17',
                q{TIV02 stringify_integer(-17) returns correct value} );
        },
        q{TIV02 stringify_integer(-17) lives}
    );
    throws_ok(                                              # TIV03
        sub { stringify_integer(-17.3) },
        "/(EIV01.*$OPS_TYPES)/",
        q{TIV03 stringify_integer(-17.3) throws correct exception}
    );
    throws_ok(                                              # TIV04
        sub { stringify_integer('-17.3') },
        "/(EIV01.*$OPS_TYPES)/",
        q{TIV04 stringify_integer('-17.3') throws correct exception}
    );
    throws_ok(                                              # TIV05
        sub { stringify_integer( [3] ) },
        "/(EIV01.*$OPS_TYPES)/",
        q{TIV05 stringify_integer([3]) throws correct exception}
    );
    throws_ok(                                              # TIV06
        sub { stringify_integer( { a_key => 3 } ) },
        "/(EIV01.*$OPS_TYPES)/",
        q{TIV06 stringify_integer({a_key => 3}) throws correct exception}
    );
    lives_and(                                              # TIV07
        sub {
            is( stringify_integer(-1_234_567_890), '-1234567890',
                q{TIV07 stringify_integer(-1_234_567_890) returns correct value}
            );
        },
        q{TIV07 stringify_integer(-1_234_567_890) lives}
    );
    throws_ok(                                              # TIV08
        sub { stringify_integer( -1_234_567_890_000 ) },
        "/(EIV01.*$OPS_TYPES)/",
        q{TIV08 stringify_integer(-1_234_567_890_000) throws correct exception}
    );
    lives_and(                                              # TIV10
        sub {
            is( typetest___void__in___integer__out(), (3 + $OPS_TYPES_ID),
                q{TIV10 typetest___void__in___integer__out() returns correct value}
            );
        },
        q{TIV10 typetest___void__in___integer__out() lives}
    );
    throws_ok(    # TIV20
        sub { typetest___integer__in___integer__out() },
        "/(EIV00.*$OPS_TYPES)|(Usage.*typetest___integer__in___integer__out)/", # DEV NOTE: 2 different error messages, RPerl & C
        q{TIV20 typetest___integer__in___integer__out() throws correct exception}
    );
    lives_and(                                              # TIV21
        sub {
            is( typetest___integer__in___integer__out(3), ((3 * 2) + $OPS_TYPES_ID),
                q{TIV21 typetest___integer__in___integer__out(3) returns correct value} );
        },
        q{typetest___integer__in___integer__out(3) lives}
    );
    lives_and(                                              # TIV22
        sub {
            is( typetest___integer__in___integer__out(-17), ((-17 * 2) + $OPS_TYPES_ID),
                q{TIV22 typetest___integer__in___integer__out(-17) returns correct value} );
        },
        q{TIV22 typetest___integer__in___integer__out(-17) lives}
    );
    throws_ok(                                              # TIV23
        sub { typetest___integer__in___integer__out(-17.3) },
        "/(EIV01.*$OPS_TYPES)/",
        q{TIV23 typetest___integer__in___integer__out(-17.3) throws correct exception}
    );
    throws_ok(                                              # TIV24
        sub { typetest___integer__in___integer__out('-17.3') },
        "/(EIV01.*$OPS_TYPES)/",
        q{TIV24 typetest___integer__in___integer__out('-17.3') throws correct exception}
    );
    throws_ok(                                              # TIV25
        sub { typetest___integer__in___integer__out( [3] ) },
        "/(EIV01.*$OPS_TYPES)/",
        q{TIV25 typetest___integer__in___integer__out([3]) throws correct exception}
    );
    throws_ok(                                              # TIV26
        sub { typetest___integer__in___integer__out( { a_key => 3 } ) },
        "/(EIV01.*$OPS_TYPES)/",
        q{TIV26 typetest___integer__in___integer__out({a_key => 3}) throws correct exception}
    );
    lives_and(                                              # TIV27
        sub {
            is( typetest___integer__in___integer__out(-234_567_890), ((-234_567_890 * 2) + $OPS_TYPES_ID),
                q{TIV27 typetest___integer__in___integer__out(-234_567_890) returns correct value}
            );
        },
        q{TIV27 typetest___integer__in___integer__out(-234_567_890) lives}
    );
    throws_ok(                                              # TIV28
        sub { typetest___integer__in___integer__out( -1_234_567_890_000 ) },
        "/(EIV01.*$OPS_TYPES)/",
        q{TIV28 typetest___integer__in___integer__out(-1_234_567_890_000) throws correct exception}
    );

    # [[[ NUMBER TESTS ]]]
    # [[[ NUMBER TESTS ]]]
    # [[[ NUMBER TESTS ]]]

    lives_and(
        sub {
            is( stringify_number(
                    3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679
                ),
                '3.14159265358979',
                q{stringify_number(3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679) returns correct value}
            );
        },
        q{stringify_number(3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679) lives}
    );
    lives_and(
        sub {
            cmp_ok(
                abs(typetest___void__in___number__out()
                        - ( 3.14285714285714 + $OPS_TYPES_ID )
                ),    ## PERLTIDY BUG comma on newline
                '<',
                $ERROR_MAX,
                q{typetest___void__in___number__out() returns correct value}
            );
        },
        q{typetest___void__in___number__out() lives}
    );
    lives_and(
        sub {
            cmp_ok(
                abs(typetest___number__in___number__out(
                        3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679
                    ) - ( 6.28318530717959 + $OPS_TYPES_ID )
                ),
                '<',
                $ERROR_MAX,
                q{typetest___number__in___number__out(3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679) returns correct value}
            );
        },
        q{typetest___number__in___number__out(3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679) lives}
    );

    # [[[ STRING TESTS ]]]
    # [[[ STRING TESTS ]]]
    # [[[ STRING TESTS ]]]

    lives_and(
        sub {
            is( typetest___void__in___string__out(),
                "Spice $OPS_TYPES",
                q{typetest___void__in___string__out() returns correct value}
            );
        },
        q{typetest___void__in___string__out() lives}
    );
    lives_and(
        sub {
            is( typetest___string__in___string__out('Melange'),
                "Melange $OPS_TYPES",
                q{typetest___string__in___string__out("Melange") returns correct value}
            );
        },
        q{typetest___string__in___string__out("Melange") lives}
    );
}

done_testing();
