#!/usr/bin/perl
use strict;  use warnings;

# RPERL DRIVER BOILERPLATE
BEGIN { package main;  our $RPERL_INCLUDE_PATH = '/tmp/RPerl-latest/lib'; }  # NEED REMOVE hard-coded path
BEGIN { use lib $main::RPERL_INCLUDE_PATH . '/CPAN/';  use MyConfig; }  # RPerl's MyConfig.pm 
BEGIN { use lib $main::RPERL_INCLUDE_PATH;  use RPerl;  our @ISA = ('RPerl');  $RPerl::INCLUDE_PATH = $main::RPERL_INCLUDE_PATH; }  # RPerl system files
BEGIN { use Data::Dumper;  our $AUTOLOAD;  sub AUTOLOAD { die("AUTOLOAD purposefully disabled for debugging, have \$AUTOLOAD = '$AUTOLOAD' and \@_ = \n" . Dumper(\@_) . ", dying"); } }  ## no critic

# UNCOMMENT TO ENABLE C++
use RPerl::DataType::Number_cpp;  RPerl::DataType::Number_cpp::cpp_load();  RPerl::DataType::Number_cpp::cpp_link();
use RPerl::DataType::String_cpp;  RPerl::DataType::String_cpp::cpp_load();  RPerl::DataType::String_cpp::cpp_link();

# variable declarations
my number $number_retval;
my string $string_retval;

# loop to test for memory leaks
my const_int $i_MAX = 1;
for (my int $i = 0;  $i < $i_MAX;  ++$i)
{
	print "in scalar_test.pl, top of for() loop $i/$i_MAX\n";
	
	$number_retval = stringify_number(3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679);
	print "in scalar_test.pl $i/$i_MAX, have \$number_retval = '$number_retval'\n";
	$number_retval = typetest___void__in___number__out();
	print "in scalar_test.pl $i/$i_MAX, have \$number_retval = $number_retval\n";
	$number_retval = typetest___number__in___number__out(3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679);
	print "in scalar_test.pl $i/$i_MAX, have \$number_retval = $number_retval\n";

	$string_retval = typetest___void__in___string__out();
	print "in scalar_test.pl $i/$i_MAX, have \$string_retval = '$string_retval'\n";
	$string_retval = typetest___string__in___string__out("Melange");
	print "in scalar_test.pl $i/$i_MAX, have \$string_retval = '$string_retval'\n";
}

#die("Done for now, dying");
