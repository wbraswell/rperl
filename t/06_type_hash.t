#!/usr/bin/perl
use strict;
use warnings;
use version; our $VERSION = qv('0.1.4');

# SUPPRESS OUTPUT FROM INDIVIDUAL TESTS, EXCLUDING TESTS INSIDE BEGIN{} BLOCKS
# order is BEGIN, UNITCHECK, CHECK, INIT, END; CHECK here suppresses Inline compile output from including HelperFunctions_cpp.pm from INIT in Hash.pm
CHECK {
    open( STDOUT, '>', '/dev/null' )
        || croak('Error redirecting stdout, croaking');
    open( STDERR, '>', '/dev/null' )
        || croak('Error redirecting stderr, croaking');
}

use Test::More;    # tests => 121;
use Test::Exception;
use Carp;

BEGIN {
    diag(
        "\n[[[ Beginning Hash Type Pre-Test Loading, RPerl Type System ]]]\n "
    );
}

BEGIN {
    lives_ok(
        sub {      ## PERLTIDY BUG blank newline

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
    print "in 06_type_hash.t, top of for() loop, have \$i = $i\n" or croak; # no effect if suppressing output!
    my $OPS_TYPES;
    if ( $i == 0 ) {
        $OPS_TYPES = 'PERLOPS_PERLTYPES';
        diag(
            "\n[[[ Beginning RPerl's Pure-Perl Hash Type Tests, RPerl Type System Using Perl Data Types & Perl Operations ]]]\n "
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
            sub { is( ops_hash(), 'PERL', q{ops_hash() returns 'PERL'} ) },
            q{ops_hash() lives} );
        lives_and(
            sub {
                is( types_hash(), 'PERL', q{types_hash() returns 'PERL'} );
            },
            q{types_hash() lives}
        );
    }
    elsif ( $i == 1 ) {
        $OPS_TYPES = 'CPPOPS_PERLTYPES';
        diag(
            "\n[[[ Beginning RPerl's Perl-Data Mode Hash Type Tests, RPerl Type System Using Perl Data Types & C++ Operations ]]]\n "
        );

        lives_ok(
            sub { types::types_enable('PERL') },
            q{types::types_enable('PERL') lives}
        );

        # Hash: C++ use, load, link
        BEGIN {
            lives_and(
                sub { use_ok('RPerl::DataStructure::Hash_cpp'); },
                q{use_ok('RPerl::DataStructure::Hash_cpp') lives}
            );
        }
        lives_and(
            sub { require_ok('RPerl::DataStructure::Hash_cpp'); },
            q{require_ok('RPerl::DataStructure::Hash_cpp') lives}
        );
        lives_ok(
            sub { RPerl::DataStructure::Hash_cpp::cpp_load(); },
            q{RPerl::DataStructure::Hash_cpp::cpp_load() lives}
        );
        lives_ok(
            sub { RPerl::DataStructure::Hash_cpp::cpp_link(); },
            q{RPerl::DataStructure::Hash_cpp::cpp_link() lives}
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
            sub { is( ops_hash(), 'CPP', q{ops_hash() returns 'CPP'} ) },
            q{ops_hash() lives} );
        lives_and(
            sub {
                is( types_hash(), 'PERL', q{types_hash() returns 'PERL'} );
            },
            q{types_hash() lives}
        );
    }
    else {
        $OPS_TYPES = 'CPPOPS_CPPTYPES';
        diag(
            "\n[[[ Beginning RPerl's C-Data Mode Hash Type Tests, RPerl Type System Using C++ Data Types & C++ Operations ]]]\n "
        );
        lives_ok(
            sub { types::types_enable('CPP') },
            q{types::types_enable('CPP') lives}
        );

        # force reload and relink
        $RPerl::DataStructure::Hash_cpp::CPP_LOADED = 0;
        $RPerl::DataStructure::Hash_cpp::CPP_LINKED = 0;

        # Hash: C++ use, load, link
        lives_ok(
            sub { RPerl::DataStructure::Hash_cpp::cpp_load(); },
            q{RPerl::DataStructure::Hash_cpp::cpp_load() lives}
        );
        lives_ok(
            sub { RPerl::DataStructure::Hash_cpp::cpp_link(); },
            q{RPerl::DataStructure::Hash_cpp::cpp_link() lives}
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
            sub { is( ops_hash(), 'CPP', q{ops_hash() returns 'CPP'} ) },
            q{ops_hash() lives} );
        lives_and(
            sub { is( types_hash(), 'CPP', q{types_hash() returns 'CPP'} ) }
            ,    ## PERLTIDY BUG comma on newline
            q{types_hash() lives}
        );
    }

    # Int Hash: stringify, create, manipulate
    throws_ok(    # HV00
        sub { stringify_int__hash_ref(2) },
        "/$OPS_TYPES.*input_hv_ref was not an HV ref/",
        q{stringify_int__hash_ref(2) throws correct exception}
    );
    lives_and(    # HV01
        sub {
            is( stringify_int__hash_ref( { a_key => 23 } ),
                q{{'a_key' => 23}},
                q{stringify_int__hash_ref({a_key => 23}) returns correct value}
            );
        },
        q{stringify_int__hash_ref({a_key => 23}) lives}
    );
    lives_and(    # HV02
        sub {
            like(
                stringify_int__hash_ref(
                    {   a_key => 2,
                        b_key => 2112,
                        c_key => 42,
                        d_key => 23,
                        e_key => -877,
                        f_key => 33,
                        g_key => 1701
                    }
                ),

# NEED FIX: replace ".*" near end of this & following regexes with syntax to match exactly 6 occurrences of ", "; (,\s)* and variations don't work?
                q{/^\{(?=.*'a_key' => 2\b)(?=.*'b_key' => 2112\b)(?=.*'c_key' => 42\b)(?=.*'d_key' => 23\b)(?=.*'e_key' => -877\b)(?=.*'f_key' => 33\b)(?=.*'g_key' => 1701\b).*\}$/m} ## no critic qw(RequireInterpolationOfMetachars)  ## RPERL allow single-quoted sigils
                ,
                q{stringify_int__hash_ref({a_key => 2, b_key => 2112, c_key => 42, d_key => 23, e_key => -877, f_key => 33, g_key => 1701}) returns correct value}
            );
        },
        q{stringify_int__hash_ref({a_key => 2, b_key => 2112, c_key => 42, d_key => 23, e_key => -877, f_key => 33, g_key => 1701}) lives}
    );
    throws_ok(    # HV03
        sub {
            stringify_int__hash_ref(
                {   a_key => 2,
                    b_key => 2112,
                    c_key => 42.3,
                    d_key => 23,
                    e_key => -877,
                    f_key => 33,
                    g_key => 1701
                }
            );    ## PERLTIDY BUG semicolon on newline
        },
        "/$OPS_TYPES.*input_hv_value at key 'c_key' was not an int/",
        q{stringify_int__hash_ref({a_key => 2, b_key => 2112, c_key => 42.3, d_key => 23, e_key => -877, f_key => 33, g_key => 1701}) throws correct exception}
    );
    throws_ok(    # HV04
        sub {
            stringify_int__hash_ref(
                {   a_key => 2,
                    b_key => 2112,
                    c_key => 42,
                    d_key => '23',
                    e_key => -877,
                    f_key => 33,
                    g_key => 1701
                }
            );    ## PERLTIDY BUG semicolon on newline
        },
        "/$OPS_TYPES.*input_hv_value at key 'd_key' was not an int/",
        q{stringify_int__hash_ref({a_key => 2, b_key => 2112, c_key => 42, d_key => '23', e_key => -877, f_key => 33, g_key => 1701}) throws correct exception}
    );
    lives_and(    # HV10
        sub {
            like(
                typetest___int__hash_ref__in___string__out(
                    {   'binary' => 2,
                        'rush'   => 2112,
                        'answer' => 42,
                        'fnord'  => 23,
                        'units'  => -877,
                        'degree' => 33,
                        'ncc'    => 1701
                    }
                ),
                q{/^\{(?=.*'binary' => 2\b)(?=.*'rush' => 2112\b)(?=.*'answer' => 42\b)(?=.*'fnord' => 23\b)(?=.*'units' => -877\b)(?=.*'degree' => 33\b)(?=.*'ncc' => 1701\b).*\}} ## no critic qw(RequireInterpolationOfMetachars)  ## RPERL allow single-quoted sigils
                    . $OPS_TYPES . q{$/m}, ## no critic qw(RequireInterpolationOfMetachars)  ## RPERL allow single-quoted sigils

#                q{typetest___int__hash_ref__in___string__out({'binary' => 2, 'rush' => 2112, 'answer' => 42, 'fnord' => 23, 'units' => -877, 'degree' => 33, 'ncc' => 1701}) returns correct value}
                q{typetest___int__hash_ref__in___string__out({'binary' => 2, 'rush' => 2112, ..., 'ncc' => 1701}) returns correct value}
            );
        },
        q{typetest___int__hash_ref__in___string__out({'binary' => 2, 'rush' => 2112, ..., 'ncc' => 1701}) lives}
    );
    throws_ok(                             # HV11
        sub {
            typetest___int__hash_ref__in___string__out(
                {   'binary'       => 2,
                    'rush'         => 2112,
                    'ERROR_FUNKEY' => 'abcdefg',
                    'answer'       => 42,
                    'fnord'        => 23,
                    'units'        => -877,
                    'degree'       => 33,
                    'ncc'          => 1701
                }
            );
        },
        "/$OPS_TYPES.*input_hv_value at key 'ERROR_FUNKEY' was not an int/",
        q{typetest___int__hash_ref__in___string__out({'binary' => 2, 'rush' => 2112, 'ERROR_FUNKEY' => 'abcdefg', ..., 'ncc' => 1701}) throws correct exception}
    );
    lives_and(    # HV12
        sub {
            like(
                typetest___int__hash_ref__in___string__out(
                    { something => 444, degree => 33, ncc => 1701 }
                ),
                q{/^\{(?=.*'something' => 444\b)(?=.*'degree' => 33\b)(?=.*'ncc' => 1701\b).*\}} ## no critic qw(RequireInterpolationOfMetachars)  ## RPERL allow single-quoted sigils
                    . $OPS_TYPES . q{$/m}, ## no critic qw(RequireInterpolationOfMetachars)  ## RPERL allow single-quoted sigils
                q{typetest___int__hash_ref__in___string__out({something => 444, degree => 33, ncc => 1701}) returns correct value again, Perl stack still functioning properly}
            );
        },
        q{typetest___int__hash_ref__in___string__out({something => 444, degree => 33, ncc => 1701}) lives}
    );
    lives_and(                             # HV20
        sub {
            is_deeply(
                typetest___int__in___int__hash_ref__out(5), ## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
                {   "$OPS_TYPES\_funkey2" => 10,
                    "$OPS_TYPES\_funkey3" => 15,
                    "$OPS_TYPES\_funkey4" => 20,
                    "$OPS_TYPES\_funkey1" => 5,
                    "$OPS_TYPES\_funkey0" => 0
                },
                q{typetest___int__in___int__hash_ref__out(5) returns correct value}
            );
        },
        q{typetest___int__in___int__hash_ref__out(5) lives}
    );

    # Num Hash: stringify, create, manipulate
    throws_ok(    # HV30
        sub { stringify_number__hash_ref(2) },
        "/$OPS_TYPES.*input_hv_ref was not an HV ref/",
        q{stringify_number__hash_ref(2) throws correct exception}
    );
    lives_and(    # HV31
        sub {
            is( stringify_number__hash_ref( { a_key => 23 } ),
                q{{'a_key' => 23}},
                q{stringify_number__hash_ref({a_key => 23}) returns correct value}
            );
        },
        q{stringify_number__hash_ref({a_key => 23}) lives}
    );
    lives_and(    # HV32
        sub {
            like(
                stringify_number__hash_ref(
                    {   a_key => 2,
                        b_key => 2112,
                        c_key => 42,
                        d_key => 23,
                        e_key => -877,
                        f_key => 33,
                        g_key => 1701
                    }
                ),

                q{/^\{(?=.*'a_key' => 2\b)(?=.*'b_key' => 2112\b)(?=.*'c_key' => 42\b)(?=.*'d_key' => 23\b)(?=.*'e_key' => -877\b)(?=.*'f_key' => 33\b)(?=.*'g_key' => 1701\b).*\}$/m} ## no critic qw(RequireInterpolationOfMetachars)  ## RPERL allow single-quoted sigils
                ,
                q{stringify_number__hash_ref({a_key => 2, b_key => 2112, c_key => 42, d_key => 23, e_key => -877, f_key => 33, g_key => 1701}) returns correct value}
            );
        },
        q{stringify_number__hash_ref({a_key => 2, b_key => 2112, c_key => 42, d_key => 23, e_key => -877, f_key => 33, g_key => 1701}) lives}
    );
    lives_and(    # HV33
        sub {
            like(
                stringify_number__hash_ref(
                    {   a_key => 2,
                        b_key => 2112,
                        c_key => 42.3,
                        d_key => 23,
                        e_key => -877,
                        f_key => 33,
                        g_key => 1701
                    }
                ),
                q{/^\{(?=.*'a_key' => 2\b)(?=.*'b_key' => 2112\b)(?=.*'c_key' => 42\.3\b)(?=.*'d_key' => 23\b)(?=.*'e_key' => -877\b)(?=.*'f_key' => 33\b)(?=.*'g_key' => 1701\b).*\}$/m} ## no critic qw(RequireInterpolationOfMetachars)  ## RPERL allow single-quoted sigils
                ,
                q{stringify_number__hash_ref({a_key => 2, b_key => 2112, c_key => 42.3, d_key => 23, e_key => -877, f_key => 33, g_key => 1701}) returns correct value}
            );
        },
        q{stringify_number__hash_ref({a_key => 2, b_key => 2112, c_key => 42.3, d_key => 23, e_key => -877, f_key => 33, g_key => 1701}) lives}
    );
    lives_and(    # HV34
        sub {
            like(
                stringify_number__hash_ref(
                    {   a_key => 2.1234432112344321,
                        b_key => 2112.4321,
                        c_key => 42.4567,
                        d_key => 23.765444444444444444,
                        e_key => -877.5678,
                        f_key => 33.876587658765875687658765,
                        g_key => 1701.6789
                    }
                ),
                q{/^\{(?=.*'a_key' => 2\.12344321123443\b)(?=.*'b_key' => 2112\.4321\b)(?=.*'c_key' => 42\.4567\b)(?=.*'d_key' => 23\.7654444444444\b)(?=.*'e_key' => -877\.5678\b)(?=.*'f_key' => 33\.8765876587659\b)(?=.*'g_key' => 1701\.6789\b).*\}$/m} ## no critic qw(RequireInterpolationOfMetachars)  ## RPERL allow single-quoted sigils
                ,
                q{stringify_number__hash_ref({a_key => 2.1234432112344321, b_key => 2112.4321, ..., g_key => 1701.6789}) returns correct value}
            );
        },
        q{stringify_number__hash_ref({a_key => 2.1234432112344321, b_key => 2112.4321, ..., g_key => 1701.6789}) lives}
    );
    throws_ok(    # HV35
        sub {
            stringify_number__hash_ref(
                {   a_key => 2,
                    b_key => 2112,
                    c_key => 42,
                    d_key => '23',
                    e_key => -877,
                    f_key => 33,
                    g_key => 1701
                }
            );    ## PERLTIDY BUG semicolon on newline
        },
        "/$OPS_TYPES.*input_hv_value at key 'd_key' was not a number/",
        q{stringify_number__hash_ref({a_key => 2, b_key => 2112, c_key => 42, d_key => '23', e_key => -877, f_key => 33, g_key => 1701}) throws correct exception}
    );
}
done_testing();
