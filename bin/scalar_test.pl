#!/usr/bin/perl
use strict;  use warnings;

# RPERL DRIVER BOILERPLATE
BEGIN { package main;  our $RPERL_INCLUDE_PATH = '/tmp/RPerl-latest/lib'; } # NEED REMOVE hard-coded path
use lib $main::RPERL_INCLUDE_PATH;  use RPerl;  our @ISA = ('RPerl');  $RPerl::INCLUDE_PATH = $main::RPERL_INCLUDE_PATH;  # RPerl system files
use lib $main::RPERL_INCLUDE_PATH . '/CPAN/';  use MyConfig;  # RPerl's MyConfig.pm 
use Data::Dumper;  our $AUTOLOAD;  sub AUTOLOAD { die("AUTOLOAD purposefully disabled for debugging, have \$AUTOLOAD = '$AUTOLOAD' and \@_ = \n" . Dumper(\@_) . ", dying"); }

# UNCOMMENT TO ENABLE C++
use RPerl::DataType::Number_cpp;  RPerl::DataType::Number_cpp::cpp_load();  RPerl::DataType::Number_cpp::cpp_link();
use RPerl::DataType::String_cpp;  RPerl::DataType::String_cpp::cpp_load();  RPerl::DataType::String_cpp::cpp_link();

# variable declarations
my number $retval_number;
my string $retval_string;

# loop to test for memory leaks
my const_int $i_MAX = 1;
for (my int $i = 0;  $i < $i_MAX;  ++$i)
{
	print "in scalar_test.pl, top of for() loop $i/$i_MAX\n";
	
	typetest___number__in___void__out(3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679);
	$retval_number = typetest___void__in___number__out();
	print "in scalar_test.pl $i/$i_MAX, have \$retval_number = $retval_number\n";

	typetest___string__in___void__out("Melange");
	$retval_string = typetest___void__in___string__out();
	print "in scalar_test.pl $i/$i_MAX, have \$retval_string = '$retval_string'\n";
}

#die("Done for now, dying");
