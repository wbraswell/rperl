#!/usr/bin/perl
use strict;
use warnings;
our $VERSION = 0.000_010;
use Carp;
#use RPerl;

use Data::Dumper;
use RPerl::Grammar;

my $eyapp_parser = RPerl::Grammar->new();

my $input_filename = shift;
$eyapp_parser->YYSlurpFile($input_filename);

my $ast = $eyapp_parser->YYParse(yydebug => 0xFF);
print "\n";
print $ast->str() . "\n";
print Dumper($ast) . "\n\n";
