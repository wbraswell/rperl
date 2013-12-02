#!/usr/bin/perl
use strict;
use warnings;
use version; our $VERSION = qv('0.0.8');

# SUPPRESS OUTPUT FROM INDIVIDUAL TESTS, EXCLUDING TESTS INSIDE BEGIN{} BLOCKS
# order is BEGIN, UNITCHECK, CHECK, INIT, END; CHECK here suppresses Inline compile output from including HelperFunctions_cpp.pm from INIT in Hash.pm
CHECK {
    open( STDOUT, '>', '/dev/null' )
        || croak('Error redirecting stdout, croaking');
    open( STDERR, '>', '/dev/null' )
        || croak('Error redirecting stderr, croaking');
}

use Test::More;# tests => 121;
use Test::Exception;
use Carp;

# RPERL TEST BOILERPLATE
BEGIN {
    diag(
        "\n[[[ Beginning Hash Type Pre-Test Loading, RPerl Type System ]]]\n "
    );
}

BEGIN {
    lives_ok(
        sub {

            package main;
            our $RPERL_INCLUDE_PATH = '/tmp/RPerl-latest/lib';
        },
        q(package main;  our $RPERL_INCLUDE_PATH = '/tmp/RPerl-latest/lib';)
    );
}    # NEED REMOVE hard-coded path

BEGIN {
    lives_ok(
        sub { use lib $main::RPERL_INCLUDE_PATH . '/CPAN/'; },
        q(use lib $main::RPERL_INCLUDE_PATH . '/CPAN/';)
    );
    lives_and( sub { use_ok('MyConfig'); } );
}    # RPerl's MyConfig.pm

BEGIN {
    lives_ok(
        sub { use lib $main::RPERL_INCLUDE_PATH; },
        q(use lib $main::RPERL_INCLUDE_PATH;)
    );
    lives_and( sub { use_ok('RPerl'); } );
    lives_ok(
        sub {
            our @ISA = ('RPerl');
            $RPerl::INCLUDE_PATH = $main::RPERL_INCLUDE_PATH;
        },
        q(our @ISA = ('RPerl');  $RPerl::INCLUDE_PATH = $main::RPERL_INCLUDE_PATH;)
    );
}    # RPerl system files

BEGIN {
    lives_and( sub { use_ok('Data::Dumper'); } );
    lives_ok(
        sub {
            our $AUTOLOAD;

            sub AUTOLOAD {
                die("AUTOLOAD purposefully disabled for debugging, have \$AUTOLOAD = '$AUTOLOAD' and \@_ = \n"
                        . Dumper( \@_ )
                        . ", dying" );
            }
        },
        q(our $AUTOLOAD;  sub AUTOLOAD {...})
    );
}    ## no critic

