#!/usr/bin/perl
use strict;  use warnings;

# SUPPRESS OUTPUT FROM INDIVIDUAL TESTS, EXCLUDING TESTS INSIDE BEGIN{} BLOCKS
# order is BEGIN, UNITCHECK, CHECK, INIT, END; CHECK here suppresses Inline compile output from including HelperFunctions_cpp.pm from INIT in Array.pm
CHECK
{
	open(STDOUT, ">/dev/null") || die "Can't redirect stdout";  ## no critic
	open(STDERR, ">/dev/null") || die "Can't redirect stderr";  ## no critic
};
	
use Test::More tests => 49;
#use Test::More;
use Test::Exception;

# RPERL TEST BOILERPLATE
BEGIN { diag("\n[[[ Beginning Scalar Type Pre-Test Loading, RPerl Type System ]]]\n ");	}
BEGIN { lives_ok(sub { package main;  our $RPERL_INCLUDE_PATH = '/tmp/RPerl-latest/lib'; }, q(package main;  our $RPERL_INCLUDE_PATH = '/tmp/RPerl-latest/lib';)); }  # NEED REMOVE hard-coded path
BEGIN { lives_ok(sub { use lib $main::RPERL_INCLUDE_PATH . '/CPAN/'; }, q(use lib $main::RPERL_INCLUDE_PATH . '/CPAN/';)); lives_and(sub { use_ok('MyConfig'); }); }  # RPerl's MyConfig.pm 
BEGIN { lives_ok(sub { use lib $main::RPERL_INCLUDE_PATH; }, q(use lib $main::RPERL_INCLUDE_PATH;));  lives_and(sub { use_ok('RPerl'); });  lives_ok(sub { our @ISA = ('RPerl');  $RPerl::INCLUDE_PATH = $main::RPERL_INCLUDE_PATH; }, q(our @ISA = ('RPerl');  $RPerl::INCLUDE_PATH = $main::RPERL_INCLUDE_PATH;)); }  # RPerl system files
BEGIN { lives_and(sub { use_ok('Data::Dumper'); });  lives_ok(sub { our $AUTOLOAD;  sub AUTOLOAD { die("AUTOLOAD purposefully disabled for debugging, have \$AUTOLOAD = '$AUTOLOAD' and \@_ = \n" . Dumper(\@_) . ", dying"); }}, q(our $AUTOLOAD;  sub AUTOLOAD {...})); }  ## no critic

