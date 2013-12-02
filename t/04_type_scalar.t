#!/usr/bin/perl
use strict;
use warnings;
use version; our $VERSION = qv('0.1.0');

# SUPPRESS OUTPUT FROM INDIVIDUAL TESTS, EXCLUDING TESTS INSIDE BEGIN{} BLOCKS
# order is BEGIN, UNITCHECK, CHECK, INIT, END; CHECK here suppresses Inline compile output from including HelperFunctions_cpp.pm from INIT in Array.pm
CHECK {
    open( STDOUT, '>', '/dev/null' )
        || croak('Error redirecting stdout, croaking');
    open( STDERR, '>', '/dev/null' )
        || croak('Error redirecting stderr, croaking');
}

use Test::More tests => 49;
use Test::Exception;
use Carp;
my $ERROR_MAX = 0.00000001; ## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values

BEGIN {
    diag(
        "\n[[[ Beginning Scalar Type Pre-Test Loading, RPerl Type System ]]]\n "
    );
}

BEGIN {
    lives_ok(
        sub {               ## PERLTIDY BUG blank newline

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
        q{our @ISA = ('RPerl');  $RPerl::INCLUDE_PATH = $main::RPERL_INCLUDE_PATH;} ## no critic qw(RequireInterpolationOfMetachars)  ## RPERL allow single-quoted sigils
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

# loop 3 times, once for each mode: Pure-Perl, Hybrid-Perl-and-C++, Pure-C++
#for ( my $i = 0; $i < 3; ++$i ) {
for my $i ( 0 .. 2 ) {
    print "in 03_type_scalar.t, top of for() loop, have \$i = $i\n"
        or croak;    # no effect if suppressing output!

    if ( $i == 0 ) {
        diag(
            "\n[[[ Beginning RPerl's Pure-Perl Scalar Type Tests, RPerl Type System Using Perl Data Types & Perl Operations ]]]\n "
        );
        lives_and(
            sub {
                is( types_number(), 'PERL',
                    q{types_number() returns 'PERL'} );
            },
            q{types_number() lives}
        );
        lives_and(
            sub { is( ops_number(), 'PERL', q{ops_number() returns 'PERL'} ) }
            ,
            q{ops_number() lives}
        );
        lives_and(
            sub {
                is( types_string(), 'PERL',
                    q{types_string() returns 'PERL'} );
            },
            q{types_string() lives}
        );
        lives_and(
            sub { is( ops_string(), 'PERL', q{ops_string() returns 'PERL'} ) }
            ,    ## PERLTIDY BUG comma on newline
            q{ops_string() lives}
        );
    }
    elsif ( $i == 1 ) {
        diag(
            "\n[[[ Beginning RPerl's Perl Data Mode Scalar Type Tests, RPerl Type System Using Perl Data Types & C++ Operations ]]]\n "
        );

#		lives_ok(sub { types_enable('PERL') }, q{types_enable('PERL') lives});  # NEED FIX?  RPerl typed functions not working in types.pm, must call as normal Perl function
        lives_ok(
            sub { types::types_enable('PERL') },
            q{types::types_enable('PERL') lives}
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
            sub {
                is( types_number(), 'PERL',
                    q{types_number() returns 'PERL'} );
            },
            q{types_number() lives}
        );
        lives_and(
            sub { is( ops_number(), 'CPP', q{ops_number() returns 'CPP'} ) },
            q{ops_number() lives}
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
            sub {
                is( types_string(), 'PERL',
                    q{types_string() returns 'PERL'} );
            },
            q{types_string() lives}
        );
        lives_and(
            sub { is( ops_string(), 'CPP', q{ops_string() returns 'CPP'} ) },
            q{ops_string() lives}
        );
    }
    else {
        diag(
            "\n[[[ Beginning RPerl's C++ Data Mode Scalar Type Tests, RPerl Type System Using C++ Data Types & C++ Operations ]]]\n "
        );
        lives_ok(
            sub { types::types_enable('CPP') },
            q{types::types_enable('CPP') lives}
        );

        # force reload and relink
        $RPerl::DataType::Number_cpp::CPP_LOADED = 0;
        $RPerl::DataType::Number_cpp::CPP_LINKED = 0;
        $RPerl::DataType::String_cpp::CPP_LOADED = 0;
        $RPerl::DataType::String_cpp::CPP_LINKED = 0;

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
            sub {
                is( types_number(), 'CPP', q{types_number() returns 'CPP'} );
            },
            q{types_number() lives}
        );
        lives_and(
            sub { is( ops_number(), 'CPP', q{ops_number() returns 'CPP'} ) },
            q{ops_number() lives}
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
            sub {
                is( types_string(), 'CPP', q{types_string()  returns 'CPP'} );
            },
            q{types_string() lives}
        );
        lives_and(
            sub { is( ops_string(), 'CPP', q{ops_string()  returns 'CPP'} ) },
            q{ops_string() lives}
        );
    }

    # Number: stringify, create, manipulate
    lives_and(
        sub {
            is( stringify_number(
                    3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679 ## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
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
                abs(typetest___void__in___number__out() - 3.14285714285714 ) ## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
                ,    ## PERLTIDY BUG comma on newline
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
                        3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679 ## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
                        ) - 6.28318530717959 ## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
                ),
                '<',
                $ERROR_MAX,
                q{typetest___number__in___number__out(3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679) returnsn correct value}
            );
        },
        q{typetest___number__in___number__out(3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679) lives}
    );

    # String: create, manipulate
    lives_and(
        sub {
            is( typetest___void__in___string__out(), 'Spice',
                q{typetest___void__in___string__out() returns correct value}
            );
        },
        q{typetest___void__in___string__out() lives}
    );
    lives_and(
        sub {
            is( typetest___string__in___string__out('Melange'), 'MelangeFUZZ',
                q{typetest___string__in___string__out("Melange") returns correct value}
            );
        },
        q{typetest___string__in___string__out("Melange") lives}
    );
}

#done_testing();
