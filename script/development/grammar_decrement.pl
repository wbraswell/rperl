#!/usr/bin/env perl

use RPerl;
use strict;
use warnings;
our $VERSION = 0.002_000;

use Data::Dumper;
use RPerl::Grammar;
use File::Which;

## no critic qw(ProhibitExplicitStdin)  # USER DEFAULT 4: allow <STDIN>

if (not defined $ARGV[0]) { die 'First input argument missing, rule key start integer, dying'; }
if (not defined $ARGV[1]) { die 'Second input argument missing, rule key finish integer, dying'; }
if (not defined $ARGV[2]) { die 'Third input argument missing, rule key decrement integer, dying'; }

my string $which_find_replace_recurse_sh = which('find_replace_recurse.sh');
if (not defined $which_find_replace_recurse_sh) { die 'Required utility program missing, find_replace_recurse.sh, try `wget https://github.com/wbraswell/lampuniversity.org/blob/master/bin/find_replace_recurse.sh`, dying'; }

print 'ARE YOU AN RPERL SYSTEM DEVELOPER? ';
my string $stdin_confirm = <STDIN>;
if ( $stdin_confirm !~ /^[Yy]/ ) {
    exit;
}

my integer $input_rule_key_integer_start = string_to_integer($ARGV[0]);
my integer $input_rule_key_integer_finish = string_to_integer($ARGV[1]);
my integer $input_rule_key_decrement = string_to_integer($ARGV[2]);

if ($input_rule_key_integer_start < 1) { die 'First input argument invalid, must be 1 or greater, rule key start integer, dying'; }
if ($input_rule_key_integer_finish < 1) { die 'Second input argument invalid, must be 1 or greater, rule key finish integer, dying'; }
if ($input_rule_key_integer_finish < $input_rule_key_integer_start) { die 'Second input argument invalid, cannot be smaller than first argument, rule key finish integer, dying'; }
if ($input_rule_key_decrement < 1) { die 'Third input argument invalid, must be 1 or greater, rule key decrement integer, dying'; }

#print Dumper($RPerl::Grammar::RULES);

my string_arrayref $rules_sorted = [];
my integer $rule_key_integer_max = 0;

foreach my string $rule_key (keys %{$RPerl::Grammar::RULES}) {
    my string_arrayref $rule_key_split;
#    @{$rule_key_split} = split /_/, $rule_key;
    $rule_key_split = [split /_/, $rule_key];  # same as above
#    print Dumper($rule_key_split) . "\n";

    my integer $rule_key_integer = string_to_integer($rule_key_split->[1]);
    $rules_sorted->[$rule_key_integer] = [ $rule_key_split->[0], $RPerl::Grammar::RULES->{$rule_key} ];
    if ($rule_key_integer > $rule_key_integer_max) { $rule_key_integer_max = $rule_key_integer; }
}

#print Dumper($rules_sorted) . "\n";
#print $rule_key_integer_max . "\n";

if ($input_rule_key_integer_start > $rule_key_integer_max) { die 'First input argument invalid, must be 1 or greater, rule key start integer, dying'; }
print "\n";

my integer_arrayref $rule_key_range = [$input_rule_key_integer_start .. $input_rule_key_integer_finish];

foreach my integer $i (@{$rule_key_range}) {
    if (not defined $rules_sorted->[$i]) { next; }
    my string $rule_key_old = $rules_sorted->[$i]->[0] . '_' . integer_to_string($i);
    my string $rule_key_new = $rules_sorted->[$i]->[0] . '_' . integer_to_string($i - $input_rule_key_decrement);
    
    print $rule_key_old . '  ==>>  ' . $rule_key_new . "\n";
}

print "\n";
print 'WARNING: The above changes will be made in ALL FILES UNDER THIS DIRECTORY & ALL SUBDIRECTORIES...' . "\n\n";

print 'ARE YOU SURE YOU WANT TO CONTINUE? ';
$stdin_confirm = <STDIN>;
if ( $stdin_confirm !~ /^[Yy]/ ) {
    exit;
}

print 'Decrementing RPerl Grammar Production Rules...';

#foreach my integer $i (reverse @{$rule_key_range}) {
foreach my integer $i (@{$rule_key_range}) {  # do NOT reverse in decrement script
    if (not defined $rules_sorted->[$i]) { next; }
    my string $rule_key_old = $rules_sorted->[$i]->[0] . '_' . integer_to_string($i);
    my string $rule_key_new = $rules_sorted->[$i]->[0] . '_' . integer_to_string($i - $input_rule_key_decrement);
    
    # discard STDOUT but not STDERR, just in case of error in find_replace_recurse.sh
    my string $find_replace_recurse_command = 'find_replace_recurse.sh ' . $rule_key_old . q{ } . $rule_key_new . ' . YES > /dev/null';
#    print $find_replace_recurse_command . "\n";
    my string $return_value = `$find_replace_recurse_command`;
    if ((defined $return_value) and ($return_value !~ m/^\s*$/)) { print "\n"; die 'Non-empty return value for command:' . "\n" . $find_replace_recurse_command . "\n" . 'Return value:' . "\n" . $return_value . "\n" . 'dying'; }
}

print ' DONE!' . "\n";
