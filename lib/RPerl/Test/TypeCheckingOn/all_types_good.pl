#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< RUN_SUCCESS: '1' >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.000_010;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values and print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use RPerl::Test::TypeCheckingOn::AllTypes;

# [[[ OPERATIONS ]]]

check__integer(0);
check__integer(1);
check__integer(555_555);
check__integer(-1);
check__integer(-555_555);

check__number(0);
check__number(1);
check__number(555_555);
check__number(-1);
check__number(-555_555);
check__number(0.123_456);
check__number(1.123_456);
check__number(555_555.123_456);
check__number(-1.123_456);
check__number(-555_555.123_456);

check__string(q{});
check__string('0');
check__string('a');
check__string('0123abcd');
check__string(q{0123abcd});
check__string('0123abcd\n');
check__string(q{0123abcd\n});
check__string("0123abcd\n");
check__string('0123$abcd');
check__string(q{0123$abcd});

check__array_ref( [] );
check__array_ref( [0] );
check__array_ref( [0.123] );
check__array_ref( ['abcd'] );
check__array_ref( [ 0, 0, 0 ] );
check__array_ref( [ 0.123, 0.123, 0.123 ] );
check__array_ref( [ 'abcd', 'abcd', 'abcd' ] );
check__array_ref( [ 0, -0.123_456, 'abcd' ] );
check__array_ref(
    [   0, -0.123_456, 'abcd',
        [ 2, 4, 6, 8 ],
        { a => 'hello', b => 'howdy', c => 'ahoy' }
    ]
);

check__integer__array_ref( [] );
check__integer__array_ref( [0] );
check__integer__array_ref( [ 0, 1, 2, 3 ] );
check__integer__array_ref( [ -999_999, 0, 1, 2, 3 ] );

check__number__array_ref( [] );
check__number__array_ref( [0] );
check__number__array_ref( [ 0, 1, 2, 3 ] );
check__number__array_ref( [ -999_999, 0, 1, 2, 3 ] );
check__number__array_ref( [0.123] );
check__number__array_ref( [ 0.123, 1.123, 2.123, 3.123 ] );
check__number__array_ref( [ -999_999.123_456, 0.123, 1, 2, 3 ] );

my number__array_ref $input_1 = [ -999_999, 0.0,  0.0,  0.0 ];
my number__array_ref $input_2 = [ -999_999, 3.0,  4.0,  12.0 ];
my number__array_ref $input_3 = [ -999_999, 23.0, 42.0, 2_112.0 ];
check__number__array_refs( $input_1, $input_2, $input_3 );

check__string__array_ref( [] );
check__string__array_ref( ['0'] );
check__string__array_ref( [ '0', 'a', '0123abcd' ] );
check__string__array_ref( [ '0', 'a', '0123abcd', q{0}, q{a}, q{0123abcd} ] );
check__string__array_ref(
    [ '0\n', '$a', '0123$abcd', q{0}, q{a\n}, q{0123abcd\n} ] );
check__string__array_ref( [ "0\n", "a\n", "0123abcd\n" ] );

check__hash_ref( {} );
check__hash_ref( { a => 0 } );
check__hash_ref( { a => 0.123 } );
check__hash_ref( { a => 'abcd' } );
check__hash_ref( { a => 0, b => 0, c => 0 } );
check__hash_ref( { a => 0.123, b => 0.123, c => 0.123 } );
check__hash_ref( { a => 'abcd', b => 'abcd', c => 'abcd' } );
check__hash_ref(
    {   a => 0,
        b => -0.123_456,
        c => 'abcd',
        d => [ 2, 4, 6, 8 ],
        e => { a => 'hello', b => 'howdy', c => 'ahoy' }
    }
);
check__integer__hash_ref( {} );
check__integer__hash_ref( { a => 0 } );
check__integer__hash_ref( { a => 0, b => 1, c => 2, d => 3 } );
check__integer__hash_ref(
    { aa => -999_999, a => 0, b => 1, c => 2, d => 3 } );

check__number__hash_ref( {} );
check__number__hash_ref( { a => 0 } );
check__number__hash_ref( { a => 0, b => 1, c => 2, d => 3 } );
check__number__hash_ref( { aa => -999_999, a => 0, b => 1, c => 2, d => 3 } );
check__number__hash_ref( { a => 0.123 } );
check__number__hash_ref( { a => 0.123, b => 1.123, c => 2.123, d => 3.123 } );
check__number__hash_ref(
    { aa => -999_999.123_456, a => 0.123, b => 1, c => 2, d => 3 } );

my number__hash_ref $input_4
    = { a => -999_999, b => 0.0, c => 0.0, d => 0.0 };
my number__hash_ref $input_5
    = { a => -999_999, b => 3.0, c => 4.0, d => 12.0 };
my number__hash_ref $input_6
    = { a => -999_999, b => 23.0, c => 42.0, d => 2_112.0 };
check__number__hash_refs( $input_4, $input_5, $input_6 );

check__string__hash_ref( {} );
check__string__hash_ref( { a => '0' } );
check__string__hash_ref( { a => '0', b => 'a', c => '0123abcd' } );
check__string__hash_ref(
    {   a => '0',
        b => 'a',
        c => '0123abcd',
        d => q{0},
        e => q{a},
        f => q{0123abcd}
    }
);
check__string__hash_ref(
    {   a => '0\n',
        b => '$a',
        c => '0123$abcd',
        d => q{0},
        e => q{a\n},
        f => q{0123abcd\n}
    }
);
check__string__hash_ref(
    {   a => "0\n",
        b => "a\n",
        c => "0123abcd\n"
    }
);

print "1\n";
