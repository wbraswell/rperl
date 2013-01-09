#!/usr/bin/perl
use strict;  use warnings;  use RPerl;

use RPerl::Language::Parser;

my $parser_obj = RPerl::Language::Parser->new();
print "have \$parser_obj =\n" . Dumper($parser_obj) . "\n";

my $retval_str = $parser_obj->foo_str(33, 1.21);  # should print "baz" and 23

print "in parser.pl, have \$retval_str = $retval_str\n";  # should print "howdy"

my $retval_array_ref = $parser_obj->bar_array_ref();

print "in parser.pl, have \$retval_array_ref = \n" . Dumper($retval_array_ref) . "\n";


#&$RPerl::Language::Parser::foo_method({fake => 'object'}, "foo_arg_noAUTOLOAD");
#$sorter->foo_method("foo_arg_yesAUTOLOAD");
our int $foo_func = sub {(my $func_arg) = @_;  print "HEY-HO FROM foo_func(), RECEIVED \$func_arg = '$func_arg'\n";}; 
&$foo_func('2112_noAUTOLOAD');
my $foo_func_name = 'foo_func';
my $foo_func_ref = eval("\${$foo_func_name}");  ## no critic
print "in multi_sort.pl, have \$foo_func_ref =\n" . RPerl::DUMPER($foo_func_ref) . "\n";
&$foo_func_ref('4114_noAUTOLOAD');
foo_func('3113_yesAUTOLOAD', 23);