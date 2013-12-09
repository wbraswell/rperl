#!/usr/bin/perl
use strict;
use warnings;
use version; our $VERSION = qv('0.3.3');

# SUPPRESS OUTPUT FROM INDIVIDUAL TESTS, EXCLUDING TESTS INSIDE BEGIN{} BLOCKS
# order is BEGIN, UNITCHECK, CHECK, INIT, END; CHECK here suppresses Inline compile output from including HelperFunctions_cpp.pm from INIT in Array.pm
CHECK {
    open( STDOUT, '>', '/dev/null' )
        || croak('Error redirecting stdout, croaking');
    open( STDERR, '>', '/dev/null' )
        || croak('Error redirecting stderr, croaking');
}

use Test::More tests => 127;
use Test::Exception;
use Carp;

BEGIN {
    diag(
        "\n[[[ Beginning Array Type Pre-Test Loading, RPerl Type System ]]]\n "
    );
}

BEGIN {
    lives_ok(
        sub {    ## PERLTIDY BUG blank newline

            package main;
            our $RPERL_INCLUDE_PATH = '/tmp/RPerl-latest/lib';
        },
        q{package main; our $RPERL_INCLUDE_PATH = '/tmp/RPerl-latest/lib';} ## no critic qw(RequireInterpolationOfMetachars)  ## RPERL allow single-quoted sigils
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

# loop 3 times, once for each mode: Pure-Perl, RPerl Perl-Data, and RPerl C-Data
for my $i ( 0 .. 2 ) {
    print "in 05_type_array.t, top of for() loop, have \$i = $i\n"
        or croak;    # no effect if suppressing output!
    my $OPS_TYPES;

    if ( $i == 0 ) {
        $OPS_TYPES = 'PERLOPS_PERLTYPES';
        diag(
            "\n[[[ Beginning RPerl's Pure-Perl Array Type Tests, RPerl Type System Using Perl Data Types & Perl Operations ]]]\n "
        );
        lives_and(
            sub {
                is( ops_number(), 'PERL', q{ops_number() returns 'PERL'} );
            },
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
            ,
            q{ops_string() lives}
        );
        lives_and(
            sub {
                is( types_string(), 'PERL',
                    q{types_string() returns 'PERL'} );
            },
            q{types_string() lives}
        );
        lives_and(
            sub { is( ops_array(), 'PERL', q{ops_array() returns 'PERL'} ) },
            q{ops_array() lives}
        );
        lives_and(
            sub {
                is( types_array(), 'PERL', q{types_array() returns 'PERL'} );
            },
            q{types_array() lives}
        );
    }
    elsif ( $i == 1 ) {
        $OPS_TYPES = 'CPPOPS_PERLTYPES';
        diag(
            "\n[[[ Beginning RPerl's Perl-Data Mode Array Type Tests, RPerl Type System Using Perl Data Types & C++ Operations ]]]\n "
        );

        lives_ok(
            sub { types::types_enable('PERL') },
            q{types::types_enable('PERL') lives}
        );

        # Array: C++ use, load, link
        BEGIN {
            lives_and(
                sub { use_ok('RPerl::DataStructure::Array_cpp'); },
                q{use_ok('RPerl::DataStructure::Array_cpp') lives}
            );
        }
        lives_and(
            sub { require_ok('RPerl::DataStructure::Array_cpp'); },
            q{require_ok('RPerl::DataStructure::Array_cpp') lives}
        );
        lives_ok(
            sub { RPerl::DataStructure::Array_cpp::cpp_load(); },
            q{RPerl::DataStructure::Array_cpp::cpp_load() lives}
        );
        lives_ok(
            sub { RPerl::DataStructure::Array_cpp::cpp_link(); },
            q{RPerl::DataStructure::Array_cpp::cpp_link() lives}
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
        lives_and(
            sub { is( ops_array(), 'CPP', q{ops_array() returns 'CPP'} ) },
            q{ops_array() lives} );
        lives_and(
            sub {
                is( types_array(), 'PERL', q{types_array() returns 'PERL'} );
            },
            q{types_array() lives}
        );
    }
    else {
        $OPS_TYPES = 'CPPOPS_CPPTYPES';
        diag(
            "\n[[[ Beginning RPerl's C-Data Mode Array Type Tests, RPerl Type System Using C++ Data Types & C++ Operations ]]]\n "
        );
        lives_ok(
            sub { types::types_enable('CPP') },
            q{types::types_enable('CPP') lives}
        );

        # force reload and relink
        $RPerl::DataStructure::Array_cpp::CPP_LOADED = 0;
        $RPerl::DataStructure::Array_cpp::CPP_LINKED = 0;

        # Array: C++ use, load, link
        lives_ok(
            sub { RPerl::DataStructure::Array_cpp::cpp_load(); },
            q{RPerl::DataStructure::Array_cpp::cpp_load() lives}
        );
        lives_ok(
            sub { RPerl::DataStructure::Array_cpp::cpp_link(); },
            q{RPerl::DataStructure::Array_cpp::cpp_link() lives}
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
        lives_and(
            sub { is( ops_string(), 'CPP', q{ops_string() returns 'CPP'} ) },
            q{ops_string() lives}
        );
        lives_and(
            sub {
                is( types_string(), 'CPP', q{types_string() returns 'CPP'} );
            },
            q{types_string() lives}
        );
        lives_and(
            sub { is( ops_array(), 'CPP', q{ops_array() returns 'CPP'} ) },
            q{ops_array() lives} );
        lives_and(
            sub { is( types_array(), 'CPP', q{types_array() returns 'CPP'} ) }
            ,    ## PERLTIDY BUG comma on newline
            q{types_array() lives}
        );
    }

    # Int Array: stringify, create, manipulate
    throws_ok(    # AVIV00
        sub { stringify_int__array_ref(2) },
        "/$OPS_TYPES.*input_av_ref was not an AV ref/",
        q{stringify_int__array_ref(2) throws correct exception}
    );
    lives_and(    # AVIV01
        sub {
            is( stringify_int__array_ref( [2] ),
                '[2]',
                q{AVIV01 stringify_int__array_ref([2]) returns correct value}
            );
        },
        q{AVIV01 stringify_int__array_ref([2]) lives}
    );
    lives_and(    # AVIV02
        sub {
            is( stringify_int__array_ref(
                    [ 2, 2112, 42, 23, -877, 33, 1701 ] ## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
                ),
                '[2, 2112, 42, 23, -877, 33, 1701]',
                q{AVIV02 stringify_int__array_ref([2, 2112, 42, 23, -877, 33, 1701]) returns correct value}
            );
        },
        q{AVIV02 stringify_int__array_ref([2, 2112, 42, 23, -877, 33, 1701]) lives}
    );
    throws_ok(                                          # AVIV03
        sub {
            stringify_int__array_ref(
                [ 2, 2112, 42.3, 23, -877, 33, 1701 ] ) ## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
                ;    ## PERLTIDY BUG semicolon on newline
        },
        "/$OPS_TYPES.*input_av_element at index 2 was not an int/",
        q{AVIV03 stringify_int__array_ref([2, 2112, 42.3, 23, -877, 33, 1701]) throws correct exception}
    );
    throws_ok(       # AVIV04
        sub {
            stringify_int__array_ref(
                [ 2, 2112, 42, '23', -877, 33, 1701 ] ) ## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
                ;    ## PERLTIDY BUG semicolon on newline
        },
        "/$OPS_TYPES.*input_av_element at index 3 was not an int/",
        q{AVIV04 stringify_int__array_ref([2, 2112, 42, '23', -877, 33, 1701]) throws correct exception}
    );
    lives_and(       # AVIV10
        sub {
            is( typetest___int__array_ref__in___string__out(
                    [ 2, 2112, 42, 23, -877, 33, 1701 ] ## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
                ),
                '[2, 2112, 42, 23, -877, 33, 1701]' . $OPS_TYPES,
                q{AVIV10 typetest___int__array_ref__in___string__out([2, 2112, 42, 23, -877, 33, 1701]) returns correct value}
            );
        },
        q{AVIV10 typetest___int__array_ref__in___string__out([2, 2112, 42, 23, -877, 33, 1701]) lives}
    );
    throws_ok(                                          # AVIV11
        sub {
            typetest___int__array_ref__in___string__out(
                [ 2, 2112, 42, 23, -877, 'abcdefg', 33, 1701 ] ); ## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
        },
        "/$OPS_TYPES.*input_av_element at index 5 was not an int/",
        q{AVIV11 typetest___int__array_ref__in___string__out([2, 2112, 42, 23, -877, 'abcdefg', 33, 1701]) throws correct exception}
    );
    lives_and(                                                    # AVIV12
        sub {
            is( typetest___int__array_ref__in___string__out(
                    [ -444, 33, 1701 ] ## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
                ),
                '[-444, 33, 1701]' . $OPS_TYPES,
                q{AVIV12 typetest___int__array_ref__in___string__out([-444, 33, 1701]) returns correct value}
            );
        },
        q{AVIV12 typetest___int__array_ref__in___string__out([-444, 33, 1701]) lives}
    );
    lives_and(                         # AVIV20
        sub {
            is_deeply(
                typetest___int__in___int__array_ref__out(5), ## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
                [ 0, 5, 10, 15, 20 ], ## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
                q{AVIV20 typetest___int__in___int__array_ref__out(5) returns correct value}
            );
        },
        q{AVIV20 typetest___int__in___int__array_ref__out(5) lives}
    );

    # Number Array: stringify, create, manipulate
    throws_ok(                        # AVNV00
        sub { stringify_number__array_ref(2) },
        "/$OPS_TYPES.*input_av_ref was not an AV ref/",
        q{AVNV00 stringify_number__array_ref(2) throws correct exception}
    );
    lives_and(                        # AVNV01
        sub {
            is( stringify_number__array_ref( [2] ),
                '[2]',
                q{AVNV01 stringify_number__array_ref([2]) returns correct value}
            );
        },
        q{AVNV01 stringify_number__array_ref([2]) lives}
    );
    lives_and(                        # AVNV02
        sub {
            is( stringify_number__array_ref(
                    [ 2, 2112, 42, 23, -877, 33, 1701 ] ## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
                ),
                '[2, 2112, 42, 23, -877, 33, 1701]',
                q{AVNV02 stringify_number__array_ref([2, 2112, 42, 23, -877, 33, 1701]) returns correct value}
            );
        },
        q{AVNV02 stringify_number__array_ref([2, 2112, 42, 23, -877, 33, 1701]) lives}
    );
    lives_and(                                          # AVNV03
        sub {
            is( stringify_number__array_ref(
                    [ 2.1, 2112.2, 42.3, 23, -877, 33, 1701 ] ## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
                ),
                '[2.1, 2112.2, 42.3, 23, -877, 33, 1701]',
                q{AVNV03 stringify_number__array_ref([2.1, 2112.2, 42.3, 23, -877, 33, 1701]) returns correct value}
            );
        },
        q{AVNV03 stringify_number__array_ref([2.1, 2112.2, 42.3, 23, -877, 33, 1701]) lives}
    );
    lives_and(                                                # AVNV04
        sub {
            is( stringify_number__array_ref(
                    [   2.1234432112344321, 2112.4321, ## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
                        42.4567, 23.765444444444444444, ## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
                        -877.5678, 33.876587658765875687658765, ## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
                        1701.6789 ## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
                    ]
                ),
                '[2.12344321123443, 2112.4321, 42.4567, 23.7654444444444, -877.5678, 33.8765876587659, 1701.6789]',
                q{AVNV04 stringify_number__array_ref([2.1234432112344321, 2112.4321, ..., 1701.6789]) returns correct value}
            );
        },
        q{AVNV04 stringify_number__array_ref([2.1234432112344321, 2112.4321, ..., 1701.6789]) lives}
    );
    throws_ok(                    # AVNV05
        sub {
            stringify_number__array_ref(
                [ 2, 2112, 42, '23', -877, 33, 1701 ] ); ## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
        },
        "/$OPS_TYPES.*input_av_element at index 3 was not a number/",
        q{AVNV05 stringify_number__array_ref([2, 2112, 42, '23', -877, 33, 1701]) throws correct exception}
    );
    lives_and(                                           # AVNV10
        sub {
            is( typetest___number__array_ref__in___string__out(
                    [   2.1234432112344321, 2112.4321, ## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
                        42.4567, 23.765444444444444444, ## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
                        -877.5678, 33.876587658765875687658765, ## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
                        1701.6789 ## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
                    ]
                ),
                '[2.12344321123443, 2112.4321, 42.4567, 23.7654444444444, -877.5678, 33.8765876587659, 1701.6789]'
                    . $OPS_TYPES,
                q{AVNV05 typetest___number__array_ref__in___string__out([2.1234432112344321, 2112.4321, ..., 1701.6789]) returns correct value}
            );
        },
        q{AVNV05 typetest___number__array_ref__in___string__out([2.1234432112344321, 2112.4321, ..., 1701.6789]) lives}
    );
    throws_ok(                    # AVNV11
        sub {
            typetest___number__array_ref__in___string__out(
                [   2.1234432112344321, 2112.4321, ## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
                    42.4567, 23.765444444444444444, ## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
                    -877.5678, 'abcdefg', ## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
                    33.876587658765875687658765, 1701.6789 ## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
                ]
            );
        },
        "/$OPS_TYPES.*input_av_element at index 5 was not a number/",
        q{AVNV11 typetest___number__array_ref__in___string__out([2.1234432112344321, ..., 'abcdefg', 33.876587658765875687658765, 1701.6789]) throws correct exception}
    );
    lives_and(                                             # AVNV12
        sub {
            is( typetest___number__array_ref__in___string__out(
                    [ -444, 33.876587658765875687658765, 1701.6789 ] ## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
                ),
                '[-444, 33.8765876587659, 1701.6789]' . $OPS_TYPES,
                q{AVNV12 typetest___number__array_ref__in___string__out([-444, 33.876587658765875687658765, 1701.6789]) returns correct value}
            );
        },
        q{AVNV12 typetest___number__array_ref__in___string__out([-444, 33.876587658765875687658765, 1701.6789]) lives}
    );
    lives_and(                                                       # AVNV20
        sub {
            is_deeply(
                typetest___int__in___number__array_ref__out(5), ## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
                [ 0, 5.123456789, 10.246913578, 15.370370367, 20.493827156 ] ## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
                ,    ## PERLTIDY BUG comma on newline
                q{AVNV20 typetest___int__in___number__array_ref__out(5) returns correct value}
            );
        },
        q{AVNV20 typetest___int__in___number__array_ref__out(5) lives}
    );

# String Array: stringify, create, manipulate
# DEV NOTE: all single-quotes replaced by double-quotes when passing through stringify, this is because Perl accepts both but C/C++ only accepts double-quotes for strings
    throws_ok(    # AVPV00
        sub { stringify_string__array_ref('Lone Ranger') },
        "/$OPS_TYPES.*input_av_ref was not an AV ref/",
        q{AVPV00 stringify_string__array_ref('Lone Ranger') throws correct exception}
    );
    lives_and(    # AVPV01
        sub {
            is( stringify_string__array_ref(
                    [   'Superman',      'Batman',
                        'Wonder Woman',  'Flash',
                        'Green Lantern', 'Aquaman',
                        'Martian Manhunter'
                    ]
                ),
                q{['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter']},
                q{AVPV01 stringify_string__array_ref(['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter']) returns correct value}
            );
        },
        q{AVPV01 stringify_string__array_ref(['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter']) lives}
    );
    lives_and(    # AVPV02
        sub {
            is( stringify_string__array_ref(
                    [   'Superman',          'Batman',
                        'Wonder Woman',      'Flash',
                        'Green Lantern',     'Aquaman',
                        'Martian Manhunter', '23'
                    ]
                ),
                q{['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter', '23']},
                q{AVPV02 stringify_string__array_ref(['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter', '23']) returns correct value}
            );
        },
        q{AVPV02 stringify_string__array_ref(['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter', '23']) lives}
    );
    throws_ok(    # AVPV03
        sub {
            stringify_string__array_ref(
                [   'Superman',      'Batman',
                    'Wonder Woman',  'Flash',
                    'Green Lantern', 'Aquaman',
                    'Martian Manhunter', 23 ## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
                ]
            );
        },
        "/$OPS_TYPES.*input_av_element at index 7 was not a string/",
        q{AVPV03 stringify_string__array_ref(['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter', 23]) throws correct exception}
    );
    lives_and(                              # AVPV04
        sub {
            is( stringify_string__array_ref(
                    [   'Superman',          'Batman',
                        'Wonder Woman',      'Flash',
                        'Green Lantern',     'Aquaman',
                        'Martian Manhunter', '-2112.23'
                    ]
                ),
                q{['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter', '-2112.23']},
                q{AVPV04 stringify_string__array_ref(['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter', '-2112.23']) returns correct value}
            );
        },
        q{AVPV04 stringify_string__array_ref(['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter', '-2112.23']) lives}
    );
    lives_and(    # AVPV05
        sub {
            is( stringify_string__array_ref(
                    [   'Superman',      'Batman',
                        'Wonder Woman',  'Flash',
                        'Green Lantern', 'Aquaman',
                        "Martian Manhunter", "-2112.23" ## no critic qw(ProhibitInterpolationOfLiterals)  ## RPERL allow double-quoted test values
                    ]
                ),
                q{['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter', '-2112.23']},
                q{AVPV05 stringify_string__array_ref(['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', "Martian Manhunter", "-2112.23"]) returns correct value}
            );
        },
        q{AVPV05 stringify_string__array_ref(['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', "Martian Manhunter", "-2112.23"]) lives}
    );
    throws_ok(                                          # AVPV06
        sub {
            stringify_string__array_ref(
                [   'Superman',      'Batman',
                    'Wonder Woman',  'Flash',
                    'Green Lantern', 'Aquaman',
                    'Martian Manhunter', -2112.23 ## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
                ]
            );
        },
        "/$OPS_TYPES.*input_av_element at index 7 was not a string/",
        q{AVPV06 stringify_string__array_ref(['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter', -2112.23]) throws correct exception}
    );
    throws_ok(                                    # AVPV07
        sub {
            stringify_string__array_ref(
                [   'Wonder Woman',
                    'Flash',
                    'Green Lantern',
                    'Aquaman',
                    'Martian Manhunter',
                    { fuzz => 'bizz', bar => "stool!\n", bat => 24 }
                ]
            );
        },
        "/$OPS_TYPES.*input_av_element at index 5 was not a string/",
        q{AVPV07 stringify_string__array_ref(['Wonder Woman', ..., 'Martian Manhunter', {fuzz => 'bizz', bar => "stool!\n", bat => 24}]) throws correct exception} ## no critic qw(RequireInterpolationOfMetachars)  ## RPERL allow single-quoted newline
    );
    lives_and(    # AVPV10
        sub {
            is( typetest___string__array_ref__in___string__out(
                    [   'Superman',      'Batman',
                        'Wonder Woman',  'Flash',
                        'Green Lantern', 'Aquaman',
                        'Martian Manhunter'
                    ]
                ),
                q{['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter']}
                    . $OPS_TYPES,
                q{AVPV10 typetest___string__array_ref__in___string__out(['Superman', ..., 'Green Lantern', 'Aquaman', 'Martian Manhunter']) returns correct value}
            );
        },
        q{AVPV10 typetest___string__array_ref__in___string__out(['Superman', ..., 'Green Lantern', 'Aquaman', 'Martian Manhunter']) lives}
    );
    throws_ok(    # AVPV11
        sub {
            typetest___string__array_ref__in___string__out(
                [   'Superman',      'Batman',
                    'Wonder Woman',  'Flash',
                    'Green Lantern', 'Aquaman',
                    'Martian Manhunter', 23 ## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
                ]
            );
        },
        "/$OPS_TYPES.*input_av_element at index 7 was not a string/",
        q{AVPV11 typetest___string__array_ref__in___string__out(['Superman', ..., 'Green Lantern', 'Aquaman', 'Martian Manhunter', 23]) throws correct exception}
    );
    lives_and(                              # AVPV12
        sub {
            is( typetest___string__array_ref__in___string__out(
                    [ 'Howard The Duck', 'Aquaman', 'Martian Manhunter' ]
                ),
                q{['Howard The Duck', 'Aquaman', 'Martian Manhunter']}
                    . $OPS_TYPES,
                q{AVPV12 typetest___string__array_ref__in___string__out(['Howard The Duck', 'Aquaman', 'Martian Manhunter']) returns correct value}
            );
        },
        q{AVPV12 typetest___string__array_ref__in___string__out(['Howard The Duck', 'Aquaman', 'Martian Manhunter']) lives}
    );
    lives_and(                              # AVPV20
        sub {
            is_deeply(
                typetest___int__in___string__array_ref__out(5), ## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
                [   'Jeffy Ten! 0/4 ' . $OPS_TYPES,
                    'Jeffy Ten! 1/4 ' . $OPS_TYPES,
                    'Jeffy Ten! 2/4 ' . $OPS_TYPES,
                    'Jeffy Ten! 3/4 ' . $OPS_TYPES,
                    'Jeffy Ten! 4/4 ' . $OPS_TYPES,
                ],
                q{AVPV20 typetest___int__in___string__array_ref__out(5) returns correct value}
            );
        },
        q{AVPV20 typetest___int__in___string__array_ref__out(5) lives}
    );
}

#done_testing();
