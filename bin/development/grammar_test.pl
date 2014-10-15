#!/usr/bin/perl
use strict;
use warnings;
our $VERSION = 0.000_010;
use RPerl::Config;

use RPerl::Grammar;

my $eyapp_parser = RPerl::Grammar->new();

#$eyapp_parser->input(\<<'EOI'
#a = 2*3       # 1: 6
#d = 5/(a-6)   # 2: division by zero
#b = (a+1)/7   # 3: 1
#c=a*3+4)-5    # 4: syntax error
#a = a+1       # 5: 7
#EOI
#);

my $input_filename = shift;
$eyapp_parser->YYSlurpFile($input_filename);

my $ast = $eyapp_parser->YYParse(yydebug => 0xFF);
print "\n";
print $ast->str() . "\n";
print Dumper($ast) . "\n\n";
