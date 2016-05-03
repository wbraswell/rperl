#!/usr/bin/perl

use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

#my string_arrayref $inputs_i = ['', 'a', 'aa', 'aaa', 'b', 'bb', 'bbb', 'A', 'AA', 'AAA', 'B', 'BB', 'BBB'];
my string_arrayref $inputs_i = ['', 'a', 'aa', 'b', 'bb', 'A', 'AA', 'B', 'BB'];
#my string_arrayref $inputs_j = ['', 'a', 'aa', 'aaa', 'b', 'bb', 'bbb', 'A', 'AA', 'AAA', 'B', 'BB', 'BBB'];
my string_arrayref $inputs_j = ['', 'a', 'b', 'A', 'B'];

OPERATOR_LOOP:
foreach my string $operator (qw{lt gt le ge eq ne cmp}) {
    my string_arrayref $print_strings = [];
    my integer_arrayref $eval_retvals = [];
    my integer $eval_retval_length_max = 0;
I_LOOP:
    foreach my string $i (@{$inputs_i}) {
J_LOOP:
        foreach my string $j (@{$inputs_j}) {
            my string $print_string = q{    };
            my integer $eval_retval = undef;
            $print_string .= q{ } x (3 - (length $i));  # hard-coded max length 3, must change if $inputs_i has longer element
            $print_string .= q{'} . $i . q{'} . q{ } . $operator . q{ };
            $print_string .= q{ } x (3 - (length $j));  # hard-coded max length 3, must change if $inputs_j has longer element
            $print_string .= q{'} . $j . q{'} . q{  } . '#' . q{ };
            $eval_retval = eval "return $print_string";
#            if ($eval_retval >= 0) { $print_string .= q{ }; }
            push @{$print_strings}, $print_string;
            push @{$eval_retvals}, $eval_retval;
            my integer $eval_retval_length = length "$eval_retval";
            if ($eval_retval_length > $eval_retval_length_max) { $eval_retval_length_max = $eval_retval_length; }
        }
    } 

#    print 'have $eval_retval_length_max = ' . $eval_retval_length_max . "\n";
#    next;
#    print Dumper($print_strings);
#    die 'TMP DEBUG';

    for my integer $print_string_index (0 .. ((scalar @{$print_strings}) - 1)) {
        print $print_strings->[$print_string_index];
        my string $eval_retval_stringified = (q{ } x $eval_retval_length_max) . $eval_retvals->[$print_string_index];
        print (substr $eval_retval_stringified, -($eval_retval_length_max), $eval_retval_length_max);
        if ((index $print_strings->[$print_string_index], 'cmp') >= 0) {
            if ($eval_retvals->[$print_string_index] == -1) { print ' (less    than)'; }
            elsif ($eval_retvals->[$print_string_index] == 0) { print ' (equal)'; }
            else { print ' (greater than)'; }
        }
        else{
            if ($eval_retvals->[$print_string_index]) { print ' (true)'; }
            else { print ' (false)'; }
        }
        print "\n";
    }
    print "\n";
}
