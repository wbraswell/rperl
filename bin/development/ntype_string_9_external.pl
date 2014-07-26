#!/usr/bin/perl
use strict;
use warnings;
use Carp;

BEGIN { print "[[[ BEGIN 'use Inline' STAGE for '_debugging/ntype.cpp' ]]]\n"x3; }
use Inline (CPP => "blib/lib/_debugging/ntype_string_9.cpp", 
TYPEMAPS => "blib/lib/typemap.rperl",
  CCFLAGSEX => '-DNO_XSLOCKS -Wno-deprecated -std=c++0x -Wno-reserved-user-defined-literal -Wno-literal-suffix',
  INC => "-Iblib/lib",
  BUILD_NOISY => 1,
  CLEAN_AFTER_BUILD => 0, # cache it
  WARNINGS => 1,
  FILTERS => 'Preprocess',
  );
print "[[[ END 'use Inline' STAGE for '_debugging/ntype.cpp' ]]]\n"x3;

#my $string_retval = string__typetest0();
my $string_retval = string__typetest1('howdy');
print STDERR "in ntype.pl have \$string_retval = '$string_retval'\n";





