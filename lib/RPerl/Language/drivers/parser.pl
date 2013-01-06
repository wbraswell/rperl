#!/usr/bin/perl
use strict;  use warnings;
use Data::Dumper;

use RPerl::Language::Parser;

my $parser_obj = RPerl::Language::Parser->new();
print "have \$parser_obj =\n" . Dumper($parser_obj) . "\n";

my $retval_str = $parser_obj->foo_str(33, 1.21);  # should print "baz" and 23

print "in parser.pl, have \$retval_str = $retval_str\n";  # should print "howdy"

my $retval_array_ref = $parser_obj->bar_array_ref();

print "in parser.pl, have \$retval_array_ref = \n" . Dumper($retval_array_ref) . "\n";
