#!/usr/bin/perl
# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitCStyleForLoops)  # USER DEFAULT 6: allow C-style for() loop headers
## no critic qw(ProhibitParensWithBuiltins ProhibitNoisyQuotes)  # SYSTEM SPECIAL 3: allow auto-generated code

sub pretty_print {
    { my void $RETURN_TYPE };
    ( my integer_arrayref_hashref $input ) = @ARG;

    print '{', "\n";
    my string_arrayref $input_keys = [ sort keys %{$input} ];
    my integer $input_keys_count = scalar @{$input_keys};
    for (my integer $i = 0; $i < $input_keys_count; $i++) {
        my string $input_key = $input_keys->[$i];
        my integer_arrayref $input_value = $input->{$input_key};
        my integer $input_value_count = scalar @{$input_value};

        if ($i > 0) {
            print ',', "\n";
        }
        print q{    }, $input_key, ' => ';

        print '[ ';
        for (my integer $j = 0; $j < $input_value_count; $j++) {
            if ($j > 0) {
                print ', ';
            }
            print $input_value->[$j];
        }
        print ' ]';
    }
    print "\n", '}';
    return;
}

sub pretty_return {
    { my string $RETURN_TYPE };
    ( my integer_arrayref_hashref $input ) = @ARG;
    my string $retval = q{};

    $retval .= '{' . "\n";
    my string_arrayref $input_keys = [ sort keys %{$input} ];
    my integer $input_keys_count = scalar @{$input_keys};
    for (my integer $i = 0; $i < $input_keys_count; $i++) {
        my string $input_key = $input_keys->[$i];
        my integer_arrayref $input_value = $input->{$input_key};
        my integer $input_value_count = scalar @{$input_value};

        if ($i > 0) {
            $retval .= ',' . "\n";
        }
        $retval .= q{    } . $input_key . ' => ';

        $retval .= '[ ';
        for (my integer $j = 0; $j < $input_value_count; $j++) {
            if ($j > 0) {
                $retval .= ', ';
            }
            $retval .= $input_value->[$j];
        }
        $retval .= ' ]';
    }
    $retval .= "\n" . '}';
    return $retval;
}

# [[[ OPERATIONS ]]]

# homogeneous 2-dimensional hash of arrays of integers
my integer_arrayref_hashref $foo = {
    key_0 => [  0,  1,  2,  3,  4 ],
    key_1 => [  5,  6,  7,  8,  9 ],
    key_2 => [  0, -1, -2, -3, -4 ],
    key_3 => [ -5, -6, -7, -8, -9 ]
};

print 'have printed  $foo = ';
pretty_print($foo);
print "\n";

print 'have returned $foo = ', pretty_return($foo), "\n";
