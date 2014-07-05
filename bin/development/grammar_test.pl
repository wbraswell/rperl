#!/usr/bin/perl
use strict;
use warnings;
our $VERSION = 0.000_010;
use Carp;
#use RPerl;

use RPerl::Grammar;

my $eyapp_parser = RPerl::Grammar->new();

my $input_filename = shift;
$eyapp_parser->YYSlurpFile($input_filename);

my $ast = $eyapp_parser->YYParse(yydebug => 0xFF);
print $ast->str() . "\n";
