#!/usr/bin/perl

use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

#my integer_arrayref $inputs_i = [-2, -1, 0, 1, 2];
my integer_arrayref $inputs_i = [-1, 0, 1];
#my integer_arrayref $inputs_j = [-8, -2, -1, 0, 1, 2, 8];
my integer_arrayref $inputs_j = [-8, -1, 0, 1, 8];

OPERATOR_LOOP:
foreach my string $operator (qw{~( << >> & | ^}) {
    foreach my string $use_integer (q{}, "    use integer;\n") {
        my string_arrayref $print_strings = [];
        my integer_arrayref $eval_retvals = [];
        my integer $eval_retval_length_max = 0;
        print $use_integer;
I_LOOP:
        foreach my integer $i (@{$inputs_i}) {
J_LOOP:
            foreach my integer $j (@{$inputs_j}) {
                my string $print_string = q{    };
                my integer $eval_retval = undef;
                if ((substr $operator, -1, 1) eq '(') {
                    $print_string .= $operator;
                    if ($j >= 0) { $print_string .= q{ }; }
                    $print_string .= $j . ')' . q{  } . '#' . q{ };
                    $eval_retval = eval "$use_integer return integer_to_string($operator $j));";
#                    if (($use_integer ne q{}) and ($eval_retval >= 0)) { $print_string .= q{ }; }
                }
                else {
                    if ($i >= 0) { $print_string .= q{ }; }
                    $print_string .= $i . q{ } . $operator . q{ };
                    if ($j >= 0) { $print_string .= q{ }; }
                    $print_string .= $j . q{  } . '#' . q{ };
                    $eval_retval = eval "$use_integer return integer_to_string($i $operator $j);";
#                    if (($use_integer ne q{}) and ($eval_retval >= 0)) { $print_string .= q{ }; }
                }
                push @{$print_strings}, $print_string;
                push @{$eval_retvals}, $eval_retval;
                my integer $eval_retval_length = length "$eval_retval";
                if ($eval_retval_length > $eval_retval_length_max) { $eval_retval_length_max = $eval_retval_length; }
            }
            if ((substr $operator, -1, 1) eq '(') { last; }
        } 
        for my integer $print_string_index (0 .. ((scalar @{$print_strings}) - 1)) {
            print $print_strings->[$print_string_index];
            $eval_retvals->[$print_string_index] = (q{ } x $eval_retval_length_max) . $eval_retvals->[$print_string_index];
            print (substr $eval_retvals->[$print_string_index], -($eval_retval_length_max), $eval_retval_length_max);
            print "\n";
        }
        print "\n";
        print 'X<break_code_blocks>' . "\n\n\n";
    }
    print "\n";
}
