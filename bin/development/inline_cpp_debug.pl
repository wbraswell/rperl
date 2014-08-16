#!/usr/bin/perl
use strict;
use warnings;
our $VERSION = 0.000_010;
use Carp;

# START HERE: boil down to find why methods are binding but not functions
# START HERE: boil down to find why methods are binding but not functions
# START HERE: boil down to find why methods are binding but not functions

# RPERL DRIVER BOILERPLATE
BEGIN { package main;  our $RPERL_INCLUDE_PATH = 'blib/lib'; }  # NEED REMOVE hard-coded path
BEGIN { use RPerl; use parent ('RPerl'); $RPerl::INCLUDE_PATH = $main::RPERL_INCLUDE_PATH; }    # RPerl system files
use Data::Dumper;



package rperltypes;
#our void $types_input_enable = sub { (my $types_input) = @_;  # NEED FIX: RPerl typed functions not working in types.pm, must call as normal Perl function
sub types_enable { (my $types_input) = @_;
;
#	RPerl::diag "in rperltypes::types_enable(), received \$types_input = '$types_input'\n";
	
	my string $rperltypes_h_filename = $RPerl::INCLUDE_PATH . '/rperltypes_mode.h';
#	my bool $rperltypes_h_modified = 0;
	my integer $rperltypes_h_modified = 0;
	
#	RPerl::diag "in rperltypes::types_enable(), have \$rperltypes_h_filename = '$rperltypes_h_filename'\n";
	
	open(my $TYPES_H_FILEHANDLE_IN,'<', $rperltypes_h_filename) or die("Can't read rperltypes_mode.h input file: $!, dying");
	open(my $TYPES_H_FILEHANDLE_OUT,'>', ($rperltypes_h_filename . '.swap')) or die("Can't write rperltypes_mode.h.swap output file: $!, dying");

	while(defined(my $line_current = <$TYPES_H_FILEHANDLE_IN>))
	{
		my string $types_current;
	
#		RPerl::diag "in rperltypes::types_enable(), have \$line_current =\n$line_current";
		if ($line_current =~ /\#\s*define\s+\_\_(\w+)\_\_TYPES/)
		{
			$types_current = $1;
#			RPerl::diag "in rperltypes::types_enable(), FOUND $types_current TYPES DEFINITION\n";
			
			if ($line_current =~ /^\s*\/\//)
			{
#				RPerl::diag "in rperltypes::types_enable(), FOUND $types_current TYPES DISABLED\n";
				if ($types_current eq $types_input)
				{
#					RPerl::diag "in rperltypes::types_enable(), ENABLE $types_current TYPES\n";
					$line_current =~ s/\/\///;  # remove first occurence of // comment
					$rperltypes_h_modified = 1;
				}
			}
			elsif ($line_current =~ /^\s*\#\s*define/)
			{
#				RPerl::diag "in rperltypes::types_enable(), FOUND $types_current TYPES ENABLED\n";
				if ($types_current ne $types_input)
				{
#					RPerl::diag "in rperltypes::types_enable(), DISABLE $types_current TYPES\n";
					$line_current = '//' . $line_current;
					$rperltypes_h_modified = 1;
				}
			}
			else
			{
				close($TYPES_H_FILEHANDLE_IN);
				close($TYPES_H_FILEHANDLE_OUT);
				die('Found invalid __$types_current__TYPES definition in rperltypes_mode.h, neither properly disabled nor enabled, dying');
			}
		}
		print $TYPES_H_FILEHANDLE_OUT $line_current;  # WRITE DATA BACK TO FILE
	}

	close($TYPES_H_FILEHANDLE_IN);
	close($TYPES_H_FILEHANDLE_OUT);
	
	if ($rperltypes_h_modified)
	{
		move($rperltypes_h_filename, ($rperltypes_h_filename . '.orig')) or die("Can't move rperltypes_mode.h input file to rperltypes_mode.h.orig: $!, dying");
		move(($rperltypes_h_filename . '.swap'), $rperltypes_h_filename) or die("Can't move rperltypes_mode.h.swap output file to rperltypes_mode.h: $!, dying");
	}
	
	return();
#};
}

1;


package main; 

# WHY CAN'T I DELETE THIS LINE?
rperltypes::types_enable('PERL');


        my $eval_string = <<"EOF";
use RPerl::Inline;
use Inline (CPP => "blib/lib/RPerl/Algorithm/Sort/Bubble.cpp", \@RPerl::Inline::ARGS);
1;
EOF

        eval($eval_string);
 

print STDERR q{in inline_cpp_debug.pl, have \%main:: symbol table = '} . Dumper(\%main::) . "'\n" or croak();

print STDERR q{in inline_cpp_debug.pl, have integer__ops() = '} . integer__ops() . "'\n" or croak();
print STDERR q{in inline_cpp_debug.pl, have integer__types() = '} . integer__types() . "'\n" or croak();
print STDERR q{in inline_cpp_debug.pl, have number__ops() = '} . number__ops() . "'\n" or croak();
print STDERR q{in inline_cpp_debug.pl, have number__types() = '} . number__types() . "'\n" or croak();
print STDERR q{in inline_cpp_debug.pl, have string__ops() = '} . string__ops() . "'\n" or croak();
print STDERR q{in inline_cpp_debug.pl, have string__types() = '} . string__types() . "'\n" or croak();
print STDERR q{in inline_cpp_debug.pl, have array__ops() = '} . array__ops() . "'\n" or croak();
print STDERR q{in inline_cpp_debug.pl, have array__types() = '} . array__types() . "'\n" or croak();
print STDERR q{in inline_cpp_debug.pl, have hash__ops() = '} . hash__ops() . "'\n" or croak();
print STDERR q{in inline_cpp_debug.pl, have hash__types() = '} . hash__types() . "'\n" or croak();

my $sorter = RPerl::Algorithm::Sort::Bubble->new();
print STDERR "in inline_cpp_debug.pl have \$sorter->bubblesort__ops__oo() = '" . $sorter->bubblesort__ops__oo() . "'\n" or croak();  # OO INTERFACE

#print STDERR q{in inline_cpp_debug.pl, have string__hash_ref__stringify() = '} . string__hash_ref__stringify() . "'\n" or croak();

print STDERR q{in inline_cpp_debug.pl, have bubblesort__ops() = '} . bubblesort__ops() . "'\n" or croak();
#print STDERR q{in inline_cpp_debug.pl, have bubblesort__ops() = '} . RPerl::Algorithm::Sort::Bubble::bubblesort__ops() . "'\n" or croak();
#print STDERR q{in inline_cpp_debug.pl, have bubblesort__types() = '} . bubblesort__types() . "'\n" or croak();
