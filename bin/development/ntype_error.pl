#!/usr/bin/perl
use strict;
use warnings;
use Carp;

#rperltypes::types_enable('CPP');

use RPerl;

		my $eval_string = <<"EOF";
package main;
BEGIN { print "[[[ BEGIN 'use Inline' STAGE for 'RPerl/DataType/String.cpp' ]]]\n"x3; }
use Inline (CPP => "blib/lib/RPerl/DataType/String.cpp", 
TYPEMAPS => "blib/lib/typemap.rperl",
  CCFLAGSEX => '-DNO_XSLOCKS -Wno-deprecated -std=c++0x -Wno-reserved-user-defined-literal -Wno-literal-suffix',
  INC => "-Iblib/lib",
  BUILD_NOISY => $ENV{TEST_VERBOSE},
  CLEAN_AFTER_BUILD => 0, # cache it
  WARNINGS => 1,
  FILTERS => 'Preprocess',
  AUTO_INCLUDE => # DEV NOTE: include non-RPerl files using AUTO_INCLUDE so they are not parsed by the 'Preprocess' filter
  [
   '#include <iostream>',
   '#include <string>',
   '#include <sstream>',
   '#include <limits>',
   '#include <vector>',
   '#include <unordered_map>',  # DEV NOTE: unordered_map may require '-std=c++0x' in CCFLAGS above
  ]);
print "[[[ END 'use Inline' STAGE for 'RPerl/DataType/String.cpp' ]]]\n"x3;
1;
EOF

		eval($eval_string);  ## no critic




my $string_retval = integer__stringify(3);
print STDERR "in scalar_test.pl have \$string_retval = '$string_retval'\n";