# loop 3 times, once for each mode: Pure-Perl, Hybrid-Perl-and-C++, Pure-C++
for (my $i = 0;  $i < 3;  ++$i)
{
	print "in 03_type_scalar.t, top of for() loop, have \$i = $i\n";  # no effect if suppressing output!
	
	if ($i == 0)
	{
		diag("\n[[[ Beginning Pure-Perl Scalar Type Tests, RPerl Type System Using Perl Data Types & Perl Operations ]]]\n ");	
		lives_and(sub { is(types_number(), 'PERL') }, q(types_number();));
		lives_and(sub { is(ops_number(), 'PERL') }, q(ops_number();));
		lives_and(sub { is(types_string(), 'PERL') }, q(types_string();));
		lives_and(sub { is(ops_string(), 'PERL') }, q(ops_string();));
	}
	elsif ($i == 1)
	{
		diag("\n[[[ Beginning Hybrid-Perl-and-C++ Scalar Type Tests, RPerl Type System Using Perl Data Types & C++ Operations ]]]\n ");	
#		lives_and(sub { is(types_enable('PERL'), undef) }, q(types_enable('PERL');));  # NEED FIX: RPerl typed functions not working in types.pm, must call as normal Perl function
		lives_and(sub { is(types::types_enable('PERL'), undef) }, q(types::types_enable('PERL');));
		
		# Number: C++ use, load, link
		BEGIN { lives_and(sub { use_ok('RPerl::DataType::Number_cpp'); }); }
		lives_and(sub { require_ok('RPerl::DataType::Number_cpp'); });
		lives_ok(sub { RPerl::DataType::Number_cpp::cpp_load(); }, q(RPerl::DataType::Number_cpp::cpp_load();));
		lives_ok(sub { RPerl::DataType::Number_cpp::cpp_link(); }, q(RPerl::DataType::Number_cpp::cpp_link();));
		lives_and(sub { is(types_number(), 'PERL') }, q(types_number();));
		lives_and(sub { is(ops_number(), 'CPP') }, q(ops_number();));

		# String: C++ use, load, link
		BEGIN { lives_and(sub { use_ok('RPerl::DataType::String_cpp'); }); }
		lives_and(sub { require_ok('RPerl::DataType::String_cpp'); });
		lives_ok(sub { RPerl::DataType::String_cpp::cpp_load(); }, q(RPerl::DataType::String_cpp::cpp_load();));
		lives_ok(sub { RPerl::DataType::String_cpp::cpp_link(); }, q(RPerl::DataType::String_cpp::cpp_link();));
		lives_and(sub { is(types_string(), 'PERL') }, q(types_string();));
		lives_and(sub { is(ops_string(), 'CPP') }, q(ops_string();));
	}
	else
	{
		diag("\n[[[ Beginning Pure-C++ Scalar Type Tests, RPerl Type System Using C++ Data Types & C++ Operations ]]]\n ");	
		lives_and(sub { is(types::types_enable('CPP'), undef) }, q(types::types_enable('CPP');));
		
		# force reload and relink
		$RPerl::DataType::Number_cpp::CPP_loaded = 0;	
		$RPerl::DataType::Number_cpp::CPP_linked = 0;	
		$RPerl::DataType::String_cpp::CPP_loaded = 0;	
		$RPerl::DataType::String_cpp::CPP_linked = 0;	
		
		# Number: C++ use, load, link
#		BEGIN { lives_and(sub { use_ok('RPerl::DataType::Number_cpp'); }); }  # duplicate
#		lives_and(sub { require_ok('RPerl::DataType::Number_cpp'); });  # duplicate
		lives_ok(sub { RPerl::DataType::Number_cpp::cpp_load(); }, q(RPerl::DataType::Number_cpp::cpp_load();));
		lives_ok(sub { RPerl::DataType::Number_cpp::cpp_link(); }, q(RPerl::DataType::Number_cpp::cpp_link();));
		lives_and(sub { is(types_number(), 'CPP') }, q(types_number();));
		lives_and(sub { is(ops_number(), 'CPP') }, q(ops_number();));

		# String: C++ use, load, link
#		BEGIN { lives_and(sub { use_ok('RPerl::DataType::String_cpp'); }); }  # duplicate
#		lives_and(sub { require_ok('RPerl::DataType::String_cpp'); });  # duplicate
		lives_ok(sub { RPerl::DataType::String_cpp::cpp_load(); }, q(RPerl::DataType::String_cpp::cpp_load();));
		lives_ok(sub { RPerl::DataType::String_cpp::cpp_link(); }, q(RPerl::DataType::String_cpp::cpp_link();));
		lives_and(sub { is(types_string(), 'CPP') }, q(types_string();));
		lives_and(sub { is(ops_string(), 'CPP') }, q(ops_string();));
	}

	# Number: stringify, create, manipulate
	lives_and(sub { is(stringify_number(3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679), '3.14159265358979')}, q(stringify_number(3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679);));
	lives_and(sub { cmp_ok(abs(typetest___void__in___number__out() - 3.14285714285714), '<', 0.0000001)}, q(typetest___void__in___number__out();));
	lives_and(sub { cmp_ok(abs(typetest___number__in___number__out(3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679) - 6.28318530717959), '<', 0.0000001)}, q(typetest___number__in___number__out(3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679);));

	# String: create, manipulate
	lives_and(sub { is(typetest___void__in___string__out(), 'Spice')}, q(typetest___void__in___string__out();));
	lives_and(sub { is(typetest___string__in___string__out("Melange"), 'MelangeFUZZ')}, q(typetest___string__in___string__out("Melange");));
}

done_testing();