# loop 3 times, once for each mode: Pure-Perl, Hybrid-Perl-and-C++, Pure-C++
for ( my $i = 0; $i < 3; ++$i ) {
    print "in 05_type_hash.t, top of for() loop, have \$i = $i\n"; # no effect if suppressing output!

    if ( $i == 0 ) {
        diag(
            "\n[[[ Beginning Pure-Perl Hash Type Tests, RPerl Type System Using Perl Data Types & Perl Operations ]]]\n "
        );
        lives_and( sub { is( types_number(), 'PERL' ) }, q(types_number();) );
        lives_and( sub { is( ops_number(),   'PERL' ) }, q(ops_number();) );
        lives_and( sub { is( types_string(), 'PERL' ) }, q(types_string();) );
        lives_and( sub { is( ops_string(),   'PERL' ) }, q(ops_string();) );
        lives_and( sub { is( types_hash(),   'PERL' ) }, q(types_hash();) );
        lives_and( sub { is( ops_hash(),     'PERL' ) }, q(ops_hash();) );
    }
    elsif ( $i == 1 ) {
        diag(
            "\n[[[ Beginning Hybrid-Perl-and-C++ Hash Type Tests, RPerl Type System Using Perl Data Types & C++ Operations ]]]\n "
        );

#		lives_and(sub { is(types_enable('PERL'), undef) }, q(types_enable('PERL');));  # NEED FIX: RPerl typed functions not working in types.pm, must call as normal Perl function
        lives_and( sub { is( types::types_enable('PERL'), undef ) },
            q(types::types_enable('PERL');) );

        # Hash: C++ use, load, link
        BEGIN {
            lives_and( sub { use_ok('RPerl::DataStructure::Hash_cpp'); } );
        }
        lives_and( sub { require_ok('RPerl::DataStructure::Hash_cpp'); } );
        lives_ok(
            sub { RPerl::DataStructure::Hash_cpp::cpp_load(); },
            q(RPerl::DataStructure::Hash_cpp::cpp_load();)
        );
        lives_ok(
            sub { RPerl::DataStructure::Hash_cpp::cpp_link(); },
            q(RPerl::DataStructure::Hash_cpp::cpp_link();)
        );
        lives_and( sub { is( types_number(), 'PERL' ) }, q(types_number();) );
        lives_and( sub { is( ops_number(),   'CPP' ) },  q(ops_number();) );
        lives_and( sub { is( types_string(), 'PERL' ) }, q(types_string();) );
        lives_and( sub { is( ops_string(),   'CPP' ) },  q(ops_string();) );
        lives_and( sub { is( types_hash(),   'PERL' ) }, q(types_hash();) );
        lives_and( sub { is( ops_hash(),     'CPP' ) },  q(ops_hash();) );
    }
    else {
        diag(
            "\n[[[ Beginning Pure-C++ Hash Type Tests, RPerl Type System Using C++ Data Types & C++ Operations ]]]\n "
        );
        lives_and( sub { is( types::types_enable('CPP'), undef ) },
            q(types::types_enable('CPP');) );

        # force reload and relink
        $RPerl::DataStructure::Hash_cpp::CPP_loaded = 0;
        $RPerl::DataStructure::Hash_cpp::CPP_linked = 0;

        # Hash: C++ use, load, link
        lives_ok(
            sub { RPerl::DataStructure::Hash_cpp::cpp_load(); },
            q(RPerl::DataStructure::Hash_cpp::cpp_load();)
        );
        lives_ok(
            sub { RPerl::DataStructure::Hash_cpp::cpp_link(); },
            q(RPerl::DataStructure::Hash_cpp::cpp_link();)
        );
        lives_and( sub { is( types_number(), 'CPP' ) }, q(types_number();) );
        lives_and( sub { is( ops_number(),   'CPP' ) }, q(ops_number();) );
        lives_and( sub { is( types_string(), 'CPP' ) }, q(types_string();) );
        lives_and( sub { is( ops_string(),   'CPP' ) }, q(ops_string();) );
        lives_and( sub { is( types_hash(),   'CPP' ) }, q(types_hash();) );
        lives_and( sub { is( ops_hash(),     'CPP' ) }, q(ops_hash();) );
    }

    # Int Hash: stringify, create, manipulate
    throws_ok(
        sub { stringify_int__hash_ref(2) },
        '/input_av_ref was not an AV ref/',
        q(stringify_int__hash_ref(2);  # throw exception)
    );
    lives_and( sub { is( stringify_int__hash_ref( [2] ), '[2]' ) },
        q(stringify_int__hash_ref([2]);) );
    lives_and(
        sub {
            is( stringify_int__hash_ref( [ 2, 2112, 42, 23, 877, 33, 1701 ] ),
                '[2, 2112, 42, 23, 877, 33, 1701]'
            );
        },
        q(stringify_int__hash_ref([2, 2112, 42, 23, 877, 33, 1701]);)
    );
    throws_ok(
        sub {
            stringify_int__hash_ref( [ 2, 2112, 42.3, 23, 877, 33, 1701 ] );
        },
        '/input_av_element at index 2 was not an int/',
        q(stringify_int__hash_ref([2, 2112, 42.3, 23, 877, 33, 1701]);  # throw exception)
    );
    throws_ok(
        sub {
            stringify_int__hash_ref( [ 2, 2112, '42', 23, 877, 33, 1701 ] );
        },
        '/input_av_element at index 2 was not an int/',
        q(stringify_int__hash_ref([2, 2112, '42', 23, 877, 33, 1701]);  # throw exception)
    );
    lives_and(
        sub {
            is( typetest___int__hash_ref__in___string__out(
                    [ 2, 2112, 42, 23, 877, 33, 1701 ]
                ),
                '[2, 2112, 42, 23, 877, 33, 1701]BARBAT'
            );
        },
        q(typetest___int__hash_ref__in___string__out([2, 2112, 42, 23, 877, 33, 1701]);)
    );
    throws_ok(
        sub {
            typetest___int__hash_ref__in___string__out(
                [ 2, 2112, 42, 23, 877, "abcdefg\n", 33, 1701 ] );
        },
        '/input_av_element at index 5 was not an int/',
        q(typetest___int__hash_ref__in___string__out([2, 2112, 42, 23, 877, "abcdefg\n", 33, 1701]);  # throw exception)
    );
    lives_and(
        sub {
            is( typetest___int__hash_ref__in___string__out(
                    [ 444, 33, 1701 ]
                ),
                '[444, 33, 1701]BARBAT'
            );
        },
        q(typetest___int__hash_ref__in___string__out([444, 33, 1701]);  # call again to test Perl stack is still functioning properly)
    );
    lives_and(
        sub {
            is_deeply( typetest___int__in___int__hash_ref__out(5),
                [ 0, 5, 10, 15, 20 ] );
        },
        q(typetest___int__in___int__hash_ref__out(5);)
    );

    # Number Hash: stringify, create, manipulate
    throws_ok(
        sub { stringify_number__hash_ref(2) },
        '/input_av_ref was not an AV ref/',
        q(stringify_number__hash_ref(2);  # throw exception)
    );
    lives_and( sub { is( stringify_number__hash_ref( [2] ), '[2]' ) },
        q(stringify_number__hash_ref([2]);) );
    lives_and(
        sub {
            is( stringify_number__hash_ref(
                    [ 2, 2112, 42, 23, 877, 33, 1701 ]
                ),
                '[2, 2112, 42, 23, 877, 33, 1701]'
            );
        },
        q(stringify_number__hash_ref([2, 2112, 42, 23, 877, 33, 1701]);)
    );
    lives_and(
        sub {
            is( stringify_number__hash_ref(
                    [ 2.1, 2112.2, 42.3, 23, 877, 33, 1701 ]
                ),
                '[2.1, 2112.2, 42.3, 23, 877, 33, 1701]'
            );
        },
        q(stringify_number__hash_ref([2.1, 2112.2, 42.3, 23, 877, 33, 1701]);)
    );
    lives_and(
        sub {
            is( stringify_number__hash_ref(
                    [   2.1234432112344321, 2112.4321,
                        42.4567,            23.765444444444444444,
                        877.5678,           33.876587658765875687658765,
                        1701.6789
                    ]
                ),
                '[2.12344321123443, 2112.4321, 42.4567, 23.7654444444444, 877.5678, 33.8765876587659, 1701.6789]'
            );
        },
        q(stringify_number__hash_ref([2.1234432112344321, 2112.4321, 42.4567, 23.765444444444444444, 877.5678, 33.876587658765875687658765, 1701.6789]);)
    );
    throws_ok(
        sub {
            stringify_number__hash_ref(
                [ 2, 2112, '42', 23, 877, 33, 1701 ] );
        },
        '/input_av_element at index 2 was not a number/',
        q(stringify_number__hash_ref([2, 2112, '42', 23, 877, 33, 1701]);  # throw exception)
    );
    lives_and(
        sub {
            is( typetest___number__hash_ref__in___string__out(
                    [   2.1234432112344321, 2112.4321,
                        42.4567,            23.765444444444444444,
                        877.5678,           33.876587658765875687658765,
                        1701.6789
                    ]
                ),
                '[2.12344321123443, 2112.4321, 42.4567, 23.7654444444444, 877.5678, 33.8765876587659, 1701.6789]BARBAZ'
            );
        },
        q(typetest___number__hash_ref__in___string__out([2.1234432112344321, 2112.4321, 42.4567, 23.765444444444444444, 877.5678, 33.876587658765875687658765, 1701.6789]);)
    );
    throws_ok(
        sub {
            typetest___number__hash_ref__in___string__out(
                [   2.1234432112344321,          2112.4321,
                    42.4567,                     23.765444444444444444,
                    877.5678,                    "abcdefg\n",
                    33.876587658765875687658765, 1701.6789
                ]
            );
        },
        '/input_av_element at index 5 was not a number/',
        q(typetest___number__hash_ref__in___string__out([2.1234432112344321, 2112.4321, 42.4567, 23.765444444444444444, 877.5678, "abcdefg\n", 33.876587658765875687658765, 1701.6789]);  # throw exception)
    );
    lives_and(
        sub {
            is_deeply( typetest___int__in___number__hash_ref__out(5),
                [ 0, 5.123456789, 10.246913578, 15.370370367, 20.493827156 ]
            );
        },
        q(typetest___int__in___number__hash_ref__out(5);)
    );

# String Hash: stringify, create, manipulate
# DEV NOTE: all single-quotes replaced by double-quotes when passing through stringify, this is because Perl accepts both but C/C++ only accepts double-quotes for strings
    throws_ok(
        sub { stringify_string__hash_ref('Lone Ranger') },
        '/input_av_ref was not an AV ref/',
        q(stringify_string__hash_ref('Lone Ranger');  # throw exception)
    );
    lives_and(
        sub {
            is( stringify_string__hash_ref(
                    [   'Superman',      'Batman',
                        'Wonder Woman',  'Flash',
                        'Green Lantern', 'Aquaman',
                        'Martian Manhunter'
                    ]
                ),
                q(["Superman", "Batman", "Wonder Woman", "Flash", "Green Lantern", "Aquaman", "Martian Manhunter"])
            );
        },
        q(stringify_string__hash_ref(['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter']);)
    );
    lives_and(
        sub {
            is( stringify_string__hash_ref(
                    [   'Superman',          'Batman',
                        'Wonder Woman',      'Flash',
                        'Green Lantern',     'Aquaman',
                        'Martian Manhunter', '23'
                    ]
                ),
                q(["Superman", "Batman", "Wonder Woman", "Flash", "Green Lantern", "Aquaman", "Martian Manhunter", "23"])
            );
        },
        q(stringify_string__hash_ref(['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter', '23']);)
    );
    throws_ok(
        sub {
            stringify_string__hash_ref(
                [   'Superman',          'Batman',
                    'Wonder Woman',      'Flash',
                    'Green Lantern',     'Aquaman',
                    'Martian Manhunter', 23
                ]
            );
        },
        '/input_av_element at index 7 was not a string/',
        q(stringify_string__hash_ref(['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter', 23]);  # throw exception)
    );
    lives_and(
        sub {
            is( stringify_string__hash_ref(
                    [   'Superman',          'Batman',
                        'Wonder Woman',      'Flash',
                        'Green Lantern',     'Aquaman',
                        'Martian Manhunter', '-2112.23'
                    ]
                ),
                q(["Superman", "Batman", "Wonder Woman", "Flash", "Green Lantern", "Aquaman", "Martian Manhunter", "-2112.23"])
            );
        },
        q(stringify_string__hash_ref(['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter', '-2112.23']);)
    );
    lives_and(
        sub {
            is( stringify_string__hash_ref(
                    [   'Superman',          'Batman',
                        'Wonder Woman',      'Flash',
                        'Green Lantern',     'Aquaman',
                        "Martian Manhunter", "-2112.23"
                    ]
                ),
                q(["Superman", "Batman", "Wonder Woman", "Flash", "Green Lantern", "Aquaman", "Martian Manhunter", "-2112.23"])
            );
        },
        q(stringify_string__hash_ref(['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', "Martian Manhunter", "-2112.23"]);)
    );
    throws_ok(
        sub {
            stringify_string__hash_ref(
                [   'Superman',          'Batman',
                    'Wonder Woman',      'Flash',
                    'Green Lantern',     'Aquaman',
                    'Martian Manhunter', -2112.23
                ]
            );
        },
        '/input_av_element at index 7 was not a string/',
        q(stringify_string__hash_ref(['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter', -2112.23]);  # throw exception)
    );
    throws_ok(
        sub {
            stringify_string__hash_ref(
                [   'Wonder Woman',
                    'Flash',
                    'Green Lantern',
                    'Aquaman',
                    'Martian Manhunter',
                    { fuzz => 'bizz', bar => "stool!\n", bat => 24 }
                ]
            );
        },
        '/input_av_element at index 5 was not a string/',
        q(stringify_string__hash_ref(['Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter', {fuzz => 'bizz', bar => "stool!\n", bat => 24}]);  # throw exception)
    );
    lives_and(
        sub {
            is( typetest___string__hash_ref__in___string__out(
                    [   'Superman',      'Batman',
                        'Wonder Woman',  'Flash',
                        'Green Lantern', 'Aquaman',
                        'Martian Manhunter'
                    ]
                ),
                q(["Superman", "Batman", "Wonder Woman", "Flash", "Green Lantern", "Aquaman", "Martian Manhunter"]BARBAR)
            );
        },
        q(typetest___string__hash_ref__in___string__out(['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter']);)
    );
    throws_ok(
        sub {
            typetest___string__hash_ref__in___string__out(
                [   'Superman',          'Batman',
                    'Wonder Woman',      'Flash',
                    'Green Lantern',     'Aquaman',
                    'Martian Manhunter', 23
                ]
            );
        },
        '/input_av_element at index 7 was not a string/',
        q(typetest___string__hash_ref__in___string__out(['Superman', 'Batman', 'Wonder Woman', 'Flash', 'Green Lantern', 'Aquaman', 'Martian Manhunter', 23]);  # throw exception)
    );
    lives_and(
        sub {
            is_deeply(
                typetest___int__in___string__hash_ref__out(5),
                [   'Jeffy Ten! 0/4',
                    'Jeffy Ten! 1/4',
                    'Jeffy Ten! 2/4',
                    'Jeffy Ten! 3/4',
                    'Jeffy Ten! 4/4'
                ]
            );
        },
        q(typetest___int__in___string__hash_ref__out(5);)
    );
}

done_testing();
