package rperltypes;
use strict;
use warnings;
use RPerl::Config;
our $VERSION = 0.000_101;

# NEED UPGRADE: create GrammarComponents
#use parent qw(RPerl::GrammarComponent)

# [[[ NON-RPERL MODULES ]]]
use File::Copy qw(move);

# all following type lists lowest-to-highest level

# [[[ DATA TYPES ]]]
use RPerl::DataType::Void;
use RPerl::DataType::Integer;
use RPerl::DataType::Float;
use RPerl::DataType::Number;
use RPerl::DataType::Character;
use RPerl::DataType::String;
use RPerl::DataType::Scalar;
use RPerl::DataType::Unknown;

# [[[ DATA STRUCTURES ]]]
use RPerl::DataStructure::Array;
use RPerl::DataStructure::Hash;
#use RPerl::DataStructure::LinkedList;
#use RPerl::DataStructure::LinkedList::Node;
#use RPerl::DataStructure::Graph;
#use RPerl::DataStructure::Graph::Tree;
#use RPerl::DataStructure::Graph::Tree::Binary;
#use RPerl::DataStructure::Graph::Tree::Binary::Node;

# [[[ OBJECT-ORIENTED ]]]
use RPerl::Object;
use RPerl::CodeBlock::Subroutine::Method;  # Method is the only item that is both a Data Type & a Grammar Rule

# these types are currently implemented for all 3 primary RPerl modes: PERLOPS_PERLTYPES, CPPOPS_PERLTYPES, CPPOPS_CPPTYPES
# NEED REMOVE: hard-coded list
our string__array_ref $supported = [
    qw(
        void
        integer
        number
        string
        integer__array_ref
        number__array_ref
        string__array_ref
        integer__hash_ref
        number__hash_ref
        string__hash_ref
        )
];

# [[[ C++ TYPE CONTROL ]]]
package RPerl;  if (not(defined($RPerl::INCLUDE_PATH))) { our $INCLUDE_PATH = '/FAILURE/BECAUSE/RPERL/INCLUDE/PATH/NOT/YET/SET'; }  1;  # suppress warnings about typo in types_enable() below
package rperltypes;
#our void $types_input_enable = sub { (my $types_input) = @_;  # NEED FIX: RPerl typed functions not working in types.pm, must call as normal Perl function
sub types_enable { (my $types_input) = @_;
;
#	RPerl::diag "in rperltypes::types_enable(), received \$types_input = '$types_input'\n";
	
	my string $rperltypes_h_filename = $RPerl::INCLUDE_PATH . '/rperltypes_mode.h';
#	my bool $rperltypes_h_modified = 0;
	my integer $rperltypes_h_modified = 0;
	
#	RPerl::diag "in rperltypes::types_enable(), have \$rperltypes_h_filename = '$rperltypes_h_filename'\n";
	
	open(my $TYPES_H_FILEHANDLE_IN,'<', $rperltypes_h_filename) or croak("Can't read rperltypes_mode.h input file: $ERRNO, croaking");
	open(my $TYPES_H_FILEHANDLE_OUT,'>', ($rperltypes_h_filename . '.swap')) or croak("Can't write rperltypes_mode.h.swap output file: $ERRNO, croaking");

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
				croak('Found invalid __$types_current__TYPES definition in rperltypes_mode.h, neither properly disabled nor enabled, croaking');
			}
		}
		print $TYPES_H_FILEHANDLE_OUT $line_current;  # WRITE DATA BACK TO FILE
	}

	close($TYPES_H_FILEHANDLE_IN);
	close($TYPES_H_FILEHANDLE_OUT);
	
	if ($rperltypes_h_modified)
	{
		move($rperltypes_h_filename, ($rperltypes_h_filename . '.orig')) or croak("Can't move rperltypes_mode.h input file to rperltypes_mode.h.orig: $ERRNO, croaking");
		move(($rperltypes_h_filename . '.swap'), $rperltypes_h_filename) or croak("Can't move rperltypes_mode.h.swap output file to rperltypes_mode.h: $ERRNO, croaking");
	}
	
	return();
#};
}


1;
